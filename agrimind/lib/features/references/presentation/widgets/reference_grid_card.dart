import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dark_surface_card.dart';
import '../../domain/reference_models.dart';

class ReferenceGridCard extends StatelessWidget {
  const ReferenceGridCard({
    super.key,
    required this.kind,
    this.onTap,
  });

  final ReferenceKind kind;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final available = kind.isAvailable;

    return DarkSurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryIcon(kind: kind),
          const Spacer(),
          Text(
            kind.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            kind.subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceMuted,
                  height: 1.3,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (!available) ...[
            const SizedBox(height: 8),
            Text(
              'Em breve',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceDim,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.kind});

  final ReferenceKind kind;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kind.accentColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        kind.icon,
        size: 18,
        color: kind.accentColor,
      ),
    );
  }
}
