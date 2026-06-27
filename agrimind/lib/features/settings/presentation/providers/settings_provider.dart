import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/theme/app_theme_provider.dart';
import '../../domain/entities/settings_entity.dart';

part 'settings_provider.g.dart';

/// Provider principal de configurações e perfil do usuário.
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  FutureOr<SettingsEntity?> build() async {
    final repo = ref.read(settingsRepoProvider);
    final authUser = await ref.read(authRepoProvider).currentUser;
    if (authUser == null) return repo.getSettings();

    final existing = await repo.getSettings(uid: authUser.id);
    if (existing != null) return existing;

    return repo.ensureProfile(
      uid: authUser.id,
      nome: authUser.nome,
      email: authUser.email,
      avatarUrl: authUser.avatarUrl,
    );
  }

  /// Atualiza perfil (nome, telefone, empresa, CRA).
  Future<void> updateProfile(SettingsEntity s) async {
    await ref.read(settingsRepoProvider).updateProfile(s);
    ref.invalidateSelf();
  }

  /// Alterna modo escuro e sincroniza com o ThemeProvider.
  Future<void> setDarkMode(bool value) async {
    await ref.read(settingsRepoProvider).setDarkMode(value);
    ref.read(darkModeProvider.notifier).setValue(value);
    ref.invalidateSelf();
  }

  /// Altera ícone do app.
  Future<void> setAppIcon(String iconKey) async {
    await ref.read(settingsRepoProvider).setAppIcon(iconKey);
    ref.invalidateSelf();
  }
}
