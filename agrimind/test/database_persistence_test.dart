import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/features/plan/domain/plan_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late Directory tempDir;
  late AppDatabase db;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('agrimind_test_');
    db = await AppDatabase.open(pathOverride: p.join(tempDir.path, 'test.db'));
  });

  tearDown(() async {
    await db.close();
    await tempDir.delete(recursive: true);
  });

  group('AppDatabase persistence', () {
    test('seedDemoData creates client, plan and stages', () async {
      await db.seedDemoData();

      final clients = await db.getClients();
      expect(clients, hasLength(1));
      expect(clients.first.name, 'Adriel Pasqualli');
      expect(clients.first.areaHa, 1000);
      expect(clients.first.harvest, '2025/26');

      final plan = await db.getPlanForClient(clients.first.id);
      expect(plan, isNotNull);

      final stages = await db.getStages(plan!.id);
      expect(stages, hasLength(2));
      expect(stages[0].code, 'VC');
      expect(stages[0].name, 'Cotilédone');
      expect(stages[1].code, 'V5');
      expect(stages[1].name, '5º Nó');
    });

    test('update stage name persists after reload', () async {
      await db.seedDemoData();
      final plan = await db.getPlanForClient('client-1');
      final stages = await db.getStages(plan!.id);
      final vc = stages.first;

      await db.upsertStage(vc.copyWith(name: 'Cotilédone Atualizado'));

      final reloaded = await db.getStages(plan.id);
      expect(reloaded.first.name, 'Cotilédone Atualizado');
    });

    test('add and remove product persists', () async {
      await db.seedDemoData();
      const product = ProductModel(
        id: 'prod-1',
        stageId: 'stage-vc',
        name: 'Roundup',
      );
      await db.upsertProduct(product);

      var products = await db.getProducts('stage-vc');
      expect(products, hasLength(1));
      expect(products.first.name, 'Roundup');

      await db.deleteProduct('prod-1');
      products = await db.getProducts('stage-vc');
      expect(products, isEmpty);
    });

    test('add stage persists with correct sort order', () async {
      await db.seedDemoData();
      const newStage = StageModel(
        id: 'stage-v3',
        planId: 'plan-1',
        code: 'V3',
        name: '3º Trifólio',
        sortOrder: 2,
      );
      await db.upsertStage(newStage);

      final stages = await db.getStages('plan-1');
      expect(stages, hasLength(3));
      expect(stages.last.code, 'V3');
    });

    test('delete stage removes linked products', () async {
      await db.seedDemoData();
      await db.upsertProduct(const ProductModel(
        id: 'p1',
        stageId: 'stage-vc',
        name: 'Herbicida',
      ));

      await db.deleteStage('stage-vc');

      final stages = await db.getStages('plan-1');
      expect(stages.where((s) => s.id == 'stage-vc'), isEmpty);
      final products = await db.getProducts('stage-vc');
      expect(products, isEmpty);
    });
  });
}
