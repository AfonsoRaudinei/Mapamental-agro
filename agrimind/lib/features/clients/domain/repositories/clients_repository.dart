import '../cronograma_soja/cronograma_soja_parametros.dart';
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

  // ── Cronograma agrícola (soja) ────────────────────────────────────────────
  Future<List<CronogramaSojaParametros>> getCronogramasSojaByFazenda(
    String fazendaId,
  );
  Future<List<CronogramaSojaParametros>> getCronogramasSojaByPlano(
    String planoId,
  );
  Future<CronogramaSojaParametros> upsertCronogramaSoja(
    CronogramaSojaParametros params, {
    required String planoId,
  });
  Future<void> deleteCronogramaSoja(String id);

  /// Anexa IDs de [ProgramaOperacional] à lista persistida do talhão na safra.
  Future<List<String>> anexarProgramasOperacionaisTalhaoSafra({
    required String planoId,
    required String talhaoId,
    required List<String> programaIds,
  });
}
