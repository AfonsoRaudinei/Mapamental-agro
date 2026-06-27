import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../../../../core/utils/extensions.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  Future<void> _sendEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      queryParameters: {
        'subject': 'Feedback AgriMind ${AppConstants.appVersion}',
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

  Future<void> _sendWhatsApp(BuildContext context) async {
    final text = Uri.encodeComponent(
      'Olá, preciso de suporte no AgriMind ${AppConstants.appVersion}.',
    );
    final uri = Uri.parse('https://wa.me/?text=$text');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      await SharePlus.instance.share(
        ShareParams(
          text: 'Olá, preciso de suporte no AgriMind.',
          subject: 'Suporte AgriMind',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          child: PhosphorIcon(
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
          SettingsSection(
            title: 'Contato',
            children: [
              SettingsTile(
                title: 'Enviar por email',
                subtitle: AppConstants.supportEmail,
                leading: _iconBox(
                  PhosphorIconsRegular.envelopeSimple,
                  AppColors.primary,
                ),
                onTap: () => _sendEmail(context),
              ),
              SettingsTile(
                title: 'Enviar pelo WhatsApp',
                subtitle: 'Abre o WhatsApp com mensagem pronta',
                leading: _iconBox(
                  PhosphorIconsRegular.whatsappLogo,
                  AppColors.success,
                ),
                onTap: () => _sendWhatsApp(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Inclua o que estava fazendo, o cliente/plano envolvido e uma captura de tela quando possível.',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: PhosphorIcon(icon, size: 18, color: color)),
    );
  }
}
