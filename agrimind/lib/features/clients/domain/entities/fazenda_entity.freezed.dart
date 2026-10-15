// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fazenda_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FazendaEntity {
  String get id => throw _privateConstructorUsedError;
  String get clienteId => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  double get areaHa => throw _privateConstructorUsedError;
  String get cultura => throw _privateConstructorUsedError;
  String get safra => throw _privateConstructorUsedError;
  String? get municipio => throw _privateConstructorUsedError;
  String? get uf => throw _privateConstructorUsedError;
  bool get ativo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<TalhaoEntity> get talhoes => throw _privateConstructorUsedError;

  /// Create a copy of FazendaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FazendaEntityCopyWith<FazendaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FazendaEntityCopyWith<$Res> {
  factory $FazendaEntityCopyWith(
          FazendaEntity value, $Res Function(FazendaEntity) then) =
      _$FazendaEntityCopyWithImpl<$Res, FazendaEntity>;
  @useResult
  $Res call(
      {String id,
      String clienteId,
      String nome,
      double areaHa,
      String cultura,
      String safra,
      String? municipio,
      String? uf,
      bool ativo,
      DateTime createdAt,
      DateTime updatedAt,
      List<TalhaoEntity> talhoes});
}

/// @nodoc
class _$FazendaEntityCopyWithImpl<$Res, $Val extends FazendaEntity>
    implements $FazendaEntityCopyWith<$Res> {
  _$FazendaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FazendaEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clienteId = null,
    Object? nome = null,
    Object? areaHa = null,
    Object? cultura = null,
    Object? safra = null,
    Object? municipio = freezed,
    Object? uf = freezed,
    Object? ativo = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? talhoes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clienteId: null == clienteId
          ? _value.clienteId
          : clienteId // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      areaHa: null == areaHa
          ? _value.areaHa
          : areaHa // ignore: cast_nullable_to_non_nullable
              as double,
      cultura: null == cultura
          ? _value.cultura
          : cultura // ignore: cast_nullable_to_non_nullable
              as String,
      safra: null == safra
          ? _value.safra
          : safra // ignore: cast_nullable_to_non_nullable
              as String,
      municipio: freezed == municipio
          ? _value.municipio
          : municipio // ignore: cast_nullable_to_non_nullable
              as String?,
      uf: freezed == uf
          ? _value.uf
          : uf // ignore: cast_nullable_to_non_nullable
              as String?,
      ativo: null == ativo
          ? _value.ativo
          : ativo // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      talhoes: null == talhoes
          ? _value.talhoes
          : talhoes // ignore: cast_nullable_to_non_nullable
              as List<TalhaoEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FazendaEntityImplCopyWith<$Res>
    implements $FazendaEntityCopyWith<$Res> {
  factory _$$FazendaEntityImplCopyWith(
          _$FazendaEntityImpl value, $Res Function(_$FazendaEntityImpl) then) =
      __$$FazendaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clienteId,
      String nome,
      double areaHa,
      String cultura,
      String safra,
      String? municipio,
      String? uf,
      bool ativo,
      DateTime createdAt,
      DateTime updatedAt,
      List<TalhaoEntity> talhoes});
}

