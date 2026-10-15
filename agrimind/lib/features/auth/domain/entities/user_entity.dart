import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// Entidade de usuário — Dart puro, sem dependências de Flutter.
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String nome,
    required String email,
    String? telefone,
    String? empresa,
    String? craRegistro,
    String? avatarUrl,
    @Default(false) bool darkMode,
    @Default('principal') String appIconKey,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserEntity;
}
