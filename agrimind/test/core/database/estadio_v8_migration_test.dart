import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/estadio_v8_migration.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  Future<void> seedPlano({required String planoId}) async {
    final now = DateTime.utc(2026, 6, 27);
    await database.into(database.planos).insert(
          PlanosCompanion.insert(
            uid: planoId,
            nome: 'Plano teste',
            cultura: 'Soja',
            safra: '2026/27',
            areaHaTotal: 100,
            status: 'rascunho',
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  test('renomeia estádio V8 para V7 quando plano não tem V7', () async {
    const planoId = 'plano-1';
    final now = DateTime.utc(2026, 6, 27);
    await seedPlano(planoId: planoId);
    await database.into(database.estadios).insert(
          EstadiosCompanion.insert(
            uid: 'estadio-v8',
            planoId: planoId,
            codigo: 'V8',
            label: 'V8 — 8º Nó',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await migrateEstadioV8ToV7(database);

    final stages = await database.select(database.estadios).get();
    expect(stages, hasLength(1));
    expect(stages.single.codigo, 'V7');
    expect(stages.single.label, 'V7 — 7º Nó');
  });

  test('move produtos de V8 para V7 e remove V8 quando ambos existem',
      () async {
    const planoId = 'plano-2';
    final now = DateTime.utc(2026, 6, 27);
    await seedPlano(planoId: planoId);
    await database.into(database.estadios).insert(
          EstadiosCompanion.insert(
            uid: 'estadio-v7',
            planoId: planoId,
            codigo: 'V7',
            label: 'V7 — 7º Nó',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.estadios).insert(
          EstadiosCompanion.insert(
            uid: 'estadio-v8',
            planoId: planoId,
            codigo: 'V8',
            label: 'V8 — 8º Nó',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.produtosAplicacao).insert(
          ProdutosAplicacaoCompanion.insert(
            uid: 'produto-v8',
            estadioId: 'estadio-v8',
            produtoNome: 'Produto V8',
            produtoCategoria: 'Fungicida',
            dose: 1,
            doseUnidade: 'L/ha',
            areaHa: 100,
            createdAt: now,
            updatedAt: now,
          ),
        );

    await migrateEstadioV8ToV7(database);

    final activeStages = await (database.select(database.estadios)
          ..where((row) => row.deletedAt.isNull()))
        .get();
    expect(activeStages, hasLength(1));
    expect(activeStages.single.codigo, 'V7');

    final products = await (database.select(database.produtosAplicacao)
          ..where((row) => row.deletedAt.isNull()))
        .get();
    expect(products, hasLength(1));
    expect(products.single.estadioId, 'estadio-v7');
  });

  test('migra referências técnicas de V8 para V7', () async {
    await database.into(database.referenciasTecnicas).insert(
          ReferenciasTecnicasCompanion.insert(
            uid: 'ref-v8',
            categoria: 'Insetos',
            estadio: 'V8',
            titulo: 'Ref V8',
          ),
        );

    await migrateEstadioV8ToV7(database);

    final refs = await database.select(database.referenciasTecnicas).get();
    expect(refs.single.estadio, 'V7');
  });
}
