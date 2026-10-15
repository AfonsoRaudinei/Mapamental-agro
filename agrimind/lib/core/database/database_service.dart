import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'app_database.dart';
import 'legacy_drift_migration.dart';

class DatabaseService {
  DatabaseService._();

  static AppDatabase? _database;
  static String? ownerUserId;

  static AppDatabase get instance {
    final database = _database;
    if (database == null) {
      throw StateError('DatabaseService ainda não foi inicializado.');
    }
    return database;
  }

  static Future<LegacyMigrationReport> initialize({
    String? sessionUserId,
  }) async {
    if (_database != null) {
      if (sessionUserId != null) {
        await bindOwner(sessionUserId);
      }
      return const LegacyMigrationReport(
        alreadyCompleted: true,
        migratedRecords: 0,
      );
    }

    final database = AppDatabase();
    await database.customSelect('SELECT 1').getSingle();

    try {
      final report = await LegacyDriftMigration(database).migrate(
        const LegacyMigrationBatch(),
      );
      _database = database;
      if (sessionUserId != null) {
        await bindOwner(sessionUserId);
      }
      debugPrint(
        '[DatabaseService] Drift pronto; '
        '${report.migratedRecords} registros migrados.',
      );
      return report;
    } catch (_) {
      await database.close();
      rethrow;
    }
  }

  /// Vincula a sessão local ao usuário autenticado.
  /// Se outro usuário estava ativo, remove os dados locais dele antes.
  static Future<void> bindOwner(String userId) async {
    final previous = ownerUserId;
    if (previous != null && previous != userId) {
      await purgeLocalUserData(previous);
    }
    ownerUserId = userId;
    await _backfillOrphanedUserData(userId);
  }

  /// Remove dados locais do usuário e encerra o escopo da sessão.
  static Future<void> clearUserSession() async {
    final userId = ownerUserId;
    if (userId != null) {
      await purgeLocalUserData(userId);
    }
    ownerUserId = null;
  }

  /// Apaga todos os registros locais vinculados a [userId].
  /// Mantém seeds globais (referências técnicas e catálogo isSeed).
  static Future<void> purgeLocalUserData(String userId) async {
    final database = _database;
    if (database == null) return;

    await database.transaction(() async {
      await (database.delete(database.produtosAplicacao)
            ..where((row) => row.userId.equals(userId)))
          .go();
      await (database.delete(database.estadios)
            ..where((row) => row.userId.equals(userId)))
          .go();
      await (database.delete(database.planos)
            ..where((row) => row.userId.equals(userId)))
          .go();
      await (database.delete(database.talhoes)
            ..where((row) => row.userId.equals(userId)))
          .go();
      await (database.delete(database.fazendas)
            ..where((row) => row.userId.equals(userId)))
          .go();
      await (database.delete(database.clientes)
            ..where((row) => row.userId.equals(userId)))
          .go();
      await (database.delete(database.catalogoProdutos)
            ..where(
              (row) => row.userId.equals(userId) & row.isSeed.equals(false),
            ))
          .go();
      await (database.delete(database.localUsers)
            ..where((row) => row.uid.equals(userId)))
          .go();
    });
  }

  static Future<void> _backfillOrphanedUserData(String userId) async {
    final database = _database;
    if (database == null) return;

    final profiles = await database.select(database.localUsers).get();
    if (profiles.length > 1) return;

    await database.customStatement(
      'UPDATE clientes SET user_id = ? WHERE user_id IS NULL',
      [userId],
    );
    await database.customStatement(
      'UPDATE fazendas SET user_id = ? WHERE user_id IS NULL',
      [userId],
    );
    await database.customStatement(
      'UPDATE talhoes SET user_id = ? WHERE user_id IS NULL',
      [userId],
    );
    await database.customStatement(
      'UPDATE planos SET user_id = ? WHERE user_id IS NULL',
      [userId],
    );
    await database.customStatement(
      'UPDATE estadios SET user_id = ? WHERE user_id IS NULL',
      [userId],
    );
    await database.customStatement(
      'UPDATE produtos_aplicacao SET user_id = ? WHERE user_id IS NULL',
      [userId],
    );
    await database.customStatement(
      'UPDATE catalogo_produtos SET user_id = ? '
      'WHERE user_id IS NULL AND is_seed = 0',
      [userId],
    );
  }

  static Future<void> close() async {
    await _database?.close();
    _database = null;
    ownerUserId = null;
  }

  /// Permite injetar banco em memória nos testes de purge/isolamento.
  @visibleForTesting
  static void debugBindDatabase(AppDatabase database) {
    _database = database;
  }
}
