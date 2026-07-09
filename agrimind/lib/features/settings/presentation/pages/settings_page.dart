import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/providers/package_info_provider.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_toggle.dart';
import '../../../../core/utils/extensions.dart';

/// Página de Configurações completa.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final versionLabel = ref.watch(packageInfoProvider).maybeWhen(
          data: (info) => info.displayLabel,
          orElse: () => '…',
        );
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Configurações'),
            backgroundColor: theme.scaffoldBackgroundColor.withValues(alpha: 0.85),
            border: Border.all(color: Colors.transparent),
          ),
          settingsAsync.when(
            data: (settings) {
              if (settings == null) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('Usuário não encontrado.'),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildListDelegate([
                  // ── Perfil ────────────────────────────────────────────
                  _ProfileHeader(
                    nome: settings.nome,
                    email: settings.email,
                    avatarUrl: settings.avatarUrl,
                    onTap: () => context.push(AppRoutes.profileEdit),
                    surfaceColor: colorScheme.surface,
                    borderColor: colorScheme.outline,
                    subtitleColor:
                        isDark ? AppColors.textSecondaryDark : context.appTextSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ── Aparência ─────────────────────────────────────────
                  SettingsSection(
                    title: 'Aparência',
                    children: [
                      SettingsToggle(
                        title: 'Modo escuro',
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
                      SettingsTile(
                        title: 'Ícone do app',
                        subtitle: settings.appIconKey == 'classico'
                            ? 'Clássico'
                            : 'Principal',
                        leading: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const PhosphorIcon(
                            PhosphorIconsRegular.appStoreLogo,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        onTap: () => context.push(AppRoutes.appearance),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ── Dados ─────────────────────────────────────────────
                  SettingsSection(
                    title: 'Dados',
                    children: [
                      SettingsTile(
                        title: 'Exportar dados',
                        subtitle: 'Backup completo em JSON',
                        leading: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                AppColors.catNutricao.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const PhosphorIcon(
                            PhosphorIconsRegular.arrowSquareOut,
                            size: 18,
                            color: AppColors.catNutricao,
                          ),
                        ),
                        onTap: () => context.push(AppRoutes.dataPage),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ── Suporte ───────────────────────────────────────────
                  SettingsSection(
                    title: 'Suporte',
                    children: [
                      SettingsTile(
                        title: 'Feedback',
                        subtitle: 'Enviar dúvida, erro ou sugestão',
                        leading: _iconBox(
                          PhosphorIconsRegular.chatCircleText,
                          AppColors.primary,
                        ),
                        onTap: () => context.push(AppRoutes.feedback),
                      ),
                      SettingsTile(
                        title: 'Termos de uso',
                        leading: _iconBox(
                          PhosphorIconsRegular.fileText,
                          AppColors.catInsetos,
                        ),
                        onTap: () => context.push(AppRoutes.terms),
                      ),
                      SettingsTile(
                        title: 'Política de privacidade',
                        leading: _iconBox(
                          PhosphorIconsRegular.shieldCheck,
                          AppColors.catFisiologia,
                        ),
                        onTap: () => context.push(AppRoutes.privacy),
                      ),
                      SettingsTile(
                        title: 'Sobre o AgriMind',
                        subtitle: 'Versão $versionLabel',
                        onTap: () => context.push(AppRoutes.about),
                        leading: _iconBox(
                          PhosphorIconsRegular.info,
                          context.appTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ── Conta ─────────────────────────────────────────────
                  SettingsSection(
                    title: 'Conta',
                    children: [
                      SettingsTile(
                        title: 'Sair',
                        isDestructive: false,
                        leading: _iconBox(
                          PhosphorIconsRegular.signOut,
                          context.appTextSecondary,
                        ),
                        onTap: () => _confirmLogout(context, ref),
                      ),
                      SettingsTile(
                        title: 'Excluir conta',
                        isDestructive: true,
                        showChevron: false,
                        leading: _iconBox(
                          PhosphorIconsRegular.trash,
                          AppColors.error,
                        ),
                        onTap: () => _confirmDeleteAccount(context, ref),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ]),
              );
            },
            loading: () => const SliverFillRemaining(
              child: LoadingSkeleton(),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Erro ao carregar configurações',
                  style: AppTypography.body
                      .copyWith(color: context.appTextSecondary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon, Color cor) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: PhosphorIcon(icon, size: 18, color: cor),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Sair'),
        content: const Text('Deseja encerrar sua sessão?'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(authNotifierProvider.notifier).logout();
    }
  }

  Future<void> _confirmDeleteAccount(
      BuildContext context, WidgetRef ref) async {
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Excluir conta'),
        content: const Text(
            'Esta ação é permanente e não pode ser desfeita. Todos os seus dados serão removidos.'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir permanentemente'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(authNotifierProvider.notifier).deleteAccount();
    }
  }
}

// ── Header de perfil ──────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.nome,
    required this.email,
    required this.avatarUrl,
    required this.onTap,
    required this.surfaceColor,
    required this.borderColor,
    required this.subtitleColor,
  });

  final String nome;
  final String email;
  final String? avatarUrl;
  final VoidCallback onTap;
  final Color surfaceColor;
  final Color borderColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            ProfileAvatar(nome: nome, avatarUrl: avatarUrl, size: 60),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: AppTypography.h3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email,
                    style: AppTypography.caption.copyWith(
                      color: subtitleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            PhosphorIcon(
              PhosphorIconsRegular.caretRight,
              size: 16,
              color: context.appTextDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
