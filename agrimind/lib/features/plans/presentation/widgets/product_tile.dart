import 'package:flutter/material.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/theme/plan_stage_card_tokens.dart';
import '../models/product_view_model.dart';

/// Linha de produto no corpo do card de estádio (swipe no [IosSwipeDelete]).
class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    this.onTap,
  });

  final ProductViewModel product;
  /// `null` = somente leitura (ex.: etapas do talhão).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = product.isActive
        ? PlanStageCardTokens.statusActive
        : PlanStageCardTokens.textMuted(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: PlanStageCardTokens.textPrimary(context),
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.doseTotalLine,
                      style: AppTypography.label.copyWith(
                        color: PlanStageCardTokens.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
