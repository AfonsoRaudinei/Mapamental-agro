import 'package:freezed_annotation/freezed_annotation.dart';

part 'produto_catalogo_entity.freezed.dart';

/// Entidade ProdutoCatalogo — banco de insumos agronômicos.
@freezed
class ProdutoCatalogoEntity with _$ProdutoCatalogoEntity {
  const factory ProdutoCatalogoEntity({
    required String id,
    required String nomeComercial,
    String? ingredienteAtivo,
    required String categoria,
    // Fungicida | Inseticida | Herbicida | Fertilizante | Bioestimulante | Adjuvante TA | Micros sólidos
    required String unidadePadrao,
    double? doseMin,
    double? doseMax,
    double? precoUnitario,
    String? fabricante,
    String? observacoes,
    @Default([]) List<String> culturas,
    required bool ativo,
    required bool isSeed,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProdutoCatalogoEntity;
}
