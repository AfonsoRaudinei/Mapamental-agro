/// Produto do Plano visto pelo Talhão (derivado; nunca persistido como cópia).
class ProdutoAplicado {
  const ProdutoAplicado({
    required this.produtoId,
    required this.nome,
    required this.dosePorHa,
    required this.unidade,
    required this.totalCalculado,
    this.unidadeTotal,
    this.detalhe,
  });

  final String produtoId;
  final String nome;
  final double dosePorHa;

  /// Unidade da dose, ex.: `L/ha`.
  final String unidade;
  final double totalCalculado;

  /// Unidade do total, ex.: `L` (derivada de [unidade]).
  final String? unidadeTotal;

  /// Texto extra (ex.: embalagens de sementes).
  final String? detalhe;

  String get unidadeDoTotal => unidadeTotal ?? unidade.split('/').first;
}
