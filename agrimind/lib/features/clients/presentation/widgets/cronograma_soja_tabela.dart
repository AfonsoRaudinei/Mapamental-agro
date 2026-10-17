import 'package:flutter/material.dart';

import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import 'etapa_talhao_tile.dart';
import 'talhao_timeline_stepper.dart';

/// Tabela + resumo do cronograma calculado (formato da spec / referência visual).
class CronogramaSojaTabela extends StatelessWidget {
  const CronogramaSojaTabela({
    super.key,
    required this.titulo,
    required this.linhas,
    required this.resumo,
    this.mostrarColunaData = true,
    this.etapas,
    this.etapaKeys,
    this.hoje,
  });

  final String titulo;
  final List<LinhaTempoSojaItem> linhas;
  final String resumo;
  final bool mostrarColunaData;

  /// Quando informado, cada linha mostra os produtos do plano (accordion).
  final List<EtapaTalhao>? etapas;

  /// Chaves estáveis por etapa (scroll a partir do stepper).
  final List<GlobalKey>? etapaKeys;

  /// Referência de "hoje" (testes); padrão = agora.
  final DateTime? hoje;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.appBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: etapas != null
              ? _listaEtapas(context, etapas!)
              : Table(
            columnWidths: mostrarColunaData
                ? const {
                    0: FlexColumnWidth(2.2),
                    1: FlexColumnWidth(0.75),
                    2: FixedColumnWidth(92),
                  }
                : const {
                    0: FlexColumnWidth(2.6),
                    1: FlexColumnWidth(1),
                  },
            border: TableBorder(
              horizontalInside: BorderSide(color: context.appBorder),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: context.appSurface.withValues(alpha: 0.6),
                ),
                children: [
                  _cell(context, 'Etapa', header: true),
                  _cell(context, 'DAE', header: true),
                  if (mostrarColunaData)
                    _cell(context, 'Data', header: true, noWrap: true),
                ],
              ),
              ...linhas.map((l) {
                final dae = l.dae == null ? '—' : 'DAE ${l.dae}';
                final etapa = l.notaEtapa == null
                    ? l.etapa
                    : '${l.etapa}\n${l.notaEtapa}';
                return TableRow(
                  children: [
                    _cell(context, etapa),
                    _cell(context, dae),
                    if (mostrarColunaData)
                      _cell(
                        context,
                        AppFormatters.data(l.data),
                        noWrap: true,
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          resumo,
          style: AppTypography.caption.copyWith(
            color: context.appTextSecondary,
          ),
        ),
      ],
    );
  }

  /// Etapas com status e o divisor "Hoje" entre passado e futuro.
  Widget _listaEtapas(BuildContext context, List<EtapaTalhao> etapas) {
    final agora = hoje ?? DateTime.now();
    final status = statusDasEtapas([for (final e in etapas) e.data], agora);
    final iProx = status.indexOf(StepperNodeStatus.atual);
    // Antes da próxima etapa; sem próxima (safra concluída), no fim.
    final iHoje = iProx < 0 ? etapas.length : iProx;
    return Column(
      children: [
        for (var i = 0; i <= etapas.length; i++) ...[
          if (i == iHoje) DivisorHoje(hoje: agora),
          if (i < etapas.length) ...[
            if (i > 0 && i != iHoje)
              Divider(height: 1, color: context.appBorder),
            EtapaTalhaoTile(
              key: etapaKeys != null && i < etapaKeys!.length
                  ? etapaKeys![i]
                  : null,
              etapa: etapas[i],
              status: status[i],
              hoje: agora,
            ),
          ],
        ],
      ],
    );
  }

  Widget _cell(
    BuildContext context,
    String text, {
    bool header = false,
    bool noWrap = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        text,
        softWrap: !noWrap,
        maxLines: noWrap ? 1 : null,
        overflow: noWrap ? TextOverflow.visible : null,
        style: (header ? AppTypography.label : AppTypography.caption).copyWith(
          color: header ? context.appTextSecondary : context.appTextPrimary,
          fontWeight: header ? FontWeight.w600 : FontWeight.normal,
          fontSize: noWrap && !header ? 12 : null,
        ),
      ),
    );
  }
}
