import '../entities/produto_catalogo_entity.dart';
import '../repositories/catalog_repository.dart';

class SearchProdutosUseCase {
  const SearchProdutosUseCase(this._repo);
  final CatalogRepository _repo;
  Future<List<ProdutoCatalogoEntity>> call(
    String query, {
    String? categoria,
    bool includeInactive = false,
  }) =>
      _repo.search(query,
          categoria: categoria, includeInactive: includeInactive);
}
