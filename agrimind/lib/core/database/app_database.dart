import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../features/plan/domain/plan_models.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Database must be overridden in main()');
});

class AppDatabase {
  AppDatabase(this._db);

  final Database _db;

  static Future<AppDatabase> open({String? pathOverride}) async {
    final dbPath = pathOverride ??
        p.join(await getDatabasesPath(), 'agrimind.db');
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE clients (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            area_ha REAL NOT NULL,
            harvest TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE plans (
            id TEXT PRIMARY KEY,
            client_id TEXT NOT NULL,
            FOREIGN KEY (client_id) REFERENCES clients(id)
          )
        ''');
        await db.execute('''
          CREATE TABLE stages (
            id TEXT PRIMARY KEY,
            plan_id TEXT NOT NULL,
            code TEXT NOT NULL,
            name TEXT NOT NULL,
            sort_order INTEGER NOT NULL,
            FOREIGN KEY (plan_id) REFERENCES plans(id)
          )
        ''');
        await db.execute('''
          CREATE TABLE products (
            id TEXT PRIMARY KEY,
            stage_id TEXT NOT NULL,
            name TEXT NOT NULL,
            FOREIGN KEY (stage_id) REFERENCES stages(id)
          )
        ''');
      },
    );
    return AppDatabase(db);
  }

  Future<void> close() => _db.close();

  Future<List<ClientModel>> getClients() async {
    final rows = await _db.query('clients', orderBy: 'name ASC');
    return rows.map(ClientModel.fromMap).toList();
  }

  Future<void> upsertClient(ClientModel client) async {
    await _db.insert(
      'clients',
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<PlanModel?> getPlanForClient(String clientId) async {
    final rows = await _db.query(
      'plans',
      where: 'client_id = ?',
      whereArgs: [clientId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return PlanModel.fromMap(rows.first);
  }

  Future<void> upsertPlan(PlanModel plan) async {
    await _db.insert(
      'plans',
      plan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StageModel>> getStages(String planId) async {
    final rows = await _db.query(
      'stages',
      where: 'plan_id = ?',
      whereArgs: [planId],
      orderBy: 'sort_order ASC',
    );
    return rows.map(StageModel.fromMap).toList();
  }

  Future<void> upsertStage(StageModel stage) async {
    await _db.insert(
      'stages',
      stage.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteStage(String stageId) async {
    await _db.delete('products', where: 'stage_id = ?', whereArgs: [stageId]);
    await _db.delete('stages', where: 'id = ?', whereArgs: [stageId]);
  }

  Future<List<ProductModel>> getProducts(String stageId) async {
    final rows = await _db.query(
      'products',
      where: 'stage_id = ?',
      whereArgs: [stageId],
      orderBy: 'name ASC',
    );
    return rows.map(ProductModel.fromMap).toList();
  }

  Future<void> upsertProduct(ProductModel product) async {
    await _db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct(String productId) async {
    await _db.delete('products', where: 'id = ?', whereArgs: [productId]);
  }

  Future<void> seedDemoData() async {
    final clients = await getClients();
    if (clients.isNotEmpty) return;

    const client = ClientModel(
      id: 'client-1',
      name: 'Adriel Pasqualli',
      areaHa: 1000,
      harvest: '2025/26',
    );
    await upsertClient(client);

    final plan = PlanModel(id: 'plan-1', clientId: client.id);
    await upsertPlan(plan);

    await upsertStage(StageModel(
      id: 'stage-vc',
      planId: plan.id,
      code: 'VC',
      name: 'Cotilédone',
      sortOrder: 0,
    ));
    await upsertStage(StageModel(
      id: 'stage-v5',
      planId: plan.id,
      code: 'V5',
      name: '5º Nó',
      sortOrder: 1,
    ));
  }
}
