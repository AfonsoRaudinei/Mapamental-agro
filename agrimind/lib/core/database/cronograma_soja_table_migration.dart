import 'package:drift/drift.dart';

import 'app_database.dart';

Future<bool> cronogramaSojaTalhaoHasColumn(
  AppDatabase database,
  String columnName,
) async {
  final rows = await database.customSelect(
    'PRAGMA table_info(cronogramas_soja_talhao)',
  ).get();
  return rows.any((r) => r.read<String>('name') == columnName);
}

/// Evita falha quando v12 já criou a tabela com todas as colunas do schema atual.
Future<void> addCronogramaSojaColumnIfMissing(
  AppDatabase database,
  Migrator migrator,
  String columnName,
  Future<void> Function() addColumn,
) async {
  if (await cronogramaSojaTalhaoHasColumn(database, columnName)) return;
  await addColumn();
}
