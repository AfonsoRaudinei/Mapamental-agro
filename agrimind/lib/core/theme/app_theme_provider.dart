import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que controla o modo escuro do app.
/// A partir do Sprint 8, o valor será persistido no banco local.
class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier([super.initialValue = false]);

  void toggle() => state = !state;
  void setValue(bool value) => state = value;
}

/// Provider do modo escuro — observado pelo [AgriMindApp].
final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
  (ref) => DarkModeNotifier(),
);
