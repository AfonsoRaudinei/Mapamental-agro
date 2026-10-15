import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/plan_schema_v8_migration.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('marca estádios Operacional como tipo operacional na migração', () async {
    final now = DateTime.utc(2026, 9, 30);
    await database.into(database.planos).insert(
          PlanosCompanion.insert(
            uid: 'plano-1',
            nome: 'Plano',
            cultura: 'Soja',
            safra: '2026/27',
            areaHaTotal: 100,
            status: 'rascunho',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.estadios).insert(
          EstadiosCompanion.insert(
            uid: 'op-1',
            planoId: 'plano-1',
            codigo: 'Operacional',
            label: 'Herbicida X',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.estadios).insert(
          EstadiosCompanion.insert(
            uid: 'v4-1',
            planoId: 'plano-1',
            codigo: 'V4',
            label: 'V4 — 4º Nó',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await migratePlanSchemaV8(database);

    final rows = await database.select(database.estadios).get();
    final operacional =
        rows.singleWhere((row) => row.uid == 'op-1');
    final fenologico = rows.singleWhere((row) => row.uid == 'v4-1');
    expect(operacional.tipo, 'operacional');
    expect(fenologico.tipo, 'fenologico');
  });
}
