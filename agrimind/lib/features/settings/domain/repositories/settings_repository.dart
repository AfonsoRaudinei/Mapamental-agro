import '../entities/settings_entity.dart';

/// Contrato abstrato do repositório de Configurações.
abstract class SettingsRepository {
  Future<SettingsEntity?> getSettings({String? uid});
  Future<SettingsEntity> ensureProfile({
    required String uid,
    required String nome,
    required String email,
    String? avatarUrl,
  });
  Future<SettingsEntity> updateProfile(SettingsEntity settings);
  Future<void> setDarkMode(bool value);
  Future<void> setAppIcon(String iconKey);
  Future<Map<String, dynamic>> exportAllData();
}
