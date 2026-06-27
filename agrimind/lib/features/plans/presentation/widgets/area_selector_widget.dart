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

// ── Enum interno de modo ────────────────────────────────────────────────────
enum _ModoArea { fazenda, talhao, personalizado }

/// Widget de seleção de área para aplicação de produto.
///
/// Opções:
/// 1. Fazenda inteira → areaHaFazenda
/// 2. Talhão específico → talhao.areaHa
/// 3. Personalizado → valor digitado
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
  final void Function(double) onChanged;

  @override
  State<AreaSelectorWidget> createState() => _AreaSelectorWidgetState();
}

class _AreaSelectorWidgetState extends State<AreaSelectorWidget> {
  late _ModoArea _modo;
  TalhaoOption? _talhaoSelecionado;
  late TextEditingController _customCtrl;

  @override
  void initState() {
    super.initState();
    _customCtrl = TextEditingController();

    // Determina o modo inicial pela área passada
    if ((widget.initialArea - widget.areaHaFazenda).abs() < 0.001) {
      _modo = _ModoArea.fazenda;
    } else {
      final match = widget.talhoes.where(
        (t) => (t.areaHa - widget.initialArea).abs() < 0.001,
      );
      if (match.isNotEmpty) {
        _modo = _ModoArea.talhao;
        _talhaoSelecionado = match.first;
      } else {
        _modo = _ModoArea.personalizado;
        _customCtrl.text = widget.initialArea.toStringAsFixed(2);
      }
    }
  }

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  void _onModo(_ModoArea modo) {
    setState(() => _modo = modo);
    switch (modo) {
      case _ModoArea.fazenda:
        widget.onChanged(widget.areaHaFazenda);
      case _ModoArea.talhao:
        if (_talhaoSelecionado != null) {
          widget.onChanged(_talhaoSelecionado!.areaHa);
        }
      case _ModoArea.personalizado:
        final v = double.tryParse(_customCtrl.text.replaceAll(',', '.'));
        if (v != null) widget.onChanged(v);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Área de Aplicação',
          style: AppTypography.label.copyWith(color: context.appTextSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Fazenda inteira
        _RadioItem(
          label: 'Fazenda inteira (${widget.fazendaNome})',
          sublabel: '${widget.areaHaFazenda.toStringAsFixed(1)} ha',
          selected: _modo == _ModoArea.fazenda,
          onTap: () => _onModo(_ModoArea.fazenda),
        ),

        // Talhões
        ...widget.talhoes.map(
          (t) => _RadioItem(
            label: t.nome,
            sublabel: '${t.areaHa.toStringAsFixed(1)} ha',
            selected:
                _modo == _ModoArea.talhao && _talhaoSelecionado?.id == t.id,
            onTap: () {
              setState(() => _talhaoSelecionado = t);
              _onModo(_ModoArea.talhao);
              widget.onChanged(t.areaHa);
            },
          ),
        ),

        // Personalizado
        _RadioItem(
          label: 'Personalizado',
          sublabel: null,
          selected: _modo == _ModoArea.personalizado,
          onTap: () => _onModo(_ModoArea.personalizado),
        ),

        if (_modo == _ModoArea.personalizado) ...[
          const SizedBox(height: AppSpacing.sm),
          _CustomAreaField(
            controller: _customCtrl,
            onChanged: (v) {
              final parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null) widget.onChanged(parsed);
            },
          ),
        ],
      ],
    );
  }
}

// ── Widgets internos ────────────────────────────────────────────────────────

class _RadioItem extends StatelessWidget {
  const _RadioItem({
    required this.label,
    required this.sublabel,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String? sublabel;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : context.appBorder,
                  width: selected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: AppTypography.body.copyWith(
                  color: context.appTextPrimary,
                ),
              ),
            ),
            if (sublabel != null)
              Text(
                sublabel!,
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
          ],
        ),
      ),
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
                borderSide: BorderSide(
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
