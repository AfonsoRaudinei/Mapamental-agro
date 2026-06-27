import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/referencia_tecnica_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Card especializado para dicas CESB.
class CesbTipCard extends StatelessWidget {
  const CesbTipCard({super.key, required this.cesb});

  final ReferenciaTecnicaEntity cesb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.catCESB.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.catCESB.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título com ícone troféu
          Row(
            children: [
              PhosphorIcon(
                PhosphorIconsRegular.trophy,
                size: 18,
                color: AppColors.catCESB,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  cesb.titulo,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.catCESB,
                  ),
                ),
              ),
              if (cesb.padrao != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.catCESB.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    cesb.padrao!,
                    style: AppTypography.label.copyWith(
                      color: AppColors.catCESB,
                    ),
                  ),
                ),
            ],
          ),

          if (cesb.focoManejo != null) ...[
            const SizedBox(height: 6),
            Text(
              'Foco: ${cesb.focoManejo}',
              style: AppTypography.caption.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          if (cesb.praticas != null) ...[
            const SizedBox(height: 6),
            Text(
              cesb.praticas!,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ],

          if (cesb.destaque != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.catCESB.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🏆 ', style: TextStyle(fontSize: 14)),
                  Text(
                    cesb.destaque!,
                    style: AppTypography.label.copyWith(
                      color: AppColors.catCESB,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
