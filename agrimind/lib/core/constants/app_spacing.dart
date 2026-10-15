import 'package:flutter/widgets.dart';

/// Grid de espaçamento base 8px do AgriMind.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  /// Altura do conteúdo da tab bar (sem safe area).
  static const double tabBarContentHeight = 56.0;

  /// Espaço abaixo do último item para não ficar atrás da tab (`extendBody`).
  static double shellBottomGap(BuildContext context) =>
      tabBarContentHeight + MediaQuery.paddingOf(context).bottom + md;
}
