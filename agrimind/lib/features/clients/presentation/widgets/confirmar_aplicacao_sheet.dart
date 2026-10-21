import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/cronograma_soja/cronograma_soja_linha.dart';
import '../../domain/talhao_etapas/confirmacao_etapa.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import 'talhao_timeline_stepper.dart';

/// Resultado da folha: confirmação nova/editada ou pedido de desfazer.
typedef ResultadoConfirmacao = ({ConfirmacaoEtapa? confirmacao, bool desfazer});

/// Folha "Confirmar aplicação": data real + produtos realmente usados.
Future<ResultadoConfirmacao?> mostrarConfirmarAplicacao(
  BuildContext context, {
  required String talhaoId,
  required EtapaTalhao etapa,
  required DateTime dataPlantio,
}) {
  return showModalBottomSheet<ResultadoConfirmacao>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.appSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ConfirmarAplicacaoSheet(
      talhaoId: talhaoId,
      etapa: etapa,
      dataPlantio: dataPlantio,
    ),
  );
}

class _ConfirmarAplicacaoSheet extends StatefulWidget {
  const _ConfirmarAplicacaoSheet({
    required this.talhaoId,
    required this.etapa,
    required this.dataPlantio,
  });

  final String talhaoId;
  final EtapaTalhao etapa;
  final DateTime dataPlantio;

  @override
  State<_ConfirmarAplicacaoSheet> createState() =>
      _ConfirmarAplicacaoSheetState();
}

class _LinhaProduto {
  _LinhaProduto({
    required this.produtoId,
    required this.nome,
    required this.unidade,
    required this.areaHa,
    required double dose,
  }) : controller = TextEditingController(text: _formatar(dose));

  final String produtoId;
  final String nome;
  final String unidade;

  /// Área do talhão (derivada de total ÷ dose do plano).
  final double areaHa;
  final TextEditingController controller;
  bool usado = true;

  double get dose =>
      double.tryParse(controller.text.trim().replaceAll(',', '.')) ?? 0;
  double get total => dose * areaHa;

  static String _formatar(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString().replaceAll('.', ',');
}

/// Dias de calendário de [a] até [b] (imune a horário de verão).
int _diasEntre(DateTime a, DateTime b) =>
    DateTime.utc(b.year, b.month, b.day)
        .difference(DateTime.utc(a.year, a.month, a.day))
        .inDays;

class _ConfirmarAplicacaoSheetState extends State<_ConfirmarAplicacaoSheet> {
  late DateTime _data;
  late final List<_LinhaProduto> _linhas;

  @override
  void initState() {
    super.initState();
    final hoje = DateTime.now();
    final confirmacao = widget.etapa.confirmacao;
    _data = confirmacao?.dataReal ?? DateTime(hoje.year, hoje.month, hoje.day);
    _linhas = [
      for (final p in widget.etapa.produtosVinculados)
        _LinhaProduto(
          produtoId: p.produtoId,
          nome: p.nome,
          unidade: p.unidade,
          areaHa: p.dosePorHa > 0 ? p.totalCalculado / p.dosePorHa : 0,
          dose: p.dosePorHa,
        ),
    ];
  }

  @override
  void dispose() {
    for (final l in _linhas) {
      l.controller.dispose();
    }
    super.dispose();
  }

  Future<void> _escolherData() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _data.isAfter(now) ? now : _data,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      helpText: 'Data real da aplicação',
    );
    if (picked != null) setState(() => _data = picked);
  }

  void _confirmar() {
    final usados = [
      for (final l in _linhas)
        if (l.usado)
          ProdutoConfirmado(
            produtoId: l.produtoId,
            nome: l.nome,
            dosePorHa: l.dose,
            unidade: l.unidade,
            total: l.total,
          ),
    ];
    Navigator.of(context).pop((
      confirmacao: ConfirmacaoEtapa(
        talhaoId: widget.talhaoId,
        chaveEtapa: widget.etapa.chave,
        dataReal: _data,
        produtos: usados,
        confirmadaEm: DateTime.now(),
      ),
      desfazer: false,
    ));
  }

  void _desfazer() =>
      Navigator.of(context).pop((confirmacao: null, desfazer: true));

  @override
  Widget build(BuildContext context) {
    final etapa = widget.etapa;
    final previsto = etapa.dataPrevista ?? etapa.data;
    final editando = etapa.confirmada;
    final emergencia = etapa.linha.tipo == CronogramaSojaLinhaTipo.emergencia;
    final diasReais = _diasEntre(widget.dataPlantio, _data);
    final diasPrevistos = _diasEntre(widget.dataPlantio, previsto);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              emergencia
                  ? (editando ? 'Editar emergência' : 'Confirmar emergência')
                  : (editando ? 'Editar aplicação' : 'Confirmar aplicação'),
              style: AppTypography.h2.copyWith(color: context.appTextPrimary),
            ),
            const SizedBox(height: 2),
            Text(
              '${nomeCurtoEtapa(etapa.linha)} · previsto '
              '${AppFormatters.data(previsto)}',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              emergencia ? 'Data real da emergência' : 'Data real da aplicação',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 4),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: _escolherData,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: context.appBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.event_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      AppFormatters.data(_data),
                      style: AppTypography.bodyBold.copyWith(
                        color: context.appTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            if (emergencia) ...[
              Text(
                'Emergiu $diasReais ${diasReais == 1 ? 'dia' : 'dias'} após o '
                'plantio (previsto: $diasPrevistos).',
                style: AppTypography.bodyBold.copyWith(
                  fontSize: 14,
                  color: diasReais == diasPrevistos
                      ? context.appTextPrimary
                      : AppColors.primary,
                ),
              ),
              const SizedBox(height: 2),
            ],
            Text(
              'As etapas seguintes serão recalculadas a partir desta data.',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
                fontSize: 11,
              ),
            ),
            if (_linhas.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'Produtos usados',
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
              const SizedBox(height: 4),
              for (final l in _linhas) _linhaProduto(context, l),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: _confirmar,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(editando ? 'Salvar' : 'Confirmar'),
            ),
            if (editando)
              TextButton(
                onPressed: _desfazer,
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Desfazer confirmação'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _linhaProduto(BuildContext context, _LinhaProduto l) {
    return Row(
      children: [
        Checkbox(
          value: l.usado,
          onChanged: (v) => setState(() => l.usado = v ?? true),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.nome,
                style: AppTypography.bodyBold.copyWith(
                  fontSize: 15,
                  color: context.appTextPrimary,
                ),
              ),
              Text(
                'Total: ${AppFormatters.total(l.total, l.unidade.split('/').first)}',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 110,
          child: TextField(
            controller: l.controller,
            enabled: l.usado,
            textAlign: TextAlign.end,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              isDense: true,
              suffixText: l.unidade,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
