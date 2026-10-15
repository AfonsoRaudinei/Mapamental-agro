import 'package:agrimind/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:agrimind/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late MockAuthRemoteDatasource datasource;
  late AuthRepositoryImpl repository;
  late User user;

  setUp(() {
    datasource = MockAuthRemoteDatasource();
    repository = AuthRepositoryImpl(datasource);
    user = const User(
      id: 'uid-1',
      appMetadata: {},
      userMetadata: {'full_name': 'Usuário Teste'},
      aud: 'authenticated',
      email: 'teste@agrimind.app',
      createdAt: '2026-06-21T12:00:00.000Z',
    );
  });

  test('mapeia login Supabase para entidade de domínio', () async {
    when(
      () => datasource.loginWithEmail(
        email: 'teste@agrimind.app',
        senha: '12345678',
      ),
    ).thenAnswer((_) async => user);

    final result = await repository.loginWithEmail(
      email: 'teste@agrimind.app',
      senha: '12345678',
    );

    expect(result.id, 'uid-1');
    expect(result.nome, 'Usuário Teste');
    expect(result.email, 'teste@agrimind.app');
  });

  test('usa nome padrão quando metadado não existe', () async {
    final userWithoutName = User(
      id: user.id,
      appMetadata: const {},
      userMetadata: const {},
      aud: user.aud,
      email: user.email,
      createdAt: user.createdAt,
    );
    when(() => datasource.currentUser).thenReturn(userWithoutName);

    expect((await repository.currentUser)?.nome, 'Usuário');
  });
}

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}
