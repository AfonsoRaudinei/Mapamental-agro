import '../repositories/auth_repository.dart';

/// Caso de uso: logout da conta.
class LogoutUseCase {
  const LogoutUseCase(this._repository);
  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
