import 'package:freezed_annotation/freezed_annotation.dart';

import 'estadio_entity.dart';

part 'plano_entity.freezed.dart';

/// Entidade Plano — representa um plano de aplicação por estádio fenológico.
@freezed
class PlanoEntity with _$PlanoEntity {
  const factory PlanoEntity({
    required String id,
    required String nome,
    required String cultura,
    required String safra,
    required double areaHaTotal,
    required String status, // rascunho | ativo | consolidado
    required DateTime createdAt,
    required DateTime updatedAt,
    // Referências opcionais (snapshotadas da fazenda/cliente)
    String? clienteId,
    String? clienteNome,
    String? fazendaId,
    String? fazendaNome,
    String? produtorNomeLivre,
    String? fazendaNomeLivre,
    String? cidadeUf,
    String? consultorNome,
    @Default(true) bool consultorExibirNome,
    String? logoLocalPath,
    double? precoGraoSc60,
    DateTime? dataVencimento,
    // Estádios eager-loaded para o canvas
    @Default([]) List<EstadioEntity> estadios,
  }) = _PlanoEntity;
}
