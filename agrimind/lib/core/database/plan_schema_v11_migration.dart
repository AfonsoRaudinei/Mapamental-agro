import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';

/// v11: sementes vinculadas a estádio (`tipo = sementes`) + `estadio_id` FK.
Future<void> migratePlanSchemaV11(AppDatabase database) async {
  final tables = await database.customSelect(
    "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'sementes_talhao'",
  ).get();
  if (tables.isEmpty) return;

  final columns = await database.customSelect(
    'PRAGMA table_info(sementes_talhao)',
  ).get();
  final hasEstadioId = columns.any(
    (row) => row.read<String>('name') == 'estadio_id',
  );
  if (hasEstadioId) return;

  await database.customStatement('''
    CREATE TABLE IF NOT EXISTS sementes_talhao_v11 (
      uid TEXT NOT NULL PRIMARY KEY,
      user_id TEXT,
      plano_id TEXT NOT NULL REFERENCES planos(uid) ON DELETE CASCADE,
      estadio_id TEXT NOT NULL REFERENCES estadios(uid) ON DELETE CASCADE,
      talhao_id TEXT REFERENCES talhoes(uid) ON DELETE CASCADE,
      cultivar TEXT NOT NULL DEFAULT '',
      populacao_sementes_por_ha REAL NOT NULL DEFAULT 0,
      sementes_por_embalagem INTEGER NOT NULL DEFAULT 5000000,
      espacamento_plantio_cm REAL NOT NULL DEFAULT 0,
      created_at INTEGER NOT NULL,
      updated_at INTEGER NOT NULL,
      sync_state TEXT NOT NULL DEFAULT 'pending',
      deleted_at INTEGER
    )
  ''');

  final existing = await database.customSelect(
    'SELECT uid, user_id, plano_id, talhao_id, cultivar, '
    'populacao_sementes_por_ha, sementes_por_embalagem, espacamento_plantio_cm, '
    'created_at, updated_at, sync_state, deleted_at '
    'FROM sementes_talhao',
  ).get();

  const uuid = Uuid();
  for (final row in existing) {
      final sementeUid = row.read<String>('uid');
      final planoId = row.read<String>('plano_id');
      final userId = row.read<String?>('user_id');
      final talhaoId = row.read<String?>('talhao_id');
      final cultivar = row.read<String>('cultivar');
      final pop = row.read<double>('populacao_sementes_por_ha');
      final emb = row.read<int>('sementes_por_embalagem');
      final esp = row.read<double>('espacamento_plantio_cm');
      final createdAt = row.read<int>('created_at');
      final updatedAt = row.read<int>('updated_at');
      final syncState = row.read<String>('sync_state');
      final deletedAt = row.read<int?>('deleted_at');

      final estadioId = uuid.v4();
      final label = cultivar.trim().isEmpty ? 'Sementes' : cultivar.trim();
      final ordemRow = await database.customSelect(
        'SELECT COALESCE(MAX(ordem), -1) AS m FROM estadios WHERE plano_id = ?',
        variables: [Variable<String>(planoId)],
      ).getSingle();
      final ordem = ordemRow.read<int>('m') + 1;

      await database.customStatement(
        'INSERT INTO estadios (uid, user_id, plano_id, codigo, tipo, label, ordem, '
        'created_at, updated_at, sync_state, deleted_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          estadioId,
          userId,
          planoId,
          'Sementes',
          'sementes',
          label,
          ordem,
          createdAt,
          updatedAt,
          syncState,
          deletedAt,
        ],
      );

      await database.customStatement(
        'INSERT INTO sementes_talhao_v11 (uid, user_id, plano_id, estadio_id, talhao_id, '
        'cultivar, populacao_sementes_por_ha, sementes_por_embalagem, '
        'espacamento_plantio_cm, created_at, updated_at, sync_state, deleted_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          sementeUid,
          userId,
          planoId,
          estadioId,
          talhaoId,
          cultivar,
          pop,
          emb,
          esp,
          createdAt,
          updatedAt,
          syncState,
          deletedAt,
        ],
      );
  }

  await database.customStatement('DROP TABLE sementes_talhao');

  await database.customStatement(
    'ALTER TABLE sementes_talhao_v11 RENAME TO sementes_talhao',
  );
}
