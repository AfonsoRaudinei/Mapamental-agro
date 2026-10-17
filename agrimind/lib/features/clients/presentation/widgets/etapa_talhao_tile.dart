import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../plans/presentation/models/product_view_model.dart';
import '../../../plans/presentation/widgets/product_tile.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';

/// Linha de etapa do talhão; com produtos vinculados vira accordion.
class EtapaTalhaoTile extends StatelessWidget {
  const EtapaTalhaoTile({super.key, required this.etapa, this.atual = false});

  final EtapaTalhao etapa;

  /// Etapa atual do stepper: fundo azul claro + marcador no título.
  final bool atual;

  @override
  Widget build(BuildContext context) {
    final l = etapa.linha;
    final dae = l.dae == null ? '—' : 'DAE ${l.dae}';
    final titulo = l.notaEtapa == null ? l.etapa : '${l.etapa}\n${l.notaEtapa}';
    final resumo = '$dae · ${AppFormatters.data(l.data)}';
    final cor = atual ? AppColors.primary : null;
    final titleStyle = AppTypography.caption.copyWith(
      color: cor ?? context.appTextPrimary,
      fontWeight: FontWeight.w600,
    );
    final subStyle = AppTypography.label.copyWith(
      color: cor ?? context.appTextSecondary,
    );
    final title = atual
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 6),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(child: Text(titulo, style: titleStyle)),
            ],
          )
        : Text(titulo, style: titleStyle);
    final fundo = atual ? AppColors.primary.withValues(alpha: 0.08) : null;

    if (!etapa.temProdutos) {
      return ListTile(
        dense: true,
        tileColor: fundo,
        title: title,
        subtitle: Text(resumo, style: subStyle),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: fundo,
        collapsedBackgroundColor: fundo,
        iconColor: cor,
        collapsedIconColor: cor,
        initiallyExpanded: atual,
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        childrenPadding: const EdgeInsets.only(bottom: AppSpacing.sm),
        title: title,
        subtitle: Text(
          '$resumo · ${etapa.produtosVinculados.length} '
          '${etapa.produtosVinculados.length == 1 ? 'produto' : 'produtos'}',
          style: subStyle,
        ),
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
                isActive: true,
              ),
            ),
        ],
      ),
    );
  }
}
