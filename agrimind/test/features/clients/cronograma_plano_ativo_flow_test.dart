import 'package:agrimind/core/di/providers.dart';
import 'package:agrimind/core/theme/app_theme.dart';
import 'package:agrimind/features/catalog/domain/entities/produto_catalogo_entity.dart';
import 'package:agrimind/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:agrimind/features/clients/domain/entities/cliente_entity.dart';
import 'package:agrimind/features/clients/domain/entities/fazenda_entity.dart';
import 'package:agrimind/features/clients/domain/entities/talhao_entity.dart';
import 'package:agrimind/features/clients/domain/repositories/clients_repository.dart';
import 'package:agrimind/features/clients/presentation/pages/cronograma_soja_page.dart';
import 'package:agrimind/features/clients/presentation/widgets/cronograma_modo_avulso_banner.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/domain/entities/programa_operacional_entity.dart';
import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:agrimind/features/plans/domain/repositories/plans_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const clienteId = 'cliente-1';
  const farmId = 'farm-1';
  const grupoId = 'grupo-1';

  late _FakeCronogramaClientsRepository clientsRepo;
  late _FakePlansForCronogramaWidgetTest plansRepo;

  Widget buildPage({
    String? talhaoId,
    bool comPlanoAtivo = true,
  }) {
    clientsRepo = _FakeCronogramaClientsRepository();
    plansRepo = _FakePlansForCronogramaWidgetTest(
      fazendaId: farmId,
      comPlano: comPlanoAtivo,
    );
    clientsRepo.cronogramas = [
      CronogramaSojaParametros.defaults(
        id: 'linha-1',
        talhaoId: 't1',
        cultura: 'Soja',
      ).copyWith(grupoRegulagemId: grupoId, plantioDefinido: false),
    ];

    return ProviderScope(
      overrides: [
        clientsRepoProvider.overrideWithValue(clientsRepo),
        plansRepoProvider.overrideWithValue(plansRepo),
        catalogRepoProvider.overrideWithValue(_FakeCatalogRepository()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: CronogramaSojaPage(
          clienteId: clienteId,
          farmId: farmId,
          talhaoId: talhaoId,
        ),
      ),
    );
  }

  group('CronogramaSojaPage — plano ativo', () {
    testWidgets('mostra grupos sem plantio no accordion e sem banner avulso',
        (tester) async {
      await tester.pumpWidget(buildPage(comPlanoAtivo: true));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Cronograma Agrícola (Soja)'), findsOneWidget);
      expect(find.text(CronogramaModoAvulsoBanner.titulo), findsNothing);
      expect(
        find.textContaining('Regulagem compartilhada por grupo'),
        findsOneWidget,
      );
      expect(find.text('Talhões'), findsOneWidget);
      expect(find.text('Plantio por talhão'), findsNothing);
      expect(find.text('Aplicar datas ao plano'), findsOneWidget);
      expect(find.text('Cronograma por talhão'), findsNothing);
    });

    testWidgets('ficha do talhão abre fluxo de plantio, não lista por talhão',
        (tester) async {
      await tester.pumpWidget(
        buildPage(comPlanoAtivo: true, talhaoId: 't1'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.textContaining('Definir plantio'), findsOneWidget);
      expect(find.text('Data de plantio'), findsOneWidget);
      expect(find.text('Cronograma por talhão'), findsNothing);
    });
  });

  group('CronogramaSojaPage — modo avulso', () {
    testWidgets('mantém plantio no grupo e exibe banner avulso',
        (tester) async {
      await tester.pumpWidget(buildPage(comPlanoAtivo: false));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Cronograma avulso (Soja)'), findsOneWidget);
      expect(find.text(CronogramaModoAvulsoBanner.titulo), findsOneWidget);
      expect(find.text('Plantio por talhão'), findsOneWidget);
    });
  });
}

class _FakeCronogramaClientsRepository implements ClientsRepository {
  _FakeCronogramaClientsRepository();

  List<CronogramaSojaParametros> cronogramas = [];

  final _fazenda = FazendaEntity(
    id: 'farm-1',
    clienteId: 'cliente-1',
    nome: 'Fazenda Teste',
    areaHa: 100,
    cultura: 'Soja',
    safra: '25/26',
    ativo: true,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  final _talhoes = [
    TalhaoEntity(
      id: 't1',
      fazendaId: 'farm-1',
      nome: 'Talhão 1',
      areaHa: 50,
      ativo: true,
      createdAt: DateTime(2026),
    ),
    TalhaoEntity(
      id: 't2',
      fazendaId: 'farm-1',
      nome: 'Talhão 2',
      areaHa: 50,
      ativo: true,
      createdAt: DateTime(2026),
    ),
  ];

  @override
  Future<List<FazendaEntity>> getFazendas(String clienteId) async =>
      [_fazenda];

  @override
  Future<List<TalhaoEntity>> getTalhoes(String fazendaId) async => _talhoes;

  @override
  Future<List<CronogramaSojaParametros>> getCronogramasSojaByFazenda(
    String fazendaId,
  ) async =>
      List.from(cronogramas);

  @override
  Future<CronogramaSojaParametros> upsertCronogramaSoja(
    CronogramaSojaParametros params, {
    required String planoId,
  }) async {
    cronogramas.removeWhere((c) => c.id == params.id);
    cronogramas.add(params);
    return params;
  }

  @override
  Future<void> deleteCronogramaSoja(String id) async {
    cronogramas.removeWhere((c) => c.id == id);
  }

  @override
  Future<List<String>> anexarProgramasOperacionaisTalhaoSafra({
    required String planoId,
    required String talhaoId,
    required List<String> programaIds,
  }) async =>
      programaIds;

  @override
  Future<List<CronogramaSojaParametros>> getCronogramasSojaByPlano(
    String planoId,
  ) async =>
      cronogramas;

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
  Future<FazendaEntity> createFazenda(FazendaEntity fazenda) =>
      throw UnimplementedError();

  @override
  Future<FazendaEntity> updateFazenda(FazendaEntity fazenda) =>
      throw UnimplementedError();

  @override
  Future<void> deleteFazenda(String id) => throw UnimplementedError();

  @override
  Future<TalhaoEntity> createTalhao(TalhaoEntity talhao) =>
      throw UnimplementedError();

  @override
  Future<TalhaoEntity> updateTalhao(TalhaoEntity talhao) =>
      throw UnimplementedError();

  @override
  Future<void> deleteTalhao(String id) => throw UnimplementedError();
}

class _FakePlansForCronogramaWidgetTest implements PlansRepository {
  _FakePlansForCronogramaWidgetTest({
    required this.fazendaId,
    required this.comPlano,
  });

  final String fazendaId;
  final bool comPlano;

  PlanoEntity? get _plano => comPlano
      ? PlanoEntity(
          id: 'plano-1',
          nome: 'Plano Soja',
          cultura: 'Soja',
          safra: '25/26',
          areaHaTotal: 100,
          status: 'ativo',
          fazendaId: fazendaId,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026, 10, 7),
        )
      : null;

  @override
  Future<List<PlanoEntity>> getAll() async =>
      _plano == null ? [] : [_plano!];

  @override
  Future<List<SementeTalhaoEntity>> getSementesByPlano(String planoId) async =>
      [];

  @override
  Future<PlanoEntity?> getById(String id) async => _plano;

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
  Future<EstadioEntity> addEstadio(String planoId, EstadioEntity estadio) =>
      throw UnimplementedError();

  @override
  Future<EstadioEntity> addSementeEstadio({
    required String planoId,
    required EstadioEntity estadio,
    required SementeTalhaoEntity semente,
  }) =>
      throw UnimplementedError();

  @override
  Future<void> removeEstadio(String estadioId) => throw UnimplementedError();

  @override
  Future<EstadioEntity> updateEstadio(EstadioEntity estadio) =>
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
  Future<SementeTalhaoEntity> createSementeTalhao(SementeTalhaoEntity entity) =>
      throw UnimplementedError();

  @override
  Future<SementeTalhaoEntity> updateSementeTalhao(
    SementeTalhaoEntity entity,
  ) =>
      throw UnimplementedError();

  @override
  Future<void> deleteSementeTalhao(String sementeId) =>
      throw UnimplementedError();

  @override
  Future<List<ProgramaOperacionalEntity>> listProgramasOperacionais(
    String planoId,
  ) async =>
      [];

  @override
  Future<ProgramaOperacionalEntity> upsertProgramaOperacional(
    ProgramaOperacionalEntity programa,
  ) =>
      throw UnimplementedError();

  @override
  Future<void> deleteProgramaOperacional(String programaId) =>
      throw UnimplementedError();
}

class _FakeCatalogRepository implements CatalogRepository {
  @override
  Future<List<ProdutoCatalogoEntity>> getAll({bool includeInactive = false}) =>
      Future.value([]);

  @override
  Future<void> seedIfEmpty() async {}

  @override
  Future<List<ProdutoCatalogoEntity>> search(
    String query, {
    String? categoria,
    bool includeInactive = false,
  }) =>
      throw UnimplementedError();

  @override
  Future<ProdutoCatalogoEntity?> getById(String id) =>
      throw UnimplementedError();

  @override
  Future<ProdutoCatalogoEntity> create(ProdutoCatalogoEntity produto) =>
      throw UnimplementedError();

  @override
  Future<ProdutoCatalogoEntity> update(ProdutoCatalogoEntity produto) =>
      throw UnimplementedError();

  @override
  Future<void> toggleAtivo(String id) => throw UnimplementedError();
}
