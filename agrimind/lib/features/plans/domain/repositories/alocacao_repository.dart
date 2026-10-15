import '../entities/alocacao_talhao_entity.dart';
import '../entities/escopo_alocacao_entity.dart';

abstract class AlocacaoRepository {
  Future<void> salvarRateio({
    required EscopoAlocacaoEntity escopo,
    required List<AlocacaoTalhaoEntity> lancamentos,
  });

  Future<List<AlocacaoTalhaoEntity>> listarPorProdutoAplicacao(
    String produtoAplicacaoId,
  );

  Future<List<AlocacaoTalhaoEntity>> listarPorTalhao(String talhaoId);
}
