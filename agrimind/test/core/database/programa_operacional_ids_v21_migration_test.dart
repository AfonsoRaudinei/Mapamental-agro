import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/programa_operacional_ids_v21_migration.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/programa_operacional_ids_codec.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = ON');
  });

  tearDown(() async {
    await database.close();
  });

  test('migration v21 copia todos os programas do join para talhoes_safra',
      () async {
    final now = DateTime(2026, 1, 1);
    await database.into(database.clientes).insert(
          ClientesCompanion.insert(
            uid: 'c1',
            nome: 'Cliente',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.fazendas).insert(
          FazendasCompanion.insert(
            uid: 'f1',
            clienteId: 'c1',
            nome: 'Fazenda',
            areaHa: 100,
            cultura: 'Soja',
            safra: '25/26',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.talhoes).insert(
          TalhoesCompanion.insert(
            uid: 't1',
            fazendaId: 'f1',
            nome: 'Talhão 1',
            areaHa: 50,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.planos).insert(
          PlanosCompanion.insert(
            uid: 'p1',
            nome: 'Plano',
            cultura: 'Soja',
            safra: '25/26',
            areaHaTotal: 100,
            status: 'ativo',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.talhoesSafra).insert(
          TalhoesSafraCompanion.insert(
            uid: 'ts1',
            planoId: 'p1',
            talhaoId: 't1',
            cultura: 'Soja',
            dataPlantio: now,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.estadios).insert(
          EstadiosCompanion.insert(
            uid: 'e1',
            planoId: 'p1',
            codigo: 'Operacional',
            label: 'Plantio',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.programasOperacionais).insert(
          ProgramasOperacionaisCompanion.insert(
            uid: 'prog1',
            planoId: 'p1',
            talhaoId: 't1',
            tipo: 'plantio',
            regraCalculo: 'referenciaPlantio',
            estadioId: const Value('e1'),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.programasOperacionais).insert(
          ProgramasOperacionaisCompanion.insert(
            uid: 'prog2',
            planoId: 'p1',
            talhaoId: 't1',
            tipo: 'fungicidaRecorrente',
            regraCalculo: 'recorrente',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final populados = await migrateProgramaOperacionalIdsV21(database);
    expect(populados, 1);

    final row = await (database.select(database.talhoesSafra)
          ..where((t) => t.uid.equals('ts1')))
        .getSingle();
    final ids = decodeProgramaOperacionalIds(row.programaOperacionalIds);
    expect(ids, containsAll(['prog1', 'prog2']));
    expect(ids.length, 2);
  });
}
