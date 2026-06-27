import '../entities/produto_catalogo_entity.dart';

/// Contrato abstrato do repositório de Catálogo de Produtos.
abstract class CatalogRepository {
  Future<List<ProdutoCatalogoEntity>> getAll({bool includeInactive = false});
  Future<List<ProdutoCatalogoEntity>> search(
    String query, {
    String? categoria,
    bool includeInactive = false,
  });
  Future<ProdutoCatalogoEntity?> getById(String id);
  Future<ProdutoCatalogoEntity> create(ProdutoCatalogoEntity produto);
  Future<ProdutoCatalogoEntity> update(ProdutoCatalogoEntity produto);
  Future<void> toggleAtivo(String id);
  Future<void> seedIfEmpty();
}
