import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../domain/entities/cliente_entity.dart';
import '../../domain/entities/fazenda_entity.dart';
import '../../domain/entities/talhao_entity.dart';
import '../../../plans/domain/talhao_safra/programa_operacional_ids_codec.dart';

class ClientsLocalDatasource {
  ClientsLocalDatasource(this._database, {String? userId})
      : _scope = LocalUserScope(userId);

  final AppDatabase _database;
  final LocalUserScope _scope;
  final _uuid = const Uuid();

  ClienteEntity _clienteToEntity(Cliente row) => ClienteEntity(
        id: row.uid,
        nome: row.nome,
        cpfCnpj: row.cpfCnpj,
        telefone: row.telefone,
        email: row.email,
        cidade: row.cidade,
        uf: row.uf,
        ativo: row.ativo,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  FazendaEntity _fazendaToEntity(Fazenda row) => FazendaEntity(
        id: row.uid,
        clienteId: row.clienteId,
        nome: row.nome,
        areaHa: row.areaHa,
        cultura: row.cultura,
        safra: row.safra,
        municipio: row.municipio,
        uf: row.uf,
        ativo: row.ativo,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  TalhaoEntity _talhaoToEntity(Talhoe row) => TalhaoEntity(
        id: row.uid,
        fazendaId: row.fazendaId,
        nome: row.nome,
        areaHa: row.areaHa,
        observacao: row.observacao,
        ativo: row.ativo,
        createdAt: row.createdAt,
      );

  Future<List<ClienteEntity>> getAll({bool includeInactive = false}) async {
    final userId = _scope.userId;
    final query = _database.select(_database.clientes);
    if (!includeInactive) {
      query.where(
        (row) =>
            row.userId.equals(userId) &
            row.ativo.equals(true) &
            row.deletedAt.isNull(),
      );
    } else {
      query.where((row) => row.userId.equals(userId));
    }
    final rows = await query.get();
    return rows.map(_clienteToEntity).toList();
  }

  Future<ClienteEntity?> getById(String uid) async {
    final userId = _scope.userId;
    final row = await (_database.select(_database.clientes)
          ..where(
            (table) => table.uid.equals(uid) & table.userId.equals(userId),
          ))
        .getSingleOrNull();
    return row == null ? null : _clienteToEntity(row);
  }

  Future<ClienteEntity> create(ClienteEntity cliente) async {
    final now = DateTime.now();
    final created = cliente.copyWith(
      id: _uuid.v4(),
      createdAt: now,
      updatedAt: now,
    );
    await _database.into(_database.clientes).insert(
          _clienteCompanion(created),
        );
    return created;
  }

  Future<ClienteEntity> update(ClienteEntity cliente) async {
    if (await getById(cliente.id) == null) {
      throw StateError('Cliente não encontrado: ${cliente.id}');
    }
    final updated = cliente.copyWith(updatedAt: DateTime.now());
    await _database.into(_database.clientes).insertOnConflictUpdate(
          _clienteCompanion(updated),
        );
    return updated;
  }

  Future<void> delete(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.clientes)
          ..where(
            (table) => table.uid.equals(uid) & table.userId.equals(userId),
          ))
        .write(
      ClientesCompanion(
        ativo: const Value(false),
        updatedAt: Value(now),
        deletedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }

  Future<List<FazendaEntity>> getFazendas(String clienteUid) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.fazendas)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.clienteId.equals(clienteUid) &
                table.ativo.equals(true) &
                table.deletedAt.isNull(),
          ))
        .get();
    return rows.map(_fazendaToEntity).toList();
  }

  Future<FazendaEntity> createFazenda(FazendaEntity fazenda) async {
    if (await getById(fazenda.clienteId) == null) {
      throw StateError('Cliente não encontrado: ${fazenda.clienteId}');
    }
    final now = DateTime.now();
    final created = fazenda.copyWith(
      id: _uuid.v4(),
      createdAt: now,
      updatedAt: now,
    );
    await _database.into(_database.fazendas).insert(
          _fazendaCompanion(created),
        );
    return created;
  }

  Future<FazendaEntity> updateFazenda(FazendaEntity fazenda) async {
    final userId = _scope.userId;
    final exists = await (_database.select(_database.fazendas)
          ..where(
            (table) =>
                table.uid.equals(fazenda.id) & table.userId.equals(userId),
          ))
        .getSingleOrNull();
    if (exists == null) {
      throw StateError('Fazenda não encontrada: ${fazenda.id}');
    }
    final updated = fazenda.copyWith(updatedAt: DateTime.now());
    await _database.into(_database.fazendas).insertOnConflictUpdate(
          _fazendaCompanion(updated),
        );
    return updated;
  }

  Future<void> deleteFazenda(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.fazendas)
          ..where(
            (table) => table.uid.equals(uid) & table.userId.equals(userId),
          ))
        .write(
      FazendasCompanion(
        ativo: const Value(false),
        updatedAt: Value(now),
        deletedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }

  Future<List<TalhaoEntity>> getTalhoes(String fazendaUid) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.talhoes)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.fazendaId.equals(fazendaUid) &
                table.ativo.equals(true) &
                table.deletedAt.isNull(),
          ))
        .get();
    return rows.map(_talhaoToEntity).toList();
  }

  Future<TalhaoEntity> createTalhao(TalhaoEntity talhao) async {
    final userId = _scope.userId;
    final fazenda = await (_database.select(_database.fazendas)
          ..where(
            (table) =>
                table.uid.equals(talhao.fazendaId) &
                table.userId.equals(userId),
          ))
        .getSingleOrNull();
    if (fazenda == null) {
      throw StateError('Fazenda não encontrada: ${talhao.fazendaId}');
    }
    final created = talhao.copyWith(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
    );
    await _database.into(_database.talhoes).insert(
          _talhaoCompanion(created),
        );
    return created;
  }

  Future<TalhaoEntity> updateTalhao(TalhaoEntity talhao) async {
    final userId = _scope.userId;
    final exists = await (_database.select(_database.talhoes)
          ..where(
            (table) =>
                table.uid.equals(talhao.id) & table.userId.equals(userId),
          ))
        .getSingleOrNull();
    if (exists == null) {
      throw StateError('Talhão não encontrado: ${talhao.id}');
    }
    await _database.into(_database.talhoes).insertOnConflictUpdate(
          _talhaoCompanion(talhao),
        );
    return talhao;
  }

  CronogramaSojaParametros _talhaoSafraToCronograma(TalhoesSafraData row) =>
      CronogramaSojaParametros(
        id: row.uid,
        talhaoId: row.talhaoId,
        cultura: row.cultura,
        materialCultivar: row.materialCultivar,
        dataPlantio: row.dataPlantio,
        diasEmergencia: row.diasEmergencia,
        daePosEmergente: row.daePosEmergente,
        diasRecuperacaoPosEmergente: row.diasRecuperacaoPosEmergente,
        intervaloFungicidaDias: row.intervaloFungicidaDias,
        totalAplicacoesFungicida: row.totalAplicacoesFungicida,
        daeMaturacaoCiclo: row.daeMaturacaoCiclo,
        diasAntesR8Dessecante: row.diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal: row.diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio: row.diasDessecacaoPrePlantio,
        grupoRegulagemId: row.grupoRegulagemId,
        plantioDefinido: row.plantioDefinido,
        ordem: row.ordem,
        programaOperacionalIds:
            decodeProgramaOperacionalIds(row.programaOperacionalIds),
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  Future<String?> _planoAtivoIdParaFazenda(String fazendaId) async {
    final rows = await _database.customSelect(
      "SELECT uid FROM planos WHERE fazenda_id = ? AND deleted_at IS NULL "
      "AND status != 'consolidado' ORDER BY updated_at DESC LIMIT 1",
      variables: [Variable.withString(fazendaId)],
      readsFrom: {_database.planos},
    ).get();
    return rows.isEmpty ? null : rows.first.read<String>('uid');
  }

  Future<List<CronogramaSojaParametros>> getCronogramasSojaByFazenda(
    String fazendaId,
  ) async {
    final userId = _scope.userId;
    final planoId = await _planoAtivoIdParaFazenda(fazendaId);
    if (planoId == null) return [];

    final talhoes = await getTalhoes(fazendaId);
    if (talhoes.isEmpty) return [];
    final talhaoIds = talhoes.map((t) => t.id).toList();
    final rows = await (_database.select(_database.talhoesSafra)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.planoId.equals(planoId) &
                table.talhaoId.isIn(talhaoIds) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (t) => OrderingTerm(expression: t.ordem),
            (t) => OrderingTerm(expression: t.createdAt),
          ]))
        .get();
    return rows.map(_talhaoSafraToCronograma).toList();
  }

  Future<List<CronogramaSojaParametros>> getCronogramasSojaByPlano(
    String planoId,
  ) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.talhoesSafra)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.planoId.equals(planoId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (t) => OrderingTerm(expression: t.ordem),
            (t) => OrderingTerm(expression: t.createdAt),
          ]))
        .get();
    return rows.map(_talhaoSafraToCronograma).toList();
  }

  Future<CronogramaSojaParametros> upsertCronogramaSoja(
    CronogramaSojaParametros params, {
    required String planoId,
  }) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    final saved = params.copyWith(updatedAt: now);
    await _database.into(_database.talhoesSafra).insertOnConflictUpdate(
          TalhoesSafraCompanion.insert(
            uid: saved.id,
            userId: Value(userId),
            planoId: planoId,
            talhaoId: saved.talhaoId,
            cultura: saved.cultura,
            materialCultivar: Value(saved.materialCultivar),
            dataPlantio: saved.dataPlantio,
            diasEmergencia: Value(saved.diasEmergencia),
            daePosEmergente: Value(saved.daePosEmergente),
            diasRecuperacaoPosEmergente:
                Value(saved.diasRecuperacaoPosEmergente),
            intervaloFungicidaDias: Value(saved.intervaloFungicidaDias),
            totalAplicacoesFungicida: Value(saved.totalAplicacoesFungicida),
            daeMaturacaoCiclo: Value(saved.daeMaturacaoCiclo),
            diasAntesR8Dessecante: Value(saved.diasAntesR8Dessecante),
            diasAntecipacaoColheitaReal:
                Value(saved.diasAntecipacaoColheitaReal),
            diasDessecacaoPrePlantio: Value(saved.diasDessecacaoPrePlantio),
            grupoRegulagemId: Value(saved.grupoRegulagemId),
            plantioDefinido: Value(saved.plantioDefinido),
            ordem: Value(saved.ordem),
            programaOperacionalIds: Value(
              encodeProgramaOperacionalIds(saved.programaOperacionalIds),
            ),
            createdAt: saved.createdAt,
            updatedAt: saved.updatedAt,
          ),
        );
    return saved;
  }

  Future<List<String>> anexarProgramasOperacionaisTalhaoSafra({
    required String planoId,
    required String talhaoId,
    required List<String> programaIds,
  }) async {
    if (programaIds.isEmpty) {
      final row = await _talhaoSafraRow(planoId: planoId, talhaoId: talhaoId);
      if (row == null) return const [];
      return decodeProgramaOperacionalIds(row.programaOperacionalIds);
    }

    final userId = _scope.userId;
    final now = DateTime.now();
    final row = await _talhaoSafraRow(planoId: planoId, talhaoId: talhaoId);
    if (row == null) {
      throw StateError(
        'TalhaoSafra não encontrado para plano=$planoId talhão=$talhaoId',
      );
    }

    final mesclados = mesclarProgramaOperacionalIds(
      decodeProgramaOperacionalIds(row.programaOperacionalIds),
      programaIds,
    );
    final encoded = encodeProgramaOperacionalIds(mesclados);

    await (_database.update(_database.talhoesSafra)
          ..where(
            (table) =>
                table.uid.equals(row.uid) & table.userId.equals(userId),
          ))
        .write(
      TalhoesSafraCompanion(
        programaOperacionalIds: Value(encoded),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
    return mesclados;
  }

  Future<TalhoesSafraData?> _talhaoSafraRow({
    required String planoId,
    required String talhaoId,
  }) async {
    final userId = _scope.userId;
    return (_database.select(_database.talhoesSafra)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.planoId.equals(planoId) &
                table.talhaoId.equals(talhaoId) &
                table.deletedAt.isNull(),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> deleteCronogramaSoja(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.talhoesSafra)
          ..where(
            (table) => table.uid.equals(uid) & table.userId.equals(userId),
          ))
        .write(
      TalhoesSafraCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }

  Future<void> deleteTalhao(String uid) async {
    final userId = _scope.userId;
    final now = DateTime.now();
    await (_database.update(_database.talhoes)
          ..where(
            (table) => table.uid.equals(uid) & table.userId.equals(userId),
          ))
        .write(
      TalhoesCompanion(
        ativo: const Value(false),
        updatedAt: Value(now),
        deletedAt: Value(now),
        syncState: const Value('pending'),
      ),
    );
  }

  ClientesCompanion _clienteCompanion(ClienteEntity entity) =>
      ClientesCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        nome: entity.nome,
        cpfCnpj: Value(entity.cpfCnpj),
        telefone: Value(entity.telefone),
        email: Value(entity.email),
        cidade: Value(entity.cidade),
        uf: Value(entity.uf),
        ativo: Value(entity.ativo),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  FazendasCompanion _fazendaCompanion(FazendaEntity entity) =>
      FazendasCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        clienteId: entity.clienteId,
        nome: entity.nome,
        areaHa: entity.areaHa,
        cultura: entity.cultura,
        safra: entity.safra,
        municipio: Value(entity.municipio),
        uf: Value(entity.uf),
        ativo: Value(entity.ativo),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  TalhoesCompanion _talhaoCompanion(TalhaoEntity entity) =>
      TalhoesCompanion.insert(
        uid: entity.id,
        userId: Value(_scope.userId),
        fazendaId: entity.fazendaId,
        nome: entity.nome,
        areaHa: entity.areaHa,
        observacao: Value(entity.observacao),
        ativo: Value(entity.ativo),
        createdAt: entity.createdAt,
        updatedAt: entity.createdAt,
      );
}
