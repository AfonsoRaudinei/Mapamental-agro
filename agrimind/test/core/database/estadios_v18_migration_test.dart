import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/estadios_table_migration.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v18 não duplica tipo_operacional se coluna já existe', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.customStatement('DROP TABLE IF EXISTS estadios');
    await database.customStatement('''
      CREATE TABLE estadios (
        uid TEXT NOT NULL PRIMARY KEY,
        user_id TEXT,
        plano_id TEXT NOT NULL,
        codigo TEXT NOT NULL,
        tipo TEXT NOT NULL DEFAULT 'fenologico',
        label TEXT NOT NULL,
        ordem INTEGER NOT NULL DEFAULT 0,
        data_aplicacao INTEGER,
        image_local_path TEXT,
        observacao TEXT,
        tipo_operacional TEXT,
        operacional_config TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        sync_state TEXT NOT NULL DEFAULT 'pending',
        deleted_at INTEGER
      )
    ''');

    var migrator = database.createMigrator();
    await addEstadiosColumnIfMissing(
      database,
      migrator,
      'tipo_operacional',
      () => migrator.addColumn(database.estadios, database.estadios.tipoOperacional),
    );
    await addEstadiosColumnIfMissing(
      database,
      migrator,
      'operacional_config',
      () => migrator.addColumn(database.estadios, database.estadios.operacionalConfig),
    );

    final cols = await database.customSelect('PRAGMA table_info(estadios)').get();
    final tipoCount = cols
        .where((r) => r.read<String>('name') == 'tipo_operacional')
        .length;
    expect(tipoCount, 1);
  });
}
