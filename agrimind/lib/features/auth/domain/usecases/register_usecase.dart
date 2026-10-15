import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: cadastro com e-mail, senha e nome.
class RegisterUseCase {
  const RegisterUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call({
    required String email,
    required String senha,
    required String nome,
  }) =>
      _repository.registerWithEmail(email: email, senha: senha, nome: nome);
}
