import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/extensions.dart';

/// Superfícies do canvas do plano (light/dark via [BuildContext]).
abstract final class PlanStageCardTokens {
  static const Color groupedLight = Color(0xFFEEF0F3);
  static const Color footerLight = Color(0xFFE6E8EC);

  static Color canvas(BuildContext context) =>
      context.isDark ? context.appBackground : groupedLight;

  static Color card(BuildContext context) => context.appSurface;

  static Color footerCard(BuildContext context) =>
      context.isDark ? context.appSurface : footerLight;

  static Color border(BuildContext context) => context.appBorderSoft;

  static Color separator(BuildContext context) => context.appBorderSoft;

  static Color textPrimary(BuildContext context) => context.appTextPrimary;

  static Color textSecondary(BuildContext context) => context.appTextSecondary;

  static Color textMuted(BuildContext context) => context.appTextSecondary;

  static const Color accent = AppColors.primary;

  static const Color statusActive = AppColors.primary;

  /// Borda de cards instanciados (pertencem a um talhão).
  static Color instanceBorder(BuildContext context) =>
      AppColors.primary.withValues(alpha: context.isDark ? 0.65 : 0.45);

  static Color instanceBadgeFill(BuildContext context) =>
      AppColors.primary.withValues(alpha: context.isDark ? 0.22 : 0.1);

  static Color instanceBadgeText(BuildContext context) =>
      context.isDark ? AppColors.primaryLight : AppColors.primary;

  static List<BoxShadow>? cardShadow(BuildContext context) {
    if (context.isDark) return null;
    return const [
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
    ];
  }
}
