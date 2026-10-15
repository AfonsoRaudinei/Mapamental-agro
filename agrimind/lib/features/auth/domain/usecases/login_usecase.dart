import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: login com e-mail e senha.
class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call({required String email, required String senha}) =>
      _repository.loginWithEmail(email: email, senha: senha);
}
