import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../domain/culturas_catalogo.dart';
import '../../../../core/utils/extensions.dart';

/// Seleção compacta de culturas — lista completa só no painel.
class CulturasSelector extends StatelessWidget {
  const CulturasSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  void _openPicker(BuildContext context) {
    showAppBottomSheet<void>(
      context: context,
      builder: (_) => _CulturasPickerSheet(
        initial: selected,
        onApply: onChanged,
      ),
    );
  }

  void _remove(String cultura) {
    final next = List<String>.from(selected)..remove(cultura);
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Culturas de uso',
          style: AppTypography.caption.copyWith(color: context.appTextSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (selected.isEmpty)
          Text(
            'Nenhuma cultura selecionada',
            style: AppTypography.body.copyWith(color: context.appTextDisabled),
          )
        else
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: selected.map((cultura) {
              return InputChip(
                label: Text(
                  cultura,
                  style: AppTypography.label.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onDeleted: () => _remove(cultura),
                deleteIcon: PhosphorIcon(
                  PhosphorIconsRegular.x,
                  size: 14,
                  color: context.appTextSecondary,
                ),
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.35),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: AppSpacing.sm),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _openPicker(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PhosphorIcon(
                PhosphorIconsRegular.plusCircle,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                selected.isEmpty ? 'Selecionar culturas' : 'Editar culturas',
                style: AppTypography.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CulturasPickerSheet extends StatefulWidget {
  const _CulturasPickerSheet({
    required this.initial,
    required this.onApply,
  });

  final List<String> initial;
  final ValueChanged<List<String>> onApply;

  @override
  State<_CulturasPickerSheet> createState() => _CulturasPickerSheetState();
}

class _CulturasPickerSheetState extends State<_CulturasPickerSheet> {
  late Set<String> _picked;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _picked = Set<String>.from(widget.initial);
  }

  List<String> get _filtered {
    final q = _query.trim().toLowerCase();
    final list = culturasCatalogo;
    if (q.isEmpty) return list;
    return list.where((c) => c.toLowerCase().contains(q)).toList();
  }

  void _toggle(String cultura, bool on) {
    setState(() {
      if (on) {
        _picked.add(cultura);
      } else {
        _picked.remove(cultura);
      }
    });
  }

  void _apply() {
    final next = _picked.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    widget.onApply(next);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.72;

    return SizedBox(
      height: height,
      child: AppBottomSheetScaffold(
        header: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Culturas de uso',
                  style: AppTypography.h3,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _apply,
                child: const Text(
                  'Concluir',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        bodyPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        body: Column(
          children: [
            CupertinoSearchTextField(
              placeholder: 'Buscar cultura...',
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (_picked.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_picked.length} selecionada${_picked.length == 1 ? '' : 's'}',
                    style: AppTypography.caption.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: context.appBorder,
                ),
                itemBuilder: (context, index) {
                  final cultura = _filtered[index];
                  final isOn = _picked.contains(cultura);
                  return CheckboxListTile(
                    value: isOn,
                    onChanged: (v) => _toggle(cultura, v ?? false),
                    title: Text(
                      cultura,
                      style: AppTypography.body.copyWith(
                        color: context.appTextPrimary,
                      ),
                    ),
                    activeColor: AppColors.primary,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
