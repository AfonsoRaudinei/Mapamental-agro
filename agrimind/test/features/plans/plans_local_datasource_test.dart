import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/features/plans/data/datasources/plans_local_datasource.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late PlansLocalDatasource datasource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    datasource = PlansLocalDatasource(database, userId: 'test-user');
  });

  tearDown(() => database.close());

  test('persiste e hidrata plano, estádio e produto no Drift', () async {
    final now = DateTime.utc(2026, 6, 20);
    await datasource.create(
      PlanoEntity(
        id: 'plano-1',
        nome: 'Plano Soja',
        cultura: 'Soja',
        safra: '2026/27',
        areaHaTotal: 100,
        status: 'rascunho',
        createdAt: now,
        updatedAt: now,
      ),
    );
    await datasource.createEstadio(
      'plano-1',
      EstadioEntity(
        id: 'estadio-1',
        planoId: 'plano-1',
        codigo: 'R1',
        label: 'Florescimento',
        ordem: 1,
        createdAt: now,
      ),
    );
    await datasource.createProdutoAplicacao(
      'estadio-1',
      ProdutoAplicacaoEntity(
        id: 'aplicacao-1',
        estadioId: 'estadio-1',
        produtoNome: 'Produto',
        produtoCategoria: 'Fungicida',
        dose: 0.5,
        doseUnidade: 'L/ha',
        areaHa: 100,
        ordem: 1,
        createdAt: now,
      ),
    );

    final plano = await datasource.getById('plano-1');
    expect(plano?.estadios, hasLength(1));
    expect(plano?.estadios.single.produtos, hasLength(1));
    expect(plano?.estadios.single.produtos.single.totalCalculado, 50);

    await datasource.delete('plano-1');
    expect(await datasource.getById('plano-1'), isNull);
  });

  test('lista produtos por estádio ordenados e ignora removidos', () async {
    final now = DateTime.utc(2026, 6, 20);
    await datasource.create(
      PlanoEntity(
        id: 'plano-1',
        nome: 'Plano Soja',
        cultura: 'Soja',
        safra: '2026/27',
        areaHaTotal: 100,
        status: 'rascunho',
        createdAt: now,
        updatedAt: now,
      ),
    );
    await datasource.createEstadio(
      'plano-1',
      EstadioEntity(
        id: 'estadio-1',
        planoId: 'plano-1',
        codigo: 'R1',
        label: 'Florescimento',
        ordem: 1,
        createdAt: now,
      ),
    );
    await datasource.createProdutoAplicacao(
      'estadio-1',
      ProdutoAplicacaoEntity(
        id: 'aplicacao-2',
        estadioId: 'estadio-1',
        produtoNome: 'Produto B',
        produtoCategoria: 'Fungicida',
        dose: 0.8,
        doseUnidade: 'L/ha',
        areaHa: 100,
        ordem: 2,
        createdAt: now,
      ),
    );
    await datasource.createProdutoAplicacao(
      'estadio-1',
      ProdutoAplicacaoEntity(
        id: 'aplicacao-1',
        estadioId: 'estadio-1',
        produtoNome: 'Produto A',
        produtoCategoria: 'Inseticida',
        dose: 0.5,
        doseUnidade: 'L/ha',
        areaHa: 100,
        ordem: 1,
        createdAt: now,
      ),
    );

    expect(
      (await datasource.getProdutosByEstadio('estadio-1'))
          .map((item) => item.id),
      ['aplicacao-1', 'aplicacao-2'],
    );

    await datasource.deleteProdutoAplicacao('aplicacao-1');

    final products = await datasource.getProdutosByEstadio('estadio-1');
    expect(products.map((item) => item.id), ['aplicacao-2']);
    expect(products.single.totalCalculado, 80);
  });

  test('persiste metadados do canvas e imagem do estádio', () async {
    final now = DateTime.utc(2026, 6, 20);
    await datasource.create(
      PlanoEntity(
        id: 'plano-meta',
        nome: 'Minha Lavoura',
        cultura: 'Soja',
        safra: '2026/27',
        areaHaTotal: 120,
        status: 'rascunho',
        createdAt: now,
        updatedAt: now,
        produtorNomeLivre: 'Produtor Livre',
        fazendaNomeLivre: 'Fazenda Livre',
        cidadeUf: 'Sorriso / MT',
        consultorNome: 'Consultor',
        logoLocalPath: '/tmp/logo.png',
        precoGraoSc60: 120,
        dataVencimento: DateTime(2026, 9, 1),
      ),
    );
    await datasource.createEstadio(
      'plano-meta',
      EstadioEntity(
        id: 'estadio-meta',
        planoId: 'plano-meta',
        codigo: 'R1',
        label: 'Pré-florada',
        ordem: 1,
        imageLocalPath: '/tmp/r1.jpg',
        createdAt: now,
      ),
    );

    final plano = await datasource.getById('plano-meta');

    expect(plano?.produtorNomeLivre, 'Produtor Livre');
    expect(plano?.fazendaNomeLivre, 'Fazenda Livre');
    expect(plano?.cidadeUf, 'Sorriso / MT');
    expect(plano?.consultorNome, 'Consultor');
    expect(plano?.logoLocalPath, '/tmp/logo.png');
    expect(plano?.precoGraoSc60, 120);
    expect(plano?.dataVencimento, DateTime(2026, 9, 1));
    expect(plano?.estadios.single.imageLocalPath, '/tmp/r1.jpg');
  });

  test('permite múltiplos blocos operacionais no mesmo plano', () async {
    final now = DateTime.utc(2026, 6, 20);
    await datasource.create(
      PlanoEntity(
        id: 'plano-operacional',
        nome: 'Plano Operacional',
        cultura: 'Soja',
        safra: '2026/27',
        areaHaTotal: 100,
        status: 'rascunho',
        createdAt: now,
        updatedAt: now,
      ),
    );

    await datasource.createEstadio(
      'plano-operacional',
      EstadioEntity(
        id: 'operacional-1',
        planoId: 'plano-operacional',
        codigo: 'Operacional',
        label: 'Dessecação',
        ordem: 0,
        createdAt: now,
      ),
    );
    await datasource.createEstadio(
      'plano-operacional',
      EstadioEntity(
        id: 'operacional-2',
        planoId: 'plano-operacional',
        codigo: 'Operacional',
        label: 'Plantio',
        ordem: 1,
        createdAt: now.add(const Duration(minutes: 1)),
      ),
    );

    final plano = await datasource.getById('plano-operacional');
    expect(plano?.estadios, hasLength(2));
    expect(
        plano?.estadios.every((item) => item.codigo == 'Operacional'), isTrue);
    expect(
      plano?.estadios.map((item) => item.label).toList(),
      ['Dessecação', 'Plantio'],
    );
  });
}
