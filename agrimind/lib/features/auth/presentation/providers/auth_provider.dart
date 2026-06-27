import 'dart:developer' as developer;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/recover_password_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../../../../core/di/providers.dart';
import '../../data/datasources/auth_remote_datasource.dart';

part 'auth_provider.g.dart';

/// Notifier de autenticação — gerencia o estado global do usuário logado.
/// Estado: AsyncValue<UserEntity?> (null = não autenticado).
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<UserEntity?> build() async {
    final repo = ref.read(authRepoProvider);

    final currentUser = await repo.currentUser;

    // Mantém a UI sincronizada com a sessão persistida do Supabase.
    final sub = repo.authStateChanges.listen(
      (user) => state = AsyncData(user),
      onError: (Object e, StackTrace s) => state = AsyncError(e, s),
    );
    ref.onDispose(sub.cancel);

    return currentUser;
  }

  /// Login com e-mail e senha.
  Future<void> loginWithEmail({
    required String email,
    required String senha,
  }) async {
    state = const AsyncLoading();
    state = await _guard(
      () => LoginUseCase(ref.read(authRepoProvider)).call(
        email: email,
        senha: senha,
      ),
    );
  }

  /// Cadastro com e-mail, senha e nome.
  Future<void> registerWithEmail({
    required String email,
    required String senha,
    required String nome,
  }) async {
    state = const AsyncLoading();
    state = await _guard(
      () => RegisterUseCase(ref.read(authRepoProvider)).call(
        email: email,
        senha: senha,
        nome: nome,
      ),
    );
  }

  /// Login com Google.
  Future<void> loginWithGoogle() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await ref.read(authRepoProvider).loginWithGoogle());
    } on AuthFlowCancelledException {
      state = AsyncData(await ref.read(authRepoProvider).currentUser);
    } catch (error, stackTrace) {
      _logFailure('Google', error, stackTrace);
      state = AsyncError(error, stackTrace);
    }
  }

  /// Login com Apple.
  Future<void> loginWithApple() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await ref.read(authRepoProvider).loginWithApple());
    } on AuthFlowCancelledException {
      state = AsyncData(await ref.read(authRepoProvider).currentUser);
    } catch (error, stackTrace) {
      _logFailure('Apple', error, stackTrace);
      state = AsyncError(error, stackTrace);
    }
  }

  /// Envia e-mail de recuperação de senha (não altera o state).
  Future<void> recoverPassword(String email) =>
      RecoverPasswordUseCase(ref.read(authRepoProvider)).call(email);

  /// Logout — limpa o state.
  Future<void> logout() async {
    await LogoutUseCase(ref.read(authRepoProvider)).call();
    state = const AsyncData(null);
  }

  /// Exclui conta permanentemente.
  Future<void> deleteAccount() async {
    await DeleteAccountUseCase(ref.read(authRepoProvider)).call();
    state = const AsyncData(null);
  }

  Future<AsyncValue<UserEntity?>> _guard(
      Future<UserEntity> Function() task) async {
    try {
      return AsyncData(await task());
    } catch (error, stackTrace) {
      _logFailure('E-mail/senha', error, stackTrace);
      return AsyncError(error, stackTrace);
    }
  }

  void _logFailure(String method, Object error, StackTrace stackTrace) {
    developer.log(
      'Falha de autenticação por $method.',
      name: 'agrimind.auth',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
