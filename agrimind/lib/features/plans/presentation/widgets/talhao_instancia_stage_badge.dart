import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/theme/plan_stage_card_tokens.dart';

/// Selo no cabeçalho do card: indica que o estádio pertence a um talhão.
class TalhaoInstanciaStageBadge extends StatelessWidget {
  const TalhaoInstanciaStageBadge({super.key, required this.talhaoLabel});

  final String talhaoLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: PlanStageCardTokens.instanceBadgeFill(context),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: PlanStageCardTokens.instanceBorder(context),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(
            PhosphorIconsRegular.mapPin,
            size: 13,
            color: PlanStageCardTokens.instanceBadgeText(context),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              talhaoLabel,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: PlanStageCardTokens.instanceBadgeText(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
