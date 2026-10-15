import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Seleção de cultivar vinculada ao talhão (semente com FK).
class CultivarTalhaoSelector extends StatelessWidget {
  const CultivarTalhaoSelector({
    super.key,
    required this.label,
    required this.value,
    required this.opcoesVinculadas,
    required this.onChanged,
    this.hint = 'Ex: Olimpo',
  });

  final String label;
  final String value;
  final List<String> opcoesVinculadas;
  final ValueChanged<String> onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final opcoes = opcoesVinculadas
        .map((o) => o.trim())
        .where((o) => o.isNotEmpty)
        .toList();

    if (opcoes.length <= 1) {
      return _CampoTextoCultivar(
        label: label,
        value: value,
        hint: opcoes.isEmpty ? hint : opcoes.first,
        readOnly: opcoes.length == 1,
        onChanged: opcoes.length == 1
            ? (_) {}
            : onChanged,
      );
    }

    final selected = opcoes.contains(value.trim()) ? value.trim() : opcoes.first;

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
          DropdownButtonFormField<String>(
            initialValue: selected,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.appSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            items: opcoes
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
          Text(
            '${opcoes.length} cultivares neste talhão — escolha qual planejar.',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _CampoTextoCultivar extends StatefulWidget {
  const _CampoTextoCultivar({
    required this.label,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.readOnly = false,
  });

  final String label;
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;
  final bool readOnly;

  @override
  State<_CampoTextoCultivar> createState() => _CampoTextoCultivarState();
}

class _CampoTextoCultivarState extends State<_CampoTextoCultivar> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: _textoInicial());
    if (widget.readOnly && widget.value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged(widget.hint);
      });
    }
  }

  String _textoInicial() {
    if (widget.value.trim().isNotEmpty) return widget.value;
    return widget.readOnly ? widget.hint : '';
  }

  @override
  void didUpdateWidget(covariant _CampoTextoCultivar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final novo = _textoInicial();
    if (_ctrl.text != novo) _ctrl.text = novo;
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
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: context.appSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            onChanged: widget.readOnly ? null : widget.onChanged,
          ),
        ],
      ),
    );
  }
}
