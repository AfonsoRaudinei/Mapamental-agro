import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/talhao_entity.dart';

/// Chip de talhão para exibição compacta.
class TalhaoChip extends StatelessWidget {
  const TalhaoChip({
    super.key,
    required this.talhao,
    this.onDelete,
  });

  final TalhaoEntity talhao;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${talhao.nome} — ${talhao.areaHa.toStringAsFixed(1)} ha',
            style: AppTypography.label.copyWith(color: AppColors.primary),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDelete,
              child:
                  const Icon(Icons.close, size: 14, color: AppColors.primary),
            ),
          ],
        ],
      ),
    );
  }
}
