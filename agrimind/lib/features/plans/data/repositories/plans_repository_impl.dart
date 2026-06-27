import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../../domain/repositories/plans_repository.dart';
import '../datasources/plans_local_datasource.dart';

class PlansRepositoryImpl implements PlansRepository {
  PlansRepositoryImpl(this._datasource);

  final PlansLocalDatasource _datasource;

  @override
  Future<List<PlanoEntity>> getAll() => _datasource.getAll();

  @override
  Stream<List<PlanoEntity>> watchAll() => _datasource.watchAll();

  @override
  Future<PlanoEntity?> getById(String id) => _datasource.getById(id);

  @override
  Future<PlanoEntity> create(PlanoEntity plano) => _datasource.create(plano);

  @override
  Future<PlanoEntity> update(PlanoEntity plano) => _datasource.update(plano);

  @override
  Future<void> delete(String id) => _datasource.delete(id);

  @override
  Future<void> updateProdutoPricesForPlano({
    required String planoId,
    required String produtoNome,
    required double? precoUnitario,
  }) =>
      _datasource.updateProdutoPricesForPlano(
        planoId: planoId,
        produtoNome: produtoNome,
        precoUnitario: precoUnitario,
      );

  @override
  Future<EstadioEntity> addEstadio(String planoId, EstadioEntity estadio) =>
      _datasource.createEstadio(planoId, estadio);

  @override
  Future<void> removeEstadio(String estadioId) =>
      _datasource.deleteEstadio(estadioId);

  @override
  Future<EstadioEntity> updateEstadio(EstadioEntity estadio) =>
      _datasource.updateEstadio(estadio);

  @override
  Future<List<ProdutoAplicacaoEntity>> getProdutosByEstadio(
    String estadioId,
  ) =>
      _datasource.getProdutosByEstadio(estadioId);

  @override
  Future<ProdutoAplicacaoEntity> addProduto(
    String estadioId,
    ProdutoAplicacaoEntity produto,
  ) =>
      _datasource.createProdutoAplicacao(estadioId, produto);

  @override
  Future<ProdutoAplicacaoEntity> updateProduto(
    ProdutoAplicacaoEntity produto,
  ) =>
      _datasource.updateProdutoAplicacao(produto);

  @override
  Future<void> removeProduto(String produtoId) =>
      _datasource.deleteProdutoAplicacao(produtoId);
}
