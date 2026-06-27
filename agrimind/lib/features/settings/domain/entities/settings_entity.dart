import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';

/// Entidade de perfil + preferências do usuário.
@freezed
class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    required String uid,
    required String nome,
    required String email,
    String? telefone,
    String? empresa,
    String? craRegistro,
    String? avatarUrl,
    required bool darkMode,
    required String appIconKey, // 'principal' | 'classico'
    required DateTime updatedAt,
  }) = _SettingsEntity;
}
