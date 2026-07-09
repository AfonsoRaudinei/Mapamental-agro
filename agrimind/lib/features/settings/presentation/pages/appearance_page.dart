import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/settings_provider.dart';
import '../widgets/icon_selector.dart';
import '../widgets/settings_toggle.dart';
import '../../../../core/utils/extensions.dart';

/// Página de aparência — dark mode + ícone do app.
class AppearancePage extends ConsumerWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          child: const PhosphorIcon(
            PhosphorIconsRegular.caretLeft,
            size: 22,
            color: AppColors.primary,
          ),
        ),
        title: const Text('Aparência', style: AppTypography.h3),
      ),
      body: settingsAsync.when(
        data: (settings) {
          if (settings == null) return const SizedBox.shrink();

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // ── Modo Escuro ───────────────────────────────────────────
              const _SectionTitle('Tema'),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: SettingsToggle(
                  title: 'Modo escuro',
                  subtitle: settings.darkMode
                      ? 'Interface escura ativada'
                      : 'Interface clara ativada',
                  value: settings.darkMode,
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const PhosphorIcon(
                      PhosphorIconsRegular.moon,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (v) => ref
                      .read(settingsNotifierProvider.notifier)
                      .setDarkMode(v),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Ícone do App ──────────────────────────────────────────
              const _SectionTitle('Ícone do aplicativo'),
              IconSelector(
                selectedKey: settings.appIconKey,
                onChanged: (key) =>
                    ref.read(settingsNotifierProvider.notifier).setAppIcon(key),
              ),

              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'A alteração do ícone será aplicada na próxima vez que o app for aberto.',
                  style: AppTypography.caption.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : context.appTextSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          );
        },
        loading: () => const LoadingSkeleton(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.xs),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.label.copyWith(
          color: isDark ? AppColors.textSecondaryDark : context.appTextSecondary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
