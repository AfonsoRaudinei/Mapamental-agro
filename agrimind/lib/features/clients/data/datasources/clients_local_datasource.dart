import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/cliente_entity.dart';
import '../../domain/entities/fazenda_entity.dart';
import '../../domain/entities/talhao_entity.dart';

class ClientsLocalDatasource {
  ClientsLocalDatasource(this._database);

  final AppDatabase _database;
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
    final query = _database.select(_database.clientes);
    if (!includeInactive) {
      query.where((row) => row.ativo.equals(true) & row.deletedAt.isNull());
    }
    final rows = await query.get();
    return rows.map(_clienteToEntity).toList();
  }

  Future<ClienteEntity?> getById(String uid) async {
    final row = await (_database.select(_database.clientes)
          ..where((table) => table.uid.equals(uid)))
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
    final now = DateTime.now();
    await (_database.update(_database.clientes)
          ..where((table) => table.uid.equals(uid)))
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
    final rows = await (_database.select(_database.fazendas)
          ..where(
            (table) =>
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
    final exists = await (_database.select(_database.fazendas)
          ..where((table) => table.uid.equals(fazenda.id)))
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
    final now = DateTime.now();
    await (_database.update(_database.fazendas)
          ..where((table) => table.uid.equals(uid)))
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
    final rows = await (_database.select(_database.talhoes)
          ..where(
            (table) =>
                table.fazendaId.equals(fazendaUid) &
                table.ativo.equals(true) &
                table.deletedAt.isNull(),
          ))
        .get();
    return rows.map(_talhaoToEntity).toList();
  }

  Future<TalhaoEntity> createTalhao(TalhaoEntity talhao) async {
    final fazenda = await (_database.select(_database.fazendas)
          ..where((table) => table.uid.equals(talhao.fazendaId)))
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
    final exists = await (_database.select(_database.talhoes)
          ..where((table) => table.uid.equals(talhao.id)))
        .getSingleOrNull();
    if (exists == null) {
      throw StateError('Talhão não encontrado: ${talhao.id}');
    }
    await _database.into(_database.talhoes).insertOnConflictUpdate(
          _talhaoCompanion(talhao),
        );
    return talhao;
  }

  Future<void> deleteTalhao(String uid) async {
    final now = DateTime.now();
    await (_database.update(_database.talhoes)
          ..where((table) => table.uid.equals(uid)))
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
        fazendaId: entity.fazendaId,
        nome: entity.nome,
        areaHa: entity.areaHa,
        observacao: Value(entity.observacao),
        ativo: Value(entity.ativo),
        createdAt: entity.createdAt,
        updatedAt: entity.createdAt,
      );
}
