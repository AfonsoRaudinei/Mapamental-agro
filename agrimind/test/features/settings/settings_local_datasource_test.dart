import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:agrimind/features/settings/domain/entities/settings_entity.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late SettingsLocalDatasource datasource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    datasource = SettingsLocalDatasource(database, userId: 'test-user');
  });

  tearDown(() => database.close());

  test('cria perfil local automaticamente quando ainda não existe', () async {
    final settings = await datasource.ensureProfile(
      uid: 'user-2',
      nome: 'Consultor',
      email: 'consultor@agrimind.app',
    );

    expect(settings.uid, 'user-2');
    expect(settings.nome, 'Consultor');
    expect(settings.darkMode, isFalse);
    expect(settings.appIconKey, 'principal');

    final loaded = await datasource.getSettings(uid: 'user-2');
    expect(loaded?.email, 'consultor@agrimind.app');
  });

  test('perfil e preferências persistem no Drift', () async {
    await datasource.updateProfile(
      SettingsEntity(
        uid: 'test-user',
        nome: 'Usuário',
        email: 'user@agrimind.app',
        darkMode: false,
        appIconKey: 'principal',
        updatedAt: DateTime.utc(2026),
      ),
    );
    await datasource.setDarkMode(true);
    await datasource.setAppIcon('classico');

    final settings = await datasource.getSettings();
    expect(settings?.darkMode, isTrue);
    expect(settings?.appIconKey, 'classico');
  });

  test('exporta backup local com tabelas principais', () async {
    await datasource.updateProfile(
      SettingsEntity(
        uid: 'test-user',
        nome: 'Usuário',
        email: 'user@agrimind.app',
        darkMode: true,
        appIconKey: 'principal',
        updatedAt: DateTime.utc(2026),
      ),
    );

    final export = await datasource.exportAllData();

    expect(export['schema'], 'agrimind.settings-export.v1');
    expect(export['localUsers'], isA<List>());
    expect(export['clientes'], isA<List>());
    expect(export['fazendas'], isA<List>());
    expect(export['talhoes'], isA<List>());
    expect(export['catalogoProdutos'], isA<List>());
    expect(export['planos'], isA<List>());
    expect(export['estadios'], isA<List>());
    expect(export['produtosAplicacao'], isA<List>());
    expect((export['localUsers'] as List), hasLength(1));
  });
}
