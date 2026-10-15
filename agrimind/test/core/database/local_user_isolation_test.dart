import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/database_service.dart';
import 'package:agrimind/features/clients/data/datasources/clients_local_datasource.dart';
import 'package:agrimind/features/clients/domain/entities/cliente_entity.dart';
import 'package:agrimind/features/settings/presentation/pages/legal_page.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dados locais ficam isolados por userId', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final userA = ClientsLocalDatasource(database, userId: 'user-a');
    final userB = ClientsLocalDatasource(database, userId: 'user-b');
    final now = DateTime.utc(2026);

    await userA.create(
      ClienteEntity(
        id: '',
        nome: 'Cliente A',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await userB.create(
      ClienteEntity(
        id: '',
        nome: 'Cliente B',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );

    expect(await userA.getAll(), hasLength(1));
    expect(await userB.getAll(), hasLength(1));
    expect((await userA.getAll()).single.nome, 'Cliente A');
    expect((await userB.getAll()).single.nome, 'Cliente B');
  });

  test('purgeLocalUserData remove apenas o usuário informado', () async {
    final database = AppDatabase(NativeDatabase.memory());
    DatabaseService.debugBindDatabase(database);
    addTearDown(() {
      database.close();
      DatabaseService.ownerUserId = null;
    });

    final userA = ClientsLocalDatasource(database, userId: 'user-a');
    final userB = ClientsLocalDatasource(database, userId: 'user-b');
    final now = DateTime.utc(2026);

    await userA.create(
      ClienteEntity(
        id: '',
        nome: 'Cliente A',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await userB.create(
      ClienteEntity(
        id: '',
        nome: 'Cliente B',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await DatabaseService.purgeLocalUserData('user-a');

    expect(await userA.getAll(), isEmpty);
    expect(await userB.getAll(), hasLength(1));
  });

  test('URLs legais padrão são válidas', () {
    expect(
      LegalPage.isValidLegalUrl('https://cultivamind.com/privacidade'),
      isTrue,
    );
    expect(LegalPage.isValidLegalUrl('https://cultivamind.com/termos'), isTrue);
    expect(LegalPage.isValidLegalUrl('not-a-url'), isFalse);
  });
}
