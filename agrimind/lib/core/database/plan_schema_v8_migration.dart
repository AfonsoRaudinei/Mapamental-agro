import 'app_database.dart';

/// Migração v8: tipo de estádio + campos de cultivar no plano.
Future<void> migratePlanSchemaV8(AppDatabase database) async {
  await database.customStatement(
    "UPDATE estadios SET tipo = 'operacional' "
    "WHERE codigo = 'Operacional' AND (tipo IS NULL OR tipo = '' OR tipo = 'fenologico')",
  );
  await database.customStatement(
    "UPDATE estadios SET tipo = 'fenologico' "
    "WHERE tipo IS NULL OR tipo = ''",
  );
}
