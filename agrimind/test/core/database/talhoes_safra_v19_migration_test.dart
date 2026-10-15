import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/talhoes_safra_v19_migration.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v19 lê plantio_definido sem read<Object?>', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final now = DateTime(2026, 3, 1);
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
            nome: 'Talhão',
            areaHa: 50,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.planos).insert(
          PlanosCompanion.insert(
            uid: 'p1',
            nome: 'Plano',
            fazendaId: const Value('f1'),
            cultura: 'Soja',
            safra: '25/26',
            areaHaTotal: 100,
            status: 'ativo',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database.into(database.cronogramasSojaTalhao).insert(
          CronogramasSojaTalhaoCompanion.insert(
            uid: 'cron1',
            talhaoId: 't1',
            cultura: 'Soja',
            dataPlantio: now,
            plantioDefinido: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
        );

    await database.customStatement('DROP TABLE IF EXISTS talhoes_safra');
    await database.customStatement('''
      CREATE TABLE talhoes_safra (
        uid TEXT NOT NULL PRIMARY KEY,
        user_id TEXT,
        plano_id TEXT NOT NULL,
        talhao_id TEXT NOT NULL,
        cultura TEXT NOT NULL,
        material_cultivar TEXT NOT NULL DEFAULT '',
        data_plantio INTEGER NOT NULL,
        dias_emergencia INTEGER NOT NULL DEFAULT 5,
        dae_pos_emergente INTEGER NOT NULL DEFAULT 25,
        dias_recuperacao_pos_emergente INTEGER NOT NULL DEFAULT 5,
        intervalo_fungicida_dias INTEGER NOT NULL DEFAULT 15,
        total_aplicacoes_fungicida INTEGER NOT NULL DEFAULT 4,
        dae_maturacao_ciclo INTEGER NOT NULL DEFAULT 110,
        dias_antes_r8_dessecante INTEGER NOT NULL DEFAULT 12,
        dias_antecipacao_colheita_real INTEGER NOT NULL DEFAULT 5,
        dias_dessecacao_pre_plantio INTEGER NOT NULL DEFAULT 15,
        grupo_regulagem_id TEXT NOT NULL DEFAULT '',
        plantio_definido INTEGER NOT NULL DEFAULT 0,
        ordem INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        sync_state TEXT NOT NULL DEFAULT 'pending',
        deleted_at INTEGER
      )
    ''');

    await migrateTalhoesSafraV19(database);

    final plantio = await database.customSelect(
      'SELECT plantio_definido FROM talhoes_safra WHERE talhao_id = ?',
      variables: [Variable.withString('t1')],
      readsFrom: {database.talhoesSafra},
    ).getSingle();
    expect(plantio.read<int>('plantio_definido'), 1);
  });
}
