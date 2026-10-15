import 'package:drift/drift.dart';

import 'app_database.dart';

Future<bool> estadiosHasColumn(
  AppDatabase database,
  String columnName,
) async {
  final rows = await database.customSelect(
    'PRAGMA table_info(estadios)',
  ).get();
  return rows.any((r) => r.read<String>('name') == columnName);
}

/// Evita `duplicate column` quando v18 roda de novo (crash antes de subir user_version).
Future<void> addEstadiosColumnIfMissing(
  AppDatabase database,
  Migrator migrator,
  String columnName,
  Future<void> Function() addColumn,
) async {
  if (await estadiosHasColumn(database, columnName)) return;
  await addColumn();
}
