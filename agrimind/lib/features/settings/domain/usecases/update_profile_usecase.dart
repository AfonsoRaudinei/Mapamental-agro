import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repo);
  final SettingsRepository _repo;
  Future<SettingsEntity> call(SettingsEntity s) => _repo.updateProfile(s);
}
