import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'dark_surface_card.dart';

/// Card de template de laboratório — [surfaceContainer], nunca preto puro (#000).
class LabTemplateCard extends StatelessWidget {
  const LabTemplateCard({
    super.key,
    required this.title,
    this.subtitle,
    this.badgeLabel,
    this.onTap,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final String? badgeLabel;
  final VoidCallback? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return DarkSurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          leading ??
              const Icon(Icons.science_outlined, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badgeLabel != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badgeLabel!,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(color: AppColors.onSurfaceMuted, fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
          if (onTap != null)
            const Icon(Icons.chevron_right, color: AppColors.onSurfaceMuted, size: 22),
        ],
      ),
    );
  }
}
