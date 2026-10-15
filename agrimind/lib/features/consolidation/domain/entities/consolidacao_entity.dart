import '../../../plans/domain/entities/plano_entity.dart';
import 'consolidacao_item_entity.dart';
import 'consolidacao_semente_linha.dart';

/// Entidade de consolidação gerada em memória.
///
/// Agrega todos os ProdutoAplicacao do plano por nome de produto,
/// calcula totais, normaliza unidades mistas e ordena por categoria.
/// Sementes entram como payload paralelo — não misturam em [itens].
class ConsolidacaoEntity {
  const ConsolidacaoEntity({
    required this.plano,
    required this.geradoEm,
    required this.itens,
    this.sementes = const [],
  });

  final PlanoEntity plano;
  final DateTime geradoEm;
  final List<ConsolidacaoItemEntity> itens;
  final List<ConsolidacaoSementeLinha> sementes;

  // ── Totais ───────────────────────────────────────────────────────────────

  /// Número total de produtos consolidados.
  int get totalProdutos => itens.length;

  /// Número de categorias distintas.
  int get totalCategorias => itens.map((i) => i.categoria).toSet().length;

  /// Custo geral — null se qualquer produto não tiver preço.
  double? get custoGeral {
    if (itens.any((i) => i.custoTotal == null)) return null;
    return itens.fold<double>(0, (s, i) => s + i.custoTotal!);
  }

  /// Indica se há algum item com unidade mista.
  bool get temUnidadeMista => itens.any((i) => i.temUnidadeMista);
}
