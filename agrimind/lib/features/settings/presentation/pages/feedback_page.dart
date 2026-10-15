import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/providers/package_info_provider.dart';
import '../../../../core/utils/extensions.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class FeedbackPage extends ConsumerWidget {
  const FeedbackPage({super.key});

  Future<void> _sendEmail(BuildContext context, WidgetRef ref) async {
    final version = await ref.read(packageInfoProvider.future);
    final uri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      queryParameters: {
        'subject': 'Feedback AgriMind ${version.compactLabel}',
        'body': 'Descreva aqui sua dúvida, erro ou sugestão:\n\n',
      },
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o app de email.'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _sendWhatsApp(BuildContext context, WidgetRef ref) async {
    final version = await ref.read(packageInfoProvider.future);
    final text = Uri.encodeComponent(
      'Olá, preciso de suporte no AgriMind ${version.compactLabel}.',
    );
    final uri = Uri.parse('https://wa.me/?text=$text');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      await SharePlus.instance.share(
        ShareParams(
          text: 'Olá, preciso de suporte no AgriMind ${version.compactLabel}.',
          subject: 'Suporte AgriMind',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text('Feedback', style: AppTypography.h3),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Envie dúvidas, relatos de erro ou sugestões. Incluímos a versão do app automaticamente.',
              style: AppTypography.body.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
          SettingsSection(
            title: 'Canais',
            children: [
              SettingsTile(
                title: 'E-mail',
                subtitle: AppConstants.supportEmail,
                onTap: () => _sendEmail(context, ref),
                leading: _iconBox(
                  PhosphorIconsRegular.envelopeSimple,
                  AppColors.primary,
                ),
              ),
              SettingsTile(
                title: 'WhatsApp',
                subtitle: 'Compartilhar mensagem de suporte',
                onTap: () => _sendWhatsApp(context, ref),
                leading: _iconBox(
                  PhosphorIconsRegular.chatCircle,
                  AppColors.catDoencas,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconBox(PhosphorIconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: PhosphorIcon(icon, color: color, size: 18),
      ),
    );
  }
}
