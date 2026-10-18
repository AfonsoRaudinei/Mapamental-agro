import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/cronograma_soja/aplicar_dae_catalogo_cronograma.dart';
import '../../domain/cronograma_soja/calcular_cronograma_soja.dart';
import '../../domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../../catalog/domain/entities/produto_catalogo_entity.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import 'cronograma_soja_tabela.dart';
import 'etapas_carrossel.dart';
import 'cultivar_talhao_selector.dart';

/// Cronograma de um talhão aberto pela lista da fazenda (fluxo direto).
class CronogramaSojaTalhaoFocusView extends StatelessWidget {
  const CronogramaSojaTalhaoFocusView({
    super.key,
    required this.talhaoNome,
    required this.linha,
    required this.opcoesCultivar,
    required this.catalogo,
    required this.cultivarConfirmada,
    required this.cultivarPendente,
    required this.onCultivarPendenteChanged,
    required this.onConfirmarCultivar,
    required this.onLinhaChanged,
    required this.onPlantioChanged,
    required this.onAbrirRegulagemCompleta,
    required this.avisosValidacao,
    this.etapas,
    this.carrossel,
    this.onEtapaVisivel,
  });

  final String talhaoNome;
  final CronogramaSojaParametros linha;
  final List<String> opcoesCultivar;
  final List<ProdutoCatalogoEntity> catalogo;
  final bool cultivarConfirmada;
  final String cultivarPendente;
  final ValueChanged<String> onCultivarPendenteChanged;
  final VoidCallback onConfirmarCultivar;
  final ValueChanged<CronogramaSojaParametros> onLinhaChanged;
  final ValueChanged<DateTime> onPlantioChanged;
  final VoidCallback onAbrirRegulagemCompleta;
  final List<Widget> avisosValidacao;

  /// Etapas com produtos do plano; `null` mantém a tabela só com datas.
  final List<EtapaTalhao>? etapas;

  /// Controla o carrossel de etapas (sincronizado com a linha do tempo).
  final PageController? carrossel;
  final ValueChanged<int>? onEtapaVisivel;

  bool get _multiplasCultivares => opcoesCultivar.length > 1;

  @override
  Widget build(BuildContext context) {
    if (_multiplasCultivares && !cultivarConfirmada) {
      return _seletorCultivar(context);
    }

    if (linha.plantioDefinido) {
      return _cronogramaCalculado(context);
    }

    return _definirPlantio(context);
  }

