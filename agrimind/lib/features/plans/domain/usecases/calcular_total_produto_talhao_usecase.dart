import '../entities/alocacao_talhao_entity.dart';

/// Agregação de leitura — total por talhão e linha de produto no plano.
class CalcularTotalProdutoTalhaoUseCase {
  const CalcularTotalProdutoTalhaoUseCase();

  double call({
    required String talhaoId,
    required String produtoAplicacaoId,
    required List<AlocacaoTalhaoEntity> lancamentos,
  }) {
    var total = 0.0;
    for (final row in lancamentos) {
      if (row.talhaoId == talhaoId &&
          row.produtoAplicacaoId == produtoAplicacaoId) {
        total += row.quantidadeAlocada;
      }
    }
    return total;
  }
}
