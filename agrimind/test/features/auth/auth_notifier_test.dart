import 'dart:async';

import 'package:agrimind/core/di/providers.dart';
import 'package:agrimind/features/auth/domain/errors/auth_flow_exception.dart';
import 'package:agrimind/features/auth/domain/entities/user_entity.dart';
import 'package:agrimind/features/auth/domain/repositories/auth_repository.dart';
import 'package:agrimind/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeAuthRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeAuthRepository();
    container = ProviderContainer(
      overrides: [authRepoProvider.overrideWithValue(repository)],
    );
  });

  tearDown(() async {
    container.dispose();
    await repository.dispose();
  });

  test('carrega sessão atual e realiza login por e-mail', () async {
    final subscription = container.listen(authNotifierProvider, (_, __) {});
    expect(await container.read(authNotifierProvider.future), isNull);

    await container.read(authNotifierProvider.notifier).loginWithEmail(
          email: 'teste@agrimind.app',
          senha: '12345678',
        );

    expect(container.read(authNotifierProvider).valueOrNull, testUser);
    subscription.close();
  });

  test('cancelamento social preserva a sessão sem erro', () async {
    repository.googleError = const AuthFlowCancelledException();
    final subscription = container.listen(authNotifierProvider, (_, __) {});
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).loginWithGoogle();

    final state = container.read(authNotifierProvider);
    expect(state.hasError, isFalse);
    expect(state.valueOrNull, isNull);
    subscription.close();
  });

  test('logout limpa o usuário', () async {
    repository.current = testUser;
    final subscription = container.listen(authNotifierProvider, (_, __) {});
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).logout();

    expect(container.read(authNotifierProvider).valueOrNull, isNull);
    expect(repository.logoutCalled, isTrue);
    subscription.close();
  });
}

final testUser = UserEntity(
  id: 'uid-1',
  nome: 'Usuário Teste',
  email: 'teste@agrimind.app',
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

class FakeAuthRepository implements AuthRepository {
  final _controller = StreamController<UserEntity?>.broadcast();
  UserEntity? current;
  Object? googleError;
  bool logoutCalled = false;

  @override
  Stream<UserEntity?> get authStateChanges => _controller.stream;

  @override
  Future<UserEntity?> get currentUser async => current;

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String senha,
  }) async =>
      current = testUser;

  @override
  Future<UserEntity> registerWithEmail({
    required String email,
    required String senha,
    required String nome,
  }) async =>
      current = testUser;

  @override
  Future<UserEntity> loginWithGoogle() async {
    if (googleError != null) throw googleError!;
    return current = testUser;
  }

  @override
  Future<UserEntity> loginWithApple() async => current = testUser;

  @override
  Future<void> recoverPassword(String email) async {}

  @override
  Future<void> logout() async {
    logoutCalled = true;
    current = null;
  }

  @override
  Future<void> deleteAccount() async => current = null;

  Future<void> dispose() => _controller.close();
}
