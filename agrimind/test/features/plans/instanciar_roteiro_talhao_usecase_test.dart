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
import 'package:flutter_test/flutter_test.dart';

import 'fake_clients_repository.dart';

void main() {
  test('instanciar persiste IDs em TalhaoSafra via clients repository', () async {
    final repo = _FakePlansRepo();
    final clients = FakeClientsRepositoryForPlans();
    repo.plano = repo.plano!.copyWith(
      estadios: [
        EstadioEntity(
          id: 'tpl',
          planoId: 'plano-1',
          codigo: 'Operacional',
          tipo: EstadioTipo.operacional,
          label: 'Plantio',
          ordem: 0,
          tipoOperacional: TipoOperacional.plantio,
          observacao: kObservacaoRoteiroTemplate,
          createdAt: DateTime(2026),
        ),
      ],
    );

    final resultado = await InstanciarRoteiroTalhaoUseCase(repo, clients).call(
      planoId: 'plano-1',
      talhaoId: 't1',
      talhaoNome: 'Talhão 1',
    );

    expect(resultado.instanciasCriadas, 1);
    expect(resultado.programaOperacionalIds, isNotEmpty);
    expect(
      clients.programaIdsPorTalhaoSafra['plano-1|t1'],
      resultado.programaOperacionalIds,
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
  Future<void> deleteProgramaOperacional(String programaId) async {}

  @override
  Future<EstadioEntity> updateEstadio(EstadioEntity estadio) async => estadio;

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
