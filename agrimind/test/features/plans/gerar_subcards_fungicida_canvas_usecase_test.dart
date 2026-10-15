import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_tipo.dart';
import 'package:agrimind/features/plans/domain/entities/operacional_estadio_config.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/tipo_operacional.dart';
import 'package:agrimind/features/plans/domain/entities/programa_operacional_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:agrimind/features/plans/domain/repositories/plans_repository.dart';
import 'package:agrimind/features/plans/domain/usecases/gerar_subcards_fungicida_canvas_usecase.dart';
import 'package:agrimind/features/plans/domain/usecases/instanciar_roteiro_talhao_usecase.dart';
import 'fake_clients_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('carimba datas nos filhos instanciados do roteiro', () async {
    final repo = _FakePlansRepo();
    repo.plano = repo.plano!.copyWith(
      estadios: [
        EstadioEntity(
          id: 'v7',
          planoId: 'plano-1',
          codigo: 'V7',
          tipo: EstadioTipo.fenologico,
          label: '1ª aplicação — Fungicida (recorrente)',
          ordem: 0,
          tipoOperacional: TipoOperacional.fungicidaRecorrente,
          operacionalConfig: const OperacionalEstadioConfig(aplicacaoIndice: 1),
          createdAt: DateTime(2026),
        ),
        EstadioEntity(
          id: 'v9',
          planoId: 'plano-1',
          codigo: 'V9',
          tipo: EstadioTipo.fenologico,
          label: '2ª aplicação — Fungicida (recorrente)',
          ordem: 1,
          tipoOperacional: TipoOperacional.fungicidaRecorrente,
          operacionalConfig: const OperacionalEstadioConfig(aplicacaoIndice: 2),
          createdAt: DateTime(2026),
        ),
      ],
    );
    final params = CronogramaSojaParametros.defaults(
      id: 'c1',
      talhaoId: 't1',
      cultura: 'Soja',
      dataPlantio: DateTime(2026, 10, 10),
    ).copyWith(totalAplicacoesFungicida: 2);

    await InstanciarRoteiroTalhaoUseCase(
      repo,
      FakeClientsRepositoryForPlans(),
    ).call(
      planoId: 'plano-1',
      talhaoId: 't1',
      talhaoNome: 'Talhão 1',
    );

    final result = await GerarSubcardsFungicidaCanvasUseCase(repo).call(
      planoId: 'plano-1',
      talhaoId: 't1',
      talhaoNome: 'Talhão 1',
      parametros: params,
    );

    expect(result.criados, 0);
    expect(result.atualizados, 2);
    expect(repo.programas.where((p) => p.isAplicacaoFungicida).length, 2);
    expect(
      repo.estadiosCriados.where((e) => e.dataAplicacao != null).length,
      greaterThanOrEqualTo(2),
    );
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
    if (idx >= 0) {
      estadiosCriados[idx] = estadio;
    } else {
      estadiosCriados.add(estadio);
    }
    final planoEstadios = plano!.estadios.map((e) {
      return e.id == estadio.id ? estadio : e;
    }).toList();
    plano = plano!.copyWith(estadios: planoEstadios);
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
