import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/entities/cultivar_plano_entity.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/estadio_tipo.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../../domain/entities/operacional_estadio_config.dart';
import '../../domain/entities/programa_operacional_entity.dart';
import '../../domain/talhao_safra/tipo_operacional.dart';
import '../../domain/entities/semente_talhao_entity.dart';

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
      await (_database.update(_database.sementesTalhao)
            ..where(
              (row) => row.planoId.equals(uid) & row.userId.equals(userId),
            ))
          .write(
        SementesTalhaoCompanion(
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
      await (_database.update(_database.sementesTalhao)
            ..where(
              (row) => row.estadioId.equals(uid) & row.userId.equals(userId),
            ))
          .write(
        SementesTalhaoCompanion(
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

  Future<EstadioEntity> addSementeEstadio({
    required String planoId,
    required EstadioEntity estadio,
    required SementeTalhaoEntity semente,
  }) async {
    if (await getById(planoId) == null) {
      throw StateError('Plano $planoId não encontrado.');
    }
    await _database.transaction(() async {
      await _database.into(_database.estadios).insert(
            _estadioCompanion(estadio.copyWith(planoId: planoId)),
          );
      await _database.into(_database.sementesTalhao).insert(
            _sementeCompanion(semente),
          );
    });
    return estadio.copyWith(planoId: planoId);
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
      cultivar: CultivarPlanoEntity(
        nome: row.cultivarNome,
        obtentora: row.cultivarObtentora,
        grupoMaturacao: row.cultivarGrupoMaturacao,
        populacao: row.cultivarPopulacao,
        populacaoUnidade: row.cultivarPopulacaoUnidade,
        observacoes: row.cultivarObservacoes,
      ),
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
      tipo: EstadioTipoParsing.fromStorage(row.tipo, codigo: row.codigo),
      label: row.label,
      ordem: row.ordem,
      dataAplicacao: row.dataAplicacao,
      imageLocalPath: row.imageLocalPath,
      observacao: row.observacao,
      tipoOperacional: TipoOperacional.tryParseStorage(row.tipoOperacional),
      operacionalConfig:
          OperacionalEstadioConfig.fromJsonString(row.operacionalConfig),
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
        cultivarNome: Value(entity.cultivar.nome),
        cultivarObtentora: Value(entity.cultivar.obtentora),
        cultivarGrupoMaturacao: Value(entity.cultivar.grupoMaturacao),
        cultivarPopulacao: Value(entity.cultivar.populacao),
        cultivarPopulacaoUnidade: Value(entity.cultivar.populacaoUnidade),
        cultivarObservacoes: Value(entity.cultivar.observacoes),
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
        tipo: Value(entity.tipo.name),
        label: entity.label,
        ordem: Value(entity.ordem),
        dataAplicacao: Value(entity.dataAplicacao),
        imageLocalPath: Value(entity.imageLocalPath),
        observacao: Value(entity.observacao),
        tipoOperacional: Value(entity.tipoOperacional?.name),
        operacionalConfig: Value(entity.operacionalConfig?.toJsonString()),
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

  // ── Sementes por talhão ───────────────────────────────────────────────────

  Future<List<SementeTalhaoEntity>> getSementesByPlano(String planoId) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.sementesTalhao)
          ..where(
            (row) =>
                row.planoId.equals(planoId) &
                row.userId.equals(userId) &
                row.deletedAt.isNull(),
          )
          ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
        .get();
    return rows.map(_sementeToEntity).toList();
  }

  Future<SementeTalhaoEntity> createSementeTalhao(
    SementeTalhaoEntity entity,
  ) async {
    await _database
        .into(_database.sementesTalhao)
        .insert(_sementeCompanion(entity));
    return entity;
  }

  Future<SementeTalhaoEntity> updateSementeTalhao(
    SementeTalhaoEntity entity,
  ) async {
    final updated = entity.copyWith(updatedAt: DateTime.now());
    await _database.into(_database.sementesTalhao).insertOnConflictUpdate(
          _sementeCompanion(updated),
        );
    return updated;
  }

  Future<void> deleteSementeTalhao(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.sementesTalhao)
          ..where(
            (row) => row.uid.equals(uid) & row.userId.equals(userId),
          ))
        .write(
      SementesTalhaoCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }

  SementeTalhaoEntity _sementeToEntity(SementesTalhaoData row) =>
      SementeTalhaoEntity(
        id: row.uid,
        planoId: row.planoId,
        estadioId: row.estadioId,
        talhaoId: row.talhaoId,
        cultivar: row.cultivar,
        populacaoSementesPorHa: row.populacaoSementesPorHa,
        sementesPorEmbalagem: row.sementesPorEmbalagem,
        espacamentoPlantioCm: row.espacamentoPlantioCm,
        embalagensManual: row.embalagensManual,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  SementesTalhaoCompanion _sementeCompanion(SementeTalhaoEntity entity) =>
      SementesTalhaoCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        planoId: entity.planoId,
        estadioId: entity.estadioId,
        talhaoId: Value(entity.talhaoId),
        cultivar: entity.cultivar,
        populacaoSementesPorHa: entity.populacaoSementesPorHa,
        sementesPorEmbalagem: entity.sementesPorEmbalagem,
        espacamentoPlantioCm: entity.espacamentoPlantioCm,
        embalagensManual: Value(entity.embalagensManual),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  ProgramaOperacionalEntity _programaToEntity(ProgramasOperacionai row) =>
      ProgramaOperacionalEntity(
        id: row.uid,
        planoId: row.planoId,
        talhaoId: row.talhaoId,
        tipo: TipoOperacional.values.byName(row.tipo),
        regraCalculo: RegraCalculoOperacional.values.byName(row.regraCalculo),
        ordem: row.ordem,
        programaPaiId: row.programaPaiId,
        estadioId: row.estadioId,
        aplicacaoIndice: row.aplicacaoIndice,
        incluirAdubacao: row.incluirAdubacao,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  Future<List<ProgramaOperacionalEntity>> listProgramasOperacionais(
    String planoId,
  ) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.programasOperacionais)
          ..where(
            (table) =>
                table.planoId.equals(planoId) &
                table.userId.equals(userId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.ordem)]))
        .get();
    return rows.map(_programaToEntity).toList();
  }

  Future<ProgramaOperacionalEntity> upsertProgramaOperacional(
    ProgramaOperacionalEntity programa,
  ) async {
    final now = DateTime.now();
    final saved = programa.copyWith(updatedAt: now);
    await _database.into(_database.programasOperacionais).insertOnConflictUpdate(
          ProgramasOperacionaisCompanion.insert(
            uid: saved.id,
            userId: Value(_scope.userId),
            planoId: saved.planoId,
            talhaoId: saved.talhaoId,
            programaPaiId: Value(saved.programaPaiId),
            tipo: saved.tipo.name,
            regraCalculo: saved.regraCalculo.name,
            estadioId: Value(saved.estadioId),
            aplicacaoIndice: Value(saved.aplicacaoIndice),
            ordem: Value(saved.ordem),
            incluirAdubacao: Value(saved.incluirAdubacao),
            createdAt: saved.createdAt,
            updatedAt: saved.updatedAt,
          ),
        );
    return saved;
  }

  Future<void> deleteProgramaOperacional(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.programasOperacionais)
          ..where(
            (table) => table.uid.equals(uid) & table.userId.equals(userId),
          ))
        .write(
      ProgramasOperacionaisCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }
}
