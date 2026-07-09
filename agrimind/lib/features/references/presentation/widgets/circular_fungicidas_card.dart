import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dark_surface_card.dart';

/// Card de destaque para a Circular fungicidas.
class CircularFungicidasCard extends StatelessWidget {
  const CircularFungicidasCard({super.key});

  static void open(BuildContext context) {
    context.push(AppRoutes.circularFungicidas);
  }

  @override
  Widget build(BuildContext context) {
    return DarkSurfaceCard(
      onTap: () => open(context),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.goldSurface,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.goldDark.withValues(alpha: 0.5),
              ),
            ),
            child: const PhosphorIcon(
              PhosphorIconsRegular.bookOpen,
              size: 20,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Circular fungicidas',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Estádio → doença → fungicida (Embrapa CT-219)',
                  style: TextStyle(
                    color: AppColors.onSurfaceMuted,
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.onSurfaceMuted,
          ),
        ],
      ),
    );
  }
}
