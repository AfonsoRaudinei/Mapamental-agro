import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Ícone de livro dourado — referência técnica (Circular fungicidas).
/// Reutilizável no Plano (estádios) e na aba Referências.
class GoldenBookIcon extends StatelessWidget {
  const GoldenBookIcon({
    super.key,
    this.size = 36,
    this.iconSize = 18,
    this.filled = false,
  });

  final double size;
  final double iconSize;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.goldSurface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.5)),
      ),
      child: Icon(
        filled ? Icons.menu_book : Icons.menu_book_outlined,
        size: iconSize,
        color: AppColors.gold,
      ),
    );
  }
}
