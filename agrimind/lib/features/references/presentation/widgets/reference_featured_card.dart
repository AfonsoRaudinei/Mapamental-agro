import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dark_surface_card.dart';
import '../../domain/reference_models.dart';
import 'golden_book_icon.dart';

class ReferenceFeaturedCard extends StatelessWidget {
  const ReferenceFeaturedCard({
    super.key,
    required this.kind,
    this.onTap,
    this.useGoldenBookIcon = false,
  });

  final ReferenceKind kind;
  final VoidCallback? onTap;
  final bool useGoldenBookIcon;

  @override
  Widget build(BuildContext context) {
    final isCesb = kind == ReferenceKind.campeoesCesb;
    final available = kind.isAvailable;

    return DarkSurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          if (useGoldenBookIcon)
            const GoldenBookIcon(size: 40, iconSize: 20)
          else
            _FeaturedIcon(kind: kind),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kind.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isCesb || useGoldenBookIcon
                            ? AppColors.gold
                            : AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  kind.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!available) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Em breve',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.onSurfaceDim,
                        ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: available ? AppColors.onSurfaceMuted : AppColors.onSurfaceDim,
          ),
        ],
      ),
    );
  }
}

/// Card com borda dourada para destaque especial (ex.: Campeões CESB).
class ReferenceFeaturedBorderedCard extends StatelessWidget {
  const ReferenceFeaturedBorderedCard({
    super.key,
    required this.kind,
    this.onTap,
  });

  final ReferenceKind kind;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldMuted.withValues(alpha: 0.6)),
      ),
      child: ReferenceFeaturedCard(kind: kind, onTap: onTap),
    );
  }
}

class _FeaturedIcon extends StatelessWidget {
  const _FeaturedIcon({required this.kind});

  final ReferenceKind kind;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.goldSurface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.4)),
      ),
      child: Icon(
        kind.icon,
        size: 20,
        color: AppColors.gold,
      ),
    );
  }
}
