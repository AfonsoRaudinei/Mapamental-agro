import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/database_service.dart';
import 'package:agrimind/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:agrimind/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:agrimind/features/clients/data/datasources/clients_local_datasource.dart';
import 'package:agrimind/features/clients/domain/entities/cliente_entity.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  test('logout limpa escopo local do usuário', () async {
    final database = AppDatabase(NativeDatabase.memory());
    DatabaseService.debugBindDatabase(database);
    DatabaseService.ownerUserId = 'user-a';
    addTearDown(() {
      database.close();
      DatabaseService.ownerUserId = null;
    });

    final clients = ClientsLocalDatasource(database, userId: 'user-a');
    final now = DateTime.utc(2026);
    await clients.create(
      ClienteEntity(
        id: '',
        nome: 'Cliente',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final datasource = _MockAuthDatasource();
    when(() => datasource.logout()).thenAnswer((_) async {});
    final repo = AuthRepositoryImpl(datasource);

    await repo.logout();

    verify(() => datasource.logout()).called(1);
    expect(DatabaseService.ownerUserId, isNull);
    expect(await clients.getAll(), isEmpty);
  });
}
