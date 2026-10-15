import 'package:freezed_annotation/freezed_annotation.dart';

part 'talhao_entity.freezed.dart';

/// Entidade Talhão — parcela de área dentro de uma fazenda.
@freezed
class TalhaoEntity with _$TalhaoEntity {
  const factory TalhaoEntity({
    required String id,
    required String fazendaId,
    required String nome,
    required double areaHa,
    String? observacao,
    required bool ativo,
    required DateTime createdAt,
  }) = _TalhaoEntity;
}
