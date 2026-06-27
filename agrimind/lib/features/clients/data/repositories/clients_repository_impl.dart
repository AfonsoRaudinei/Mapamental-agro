import '../../domain/entities/cliente_entity.dart';
import '../../domain/entities/fazenda_entity.dart';
import '../../domain/entities/talhao_entity.dart';
import '../../domain/repositories/clients_repository.dart';
import '../datasources/clients_local_datasource.dart';

class ClientsRepositoryImpl implements ClientsRepository {
  ClientsRepositoryImpl(this._datasource);
  final ClientsLocalDatasource _datasource;

  @override
  Future<List<ClienteEntity>> getAll({bool includeInactive = false}) =>
      _datasource.getAll(includeInactive: includeInactive);

  @override
  Future<ClienteEntity?> getById(String id) => _datasource.getById(id);

  @override
  Future<ClienteEntity> create(ClienteEntity cliente) =>
      _datasource.create(cliente);

  @override
  Future<ClienteEntity> update(ClienteEntity cliente) =>
      _datasource.update(cliente);

  @override
  Future<void> delete(String id) => _datasource.delete(id);

  @override
  Future<List<FazendaEntity>> getFazendas(String clienteId) =>
      _datasource.getFazendas(clienteId);

  @override
  Future<FazendaEntity> createFazenda(FazendaEntity fazenda) =>
      _datasource.createFazenda(fazenda);

  @override
  Future<FazendaEntity> updateFazenda(FazendaEntity fazenda) =>
      _datasource.updateFazenda(fazenda);

  @override
  Future<void> deleteFazenda(String id) => _datasource.deleteFazenda(id);

  @override
  Future<List<TalhaoEntity>> getTalhoes(String fazendaId) =>
      _datasource.getTalhoes(fazendaId);

  @override
  Future<TalhaoEntity> createTalhao(TalhaoEntity talhao) =>
      _datasource.createTalhao(talhao);

  @override
  Future<TalhaoEntity> updateTalhao(TalhaoEntity talhao) =>
      _datasource.updateTalhao(talhao);

  @override
  Future<void> deleteTalhao(String id) => _datasource.deleteTalhao(id);
}
