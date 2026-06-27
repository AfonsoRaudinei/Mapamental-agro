import '../entities/produto_catalogo_entity.dart';
import '../repositories/catalog_repository.dart';

class CreateProdutoUseCase {
  const CreateProdutoUseCase(this._repo);
  final CatalogRepository _repo;
  Future<ProdutoCatalogoEntity> call(ProdutoCatalogoEntity p) =>
      _repo.create(p);
}
