import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_dark_black.dart';

enum AppTheme { darkBlack, light }

const _themeKey = 'app_theme';

extension AppThemeX on AppTheme {
  bool get isDark => this == AppTheme.darkBlack;

  ThemeData get data => switch (this) {
        AppTheme.darkBlack => darkBlackTheme,
        AppTheme.light => ThemeData.light(useMaterial3: true),
      };

  String get storageId => name;

  /// ID legado SoloForte (`dark`, `blue`, `green`).
  String get legacyId => isDark ? 'dark' : 'blue';

  static AppTheme fromLegacyId(String? id) {
    switch (id) {
      case 'blue':
      case 'green':
      case 'light':
        return AppTheme.light;
      case 'dark':
      case 'darkBlack':
      case null:
      default:
        return AppTheme.darkBlack;
    }
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme.darkBlack) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeId = prefs.getString(_themeKey);
      state = AppThemeX.fromLegacyId(themeId);
    } catch (_) {
      state = AppTheme.darkBlack;
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    state = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.storageId);
  }
}
