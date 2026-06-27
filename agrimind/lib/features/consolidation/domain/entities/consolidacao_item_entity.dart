/// Detalhe de um produto em um estádio específico (linha na tabela da sheet).
class DetalheEstadio {
  const DetalheEstadio({
    required this.estadioCodigo,
    required this.estadioLabel,
    required this.dose,
    required this.doseUnidade,
    required this.areaHa,
    required this.total,
    required this.isOverride,
    this.overrideMotivo,
  });

  final String estadioCodigo;
  final String estadioLabel;
  final double dose;
  final String doseUnidade;
  final double areaHa;
  final double total;
  final bool isOverride;
  final String? overrideMotivo;
}

/// Item consolidado — representa um produto agrupado com totais.
class ConsolidacaoItemEntity {
  const ConsolidacaoItemEntity({
    required this.produtoNome,
    required this.categoria,
    required this.quantidadeTotal,
    required this.unidade,
    this.precoUnitario,
    required this.detalhe,
    required this.temUnidadeMista,
  });

  /// Nome comercial do produto.
  final String produtoNome;

  /// Categoria: Fungicida, Inseticida, etc.
  final String categoria;

  /// Quantidade total normalizada (soma de todos os estádios).
  final double quantidadeTotal;

  /// Unidade normalizada após conversão (L, kg, etc.).
  final String unidade;

  /// Preço unitário (snapshot do catálogo, pode ser null).
  final double? precoUnitario;

  /// Custo total = quantidadeTotal × precoUnitario.
  double? get custoTotal {
    if (precoUnitario == null) return null;
    return quantidadeTotal * precoUnitario!;
  }

  /// Breakdown por estádio para o detalhe sheet.
  final List<DetalheEstadio> detalhe;

  /// True se o produto apareceu em unidades mistas (ex: L/ha + mL/ha).
  final bool temUnidadeMista;
}