  Widget _seletorCultivar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          talhaoNome,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Este talhão tem mais de uma cultivar no plano. Escolha qual usar '
          'no cronograma.',
          style: AppTypography.caption.copyWith(
            color: context.appTextSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        CultivarTalhaoSelector(
          label: 'Cultivar',
          value: cultivarPendente,
          opcoesVinculadas: opcoesCultivar,
          onChanged: onCultivarPendenteChanged,
        ),
        const SizedBox(height: AppSpacing.md),
        CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          onPressed: onConfirmarCultivar,
          child: const Text('Continuar'),
        ),
      ],
    );
  }

  Widget _definirPlantio(BuildContext context) {
    final temVinculo = opcoesCultivar.isNotEmpty;
    final cultivar = linha.materialCultivar.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Definir plantio — $talhaoNome',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (temVinculo) ...[
          _infoRow(context, 'Cultivar', cultivar.isEmpty ? '—' : cultivar),
          _infoRow(
            context,
            'Ciclo (DAE maturação)',
            '${linha.daeMaturacaoCiclo} dias',
          ),
        ] else ...[
          CultivarTalhaoSelector(
            label: 'Material / Cultivar',
            value: linha.materialCultivar,
            opcoesVinculadas: const [],
            onChanged: (v) => onLinhaChanged(
              aplicarDaeAoEscolherCultivar(
                params: linha,
                cultivar: v,
                catalogo: catalogo,
              ),
            ),
          ),
          _CampoInteiroLeitura(
            label: 'Ciclo da cultivar (DAE maturação)',
            value: linha.daeMaturacaoCiclo,
            onChanged: (v) => onLinhaChanged(linha.copyWith(daeMaturacaoCiclo: v)),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        _CampoDataPlantio(
          label: 'Data de plantio do talhão',
          hint: 'Toque para definir',
          onChanged: onPlantioChanged,
        ),
        ...avisosValidacao,
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Após informar a data, o cronograma com datas será exibido aqui.',
          style: AppTypography.caption.copyWith(
            color: context.appTextSecondary,
            fontSize: 11,
          ),
        ),
        TextButton(
          onPressed: onAbrirRegulagemCompleta,
          child: const Text('Ajustar regulagem completa'),
        ),
      ],
    );
  }

  Widget _cronogramaCalculado(BuildContext context) {
    final linhas = calcularLinhaTempoSoja(
      dataPlantio: linha.dataPlantio,
      parametros: parametrosFromCronograma(linha),
    );

    // Com etapas, nome/cultivar/plantio ficam no cabeçalho fixo do stepper.
    final cabecalhoNoStepper = etapas != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!cabecalhoNoStepper)
          Text(
            talhaoNome,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              color: context.appTextPrimary,
            ),
          ),
        if (!cabecalhoNoStepper &&
            linha.materialCultivar.trim().isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            '${linha.materialCultivar} · plantio ${AppFormatters.data(linha.dataPlantio)}',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        _LinhaPlantio(
          data: linha.dataPlantio,
          cultivar: linha.materialCultivar.trim(),
          onChanged: onPlantioChanged,
        ),
        const SizedBox(height: AppSpacing.md),
        ...avisosValidacao,
        if (etapas != null && etapas!.isNotEmpty && carrossel != null)
          EtapasCarrossel(
            etapas: etapas!,
            controller: carrossel!,
            onPageChanged: onEtapaVisivel ?? (_) {},
          )
        else
          CronogramaSojaTabela(
            titulo: 'Cronograma',
            linhas: linhas,
            resumo: resumoCronogramaSoja(linha),
            mostrarColunaData: true,
          ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w500,
                color: context.appTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CampoDataPlantio extends StatelessWidget {
  const _CampoDataPlantio({
    required this.label,
    required this.hint,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(now.year - 2),
                lastDate: DateTime(now.year + 2),
              );
              if (picked != null) onChanged(picked);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.appBorder),
              ),
              child: Text(
                hint,
                style: AppTypography.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Mesmo intervalo do picker: [1/jan de now-2, 1/jan de now+2].
/// Plantio já definido: linha compacta (data + cultivar + "Alterar").
/// Editado raramente — não precisa do peso de um campo de formulário.
class _LinhaPlantio extends StatelessWidget {
  const _LinhaPlantio({
    required this.data,
    required this.cultivar,
    required this.onChanged,
  });

  final DateTime data;
  final String cultivar;
  final ValueChanged<DateTime> onChanged;

  Future<void> _escolher(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dentroDoIntervalo(data, now) ? data : now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
      helpText: 'Data de plantio do talhão',
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Data de plantio ${AppFormatters.data(data)}. Toque para alterar.',
      child: Material(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _escolher(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plantio',
                        style: AppTypography.label.copyWith(
                          color: context.appTextSecondary,
                        ),
                      ),
                      Text(
                        cultivar.isEmpty
                            ? AppFormatters.data(data)
                            : '${AppFormatters.data(data)} · $cultivar',
                        style: AppTypography.bodyBold.copyWith(
                          fontSize: 15,
                          color: context.appTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Alterar',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool _dentroDoIntervalo(DateTime? d, DateTime now) =>
    d != null &&
    !d.isBefore(DateTime(now.year - 2)) &&
    !d.isAfter(DateTime(now.year + 2));

class _CampoInteiroLeitura extends StatefulWidget {
  const _CampoInteiroLeitura({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  State<_CampoInteiroLeitura> createState() => _CampoInteiroLeituraState();
}

class _CampoInteiroLeituraState extends State<_CampoInteiroLeitura> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: '${widget.value}');
  }

  @override
  void didUpdateWidget(covariant _CampoInteiroLeitura oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _ctrl.text = '${widget.value}';
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixText: 'dias',
              filled: true,
              fillColor: context.appSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            onChanged: (t) {
              final v = int.tryParse(t.trim());
              if (v != null && v > 0) widget.onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}
