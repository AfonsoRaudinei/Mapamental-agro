import 'package:freezed_annotation/freezed_annotation.dart';

import 'talhao_entity.dart';

part 'fazenda_entity.freezed.dart';

/// Entidade Fazenda — propriedade agrícola de um cliente.
@freezed
class FazendaEntity with _$FazendaEntity {
  const factory FazendaEntity({
    required String id,
    required String clienteId,
    required String nome,
    required double areaHa,
    required String cultura,
    required String safra,
    String? municipio,
    String? uf,
    required bool ativo,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<TalhaoEntity> talhoes,
  }) = _FazendaEntity;
}
