import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._datasource);
  final SettingsLocalDatasource _datasource;

  @override
  Future<SettingsEntity?> getSettings({String? uid}) =>
      _datasource.getSettings(uid: uid);

  @override
  Future<SettingsEntity> ensureProfile({
    required String uid,
    required String nome,
    required String email,
    String? avatarUrl,
  }) =>
      _datasource.ensureProfile(
        uid: uid,
        nome: nome,
        email: email,
        avatarUrl: avatarUrl,
      );

  @override
  Future<SettingsEntity> updateProfile(SettingsEntity s) =>
      _datasource.updateProfile(s);

  @override
  Future<void> setDarkMode(bool value) => _datasource.setDarkMode(value);

  @override
  Future<void> setAppIcon(String iconKey) => _datasource.setAppIcon(iconKey);

  @override
  Future<Map<String, dynamic>> exportAllData() => _datasource.exportAllData();
}
