import 'package:flutter/foundation.dart';

import 'app_database.dart';
import 'legacy_drift_migration.dart';

class DatabaseService {
  DatabaseService._();

  static AppDatabase? _database;

  static AppDatabase get instance {
    final database = _database;
    if (database == null) {
      throw StateError('DatabaseService ainda não foi inicializado.');
    }
    return database;
  }

  static Future<LegacyMigrationReport> initialize({String? ownerUserId}) async {
    if (_database != null) {
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

  static Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
