import 'package:drift/drift.dart';

import 'app_database.dart';

Future<bool> talhoesSafraHasColumn(
  AppDatabase database,
  String columnName,
) async {
  final rows = await database.customSelect(
    'PRAGMA table_info(talhoes_safra)',
  ).get();
  return rows.any((r) => r.read<String>('name') == columnName);
}

/// Evita falha quando v19 já criou a tabela com todas as colunas do schema atual.
Future<void> addTalhoesSafraColumnIfMissing(
  AppDatabase database,
  Migrator migrator,
  String columnName,
  Future<void> Function() addColumn,
) async {
  if (await talhoesSafraHasColumn(database, columnName)) return;
  await addColumn();
}
