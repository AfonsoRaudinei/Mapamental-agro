import '../repositories/auth_repository.dart';

/// Caso de uso: envio de e-mail de recuperação de senha.
class RecoverPasswordUseCase {
  const RecoverPasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<void> call(String email) => _repository.recoverPassword(email);
}
