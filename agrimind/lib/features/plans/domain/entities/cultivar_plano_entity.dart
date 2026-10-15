import 'package:freezed_annotation/freezed_annotation.dart';

part 'cultivar_plano_entity.freezed.dart';

/// Cultivar associada 1:1 ao plano (dados manuais do técnico).
@freezed
class CultivarPlanoEntity with _$CultivarPlanoEntity {
  const factory CultivarPlanoEntity({
    String? nome,
    String? obtentora,
    String? grupoMaturacao,
    double? populacao,
    @Default('plantas/ha') String populacaoUnidade,
    String? observacoes,
  }) = _CultivarPlanoEntity;

  const CultivarPlanoEntity._();

  bool get isDefined {
    final n = nome?.trim();
    return n != null && n.isNotEmpty;
  }
}
