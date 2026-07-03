import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Tema escuro black — padrão do AgriMind.
final ThemeData darkBlackTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  canvasColor: AppColors.background,
  primaryColor: AppColors.primary,
  colorScheme: AppColors.darkScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
  ),
  cardTheme: const CardThemeData(
    color: AppColors.surfaceContainer,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: AppColors.border),
    ),
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: AppColors.surfaceContainer,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: AppColors.border),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.surfaceContainer,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: AppColors.onSurface,
    iconColor: AppColors.onSurfaceMuted,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceElevated,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: const TextStyle(
      color: AppColors.onSurfaceMuted,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: const TextStyle(color: AppColors.onSurfaceDim),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.onSurfaceMuted,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    elevation: 0,
    shape: StadiumBorder(),
  ),
  dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: AppColors.onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: AppColors.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(color: AppColors.onSurface, fontSize: 14),
    bodySmall: TextStyle(color: AppColors.onSurfaceMuted, fontSize: 13),
    labelLarge: TextStyle(
      color: AppColors.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  ),
);
