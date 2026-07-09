import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Link/botão de voltar legível no modo black — ex.: "Voltar para plantio".
///
/// Usa [AppColors.primary] para ícone e texto (contraste WCAG AA sobre #0A0A0A).
class PrimaryBackLink extends StatelessWidget {
  const PrimaryBackLink({
    super.key,
    required this.label,
    this.onPressed,
    this.icon = Icons.arrow_back,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed ?? () => Navigator.maybePop(context),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: padding,
          minimumSize: const Size(48, 48),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(icon, size: 18, color: AppColors.primary),
        label: Text(
          label,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
