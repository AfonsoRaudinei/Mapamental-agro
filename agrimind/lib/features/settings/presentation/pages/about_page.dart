import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/providers/package_info_provider.dart';
import '../../../../core/utils/extensions.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionAsync = ref.watch(packageInfoProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
        title: const Text('Sobre', style: AppTypography.h3),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: PhosphorIcon(
                      PhosphorIconsRegular.leaf,
                      color: AppColors.primary,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(AppConstants.appName, style: AppTypography.h2),
                versionAsync.when(
                  data: (info) => Text(
                    'Versão ${info.displayLabel}',
                    style: AppTypography.caption.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                  loading: () => Text(
                    'Versão …',
                    style: AppTypography.caption.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                  error: (_, __) => Text(
                    'Versão indisponível',
                    style: AppTypography.caption.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SettingsSection(
            title: 'Aplicativo',
            children: [
              SettingsTile(
                title: 'Planejamento agronômico',
                subtitle: 'Clientes, áreas, catálogo, planos e consolidação',
                showChevron: false,
              ),
              SettingsTile(
                title: 'Suporte',
                subtitle: AppConstants.supportEmail,
                showChevron: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
