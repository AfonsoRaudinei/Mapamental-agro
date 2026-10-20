import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Opção de talhão para seleção de área.
class TalhaoOption {
  const TalhaoOption({
    required this.id,
    required this.nome,
    required this.areaHa,
  });

  final String id;
  final String nome;
  final double areaHa;
}

/// Resultado da seleção de área (fazenda menos exclusões).
class AreaSelection {
  const AreaSelection({
    required this.areaHa,
    this.talhoesExcluidosIds = const [],
    this.personalizado = false,
  });

  final double areaHa;
  final List<String> talhoesExcluidosIds;
  final bool personalizado;
}

enum _ModoArea { fazenda, personalizado }

/// Fazenda inteira por padrão; talhões excluídos reduzem a área efetiva.
class AreaSelectorWidget extends StatefulWidget {
  const AreaSelectorWidget({
    super.key,
    required this.areaHaFazenda,
    required this.fazendaNome,
    required this.talhoes,
    required this.initialArea,
    required this.onChanged,
  });

  final double areaHaFazenda;
  final String fazendaNome;
  final List<TalhaoOption> talhoes;
  final double initialArea;
  final void Function(AreaSelection selection) onChanged;

  @override
  State<AreaSelectorWidget> createState() => _AreaSelectorWidgetState();
}

class _AreaSelectorWidgetState extends State<AreaSelectorWidget> {
  late _ModoArea _modo;
  final List<String> _excluidos = [];
  late TextEditingController _customCtrl;

  @override
  void initState() {
    super.initState();
    _customCtrl = TextEditingController();

    if ((widget.initialArea - widget.areaHaFazenda).abs() >= 0.001) {
      final inferred = _inferExclusoes(widget.initialArea);
      if (inferred != null && inferred.isNotEmpty) {
        _modo = _ModoArea.fazenda;
        _excluidos.addAll(inferred);
      } else {
        _modo = _ModoArea.personalizado;
        _customCtrl.text = widget.initialArea.toStringAsFixed(2);
      }
    } else {
      _modo = _ModoArea.fazenda;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _notify());
  }

  List<String>? _inferExclusoes(double targetArea) {
    if (widget.talhoes.isEmpty) return null;
    final diff = widget.areaHaFazenda - targetArea;
    if (diff <= 0.001) return const [];
    for (final t in widget.talhoes) {
      if ((t.areaHa - diff).abs() < 0.05) return [t.id];
    }
    return null;
  }

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  double get _areaExcluida {
    var sum = 0.0;
    for (final id in _excluidos) {
      for (final t in widget.talhoes) {
        if (t.id == id) sum += t.areaHa;
      }
    }
    return sum;
  }

  double get _areaEfetivaFazenda {
    final v = widget.areaHaFazenda - _areaExcluida;
    return v < 0 ? 0 : v;
  }

  void _notify() {
    if (_modo == _ModoArea.personalizado) {
      final v = double.tryParse(_customCtrl.text.replaceAll(',', '.'));
      widget.onChanged(
        AreaSelection(
          areaHa: v ?? widget.initialArea,
          personalizado: true,
        ),
      );
      return;
    }
    widget.onChanged(
      AreaSelection(
        areaHa: _areaEfetivaFazenda,
        talhoesExcluidosIds: List<String>.from(_excluidos),
      ),
    );
  }

  void _onModo(_ModoArea modo) {
    setState(() => _modo = modo);
    _notify();
  }

  void _addExclusao(String? talhaoId) {
    if (talhaoId == null || _excluidos.contains(talhaoId)) return;
    setState(() => _excluidos.add(talhaoId));
    _notify();
  }

  void _removeExclusao(String talhaoId) {
    setState(() => _excluidos.remove(talhaoId));
    _notify();
  }

  @override
  Widget build(BuildContext context) {
    final disponiveis =
        widget.talhoes.where((t) => !_excluidos.contains(t.id)).toList();

    final fazenda = _modo == _ModoArea.fazenda;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ChoiceChip(
              label: Text(
                '${widget.fazendaNome} · ${widget.areaHaFazenda.toStringAsFixed(1)} ha',
              ),
              selected: fazenda,
              onSelected: (_) => _onModo(_ModoArea.fazenda),
              visualDensity: VisualDensity.compact,
            ),
            ChoiceChip(
              label: const Text('Personalizado'),
              selected: !fazenda,
              onSelected: (_) => _onModo(_ModoArea.personalizado),
              visualDensity: VisualDensity.compact,
            ),
            if (fazenda && widget.talhoes.isNotEmpty)
              PopupMenuButton<String>(
                enabled: disponiveis.isNotEmpty,
                onSelected: _addExclusao,
                itemBuilder: (_) => disponiveis
                    .map(
                      (t) => PopupMenuItem(
                        value: t.id,
                        child: Text(
                          '${t.nome} — ${t.areaHa.toStringAsFixed(1)} ha',
                        ),
                      ),
                    )
                    .toList(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                    '− Excluir talhão',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (fazenda && _excluidos.isNotEmpty) ...[
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _excluidos.map((id) {
              final t = widget.talhoes.firstWhere((x) => x.id == id);
              return InputChip(
                label: Text(
                  '${t.nome} (−${t.areaHa.toStringAsFixed(1)} ha)',
                  style: AppTypography.caption,
                ),
                onDeleted: () => _removeExclusao(id),
                deleteIconColor: context.appTextSecondary,
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          Text(
            'Área efetiva: ${_areaEfetivaFazenda.toStringAsFixed(1)} ha',
            style: AppTypography.caption.copyWith(
              color: context.appTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        if (!fazenda) ...[
          const SizedBox(height: AppSpacing.xs),
          _CustomAreaField(
            controller: _customCtrl,
            onChanged: (_) => _notify(),
          ),
        ],
      ],
    );
  }
}

class _CustomAreaField extends StatelessWidget {
  const _CustomAreaField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              LengthLimitingTextInputFormatter(7),
            ],
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: '0,0',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'ha',
          style: AppTypography.body.copyWith(color: context.appTextSecondary),
        ),
      ],
    );
  }
}
