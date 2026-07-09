import 'package:flutter/material.dart';

/// Tokens de cor do tema Dark Black — ver `.agents/dark-mode-designer.md`
abstract final class AppColors {
  static const background = Color(0xFF0A0A0A);
  static const surface = Color(0xFF141414);
  static const surfaceContainer = Color(0xFF1E1E1E);
  static const surfaceElevated = Color(0xFF2D2D2D);
  static const border = Color(0xFF3D3D3D);
  static const primary = Color(0xFF3B82F6);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFFFFFFFF);
  static const onSurfaceMuted = Color(0xFF9CA3AF);
  static const onSurfaceDim = Color(0xFF6B7280);
  static const error = Color(0xFFEF4444);
  static const gold = Color(0xFFD4AF37);
  static const goldMuted = Color(0xFFCA8A04);
  static const goldDark = Color(0xFF92670A);
  static const goldSurface = Color(0xFF2A2210);

  /// Dourado — ícones de circular/referência técnica (livro).
  static const gold = Color(0xFFD4AF37);
  static const goldMuted = Color(0xFFCA8A04);
  static const goldDark = Color(0xFF92670A);
  static const goldSurface = Color(0xFF2A2210);

  /// Acentos por categoria de referência.
  static const accentDisease = Color(0xFFEF4444);
  static const accentInsect = Color(0xFF3B82F6);
  static const accentNutrition = Color(0xFFA855F7);
  static const accentPhysiology = Color(0xFF22C55E);

  /// ColorScheme M3 completo — evita cards brancos por tokens de superfície ausentes.
  static ColorScheme get darkScheme => const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        secondary: onSurfaceMuted,
        onSecondary: onPrimary,
        error: error,
        onError: onPrimary,
        surface: surface,
        onSurface: onSurface,
        outline: border,
        surfaceContainerLowest: background,
        surfaceContainerLow: surface,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceElevated,
        surfaceContainerHighest: surfaceElevated,
      );
}
