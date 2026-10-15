import 'package:freezed_annotation/freezed_annotation.dart';

part 'produto_aplicacao_entity.freezed.dart';

/// Entidade ProdutoAplicacao — núcleo do cálculo agronômico.
///
/// Lógica de cálculo:
/// - totalCalculado = dose × areaHa
/// - totalFinal = totalOverride ?? totalCalculado
/// - custoTotal = totalFinal × precoUnitario (opcional)
@freezed
class ProdutoAplicacaoEntity with _$ProdutoAplicacaoEntity {
  const ProdutoAplicacaoEntity._();

  const factory ProdutoAplicacaoEntity({
    required String id,
    required String estadioId,
    required String produtoNome, // snapshot do catálogo
    required String produtoCategoria, // snapshot: Fungicida, Inseticida...
    required double dose,
    required String doseUnidade, // L/ha | mL/ha | kg/ha | g/ha | unid/ha
    required double areaHa, // padrão = fazenda.areaHa
    String? talhaoRef,

    // Override manual do total
    double? totalOverride,
    String? overrideMotivo, // ex: "Estoque limitado"

    // Custo opcional
    double? precoUnitario,
    String? observacao,
    DateTime? dataPrevista,
    required int ordem,
    required DateTime createdAt,
  }) = _ProdutoAplicacaoEntity;

  // ── Getters computados ───────────────────────────────────────────────────

  /// Total calculado automaticamente: dose × areaHa.
  double get totalCalculado => dose * areaHa;

  /// Total final: override se definido, senão cálculo automático.
  double get totalFinal => totalOverride ?? totalCalculado;

  /// Indica se o total foi sobrescrito manualmente.
  bool get isOverride => totalOverride != null;

  /// Custo total opcional (totalFinal × precoUnitario).
  double? get custoTotal {
    if (precoUnitario == null) return null;
    return totalFinal * precoUnitario!;
  }
}
