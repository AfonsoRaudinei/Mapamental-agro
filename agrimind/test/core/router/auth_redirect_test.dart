import 'package:agrimind/core/router/app_router.dart';
import 'package:agrimind/core/router/app_routes.dart';
import 'package:agrimind/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final user = UserEntity(
    id: 'uid-1',
    nome: 'Teste',
    email: 'teste@agrimind.app',
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  test('mantém splash enquanto autenticação carrega', () {
    expect(
      authRedirect(
        auth: const AsyncLoading<UserEntity?>(),
        location: AppRoutes.plans,
      ),
      AppRoutes.splash,
    );
  });

  test('mantém login aberto durante autenticação', () {
    expect(
      authRedirect(
        auth: const AsyncLoading<UserEntity?>(),
        location: AppRoutes.login,
      ),
      isNull,
    );
  });

  test('mantém cadastro aberto durante criação da conta', () {
    expect(
      authRedirect(
        auth: const AsyncLoading<UserEntity?>(),
        location: AppRoutes.register,
      ),
      isNull,
    );
  });

  test('protege rota privada quando deslogado', () {
    expect(
      authRedirect(
        auth: const AsyncData<UserEntity?>(null),
        location: AppRoutes.plans,
      ),
      AppRoutes.login,
    );
  });

  test('redireciona usuário logado para o aplicativo', () {
    expect(
      authRedirect(
        auth: AsyncData<UserEntity?>(user),
        location: AppRoutes.login,
      ),
      AppRoutes.plans,
    );
  });
}
