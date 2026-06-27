import '../entities/cliente_entity.dart';
import '../entities/fazenda_entity.dart';
import '../entities/talhao_entity.dart';

/// Contrato abstrato do repositório de Clientes.
abstract class ClientsRepository {
  // ── Clientes ──────────────────────────────────────────────────────────────
  Future<List<ClienteEntity>> getAll({bool includeInactive = false});
  Future<ClienteEntity?> getById(String id);
  Future<ClienteEntity> create(ClienteEntity cliente);
  Future<ClienteEntity> update(ClienteEntity cliente);
  Future<void> delete(String id); // soft delete

  // ── Fazendas ─────────────────────────────────────────────────────────────
  Future<List<FazendaEntity>> getFazendas(String clienteId);
  Future<FazendaEntity> createFazenda(FazendaEntity fazenda);
  Future<FazendaEntity> updateFazenda(FazendaEntity fazenda);
  Future<void> deleteFazenda(String id);

  // ── Talhões ───────────────────────────────────────────────────────────────
  Future<List<TalhaoEntity>> getTalhoes(String fazendaId);
  Future<TalhaoEntity> createTalhao(TalhaoEntity talhao);
  Future<TalhaoEntity> updateTalhao(TalhaoEntity talhao);
  Future<void> deleteTalhao(String id);
}
