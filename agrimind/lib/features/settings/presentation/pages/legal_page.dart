import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

enum LegalDocument { terms, privacy }

class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.document});

  final LegalDocument document;

  bool get _isPrivacy => document == LegalDocument.privacy;

  String get _title => _isPrivacy ? 'Política de privacidade' : 'Termos de uso';

  String get _url =>
      _isPrivacy ? AppConstants.privacyPolicyUrl : AppConstants.termsUrl;

  static bool isValidLegalUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.hasScheme && uri.host.isNotEmpty;
  }

  List<_LegalBlock> get _blocks => _isPrivacy
      ? const [
          _LegalBlock(
            'Dados coletados',
            'O AgriMind armazena dados de conta, perfil profissional, clientes, fazendas, talhões, catálogo de produtos e planejamentos agronômicos criados pelo usuário.',
          ),
          _LegalBlock(
            'Uso dos dados',
            'Os dados são usados para autenticação, organização local do trabalho técnico, geração de relatórios e suporte solicitado pelo usuário.',
          ),
          _LegalBlock(
            'Exclusão',
            'A exclusão de conta está disponível em Configurações > Conta > Excluir conta e remove a conta autenticada pelo serviço remoto configurado.',
          ),
          _LegalBlock(
            'Compartilhamento',
            'Exportações e envios por email ou WhatsApp só acontecem quando o usuário inicia a ação no aplicativo.',
          ),
        ]
      : const [
          _LegalBlock(
            'Uso profissional',
            'O AgriMind é uma ferramenta de apoio ao planejamento agronômico. As decisões técnicas continuam sob responsabilidade do profissional responsável.',
          ),
          _LegalBlock(
            'Conta',
            'O usuário deve manter seus dados de acesso seguros e pode encerrar a sessão ou excluir a conta nas configurações.',
          ),
          _LegalBlock(
            'Dados locais',
            'Informações criadas no aparelho podem ser exportadas pelo usuário em formato JSON para backup próprio.',
          ),
          _LegalBlock(
            'Suporte',
            'Dúvidas, bugs e sugestões podem ser enviados pelo menu Feedback.',
          ),
        ];

  Future<void> _openUrl(BuildContext context) async {
    if (!isValidLegalUrl(_url)) {
      if (!context.mounted) return;
      _showLaunchError(context, 'URL legal inválida.');
      return;
    }
    final uri = Uri.parse(_url);
    final canLaunch = await canLaunchUrl(uri);
    if (!context.mounted) return;
    if (!canLaunch) {
      _showLaunchError(
        context,
        'Não foi possível abrir $_url. Use o conteúdo acima ou publique docs/legal/.',
      );
      return;
    }
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      _showLaunchError(context, 'Falha ao abrir a versão online.');
    }
  }

  void _showLaunchError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
          child: const PhosphorIcon(
            PhosphorIconsRegular.caretLeft,
            size: 22,
            color: AppColors.primary,
          ),
        ),
        title: Text(_title, style: AppTypography.h3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          for (final block in _blocks) ...[
            Text(block.title, style: AppTypography.h3),
            const SizedBox(height: AppSpacing.xs),
            Text(
              block.body,
              style: AppTypography.body.copyWith(
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          OutlinedButton.icon(
            onPressed: () => _openUrl(context),
            icon: const PhosphorIcon(PhosphorIconsRegular.arrowSquareOut),
            label: const Text('Abrir versão online'),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _url,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalBlock {
  const _LegalBlock(this.title, this.body);

  final String title;
  final String body;
}
