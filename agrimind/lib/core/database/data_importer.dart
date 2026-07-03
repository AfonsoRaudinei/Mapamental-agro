import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/plan/domain/plan_models.dart';
import 'app_database.dart';

/// Importa dados de um snapshot JSON (ex.: export local / backup).
///
/// Formato esperado:
/// ```json
/// {
///   "clients": [{"id":"...","name":"...","area_ha":1000,"harvest":"2025/26"}],
///   "plans": [{"id":"...","client_id":"..."}],
///   "stages": [{"id":"...","plan_id":"...","code":"VC","name":"Cotilédone","sort_order":0}],
///   "products": [{"id":"...","stage_id":"...","name":"Roundup"}]
/// }
/// ```
class DataImporter {
  DataImporter(this._db);

  final AppDatabase _db;

  Future<ImportResult> importSnapshot(Map<String, dynamic> snapshot) async {
    var clients = 0;
    var plans = 0;
    var stages = 0;
    var products = 0;

    for (final raw in snapshot['clients'] as List<dynamic>? ?? []) {
      final map = Map<String, Object?>.from(raw as Map);
      await _db.upsertClient(ClientModel.fromMap(map));
      clients++;
    }

    for (final raw in snapshot['plans'] as List<dynamic>? ?? []) {
      final map = Map<String, Object?>.from(raw as Map);
      await _db.upsertPlan(PlanModel.fromMap(map));
      plans++;
    }

    for (final raw in snapshot['stages'] as List<dynamic>? ?? []) {
      final map = Map<String, Object?>.from(raw as Map);
      await _db.upsertStage(StageModel.fromMap(map));
      stages++;
    }

    for (final raw in snapshot['products'] as List<dynamic>? ?? []) {
      final map = Map<String, Object?>.from(raw as Map);
      await _db.upsertProduct(ProductModel.fromMap(map));
      products++;
    }

    return ImportResult(
      clients: clients,
      plans: plans,
      stages: stages,
      products: products,
    );
  }

  /// Mescla preferência de tema legada (`dark`/`blue`/`green`) para AgriMind.
  static Future<void> migrateLegacyThemePreference() async {
    const legacyKeys = ['app_theme', 'theme_id', 'soloforte_theme'];
    final prefs = await SharedPreferences.getInstance();

    for (final key in legacyKeys) {
      final legacy = prefs.getString(key);
      if (legacy == null) continue;

      final isDark = legacy == 'dark' || legacy == 'darkBlack';
      await prefs.setString('app_theme', isDark ? 'darkBlack' : 'light');
      return;
    }
  }
}

class ImportResult {
  const ImportResult({
    required this.clients,
    required this.plans,
    required this.stages,
    required this.products,
  });

  final int clients;
  final int plans;
  final int stages;
  final int products;

  int get total => clients + plans + stages + products;
}

final dataImporterProvider = Provider<DataImporter>((ref) {
  return DataImporter(ref.watch(databaseProvider));
});
