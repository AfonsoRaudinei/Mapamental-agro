import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Linha de chips de estádio fenológico com seleção.
class EstadioChipRow extends StatelessWidget {
  const EstadioChipRow({
    super.key,
    required this.selectedEstadio,
    required this.estadiosDisponiveis,
    required this.onSelect,
  });

  final String selectedEstadio;
  final List<String> estadiosDisponiveis;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: estadiosDisponiveis.map((est) {
          final isSelected = est == selectedEstadio;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: GestureDetector(
              onTap: () => onSelect(est),
              child: AnimatedContainer(
                duration: AppConstants.animFast,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : context.appSurface,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : context.appBorder,
                  ),
                ),
                child: Text(
                  est,
                  style: AppTypography.label.copyWith(
                    color: isSelected ? Colors.white : context.appTextPrimary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