/// @nodoc
class __$$FazendaEntityImplCopyWithImpl<$Res>
    extends _$FazendaEntityCopyWithImpl<$Res, _$FazendaEntityImpl>
    implements _$$FazendaEntityImplCopyWith<$Res> {
  __$$FazendaEntityImplCopyWithImpl(
      _$FazendaEntityImpl _value, $Res Function(_$FazendaEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of FazendaEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clienteId = null,
    Object? nome = null,
    Object? areaHa = null,
    Object? cultura = null,
    Object? safra = null,
    Object? municipio = freezed,
    Object? uf = freezed,
    Object? ativo = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? talhoes = null,
  }) {
    return _then(_$FazendaEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clienteId: null == clienteId
          ? _value.clienteId
          : clienteId // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      areaHa: null == areaHa
          ? _value.areaHa
          : areaHa // ignore: cast_nullable_to_non_nullable
              as double,
      cultura: null == cultura
          ? _value.cultura
          : cultura // ignore: cast_nullable_to_non_nullable
              as String,
      safra: null == safra
          ? _value.safra
          : safra // ignore: cast_nullable_to_non_nullable
              as String,
      municipio: freezed == municipio
          ? _value.municipio
          : municipio // ignore: cast_nullable_to_non_nullable
              as String?,
      uf: freezed == uf
          ? _value.uf
          : uf // ignore: cast_nullable_to_non_nullable
              as String?,
      ativo: null == ativo
          ? _value.ativo
          : ativo // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      talhoes: null == talhoes
          ? _value._talhoes
          : talhoes // ignore: cast_nullable_to_non_nullable
              as List<TalhaoEntity>,
    ));
  }
}

/// @nodoc

class _$FazendaEntityImpl implements _FazendaEntity {
  const _$FazendaEntityImpl(
      {required this.id,
      required this.clienteId,
      required this.nome,
      required this.areaHa,
      required this.cultura,
      required this.safra,
      this.municipio,
      this.uf,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt,
      final List<TalhaoEntity> talhoes = const []})
      : _talhoes = talhoes;

  @override
  final String id;
  @override
  final String clienteId;
  @override
  final String nome;
  @override
  final double areaHa;
  @override
  final String cultura;
  @override
  final String safra;
  @override
  final String? municipio;
  @override
  final String? uf;
  @override
  final bool ativo;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<TalhaoEntity> _talhoes;
  @override
  @JsonKey()
  List<TalhaoEntity> get talhoes {
    if (_talhoes is EqualUnmodifiableListView) return _talhoes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_talhoes);
  }

  @override
  String toString() {
    return 'FazendaEntity(id: $id, clienteId: $clienteId, nome: $nome, areaHa: $areaHa, cultura: $cultura, safra: $safra, municipio: $municipio, uf: $uf, ativo: $ativo, createdAt: $createdAt, updatedAt: $updatedAt, talhoes: $talhoes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FazendaEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clienteId, clienteId) ||
                other.clienteId == clienteId) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.areaHa, areaHa) || other.areaHa == areaHa) &&
            (identical(other.cultura, cultura) || other.cultura == cultura) &&
            (identical(other.safra, safra) || other.safra == safra) &&
            (identical(other.municipio, municipio) ||
                other.municipio == municipio) &&
            (identical(other.uf, uf) || other.uf == uf) &&
            (identical(other.ativo, ativo) || other.ativo == ativo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._talhoes, _talhoes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clienteId,
      nome,
      areaHa,
      cultura,
      safra,
      municipio,
      uf,
      ativo,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_talhoes));

  /// Create a copy of FazendaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FazendaEntityImplCopyWith<_$FazendaEntityImpl> get copyWith =>
      __$$FazendaEntityImplCopyWithImpl<_$FazendaEntityImpl>(this, _$identity);
}

abstract class _FazendaEntity implements FazendaEntity {
  const factory _FazendaEntity(
      {required final String id,
      required final String clienteId,
      required final String nome,
      required final double areaHa,
      required final String cultura,
      required final String safra,
      final String? municipio,
      final String? uf,
      required final bool ativo,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final List<TalhaoEntity> talhoes}) = _$FazendaEntityImpl;

  @override
  String get id;
  @override
  String get clienteId;
  @override
  String get nome;
  @override
  double get areaHa;
  @override
  String get cultura;
  @override
  String get safra;
  @override
  String? get municipio;
  @override
  String? get uf;
  @override
  bool get ativo;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<TalhaoEntity> get talhoes;

  /// Create a copy of FazendaEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FazendaEntityImplCopyWith<_$FazendaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
