import '../../../references/domain/entities/referencia_tecnica_entity.dart';
import 'categoria_bottom_sheet.dart';

/// Converte entidades de referência para o modelo de exibição do canvas.
class ReferenciaDisplayMapper {
  ReferenciaDisplayMapper._();

  static ReferenciaDisplayItem fromEntity(ReferenciaTecnicaEntity entity) {
    return ReferenciaDisplayItem(
      titulo: entity.titulo,
      descricao: entity.descricao,
      focoManejo: entity.focoManejo,
      praticas: entity.praticas,
      padrao: entity.padrao,
      destaque: entity.destaque,
    );
  }
}
