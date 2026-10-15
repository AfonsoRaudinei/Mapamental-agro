import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../constants/app_spacing.dart';

/// Tema do AgriMind — iOS-feel com Design System SoloForte.
class AppTheme {
  AppTheme._();

  // ── LIGHT ─────────────────────────────────────────────────────────────────
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: _appBarTheme(isDark: false),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      inputDecorationTheme: _inputDecorationTheme(isDark: false),
      cardTheme: _cardTheme(isDark: false),
      bottomSheetTheme: _bottomSheetTheme(isDark: false),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 0.5,
        space: 0,
      ),
      textTheme: _textTheme(isDark: false),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
      ),
    );
  }

  // ── DARK ──────────────────────────────────────────────────────────────────
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: _appBarTheme(isDark: true),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      inputDecorationTheme: _inputDecorationTheme(isDark: true),
      cardTheme: _cardTheme(isDark: true),
      bottomSheetTheme: _bottomSheetTheme(isDark: true),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDark,
        thickness: 0.5,
        space: 0,
      ),
      textTheme: _textTheme(isDark: true),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
      ),
    );
  }

  // ── COLOR SCHEMES ─────────────────────────────────────────────────────────
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.primaryDark,
    onSecondary: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    error: AppColors.error,
    onError: Colors.white,
    outline: AppColors.border,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.primaryDark,
    onSecondary: Colors.white,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    error: AppColors.error,
    onError: Colors.white,
    outline: AppColors.borderDark,
  );

  // ── APP BAR ───────────────────────────────────────────────────────────────
  static AppBarTheme _appBarTheme({required bool isDark}) => AppBarTheme(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        foregroundColor:
            isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: AppTypography.h3.copyWith(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.primary, size: 24),
      );

  // ── BOTÃO PRIMÁRIO ────────────────────────────────────────────────────────
  static ElevatedButtonThemeData _elevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          textStyle: AppTypography.button,
        ),
      );

  // ── BOTÃO OUTLINED ────────────────────────────────────────────────────────
  static OutlinedButtonThemeData _outlinedButtonTheme() =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.button,
        ),
      );

  // ── BOTÃO GHOST (TextButton) ──────────────────────────────────────────────
  static TextButtonThemeData _textButtonTheme() => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.button,
          minimumSize: const Size(44, 44),
        ),
      );

  // ── INPUT ─────────────────────────────────────────────────────────────────
  static InputDecorationTheme _inputDecorationTheme({required bool isDark}) =>
      InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: AppTypography.body.copyWith(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.textDisabled),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
      );

  // ── CARD ──────────────────────────────────────────────────────────────────
  static CardThemeData _cardTheme({required bool isDark}) => CardThemeData(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
        margin: EdgeInsets.zero,
      );

  // ── BOTTOM SHEET ─────────────────────────────────────────────────────────
  static BottomSheetThemeData _bottomSheetTheme({required bool isDark}) =>
      BottomSheetThemeData(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        modalBackgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderSoft,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        showDragHandle: false,
      );

  // ── TEXT THEME ────────────────────────────────────────────────────────────
  static TextTheme _textTheme({required bool isDark}) {
    final base = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    return TextTheme(
      displayLarge: AppTypography.h1.copyWith(color: base),
      displayMedium: AppTypography.h2.copyWith(color: base),
      displaySmall: AppTypography.h3.copyWith(color: base),
      bodyLarge: AppTypography.body.copyWith(color: base),
      bodyMedium: AppTypography.body.copyWith(color: base),
      bodySmall: AppTypography.caption.copyWith(color: secondary),
      labelSmall: AppTypography.label.copyWith(color: secondary),
    );
  }
}
