import '../entities/user_entity.dart';

/// Contrato abstrato do repositório de autenticação.
/// Implementado em [AuthRepositoryImpl] na camada de dados.
abstract class AuthRepository {
  /// Stream do estado de autenticação (emite null quando deslogado).
  Stream<UserEntity?> get authStateChanges;

  /// Usuário atualmente autenticado, ou null.
  Future<UserEntity?> get currentUser;

  /// Login com e-mail e senha.
  Future<UserEntity> loginWithEmail({
    required String email,
    required String senha,
  });

  /// Cadastro com e-mail, senha e nome.
  Future<UserEntity> registerWithEmail({
    required String email,
    required String senha,
    required String nome,
  });

  /// Login social com Google.
  Future<UserEntity> loginWithGoogle();

  /// Login social com Apple.
  Future<UserEntity> loginWithApple();

  /// Envia e-mail de recuperação de senha.
  Future<void> recoverPassword(String email);

  /// Realiza logout da conta.
  Future<void> logout();

  /// Exclui a conta permanentemente.
  Future<void> deleteAccount();
}
