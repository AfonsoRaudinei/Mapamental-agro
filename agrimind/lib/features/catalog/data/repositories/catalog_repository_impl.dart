import '../../domain/entities/produto_catalogo_entity.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_local_datasource.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._datasource);
  final CatalogLocalDatasource _datasource;

  @override
  Future<List<ProdutoCatalogoEntity>> getAll({
    bool includeInactive = false,
  }) =>
      _datasource.getAll(includeInactive: includeInactive);

  @override
  Future<List<ProdutoCatalogoEntity>> search(
    String query, {
    String? categoria,
    bool includeInactive = false,
  }) =>
      _datasource.search(
        query,
        categoria: categoria,
        includeInactive: includeInactive,
      );

  @override
  Future<ProdutoCatalogoEntity?> getById(String id) => _datasource.getById(id);

  @override
  Future<ProdutoCatalogoEntity> create(ProdutoCatalogoEntity produto) =>
      _datasource.create(produto);

  @override
  Future<ProdutoCatalogoEntity> update(ProdutoCatalogoEntity produto) =>
      _datasource.update(produto);

  @override
  Future<void> toggleAtivo(String id) => _datasource.toggleAtivo(id);

  @override
  Future<void> seedIfEmpty() => _datasource.seedIfEmpty();
}
