import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_tipo.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/programa_operacional_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:agrimind/features/plans/domain/repositories/plans_repository.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/roteiro_plano_template.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/tipo_operacional.dart';
import 'package:agrimind/features/plans/domain/usecases/instanciar_roteiro_talhao_usecase.dart';
import 'package:agrimind/features/plans/domain/usecases/sincronizar_programas_operacionais_talhao_usecase.dart';
import 'fake_clients_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sync não cria estádios novos — só carimba em instâncias existentes',
      () async {
    final repo = _FakePlansRepo();
    repo.plano = repo.plano!.copyWith(
      estadios: [
        EstadioEntity(
          id: 'tpl-des',
          planoId: 'plano-1',
          codigo: 'Operacional',
          tipo: EstadioTipo.operacional,
          label: 'Dessecação',
          ordem: 0,
          tipoOperacional: TipoOperacional.dessecacaoPrePlantio,
          observacao: kObservacaoRoteiroTemplate,
          createdAt: DateTime(2026),
        ),
      ],
    );
    await InstanciarRoteiroTalhaoUseCase(
      repo,
      FakeClientsRepositoryForPlans(),
    ).call(
      planoId: 'plano-1',
      talhaoId: 't1',
      talhaoNome: 'Talhão 1',
    );
    final antes = repo.estadiosCriados.length;

    final params = CronogramaSojaParametros.defaults(
      id: 'c1',
      talhaoId: 't1',
      cultura: 'Soja',
      dataPlantio: DateTime(2026, 10, 10),
    ).copyWith(plantioDefinido: true);

    final resultado =
        await SincronizarProgramasOperacionaisTalhaoUseCase(repo).call(
      planoId: 'plano-1',
      talhaoId: 't1',
      talhaoNome: 'Talhão 1',
      parametros: params,
    );

    expect(repo.estadiosCriados.length, antes);
    expect(resultado.operacionaisCriados, 0);
    expect(resultado.fungicidasCriados, 0);
  });
}

class _FakePlansRepo implements PlansRepository {
  final programas = <ProgramaOperacionalEntity>[];
  final estadiosCriados = <EstadioEntity>[];
  PlanoEntity? plano = PlanoEntity(
    id: 'plano-1',
    nome: 'Teste',
    cultura: 'Soja',
    safra: '25/26',
    areaHaTotal: 100,
    status: 'ativo',
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
    estadios: [],
  );

  @override
  Future<PlanoEntity?> getById(String id) async => plano;

  @override
  Future<EstadioEntity> addEstadio(String planoId, EstadioEntity estadio) async {
    estadiosCriados.add(estadio);
    plano = plano!.copyWith(estadios: [...plano!.estadios, estadio]);
    return estadio;
  }

  @override
  Future<List<ProgramaOperacionalEntity>> listProgramasOperacionais(
    String planoId,
  ) async =>
      programas.where((p) => p.planoId == planoId).toList();

  @override
  Future<ProgramaOperacionalEntity> upsertProgramaOperacional(
    ProgramaOperacionalEntity programa,
  ) async {
    programas.removeWhere((p) => p.id == programa.id);
    programas.add(programa);
    return programa;
  }

  @override
  Future<void> deleteProgramaOperacional(String programaId) async {
    programas.removeWhere((p) => p.id == programaId);
  }

  @override
  Future<EstadioEntity> updateEstadio(EstadioEntity estadio) async {
    final idx = estadiosCriados.indexWhere((e) => e.id == estadio.id);
    if (idx >= 0) estadiosCriados[idx] = estadio;
    return estadio;
  }

  @override
  Future<void> removeEstadio(String estadioId) async {}

  @override
  Future<List<PlanoEntity>> getAll() => throw UnimplementedError();

  @override
  Stream<List<PlanoEntity>> watchAll() => throw UnimplementedError();

  @override
  Future<PlanoEntity> create(PlanoEntity plano) => throw UnimplementedError();

  @override
  Future<PlanoEntity> update(PlanoEntity plano) => throw UnimplementedError();

  @override
  Future<void> delete(String id) => throw UnimplementedError();

  @override
  Future<void> updateProdutoPricesForPlano({
    required String planoId,
    required String produtoNome,
    required double? precoUnitario,
  }) =>
      throw UnimplementedError();

  @override
  Future<EstadioEntity> addSementeEstadio({
    required String planoId,
    required EstadioEntity estadio,
    required SementeTalhaoEntity semente,
  }) =>
      throw UnimplementedError();

  @override
  Future<List<ProdutoAplicacaoEntity>> getProdutosByEstadio(String estadioId) =>
      throw UnimplementedError();

  @override
  Future<ProdutoAplicacaoEntity> addProduto(
    String estadioId,
    ProdutoAplicacaoEntity produto,
  ) =>
      throw UnimplementedError();

  @override
  Future<ProdutoAplicacaoEntity> updateProduto(
    ProdutoAplicacaoEntity produto,
  ) =>
      throw UnimplementedError();

  @override
  Future<void> removeProduto(String produtoId) => throw UnimplementedError();

  @override
  Future<List<SementeTalhaoEntity>> getSementesByPlano(String planoId) =>
      throw UnimplementedError();

  @override
  Future<SementeTalhaoEntity> createSementeTalhao(
    SementeTalhaoEntity entity,
  ) =>
      throw UnimplementedError();

  @override
  Future<SementeTalhaoEntity> updateSementeTalhao(
    SementeTalhaoEntity entity,
  ) =>
      throw UnimplementedError();

  @override
  Future<void> deleteSementeTalhao(String sementeId) =>
      throw UnimplementedError();
}
