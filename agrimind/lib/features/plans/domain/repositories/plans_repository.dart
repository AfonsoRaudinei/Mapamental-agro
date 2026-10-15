import '../entities/estadio_entity.dart';
import '../entities/plano_entity.dart';
import '../entities/produto_aplicacao_entity.dart';
import '../entities/programa_operacional_entity.dart';
import '../entities/semente_talhao_entity.dart';

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
  Future<EstadioEntity> addSementeEstadio({
    required String planoId,
    required EstadioEntity estadio,
    required SementeTalhaoEntity semente,
  });
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

  // ── Sementes por talhão ──────────────────────────────────────────────────

  Future<List<SementeTalhaoEntity>> getSementesByPlano(String planoId);
  Future<SementeTalhaoEntity> createSementeTalhao(SementeTalhaoEntity entity);
  Future<SementeTalhaoEntity> updateSementeTalhao(SementeTalhaoEntity entity);
  Future<void> deleteSementeTalhao(String sementeId);

  // ── Programas operacionais ────────────────────────────────────────────────

  Future<List<ProgramaOperacionalEntity>> listProgramasOperacionais(
    String planoId,
  );
  Future<ProgramaOperacionalEntity> upsertProgramaOperacional(
    ProgramaOperacionalEntity programa,
  );
  Future<void> deleteProgramaOperacional(String programaId);
}
