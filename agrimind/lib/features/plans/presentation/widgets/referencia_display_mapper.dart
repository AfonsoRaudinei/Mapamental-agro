import '../../../references/domain/entities/referencia_tecnica_entity.dart';
import '../../../references/domain/reference_models.dart';
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

  static List<ReferenciaDisplayItem> fromCircularEntry(
    ReferenceStageEntry entry,
  ) {
    if (entry.recommendations.isEmpty) {
      return [
        ReferenciaDisplayItem(
          titulo: entry.primaryDisease ?? entry.stageName,
          descricao: entry.management,
          focoManejo: entry.diseases.isEmpty
              ? null
              : 'Doenças: ${entry.diseases.join(' · ')}',
          podeUsarNoPlano: false,
        ),
      ];
    }

    return entry.recommendations.map((rec) {
      final metrics = <String>[
        if (rec.controlPercent != null)
          'Controle ${rec.controlPercent!.toStringAsFixed(1)}%',
        if (rec.productivityKgHa != null)
          '${rec.productivityKgHa!.toStringAsFixed(0)} kg/ha',
        if (rec.fitotoxPercent != null)
          'Fitotox ${rec.fitotoxPercent!.toStringAsFixed(1)}%',
      ];
      final parts = <String>[
        rec.activeIngredient,
        if (metrics.isNotEmpty) metrics.join(' · '),
        if (rec.notes != null) rec.notes!,
        if (rec.source != null) rec.source!,
      ];
      return ReferenciaDisplayItem(
        titulo: rec.product,
        descricao: parts.join('\n'),
        focoManejo: entry.management,
      );
    }).toList();
  }
}
