import 'package:freezed_annotation/freezed_annotation.dart';

import 'produto_aplicacao_entity.dart';

part 'estadio_entity.freezed.dart';

/// Entidade Estádio fenológico dentro de um Plano.
///
/// Códigos disponíveis:
/// Operacional, VE, VC, V1–V7, R1, R2, R3, R4, R5.1, R5.3, R5.5, R6, R7, R8
@freezed
class EstadioEntity with _$EstadioEntity {
  const factory EstadioEntity({
    required String id,
    required String planoId,
    required String codigo, // 'VE','VC','V1'...'R8','Operacional'
    required String label, // editável pelo técnico (padrão = codigo)
    required int ordem,
    DateTime? dataAplicacao,
    String? imageLocalPath,
    String? observacao,
    required DateTime createdAt,
    // Produtos eager-loaded para o canvas
    @Default([]) List<ProdutoAplicacaoEntity> produtos,
  }) = _EstadioEntity;
}
