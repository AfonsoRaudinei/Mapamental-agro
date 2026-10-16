import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
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
    this.plantioLabel,
    this.plantioPendente = false,
  });

  final TalhaoEntity talhao;
  final VoidCallback? onTap;

  /// Ex.: "Plantio 15/10/2026" ou "Definir data de plantio".
  final String? plantioLabel;

  /// Destaca o rótulo quando o talhão ainda não tem plantio (sem cálculo).
  final bool plantioPendente;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      talhao.nome,
                      style: AppTypography.body
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (plantioLabel != null)
                      Text(
                        plantioLabel!,
                        style: AppTypography.caption.copyWith(
                          color: plantioPendente
                              ? AppColors.primary
                              : context.appTextSecondary,
                          fontWeight: plantioPendente
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                  ],
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
