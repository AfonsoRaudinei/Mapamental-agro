import '../entities/estadio_entity.dart';
import '../entities/plano_entity.dart';
import '../entities/produto_aplicacao_entity.dart';

/// Contrato abstrato do repositório de Planos.
/// Implementado na camada de dados com persistência local Drift.
abstract class PlansRepository {
  // ── Planos ───────────────────────────────────────────────────────────────

  Future<List<PlanoEntity>> getAll();
  Stream<List<PlanoEntity>> watchAll();
  Future<PlanoEntity?> getById(String id);
  Future<PlanoEntity> create(PlanoEntity plano);
  Future<PlanoEntity> update(PlanoEntity plano);
  Future<void> delete(String id);
  Future<void> updateProdutoPricesForPlano({
    required String planoId,
    required String produtoNome,
    required double? precoUnitario,
  });

  // ── Estádios ─────────────────────────────────────────────────────────────

  Future<EstadioEntity> addEstadio(String planoId, EstadioEntity estadio);
  Future<void> removeEstadio(String estadioId);
  Future<EstadioEntity> updateEstadio(EstadioEntity estadio);

  // ── Produtos Aplicação ───────────────────────────────────────────────────

  Future<List<ProdutoAplicacaoEntity>> getProdutosByEstadio(String estadioId);
  Future<ProdutoAplicacaoEntity> addProduto(
    String estadioId,
    ProdutoAplicacaoEntity produto,
  );
  Future<ProdutoAplicacaoEntity> updateProduto(ProdutoAplicacaoEntity produto);
  Future<void> removeProduto(String produtoId);
}
