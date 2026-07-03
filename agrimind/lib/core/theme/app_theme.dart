import 'package:flutter/material.dart';

import 'theme_dark_black.dart';
import 'theme_provider.dart';

/// Ponte de temas — compatível com IDs legados do ecossistema SoloForte (`dark`, `blue`, `green`).
ThemeData getThemeData(AppTheme theme) => theme.data;

ThemeData themeFromLegacyId(String? id) {
  switch (id) {
    case 'blue':
    case 'green':
    case 'light':
      return AppTheme.light.data;
    case 'dark':
    case 'darkBlack':
    case null:
    default:
      return AppTheme.darkBlack.data;
  }
}

/// Compatibilidade retroativa com `AppThemeData` do SoloForte.
abstract final class AppThemeData {
  static ThemeData dark() => darkBlackTheme;
  static ThemeData light() => AppTheme.light.data;
}
