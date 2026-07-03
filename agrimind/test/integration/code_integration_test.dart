import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/data_importer.dart';
import 'package:agrimind/core/theme/theme_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('Integração código existente', () {
    test('migra tema legado SoloForte dark → darkBlack', () async {
      SharedPreferences.setMockInitialValues({'app_theme': 'dark'});

      await DataImporter.migrateLegacyThemePreference();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('app_theme'), 'darkBlack');
      expect(AppThemeX.fromLegacyId(prefs.getString('app_theme')), AppTheme.darkBlack);
    });

    test('importSnapshot mescla dados locais sem apagar existentes', () async {
      final dir = await Directory.systemTemp.createTemp('agrimind_int_');
      final db = await AppDatabase.open(pathOverride: p.join(dir.path, 'int.db'));
      await db.seedDemoData();

      final importer = DataImporter(db);
      final result = await importer.importSnapshot({
        'clients': [
          {
            'id': 'client-2',
            'name': 'Fazenda Integrada',
            'area_ha': 500,
            'harvest': '2026/27',
          },
        ],
        'plans': [
          {'id': 'plan-2', 'client_id': 'client-2'},
        ],
        'stages': [
          {
            'id': 'stage-v3',
            'plan_id': 'plan-2',
            'code': 'V3',
            'name': '3º Trifólio',
            'sort_order': 0,
          },
        ],
        'products': [
          {'id': 'prod-x', 'stage_id': 'stage-v3', 'name': 'Glifosato'},
        ],
      });

      expect(result.total, 4);

      final clients = await db.getClients();
      expect(clients.length, 2);
      expect(clients.any((c) => c.name == 'Adriel Pasqualli'), isTrue);
      expect(clients.any((c) => c.name == 'Fazenda Integrada'), isTrue);

      final stages = await db.getStages('plan-2');
      expect(stages.single.name, '3º Trifólio');

      final products = await db.getProducts('stage-v3');
      expect(products.single.name, 'Glifosato');

      await db.close();
      await dir.delete(recursive: true);
    });

    test('AppTheme.fromLegacyId mapeia blue/green para light', () {
      expect(AppThemeX.fromLegacyId('blue'), AppTheme.light);
      expect(AppThemeX.fromLegacyId('green'), AppTheme.light);
      expect(AppThemeX.fromLegacyId('dark'), AppTheme.darkBlack);
    });
  });
}
