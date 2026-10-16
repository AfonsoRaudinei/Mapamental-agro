import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../plans/presentation/models/product_view_model.dart';
import '../../../plans/presentation/widgets/product_tile.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';

/// Linha de etapa do talhão; com produtos vinculados vira accordion.
class EtapaTalhaoTile extends StatelessWidget {
  const EtapaTalhaoTile({super.key, required this.etapa});

  final EtapaTalhao etapa;

  @override
  Widget build(BuildContext context) {
    final l = etapa.linha;
    final dae = l.dae == null ? '—' : 'DAE ${l.dae}';
    final titulo = l.notaEtapa == null ? l.etapa : '${l.etapa}\n${l.notaEtapa}';
    final resumo = '$dae · ${AppFormatters.data(l.data)}';
    final titleStyle = AppTypography.caption.copyWith(
      color: context.appTextPrimary,
      fontWeight: FontWeight.w600,
    );
    final subStyle = AppTypography.label.copyWith(
      color: context.appTextSecondary,
    );

    if (!etapa.temProdutos) {
      return ListTile(
        dense: true,
        title: Text(titulo, style: titleStyle),
        subtitle: Text(resumo, style: subStyle),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        childrenPadding: const EdgeInsets.only(bottom: AppSpacing.sm),
        title: Text(titulo, style: titleStyle),
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
