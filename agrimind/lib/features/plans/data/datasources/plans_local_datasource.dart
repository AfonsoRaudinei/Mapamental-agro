import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';

class PlansLocalDatasource {
  PlansLocalDatasource(this._database, {String? userId})
      : _scope = LocalUserScope(userId);

  final AppDatabase _database;
  final LocalUserScope _scope;

  Future<List<PlanoEntity>> getAll() async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.planos)
          ..where(
            (row) => row.userId.equals(userId) & row.deletedAt.isNull(),
          ))
        .get();
    return Future.wait(rows.map(_hydratePlano));
  }

  Stream<List<PlanoEntity>> watchAll() {
    final userId = _scope.userId;
    final query = _database.select(_database.planos)
      ..where((row) => row.userId.equals(userId) & row.deletedAt.isNull());
    return query
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_hydratePlano)));
  }

  Future<PlanoEntity?> getById(String uid) async {
    final userId = _scope.userId;
    final row = await (_database.select(_database.planos)
          ..where(
            (table) =>
                table.uid.equals(uid) &
                table.userId.equals(userId) &
                table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    return row == null ? null : _hydratePlano(row);
  }

  Future<PlanoEntity> create(PlanoEntity plano) async {
    await _database.into(_database.planos).insert(_planoCompanion(plano));
    return plano;
  }

  Future<PlanoEntity> update(PlanoEntity plano) async {
    if (await getById(plano.id) == null) {
      throw StateError('Plano ${plano.id} não encontrado.');
    }
    final updated = plano.copyWith(updatedAt: DateTime.now());
    await _database
        .into(_database.planos)
        .insertOnConflictUpdate(_planoCompanion(updated));
    return updated;
  }

  Future<void> delete(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await _database.transaction(() async {
      final stages = await (_database.select(_database.estadios)
            ..where(
              (row) => row.planoId.equals(uid) & row.userId.equals(userId),
            ))
          .get();
      for (final stage in stages) {
        await (_database.update(_database.produtosAplicacao)
              ..where((row) => row.estadioId.equals(stage.uid)))
            .write(
          ProdutosAplicacaoCompanion(
            deletedAt: Value(now),
            updatedAt: Value(now),
            syncState: const Value('pending'),
          ),
        );
      }
      await (_database.update(_database.estadios)
            ..where(
              (row) => row.planoId.equals(uid) & row.userId.equals(userId),
            ))
          .write(
        EstadiosCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
      await (_database.update(_database.planos)
            ..where(
              (row) => row.uid.equals(uid) & row.userId.equals(userId),
            ))
          .write(
        PlanosCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
    });
  }

  Future<void> updateProdutoPricesForPlano({
    required String planoId,
    required String produtoNome,
    required double? precoUnitario,
  }) async {
    final userId = _scope.userId;
    final normalized = produtoNome.trim().toLowerCase();
    if (normalized.isEmpty) return;

    final stages = await (_database.select(_database.estadios)
          ..where(
            (row) =>
                row.planoId.equals(planoId) &
                row.userId.equals(userId) &
                row.deletedAt.isNull(),
          ))
        .get();
    final stageIds = stages.map((stage) => stage.uid).toSet();
    if (stageIds.isEmpty) return;

    final products = await (_database.select(_database.produtosAplicacao)
          ..where(
            (row) => row.userId.equals(userId) & row.deletedAt.isNull(),
          ))
        .get();
    final now = DateTime.now();
    for (final product in products) {
      if (!stageIds.contains(product.estadioId)) continue;
      if (product.produtoNome.trim().toLowerCase() != normalized) continue;
      await (_database.update(_database.produtosAplicacao)
            ..where((row) => row.uid.equals(product.uid)))
          .write(
        ProdutosAplicacaoCompanion(
          precoUnitario: Value(precoUnitario),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
    }
  }

  Future<EstadioEntity> createEstadio(
    String planoId,
    EstadioEntity estadio,
  ) async {
    if (await getById(planoId) == null) {
      throw StateError('Plano $planoId não encontrado.');
    }
    await _database.into(_database.estadios).insert(
          _estadioCompanion(estadio.copyWith(planoId: planoId)),
        );
    return estadio.copyWith(planoId: planoId);
  }

  Future<EstadioEntity> updateEstadio(EstadioEntity estadio) async {
    final userId = _scope.userId;
    final current = await (_database.select(_database.estadios)
          ..where(
            (row) =>
                row.uid.equals(estadio.id) &
                row.userId.equals(userId) &
                row.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (current == null) {
      throw StateError('Estádio ${estadio.id} não encontrado.');
    }
    await _database
        .into(_database.estadios)
        .insertOnConflictUpdate(_estadioCompanion(estadio));
    return estadio;
  }

  Future<void> deleteEstadio(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await _database.transaction(() async {
      await (_database.update(_database.produtosAplicacao)
            ..where(
              (row) => row.estadioId.equals(uid) & row.userId.equals(userId),
            ))
          .write(
        ProdutosAplicacaoCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
      await (_database.update(_database.estadios)
            ..where(
              (row) => row.uid.equals(uid) & row.userId.equals(userId),
            ))
          .write(
        EstadiosCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
    });
  }

  Future<List<ProdutoAplicacaoEntity>> getProdutosByEstadio(
    String estadioId,
  ) async {
    final products = await (_database.select(_database.produtosAplicacao)
          ..where(
            (product) =>
                product.estadioId.equals(estadioId) &
                product.deletedAt.isNull(),
          )
          ..orderBy([(product) => OrderingTerm.asc(product.ordem)]))
        .get();
    return products.map(_produtoToEntity).toList();
  }

  Future<ProdutoAplicacaoEntity> createProdutoAplicacao(
    String estadioId,
    ProdutoAplicacaoEntity produto,
  ) async {
    final userId = _scope.userId;
    final stage = await (_database.select(_database.estadios)
          ..where(
            (row) =>
                row.uid.equals(estadioId) &
                row.userId.equals(userId) &
                row.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (stage == null) {
      throw StateError('Estádio $estadioId não encontrado.');
    }
    final created = produto.copyWith(estadioId: estadioId);
    await _database.into(_database.produtosAplicacao).insert(
          _produtoCompanion(created),
        );
    return created;
  }

  Future<ProdutoAplicacaoEntity> updateProdutoAplicacao(
    ProdutoAplicacaoEntity produto,
  ) async {
    final userId = _scope.userId;
    final current = await (_database.select(_database.produtosAplicacao)
          ..where(
            (row) =>
                row.uid.equals(produto.id) &
                row.userId.equals(userId) &
                row.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (current == null) {
      throw StateError('Produto ${produto.id} não encontrado.');
    }
    await _database
        .into(_database.produtosAplicacao)
        .insertOnConflictUpdate(_produtoCompanion(produto));
    return produto;
  }

  Future<void> deleteProdutoAplicacao(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.produtosAplicacao)
          ..where(
            (row) => row.uid.equals(uid) & row.userId.equals(userId),
          ))
        .write(
      ProdutosAplicacaoCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }

  Future<PlanoEntity> _hydratePlano(Plano row) async {
    final userId = _scope.userId;
    final stages = await (_database.select(_database.estadios)
          ..where(
            (stage) =>
                stage.planoId.equals(row.uid) &
                stage.userId.equals(userId) &
                stage.deletedAt.isNull(),
          )
          ..orderBy([(stage) => OrderingTerm.asc(stage.ordem)]))
        .get();
    final cliente = row.clienteId == null
        ? null
        : await (_database.select(_database.clientes)
              ..where(
                (item) =>
                    item.uid.equals(row.clienteId!) &
                    item.userId.equals(userId),
              ))
            .getSingleOrNull();
    final fazenda = row.fazendaId == null
        ? null
        : await (_database.select(_database.fazendas)
              ..where(
                (item) =>
                    item.uid.equals(row.fazendaId!) &
                    item.userId.equals(userId),
              ))
            .getSingleOrNull();

    return PlanoEntity(
      id: row.uid,
      nome: row.nome,
      cultura: row.cultura,
      safra: row.safra,
      areaHaTotal: row.areaHaTotal,
      status: row.status,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      clienteId: row.clienteId,
      clienteNome: cliente?.nome,
      fazendaId: row.fazendaId,
      fazendaNome: fazenda?.nome,
      produtorNomeLivre: row.produtorNomeLivre,
      fazendaNomeLivre: row.fazendaNomeLivre,
      cidadeUf: row.cidadeUf,
      consultorNome: row.consultorNome,
      consultorExibirNome: row.consultorExibirNome,
      logoLocalPath: row.logoLocalPath,
      precoGraoSc60: row.precoGraoSc60,
      dataVencimento: row.dataVencimento,
      estadios: await Future.wait(stages.map(_hydrateEstadio)),
    );
  }

  Future<EstadioEntity> _hydrateEstadio(Estadio row) async {
    final products = await (_database.select(_database.produtosAplicacao)
          ..where(
            (product) =>
                product.estadioId.equals(row.uid) & product.deletedAt.isNull(),
          )
          ..orderBy([(product) => OrderingTerm.asc(product.ordem)]))
        .get();
    return EstadioEntity(
      id: row.uid,
      planoId: row.planoId,
      codigo: row.codigo,
      label: row.label,
      ordem: row.ordem,
      dataAplicacao: row.dataAplicacao,
      imageLocalPath: row.imageLocalPath,
      observacao: row.observacao,
      createdAt: row.createdAt,
      produtos: products.map(_produtoToEntity).toList(),
    );
  }

  ProdutoAplicacaoEntity _produtoToEntity(ProdutosAplicacaoData row) =>
      ProdutoAplicacaoEntity(
        id: row.uid,
        estadioId: row.estadioId,
        produtoNome: row.produtoNome,
        produtoCategoria: row.produtoCategoria,
        dose: row.dose,
        doseUnidade: row.doseUnidade,
        areaHa: row.areaHa,
        talhaoRef: row.talhaoRef,
        totalOverride: row.totalOverride,
        overrideMotivo: row.overrideMotivo,
        precoUnitario: row.precoUnitario,
        observacao: row.observacao,
        dataPrevista: row.dataPrevista,
        ordem: row.ordem,
        createdAt: row.createdAt,
      );

  PlanosCompanion _planoCompanion(PlanoEntity entity) => PlanosCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        clienteId: Value(entity.clienteId),
        fazendaId: Value(entity.fazendaId),
        produtorNomeLivre: Value(entity.produtorNomeLivre),
        fazendaNomeLivre: Value(entity.fazendaNomeLivre),
        cidadeUf: Value(entity.cidadeUf),
        consultorNome: Value(entity.consultorNome),
        consultorExibirNome: Value(entity.consultorExibirNome),
        logoLocalPath: Value(entity.logoLocalPath),
        precoGraoSc60: Value(entity.precoGraoSc60),
        dataVencimento: Value(entity.dataVencimento),
        nome: entity.nome,
        cultura: entity.cultura,
        safra: entity.safra,
        areaHaTotal: entity.areaHaTotal,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  EstadiosCompanion _estadioCompanion(EstadioEntity entity) =>
      EstadiosCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        planoId: entity.planoId,
        codigo: entity.codigo,
        label: entity.label,
        ordem: Value(entity.ordem),
        dataAplicacao: Value(entity.dataAplicacao),
        imageLocalPath: Value(entity.imageLocalPath),
        observacao: Value(entity.observacao),
        createdAt: entity.createdAt,
        updatedAt: DateTime.now(),
      );

  ProdutosAplicacaoCompanion _produtoCompanion(
    ProdutoAplicacaoEntity entity,
  ) =>
      ProdutosAplicacaoCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        estadioId: entity.estadioId,
        produtoNome: entity.produtoNome,
        produtoCategoria: entity.produtoCategoria,
        dose: entity.dose,
        doseUnidade: entity.doseUnidade,
        areaHa: entity.areaHa,
        talhaoRef: Value(entity.talhaoRef),
        totalOverride: Value(entity.totalOverride),
        overrideMotivo: Value(entity.overrideMotivo),
        precoUnitario: Value(entity.precoUnitario),
        observacao: Value(entity.observacao),
        dataPrevista: Value(entity.dataPrevista),
        ordem: Value(entity.ordem),
        createdAt: entity.createdAt,
        updatedAt: DateTime.now(),
      );
}
