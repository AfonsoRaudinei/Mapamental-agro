import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:agrimind/features/clients/domain/entities/cliente_entity.dart';
import 'package:agrimind/features/clients/domain/entities/fazenda_entity.dart';
import 'package:agrimind/features/clients/domain/entities/talhao_entity.dart';
import 'package:agrimind/features/clients/domain/repositories/clients_repository.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/programa_operacional_ids_codec.dart';

/// Fake mínimo para testes de plano que só precisam persistir IDs no talhão.
class FakeClientsRepositoryForPlans implements ClientsRepository {
  final Map<String, List<String>> programaIdsPorTalhaoSafra = {};

  String _key(String planoId, String talhaoId) => '$planoId|$talhaoId';

  @override
  Future<List<String>> anexarProgramasOperacionaisTalhaoSafra({
    required String planoId,
    required String talhaoId,
    required List<String> programaIds,
  }) async {
    final key = _key(planoId, talhaoId);
    final mesclados = mesclarProgramaOperacionalIds(
      programaIdsPorTalhaoSafra[key] ?? const [],
      programaIds,
    );
    programaIdsPorTalhaoSafra[key] = mesclados;
    return mesclados;
  }

  @override
  Future<List<ClienteEntity>> getAll({bool includeInactive = false}) =>
      throw UnimplementedError();

  @override
  Future<ClienteEntity?> getById(String id) => throw UnimplementedError();

  @override
  Future<ClienteEntity> create(ClienteEntity cliente) =>
      throw UnimplementedError();

  @override
  Future<ClienteEntity> update(ClienteEntity cliente) =>
      throw UnimplementedError();

  @override
  Future<void> delete(String id) => throw UnimplementedError();

  @override
  Future<List<FazendaEntity>> getFazendas(String clienteId) =>
      throw UnimplementedError();

  @override
  Future<FazendaEntity> createFazenda(FazendaEntity fazenda) =>
      throw UnimplementedError();

  @override
  Future<FazendaEntity> updateFazenda(FazendaEntity fazenda) =>
      throw UnimplementedError();

  @override
  Future<void> deleteFazenda(String id) => throw UnimplementedError();

  @override
  Future<List<TalhaoEntity>> getTalhoes(String fazendaId) =>
      throw UnimplementedError();

  @override
  Future<TalhaoEntity> createTalhao(TalhaoEntity talhao) =>
      throw UnimplementedError();

  @override
  Future<TalhaoEntity> updateTalhao(TalhaoEntity talhao) =>
      throw UnimplementedError();

  @override
  Future<void> deleteTalhao(String id) => throw UnimplementedError();

  @override
  Future<List<CronogramaSojaParametros>> getCronogramasSojaByFazenda(
    String fazendaId,
  ) =>
      throw UnimplementedError();

  @override
  Future<List<CronogramaSojaParametros>> getCronogramasSojaByPlano(
    String planoId,
  ) =>
      throw UnimplementedError();

  @override
  Future<CronogramaSojaParametros> upsertCronogramaSoja(
    CronogramaSojaParametros params, {
    required String planoId,
  }) =>
      throw UnimplementedError();

  @override
  Future<void> deleteCronogramaSoja(String id) => throw UnimplementedError();
}
