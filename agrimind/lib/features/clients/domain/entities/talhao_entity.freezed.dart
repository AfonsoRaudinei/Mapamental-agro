// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'talhao_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TalhaoEntity {
  String get id => throw _privateConstructorUsedError;
  String get fazendaId => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  double get areaHa => throw _privateConstructorUsedError;
  String? get observacao => throw _privateConstructorUsedError;
  bool get ativo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of TalhaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TalhaoEntityCopyWith<TalhaoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalhaoEntityCopyWith<$Res> {
  factory $TalhaoEntityCopyWith(
          TalhaoEntity value, $Res Function(TalhaoEntity) then) =
      _$TalhaoEntityCopyWithImpl<$Res, TalhaoEntity>;
  @useResult
  $Res call(
      {String id,
      String fazendaId,
      String nome,
      double areaHa,
      String? observacao,
      bool ativo,
      DateTime createdAt});
}

/// @nodoc
class _$TalhaoEntityCopyWithImpl<$Res, $Val extends TalhaoEntity>
    implements $TalhaoEntityCopyWith<$Res> {
  _$TalhaoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TalhaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fazendaId = null,
    Object? nome = null,
    Object? areaHa = null,
    Object? observacao = freezed,
    Object? ativo = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fazendaId: null == fazendaId
          ? _value.fazendaId
          : fazendaId // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      areaHa: null == areaHa
          ? _value.areaHa
          : areaHa // ignore: cast_nullable_to_non_nullable
              as double,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      ativo: null == ativo
          ? _value.ativo
          : ativo // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TalhaoEntityImplCopyWith<$Res>
    implements $TalhaoEntityCopyWith<$Res> {
  factory _$$TalhaoEntityImplCopyWith(
          _$TalhaoEntityImpl value, $Res Function(_$TalhaoEntityImpl) then) =
      __$$TalhaoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fazendaId,
      String nome,
      double areaHa,
      String? observacao,
      bool ativo,
      DateTime createdAt});
}

/// @nodoc
class __$$TalhaoEntityImplCopyWithImpl<$Res>
    extends _$TalhaoEntityCopyWithImpl<$Res, _$TalhaoEntityImpl>
    implements _$$TalhaoEntityImplCopyWith<$Res> {
  __$$TalhaoEntityImplCopyWithImpl(
      _$TalhaoEntityImpl _value, $Res Function(_$TalhaoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TalhaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fazendaId = null,
    Object? nome = null,
    Object? areaHa = null,
    Object? observacao = freezed,
    Object? ativo = null,
    Object? createdAt = null,
  }) {
    return _then(_$TalhaoEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fazendaId: null == fazendaId
          ? _value.fazendaId
          : fazendaId // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      areaHa: null == areaHa
          ? _value.areaHa
          : areaHa // ignore: cast_nullable_to_non_nullable
              as double,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      ativo: null == ativo
          ? _value.ativo
          : ativo // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TalhaoEntityImpl implements _TalhaoEntity {
  const _$TalhaoEntityImpl(
      {required this.id,
      required this.fazendaId,
      required this.nome,
      required this.areaHa,
      this.observacao,
      required this.ativo,
      required this.createdAt});

  @override
  final String id;
  @override
  final String fazendaId;
  @override
  final String nome;
  @override
  final double areaHa;
  @override
  final String? observacao;
  @override
  final bool ativo;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'TalhaoEntity(id: $id, fazendaId: $fazendaId, nome: $nome, areaHa: $areaHa, observacao: $observacao, ativo: $ativo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalhaoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fazendaId, fazendaId) ||
                other.fazendaId == fazendaId) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.areaHa, areaHa) || other.areaHa == areaHa) &&
            (identical(other.observacao, observacao) ||
                other.observacao == observacao) &&
            (identical(other.ativo, ativo) || other.ativo == ativo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, fazendaId, nome, areaHa, observacao, ativo, createdAt);

  /// Create a copy of TalhaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TalhaoEntityImplCopyWith<_$TalhaoEntityImpl> get copyWith =>
      __$$TalhaoEntityImplCopyWithImpl<_$TalhaoEntityImpl>(this, _$identity);
}

abstract class _TalhaoEntity implements TalhaoEntity {
  const factory _TalhaoEntity(
      {required final String id,
      required final String fazendaId,
      required final String nome,
      required final double areaHa,
      final String? observacao,
      required final bool ativo,
      required final DateTime createdAt}) = _$TalhaoEntityImpl;

  @override
  String get id;
  @override
  String get fazendaId;
  @override
  String get nome;
  @override
  double get areaHa;
  @override
  String? get observacao;
  @override
  bool get ativo;
  @override
  DateTime get createdAt;

  /// Create a copy of TalhaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TalhaoEntityImplCopyWith<_$TalhaoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
