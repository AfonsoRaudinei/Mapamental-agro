import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

extension StringX on String {
  /// Capitaliza a primeira letra.
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Retorna null se a string for vazia após trim.
  String? get nullIfEmpty => trim().isEmpty ? null : trim();

  /// Mantém apenas dígitos numéricos.
  String get onlyDigits => replaceAll(RegExp(r'\D'), '');

  /// Verifica se é um e-mail válido.
  bool get isValidEmail =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(this);
}

extension DateTimeX on DateTime {
  /// Ex: "07/06/2026"
  String get formatadoCurto =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

  /// Ex: "07/06/2026 às 14:32"
  String get formatadoCompleto {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$formatadoCurto às $h:$m';
  }

  /// Verifica se é hoje.
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }
}

extension DoubleX on double {
  /// Formata como área sem casas decimais desnecessárias: 80 ou 80,5
  String get formatadoArea {
    if (this == truncateToDouble()) return toInt().toString();
    return toStringAsFixed(1).replaceAll('.', ',');
  }
}

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Cores adaptativas — respeitam light/dark sem hardcode.
  Color get appBackground => theme.scaffoldBackgroundColor;
  Color get appSurface => colors.surface;
  Color get appOnSurface => colors.onSurface;
  Color get appBorder => isDark ? AppColors.borderDark : AppColors.border;
  Color get appBorderSoft =>
      isDark ? AppColors.borderDark : AppColors.borderSoft;
  Color get appTextPrimary => colors.onSurface;
  Color get appTextSecondary =>
      isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
  Color get appTextDisabled =>
      isDark ? AppColors.textSecondaryDark : AppColors.textDisabled;
  Color get appTabBarBackground =>
      isDark ? const Color(0xCC1C1C1E) : const Color(0xCCFFFFFF);
}
