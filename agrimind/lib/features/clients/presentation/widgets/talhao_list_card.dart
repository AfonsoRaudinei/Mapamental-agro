import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/talhao_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Linha de talhão na FarmDetailPage.
class TalhaoListCard extends StatelessWidget {
  const TalhaoListCard({
    super.key,
    required this.talhao,
    this.onTap,
  });

  final TalhaoEntity talhao;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appBorder),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  talhao.nome,
                  style:
                      AppTypography.body.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '${talhao.areaHa.toStringAsFixed(1)} ha',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: context.appTextSecondary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
