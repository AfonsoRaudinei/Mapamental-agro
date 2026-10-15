import '../repositories/auth_repository.dart';

/// Caso de uso: exclusão permanente de conta.
class DeleteAccountUseCase {
  const DeleteAccountUseCase(this._repository);
  final AuthRepository _repository;

  Future<void> call() => _repository.deleteAccount();
}
