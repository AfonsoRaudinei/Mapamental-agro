import 'package:drift/drift.dart';

import 'app_database.dart';

const legacyDriftMigrationKey = 'legacy_drift_v1';

class LegacyMigrationBatch {
  const LegacyMigrationBatch({
    this.users = const [],
    this.clientes = const [],
    this.fazendas = const [],
    this.talhoes = const [],
    this.catalogo = const [],
    this.referencias = const [],
    this.planos = const [],
    this.estadios = const [],
    this.produtosAplicacao = const [],
  });

  final List<LocalUsersCompanion> users;
  final List<ClientesCompanion> clientes;
  final List<FazendasCompanion> fazendas;
  final List<TalhoesCompanion> talhoes;
  final List<CatalogoProdutosCompanion> catalogo;
  final List<ReferenciasTecnicasCompanion> referencias;
  final List<PlanosCompanion> planos;
  final List<EstadiosCompanion> estadios;
  final List<ProdutosAplicacaoCompanion> produtosAplicacao;

  int get total =>
      users.length +
      clientes.length +
      fazendas.length +
      talhoes.length +
      catalogo.length +
      referencias.length +
      planos.length +
      estadios.length +
      produtosAplicacao.length;
}

class LegacyMigrationReport {
  const LegacyMigrationReport({
    required this.alreadyCompleted,
    required this.migratedRecords,
  });

  final bool alreadyCompleted;
  final int migratedRecords;
}

class LegacyDriftMigration {
  const LegacyDriftMigration(this._database);

  final AppDatabase _database;

  Future<LegacyMigrationReport> migrate(LegacyMigrationBatch batch) async {
    if (await _database.hasCompletedMigration(legacyDriftMigrationKey)) {
      return const LegacyMigrationReport(
        alreadyCompleted: true,
        migratedRecords: 0,
      );
    }

    await _database.transaction(() async {
      await _insertAll(_database.localUsers, batch.users);
      await _insertAll(_database.clientes, batch.clientes);
      await _insertAll(_database.fazendas, batch.fazendas);
      await _insertAll(_database.talhoes, batch.talhoes);
      await _insertAll(_database.catalogoProdutos, batch.catalogo);
      await _insertAll(_database.referenciasTecnicas, batch.referencias);
      await _insertAll(_database.planos, batch.planos);
      await _insertAll(_database.estadios, batch.estadios);
      await _insertAll(
        _database.produtosAplicacao,
        batch.produtosAplicacao,
      );
      await _database.markMigrationCompleted(legacyDriftMigrationKey);
    });

    return LegacyMigrationReport(
      alreadyCompleted: false,
      migratedRecords: batch.total,
    );
  }

  Future<void> _insertAll<T extends Table, D>(
    TableInfo<T, D> table,
    List<Insertable<D>> rows,
  ) async {
    if (rows.isEmpty) return;
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(table, rows);
    });
  }
}
