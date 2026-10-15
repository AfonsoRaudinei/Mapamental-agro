import 'package:freezed_annotation/freezed_annotation.dart';

import 'fazenda_entity.dart';

part 'cliente_entity.freezed.dart';

/// Entidade Cliente — produtor agrícola.
@freezed
class ClienteEntity with _$ClienteEntity {
  const factory ClienteEntity({
    required String id,
    required String nome,
    String? cpfCnpj,
    String? telefone,
    String? email,
    String? cidade,
    String? uf,
    required bool ativo,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<FazendaEntity> fazendas,
  }) = _ClienteEntity;
}
