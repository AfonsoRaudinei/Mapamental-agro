import '../repositories/settings_repository.dart';

class ToggleDarkModeUseCase {
  const ToggleDarkModeUseCase(this._repo);
  final SettingsRepository _repo;
  Future<void> call({required bool value}) => _repo.setDarkMode(value);
}
