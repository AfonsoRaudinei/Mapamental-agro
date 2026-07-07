import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/features/clients/data/datasources/clients_local_datasource.dart';
import 'package:agrimind/features/clients/domain/entities/cliente_entity.dart';
import 'package:agrimind/features/clients/domain/entities/fazenda_entity.dart';
import 'package:agrimind/features/clients/domain/entities/talhao_entity.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ClientsLocalDatasource datasource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    datasource = ClientsLocalDatasource(database, userId: 'test-user');
  });

  tearDown(() => database.close());

  test('CRUD relacional funciona integralmente no Drift', () async {
    final now = DateTime.utc(2026);
    final cliente = await datasource.create(
      ClienteEntity(
        id: '',
        nome: 'Cliente',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final fazenda = await datasource.createFazenda(
      FazendaEntity(
        id: '',
        clienteId: cliente.id,
        nome: 'Fazenda',
        areaHa: 120,
        cultura: 'Soja',
        safra: '2026/27',
        ativo: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final talhao = await datasource.createTalhao(
      TalhaoEntity(
        id: '',
        fazendaId: fazenda.id,
        nome: 'Talhão A',
        areaHa: 30,
        ativo: true,
        createdAt: now,
      ),
    );

    expect(await datasource.getAll(), hasLength(1));
    expect(await datasource.getFazendas(cliente.id), hasLength(1));
    final talhoes = await datasource.getTalhoes(fazenda.id);
    expect(talhoes, hasLength(1));
    expect(talhoes.single.id, talhao.id);
    expect(talhoes.single.nome, 'Talhão A');

    await datasource.deleteTalhao(talhao.id);
    await datasource.deleteFazenda(fazenda.id);
    await datasource.delete(cliente.id);

    expect(await datasource.getAll(), isEmpty);
    expect(await datasource.getAll(includeInactive: true), hasLength(1));
  });
}
