import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

/// Badge colorido de categoria de produto.
class CategoriaBadge extends StatelessWidget {
  const CategoriaBadge({super.key, required this.categoria});

  final String categoria;

  static Color corDaCategoria(String cat) => switch (cat) {
        'Fungicida' => AppColors.catDoencas,
        'Inseticida' => AppColors.catInsetos,
        'Herbicida' => AppColors.catCESB,
        'Fertilizante' => AppColors.catNutricao,
        'Bioestimulante' => AppColors.catFisiologia,
        _ => AppColors.textDisabled,
      };

  @override
  Widget build(BuildContext context) {
    final cor = corDaCategoria(categoria);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        categoria,
        style: AppTypography.label.copyWith(
          color: cor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
