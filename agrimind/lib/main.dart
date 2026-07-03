import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/main_shell.dart';
import 'core/database/app_database.dart';
import 'core/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.open();
  await db.seedDemoData();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const AgriMindApp(),
    ),
  );
}

class AgriMindApp extends ConsumerWidget {
  const AgriMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'AgriMind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light.data,
      darkTheme: AppTheme.darkBlack.data,
      themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const MainShell(),
    );
  }
}
