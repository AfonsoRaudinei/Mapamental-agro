import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/features/catalog/data/datasources/catalog_local_datasource.dart';
import 'package:agrimind/features/catalog/domain/entities/produto_catalogo_entity.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late CatalogLocalDatasource datasource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    datasource = CatalogLocalDatasource(database, userId: 'test-user');
  });

  tearDown(() => database.close());

  test('seed, busca e soft delete funcionam no Drift', () async {
    await datasource.seedIfEmpty();
    final seeded = await datasource.getAll();
    expect(seeded.length, greaterThan(20));
    expect(await datasource.search('Fox'), isNotEmpty);

    final now = DateTime.utc(2026);
    final created = await datasource.create(
      ProdutoCatalogoEntity(
        id: '',
        nomeComercial: 'Produto Teste',
        categoria: 'Fungicida',
        unidadePadrao: 'L/ha',
        ativo: true,
        isSeed: false,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await datasource.toggleAtivo(created.id);

    expect(await datasource.getById(created.id), isNotNull);
    expect(
      (await datasource.getAll()).any((item) => item.id == created.id),
      isFalse,
    );
  });
}
