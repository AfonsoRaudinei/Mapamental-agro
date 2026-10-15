import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/extensions.dart';

/// Card full-width do hub — Circular fungicidas (livro dourado).
class CircularFungicidasCard extends StatelessWidget {
  const CircularFungicidasCard({super.key});

  static void open(BuildContext context) {
    context.push(AppRoutes.circularFungicidas);
  }

  @override
  Widget build(BuildContext context) {
    const gold = AppColors.refBookFungicidas;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gold.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => open(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 96,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: gold.withValues(alpha: 0.22)),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.refBookFungicidasSurface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.refBookFungicidasDark
                          .withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Center(
                    child: PhosphorIcon(
                      PhosphorIconsFill.bookOpen,
                      size: 26,
                      color: gold,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Circular fungicidas',
                        style: AppTypography.h3.copyWith(
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Estádio → doença → fungicida (Embrapa CT-219)',
                        style: AppTypography.caption.copyWith(
                          color: context.appTextSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PhosphorIcon(
                  PhosphorIconsRegular.caretRight,
                  size: 16,
                  color: context.appTextDisabled,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
