import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_tipo.dart';
import 'package:agrimind/features/plans/domain/entities/operacional_estadio_config.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/programa_operacional_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:agrimind/features/plans/domain/repositories/plans_repository.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/tipo_operacional.dart';
import 'package:agrimind/features/plans/domain/usecases/sincronizar_subcards_fungicida_estadio_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('renumera fungicida no próprio card e remove sub-card OP legado', () async {
    final repo = _FakePlansRepo();
    repo.plano = PlanoEntity(
      id: 'plano-1',
      nome: 'Teste',
      cultura: 'Soja',
      safra: '25/26',
      areaHaTotal: 100,
      status: 'ativo',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      estadios: [
        EstadioEntity(
          id: 'v7',
          planoId: 'plano-1',
          codigo: 'V7',
          tipo: EstadioTipo.fenologico,
          label: 'Fungicida (recorrente)',
          ordem: 2,
          tipoOperacional: TipoOperacional.fungicidaRecorrente,
          createdAt: DateTime(2026),
        ),
        EstadioEntity(
          id: 'sub-legado',
          planoId: 'plano-1',
          codigo: 'Operacional',
          tipo: EstadioTipo.operacional,
          label: '1ª aplicação — Fungicida (recorrente)',
          ordem: 3,
          tipoOperacional: TipoOperacional.fungicidaRecorrente,
          operacionalConfig: const OperacionalEstadioConfig(
            fungicidaPaiEstadioId: 'v7',
            aplicacaoIndice: 1,
          ),
          createdAt: DateTime(2026),
        ),
      ],
    );

    await SincronizarSubcardsFungicidaEstadioUseCase(repo).call(
      planoId: 'plano-1',
    );

    final v7 = repo.plano!.estadios.where((e) => e.id == 'v7').firstOrNull;
    expect(v7, isNotNull);
    expect(v7!.label, '1ª aplicação — Fungicida (recorrente)');
    expect(v7.operacionalConfig?.aplicacaoIndice, 1);
    expect(
      repo.plano!.estadios.where((e) => e.id == 'sub-legado').firstOrNull,
      isNull,
    );
  });
}

class _FakePlansRepo implements PlansRepository {
  PlanoEntity? plano;

  @override
  Future<PlanoEntity?> getById(String id) async => plano;

  @override
  Future<EstadioEntity> updateEstadio(EstadioEntity estadio) async {
    final list = plano!.estadios.map((e) => e.id == estadio.id ? estadio : e);
    plano = plano!.copyWith(estadios: list.toList());
    return estadio;
  }

  @override
  Future<void> removeEstadio(String estadioId) async {
    plano = plano!.copyWith(
      estadios: plano!.estadios.where((e) => e.id != estadioId).toList(),
    );
  }

  @override
  Future<EstadioEntity> addEstadio(String planoId, EstadioEntity estadio) =>
      throw UnimplementedError();

  @override
  Future<List<ProgramaOperacionalEntity>> listProgramasOperacionais(
    String planoId,
  ) =>
      throw UnimplementedError();

  @override
  Future<ProgramaOperacionalEntity> upsertProgramaOperacional(
    ProgramaOperacionalEntity programa,
  ) =>
      throw UnimplementedError();

  @override
  Future<void> deleteProgramaOperacional(String programaId) =>
      throw UnimplementedError();

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
