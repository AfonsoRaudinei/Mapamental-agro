import 'package:freezed_annotation/freezed_annotation.dart';

part 'semente_talhao_entity.freezed.dart';

/// Entrada de sementes por talhão dentro de um plano.
@freezed
class SementeTalhaoEntity with _$SementeTalhaoEntity {
  const factory SementeTalhaoEntity({
    required String id,
    required String planoId,
    required String estadioId,
    String? talhaoId,
    required String cultivar,
    required double populacaoSementesPorHa,
    required int sementesPorEmbalagem,
    required double espacamentoPlantioCm,

    /// Quantidade de embalagens ajustada à mão; null = usa o cálculo.
    int? embalagensManual,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SementeTalhaoEntity;
}
