import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../plans/presentation/models/product_view_model.dart';
import '../../../plans/presentation/widgets/product_tile.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import 'talhao_timeline_stepper.dart';

/// Linha de etapa do talhão; com produtos vinculados vira accordion.
///
/// Passado esmaecido com check, próxima etapa destacada com selo e contagem
/// regressiva, futuro neutro — o olho encontra "onde estamos" sem ler.
class EtapaTalhaoTile extends StatelessWidget {
  const EtapaTalhaoTile({
    super.key,
    required this.etapa,
    this.status = StepperNodeStatus.futuro,
    this.hoje,
  });

  final EtapaTalhao etapa;
  final StepperNodeStatus status;
  final DateTime? hoje;

  bool get _proxima => status == StepperNodeStatus.atual;
  bool get _feito => status == StepperNodeStatus.concluido;

  @override
  Widget build(BuildContext context) {
    final l = etapa.linha;
    final agora = hoje ?? DateTime.now();
    final titulo = l.notaEtapa == null ? l.etapa : '${l.etapa}\n${l.notaEtapa}';
    final relativo = textoRelativo(l.data, agora);
    final n = etapa.produtosVinculados.length;

    final corTitulo = _proxima
        ? AppColors.primary
        : _feito
            ? context.appTextSecondary
            : context.appTextPrimary;
    final titleStyle = AppTypography.caption.copyWith(
      color: corTitulo,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );
    final subStyle = AppTypography.label.copyWith(
      fontSize: 12,
      color: _proxima ? AppColors.primary : context.appTextSecondary,
    );

    final title = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(titulo, style: titleStyle)),
        if (_proxima) ...[
          const SizedBox(width: AppSpacing.xs),
          const _Selo('PRÓXIMA'),
        ],
      ],
    );

    final subtitle = Text.rich(
      TextSpan(
        style: subStyle,
        children: [
          TextSpan(text: l.dae == null ? '' : 'DAE ${l.dae} · '),
          TextSpan(text: AppFormatters.data(l.data)),
          const TextSpan(text: ' · '),
          TextSpan(
            text: relativo,
            style: TextStyle(
              fontWeight: _proxima ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          if (n > 0) TextSpan(text: ' · $n ${n == 1 ? 'produto' : 'produtos'}'),
        ],
      ),
    );

    final leading = _GlifoStatus(status: status);
    final fundo = _proxima ? AppColors.primary.withValues(alpha: 0.08) : null;
    const padding = EdgeInsets.only(left: AppSpacing.sm, right: AppSpacing.md);

    final Widget tile;
    if (!etapa.temProdutos) {
      tile = ListTile(
        dense: true,
        contentPadding: padding,
        horizontalTitleGap: AppSpacing.sm,
        minLeadingWidth: 22,
        tileColor: fundo,
        leading: leading,
        title: title,
        subtitle: subtitle,
      );
    } else {
      final corIcone = _proxima ? AppColors.primary : context.appTextSecondary;
      tile = Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: fundo,
          collapsedBackgroundColor: fundo,
          iconColor: corIcone,
          collapsedIconColor: corIcone,
          initiallyExpanded: _proxima,
          tilePadding: padding,
          childrenPadding: const EdgeInsets.only(
            left: AppSpacing.lg,
            bottom: AppSpacing.sm,
          ),
          leading: leading,
          title: title,
          subtitle: subtitle,
          children: [
            for (final p in etapa.produtosVinculados)
              ProductTile(
                product: ProductViewModel(
                  id: p.produtoId,
                  name: p.nome,
                  doseLabel: AppFormatters.dose(p.dosePorHa, p.unidade),
                  totalLabel: [
                    AppFormatters.total(p.totalCalculado, p.unidadeDoTotal),
                    if (p.detalhe != null) p.detalhe!,
                  ].join(' · '),
                  isActive: !_feito,
                ),
              ),
          ],
        ),
      );
    }

    // Etapas passadas recuam visualmente; continuam legíveis e tocáveis.
    return _feito ? Opacity(opacity: 0.72, child: tile) : tile;
  }
}

/// Check (feito), anel azul (próxima) ou círculo vazio (futuro).
class _GlifoStatus extends StatelessWidget {
  const _GlifoStatus({required this.status});

  final StepperNodeStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepperNodeStatus.concluido:
        return const Icon(
          Icons.check_circle_rounded,
          size: 20,
          color: AppColors.primary,
        );
      case StepperNodeStatus.atual:
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 5),
          ),
        );
      case StepperNodeStatus.futuro:
        return Container(
          width: 18,
          height: 18,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.appBorder, width: 2),
          ),
        );
    }
  }
}

class _Selo extends StatelessWidget {
  const _Selo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        texto,
        style: AppTypography.label.copyWith(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// Divisor "Hoje" na lista, entre o que passou e o que vem.
class DivisorHoje extends StatelessWidget {
  const DivisorHoje({super.key, required this.hoje});

  final DateTime hoje;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Hoje, ${AppFormatters.data(hoje)}',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.xs,
          AppSpacing.md,
          AppSpacing.xs,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Hoje · ${AppFormatters.data(hoje).substring(0, 5)}',
              style: AppTypography.label.copyWith(
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Container(height: 1.5, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
