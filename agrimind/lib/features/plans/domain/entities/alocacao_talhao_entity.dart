/// Lançamento de quantidade de produto em um talhão (append-only).
class AlocacaoTalhaoEntity {
  const AlocacaoTalhaoEntity({
    required this.id,
    required this.produtoAplicacaoId,
    required this.talhaoId,
    required this.quantidadeAlocada,
    required this.origemEscopoId,
    required this.dataLancamento,
    this.foiAjustadoManualmente = false,
  });

  final String id;
  final String produtoAplicacaoId;
  final String talhaoId;
  final double quantidadeAlocada;
  final String origemEscopoId;
  final DateTime dataLancamento;
  final bool foiAjustadoManualmente;
}
