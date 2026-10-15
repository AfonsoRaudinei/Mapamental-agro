import 'app_database.dart';

/// Migração v9: escopo de alocação e lançamentos por talhão.
Future<void> migrateAlocacaoV9(AppDatabase database) async {
  await database.customStatement('''
    CREATE TABLE IF NOT EXISTS escopos_alocacao (
      uid TEXT NOT NULL PRIMARY KEY,
      user_id TEXT,
      produto_aplicacao_id TEXT NOT NULL REFERENCES produtos_aplicacao(uid) ON DELETE CASCADE,
      tipo TEXT NOT NULL,
      talhoes_ids_json TEXT NOT NULL,
      quantidade_total REAL NOT NULL,
      data_criacao INTEGER NOT NULL,
      sync_state TEXT NOT NULL DEFAULT 'pending',
      deleted_at INTEGER
    )
  ''');
  await database.customStatement('''
    CREATE TABLE IF NOT EXISTS alocacoes_talhao (
      uid TEXT NOT NULL PRIMARY KEY,
      user_id TEXT,
      produto_aplicacao_id TEXT NOT NULL REFERENCES produtos_aplicacao(uid) ON DELETE CASCADE,
      talhao_id TEXT NOT NULL REFERENCES talhoes(uid) ON DELETE CASCADE,
      quantidade_alocada REAL NOT NULL,
      origem_escopo_id TEXT NOT NULL REFERENCES escopos_alocacao(uid) ON DELETE CASCADE,
      data_lancamento INTEGER NOT NULL,
      foi_ajustado_manualmente INTEGER NOT NULL DEFAULT 0,
      sync_state TEXT NOT NULL DEFAULT 'pending',
      deleted_at INTEGER
    )
  ''');
}
