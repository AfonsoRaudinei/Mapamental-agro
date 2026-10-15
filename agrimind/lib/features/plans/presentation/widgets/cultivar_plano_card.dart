import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/accordion_section.dart';
import '../../domain/entities/cultivar_plano_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../providers/expanded_panels_provider.dart';

/// Card fixo de cultivar (1:1 com o plano), sem ação de remoção.
class CultivarPlanoCard extends ConsumerStatefulWidget {
  const CultivarPlanoCard({
    super.key,
    required this.plano,
    required this.onChanged,
  });

  final PlanoEntity plano;
  final ValueChanged<PlanoEntity> onChanged;

  @override
  ConsumerState<CultivarPlanoCard> createState() => _CultivarPlanoCardState();
}

class _CultivarPlanoCardState extends ConsumerState<CultivarPlanoCard> {
  static const _unidades = ['plantas/ha', 'sementes/ha'];

  late final TextEditingController _nome;
  late final TextEditingController _obtentora;
  late final TextEditingController _gm;
  late final TextEditingController _populacao;
  late final TextEditingController _obs;
  late String _unidade;

  @override
  void initState() {
    super.initState();
    final c = widget.plano.cultivar;
    _nome = TextEditingController(text: c.nome ?? '');
    _obtentora = TextEditingController(text: c.obtentora ?? '');
    _gm = TextEditingController(text: c.grupoMaturacao ?? '');
    _populacao = TextEditingController(
      text: c.populacao == null ? '' : c.populacao.toString(),
    );
    _obs = TextEditingController(text: c.observacoes ?? '');
    _unidade = c.populacaoUnidade;
    for (final controller in [_nome, _obtentora, _gm, _populacao, _obs]) {
      controller.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void didUpdateWidget(covariant CultivarPlanoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plano.cultivar != widget.plano.cultivar) {
      final c = widget.plano.cultivar;
      _syncController(_nome, c.nome ?? '');
      _syncController(_obtentora, c.obtentora ?? '');
      _syncController(_gm, c.grupoMaturacao ?? '');
      _syncController(
        _populacao,
        c.populacao == null ? '' : c.populacao.toString(),
      );
      _syncController(_obs, c.observacoes ?? '');
      _unidade = c.populacaoUnidade;
    }
  }

  void _syncController(TextEditingController controller, String value) {
    if (controller.text != value) controller.text = value;
  }

  @override
  void dispose() {
    _nome.dispose();
    _obtentora.dispose();
    _gm.dispose();
    _populacao.dispose();
    _obs.dispose();
    super.dispose();
  }

  CultivarPlanoEntity _buildCultivar() {
    final pop = double.tryParse(_populacao.text.replaceAll(',', '.'));
    return CultivarPlanoEntity(
      nome: _nome.text.trim().isEmpty ? null : _nome.text.trim(),
      obtentora: _obtentora.text.trim().isEmpty ? null : _obtentora.text.trim(),
      grupoMaturacao: _gm.text.trim().isEmpty ? null : _gm.text.trim(),
      populacao: pop,
      populacaoUnidade: _unidade,
      observacoes: _obs.text.trim().isEmpty ? null : _obs.text.trim(),
    );
  }

  void _save() {
    widget.onChanged(widget.plano.copyWith(cultivar: _buildCultivar()));
  }

  String get _subtitle {
    final c = _buildCultivar();
    if (!c.isDefined) {
      return 'Toque para definir a cultivar';
    }
    final parts = <String>[
      c.nome!,
      if (c.obtentora != null && c.obtentora!.isNotEmpty) c.obtentora!,
      if (c.grupoMaturacao != null && c.grupoMaturacao!.isNotEmpty)
        'GM ${c.grupoMaturacao}',
      if (c.populacao != null)
        '${c.populacao!.toStringAsFixed(0)} ${c.populacaoUnidade}',
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AccordionSection(
        title: 'Cultivar',
        subtitle: _subtitle,
        isExpanded: ref.isPanelExpanded(cultivarPanelId),
        onToggle: (_) => ref.togglePanel(cultivarPanelId),
        child: Column(
          children: [
            _field('Nome da cultivar', _nome, required: true),
            Divider(height: 1, color: context.appBorderSoft),
            _field('Obtentora', _obtentora),
            Divider(height: 1, color: context.appBorderSoft),
            _field('Grupo de maturação (GM)', _gm),
            Divider(height: 1, color: context.appBorderSoft),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _field(
                      'População',
                      _populacao,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _unidade,
                      decoration: InputDecoration(
                        labelText: 'Unidade',
                        isDense: true,
                        filled: true,
                        fillColor: context.appBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: context.appBorderSoft),
                        ),
                      ),
                      items: _unidades
                          .map(
                            (u) => DropdownMenuItem(value: u, child: Text(u)),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _unidade = value);
                        _save();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: context.appBorderSoft),
            _field('Observações', _obs, maxLines: 3),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.label.copyWith(
              color: context.appTextDisabled,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: AppTypography.body.copyWith(
              color: context.appTextPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: context.appBackground,
              hintText: required ? 'Obrigatório para salvar' : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.appBorderSoft),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.appBorderSoft),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
            onSubmitted: (_) => _save(),
            onTapOutside: (_) => _save(),
          ),
        ],
      ),
    );
  }
}
