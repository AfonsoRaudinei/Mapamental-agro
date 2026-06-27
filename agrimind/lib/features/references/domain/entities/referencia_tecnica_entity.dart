import 'package:freezed_annotation/freezed_annotation.dart';

part 'referencia_tecnica_entity.freezed.dart';

/// Entidade ReferenciaTecnica — base de conhecimento agronômico por estádio.
@freezed
class ReferenciaTecnicaEntity with _$ReferenciaTecnicaEntity {
  const factory ReferenciaTecnicaEntity({
    required String id,
    required String
        categoria, // doencas | insetos | nutricao | fisiologia | cesb
    required String estadio, // VE, VC, V1...R8, Operacional
    required String titulo,
    String? descricao,
    String? focoManejo, // CESB: "Fixação de Flores"
    String? praticas, // CESB: lista de práticas
    String? padrao, // CESB: "Nutrologia" | "Hormonal" | "Biológico"
    String? destaque, // CESB: "Agro Mallon — 135,49 sc/ha"
  }) = _ReferenciaTecnicaEntity;
}
