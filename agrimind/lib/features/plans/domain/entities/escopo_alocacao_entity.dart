import 'tipo_escopo_alocacao.dart';

/// Cabeçalho de uma ação de rateio (compra/aplicação no plano).
class EscopoAlocacaoEntity {
  const EscopoAlocacaoEntity({
    required this.id,
    required this.produtoAplicacaoId,
    required this.tipo,
    required this.talhoesIds,
    required this.quantidadeTotal,
    required this.dataCriacao,
  });

  final String id;
  final String produtoAplicacaoId;
  final TipoEscopoAlocacao tipo;
  final List<String> talhoesIds;
  final double quantidadeTotal;
  final DateTime dataCriacao;

  /// Escopo em memória antes de persistir o produto.
  EscopoAlocacaoEntity copyWith({
    String? id,
    String? produtoAplicacaoId,
    TipoEscopoAlocacao? tipo,
    List<String>? talhoesIds,
    double? quantidadeTotal,
    DateTime? dataCriacao,
  }) {
    return EscopoAlocacaoEntity(
      id: id ?? this.id,
      produtoAplicacaoId: produtoAplicacaoId ?? this.produtoAplicacaoId,
      tipo: tipo ?? this.tipo,
      talhoesIds: talhoesIds ?? this.talhoesIds,
      quantidadeTotal: quantidadeTotal ?? this.quantidadeTotal,
      dataCriacao: dataCriacao ?? this.dataCriacao,
    );
  }
}
