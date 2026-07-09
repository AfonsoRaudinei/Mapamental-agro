import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_spacing.dart';
import 'core/constants/app_typography.dart';
import 'core/config/supabase_config.dart';
import 'core/database/database_service.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_provider.dart';
import 'features/settings/data/datasources/settings_local_datasource.dart';
import 'features/settings/domain/entities/settings_entity.dart';
import 'features/references/data/datasources/references_local_datasource.dart';
import 'features/catalog/data/datasources/catalog_local_datasource.dart';
import 'core/utils/extensions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AgriMindBootstrap());
}

class AgriMindBootstrap extends StatefulWidget {
  const AgriMindBootstrap({super.key});

  @override
  State<AgriMindBootstrap> createState() => _AgriMindBootstrapState();
}

class _AgriMindBootstrapState extends State<AgriMindBootstrap> {
  late Future<_BootstrapData> _bootstrap;

  @override
  void initState() {
    super.initState();
    _bootstrap = _initializeApp();
  }

  void _retry() {
    setState(() => _bootstrap = _initializeApp());
  }

  Future<_BootstrapData> _initializeApp() async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]).timeout(const Duration(seconds: 3));

      SupabaseConfig.validate();
      await Supabase.initialize(
        url: SupabaseConfig.url,
        publishableKey: SupabaseConfig.publishableKey,
      ).timeout(const Duration(seconds: 20));

      await DatabaseService.initialize(
        sessionUserId: Supabase.instance.client.auth.currentUser?.id,
      ).timeout(const Duration(seconds: 15));

      // Garante que todos os dados de referência e catálogo estejam no banco local
      // logo na inicialização (importante para builds IPA/TestFlight com dados completos).
      final db = DatabaseService.instance;
      await ReferencesLocalDatasource(db).seedIfEmpty();
      await CatalogLocalDatasource(db).seedIfEmpty();

      final datasource = SettingsLocalDatasource(DatabaseService.instance);
      final authUser = Supabase.instance.client.auth.currentUser;
      final settings = await _loadBootstrapSettings(
        datasource: datasource,
        authUser: authUser,
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () => null,
      );

      return _BootstrapData(darkMode: settings?.darkMode ?? false);
    } on TimeoutException catch (error) {
      throw StateError(
        'Tempo excedido ao iniciar o app. Detalhe: ${error.message ?? error.duration}.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_BootstrapData>(
      future: _bootstrap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProviderScope(
            overrides: [
              darkModeProvider.overrideWith(
                (ref) => DarkModeNotifier(snapshot.data!.darkMode),
              ),
            ],
            child: const AgriMindApp(),
          );
        }

        return MaterialApp(
          title: 'AgriMind',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: _StartupScreen(
            error: snapshot.error,
            onRetry: snapshot.hasError ? _retry : null,
          ),
        );
      },
    );
  }
}

Future<SettingsEntity?> _loadBootstrapSettings({
  required SettingsLocalDatasource datasource,
  required User? authUser,
}) async {
  if (authUser == null) return datasource.getSettings();

  final metadata = authUser.userMetadata ?? const <String, dynamic>{};
  final existing = await datasource.getSettings(uid: authUser.id);
  if (existing != null) return existing;

  return datasource.ensureProfile(
    uid: authUser.id,
    nome: (metadata['full_name'] ?? metadata['name'] ?? 'Usuário').toString(),
    email: authUser.email ?? '',
    avatarUrl: metadata['avatar_url']?.toString(),
  );
}

class _BootstrapData {
  const _BootstrapData({required this.darkMode});

  final bool darkMode;
}

class _StartupScreen extends StatelessWidget {
  const _StartupScreen({
    required this.error,
    required this.onRetry,
  });

  final Object? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/icon.png',
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (!hasError) ...[
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ] else ...[
                  const Text(
                    'Não foi possível iniciar o AgriMind',
                    style: AppTypography.h3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    error.toString(),
                    style: AppTypography.caption.copyWith(
                      color: context.appTextSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    onPressed: onRetry,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AgriMindApp extends ConsumerWidget {
  const AgriMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'AgriMind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
