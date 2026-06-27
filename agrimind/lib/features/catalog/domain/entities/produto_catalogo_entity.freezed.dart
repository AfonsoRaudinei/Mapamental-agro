// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produto_catalogo_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProdutoCatalogoEntity {
  String get id => throw _privateConstructorUsedError;
  String get nomeComercial => throw _privateConstructorUsedError;
  String? get ingredienteAtivo => throw _privateConstructorUsedError;
  String get categoria =>
      throw _privateConstructorUsedError; // Fungicida | Inseticida | Herbicida | Fertilizante | Bioestimulante | Adjuvante
  String get unidadePadrao => throw _privateConstructorUsedError;
  double? get doseMin => throw _privateConstructorUsedError;
  double? get doseMax => throw _privateConstructorUsedError;
  double? get precoUnitario => throw _privateConstructorUsedError;
  String? get fabricante => throw _privateConstructorUsedError;
  String? get observacoes => throw _privateConstructorUsedError;
  bool get ativo => throw _privateConstructorUsedError;
  bool get isSeed => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ProdutoCatalogoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProdutoCatalogoEntityCopyWith<ProdutoCatalogoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdutoCatalogoEntityCopyWith<$Res> {
  factory $ProdutoCatalogoEntityCopyWith(ProdutoCatalogoEntity value,
          $Res Function(ProdutoCatalogoEntity) then) =
      _$ProdutoCatalogoEntityCopyWithImpl<$Res, ProdutoCatalogoEntity>;
  @useResult
  $Res call(
      {String id,
      String nomeComercial,
      String? ingredienteAtivo,
      String categoria,
      String unidadePadrao,
      double? doseMin,
      double? doseMax,
      double? precoUnitario,
      String? fabricante,
      String? observacoes,
      bool ativo,
      bool isSeed,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ProdutoCatalogoEntityCopyWithImpl<$Res,
        $Val extends ProdutoCatalogoEntity>
    implements $ProdutoCatalogoEntityCopyWith<$Res> {
  _$ProdutoCatalogoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProdutoCatalogoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nomeComercial = null,
    Object? ingredienteAtivo = freezed,
    Object? categoria = null,
    Object? unidadePadrao = null,
    Object? doseMin = freezed,
    Object? doseMax = freezed,
    Object? precoUnitario = freezed,
    Object? fabricante = freezed,
    Object? observacoes = freezed,
    Object? ativo = null,
    Object? isSeed = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nomeComercial: null == nomeComercial
          ? _value.nomeComercial
          : nomeComercial // ignore: cast_nullable_to_non_nullable
              as String,
      ingredienteAtivo: freezed == ingredienteAtivo
          ? _value.ingredienteAtivo
          : ingredienteAtivo // ignore: cast_nullable_to_non_nullable
              as String?,
      categoria: null == categoria
          ? _value.categoria
          : categoria // ignore: cast_nullable_to_non_nullable
              as String,
      unidadePadrao: null == unidadePadrao
          ? _value.unidadePadrao
          : unidadePadrao // ignore: cast_nullable_to_non_nullable
              as String,
      doseMin: freezed == doseMin
          ? _value.doseMin
          : doseMin // ignore: cast_nullable_to_non_nullable
              as double?,
      doseMax: freezed == doseMax
          ? _value.doseMax
          : doseMax // ignore: cast_nullable_to_non_nullable
              as double?,
      precoUnitario: freezed == precoUnitario
          ? _value.precoUnitario
          : precoUnitario // ignore: cast_nullable_to_non_nullable
              as double?,
      fabricante: freezed == fabricante
          ? _value.fabricante
          : fabricante // ignore: cast_nullable_to_non_nullable
              as String?,
      observacoes: freezed == observacoes
          ? _value.observacoes
          : observacoes // ignore: cast_nullable_to_non_nullable
              as String?,
      ativo: null == ativo
          ? _value.ativo
          : ativo // ignore: cast_nullable_to_non_nullable
              as bool,
      isSeed: null == isSeed
          ? _value.isSeed
          : isSeed // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProdutoCatalogoEntityImplCopyWith<$Res>
    implements $ProdutoCatalogoEntityCopyWith<$Res> {
  factory _$$ProdutoCatalogoEntityImplCopyWith(
          _$ProdutoCatalogoEntityImpl value,
          $Res Function(_$ProdutoCatalogoEntityImpl) then) =
      __$$ProdutoCatalogoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nomeComercial,
      String? ingredienteAtivo,
      String categoria,
      String unidadePadrao,
      double? doseMin,
      double? doseMax,
      double? precoUnitario,
      String? fabricante,
      String? observacoes,
      bool ativo,
      bool isSeed,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$ProdutoCatalogoEntityImplCopyWithImpl<$Res>
    extends _$ProdutoCatalogoEntityCopyWithImpl<$Res,
        _$ProdutoCatalogoEntityImpl>
    implements _$$ProdutoCatalogoEntityImplCopyWith<$Res> {
  __$$ProdutoCatalogoEntityImplCopyWithImpl(_$ProdutoCatalogoEntityImpl _value,
      $Res Function(_$ProdutoCatalogoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProdutoCatalogoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nomeComercial = null,
    Object? ingredienteAtivo = freezed,
    Object? categoria = null,
    Object? unidadePadrao = null,
    Object? doseMin = freezed,
    Object? doseMax = freezed,
    Object? precoUnitario = freezed,
    Object? fabricante = freezed,
    Object? observacoes = freezed,
    Object? ativo = null,
    Object? isSeed = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ProdutoCatalogoEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nomeComercial: null == nomeComercial
          ? _value.nomeComercial
          : nomeComercial // ignore: cast_nullable_to_non_nullable
              as String,
      ingredienteAtivo: freezed == ingredienteAtivo
          ? _value.ingredienteAtivo
          : ingredienteAtivo // ignore: cast_nullable_to_non_nullable
              as String?,
      categoria: null == categoria
          ? _value.categoria
          : categoria // ignore: cast_nullable_to_non_nullable
              as String,
      unidadePadrao: null == unidadePadrao
          ? _value.unidadePadrao
          : unidadePadrao // ignore: cast_nullable_to_non_nullable
              as String,
      doseMin: freezed == doseMin
          ? _value.doseMin
          : doseMin // ignore: cast_nullable_to_non_nullable
              as double?,
      doseMax: freezed == doseMax
          ? _value.doseMax
          : doseMax // ignore: cast_nullable_to_non_nullable
              as double?,
      precoUnitario: freezed == precoUnitario
          ? _value.precoUnitario
          : precoUnitario // ignore: cast_nullable_to_non_nullable
              as double?,
      fabricante: freezed == fabricante
          ? _value.fabricante
          : fabricante // ignore: cast_nullable_to_non_nullable
              as String?,
      observacoes: freezed == observacoes
          ? _value.observacoes
          : observacoes // ignore: cast_nullable_to_non_nullable
              as String?,
      ativo: null == ativo
          ? _value.ativo
          : ativo // ignore: cast_nullable_to_non_nullable
              as bool,
      isSeed: null == isSeed
          ? _value.isSeed
          : isSeed // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$ProdutoCatalogoEntityImpl implements _ProdutoCatalogoEntity {
  const _$ProdutoCatalogoEntityImpl(
      {required this.id,
      required this.nomeComercial,
      this.ingredienteAtivo,
      required this.categoria,
      required this.unidadePadrao,
      this.doseMin,
      this.doseMax,
      this.precoUnitario,
      this.fabricante,
      this.observacoes,
      required this.ativo,
      required this.isSeed,
      required this.createdAt,
      required this.updatedAt});

  @override
  final String id;
  @override
  final String nomeComercial;
  @override
  final String? ingredienteAtivo;
  @override
  final String categoria;
// Fungicida | Inseticida | Herbicida | Fertilizante | Bioestimulante | Adjuvante
  @override
  final String unidadePadrao;
  @override
  final double? doseMin;
  @override
  final double? doseMax;
  @override
  final double? precoUnitario;
  @override
  final String? fabricante;
  @override
  final String? observacoes;
  @override
  final bool ativo;
  @override
  final bool isSeed;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ProdutoCatalogoEntity(id: $id, nomeComercial: $nomeComercial, ingredienteAtivo: $ingredienteAtivo, categoria: $categoria, unidadePadrao: $unidadePadrao, doseMin: $doseMin, doseMax: $doseMax, precoUnitario: $precoUnitario, fabricante: $fabricante, observacoes: $observacoes, ativo: $ativo, isSeed: $isSeed, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdutoCatalogoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nomeComercial, nomeComercial) ||
                other.nomeComercial == nomeComercial) &&
            (identical(other.ingredienteAtivo, ingredienteAtivo) ||
                other.ingredienteAtivo == ingredienteAtivo) &&
            (identical(other.categoria, categoria) ||
                other.categoria == categoria) &&
            (identical(other.unidadePadrao, unidadePadrao) ||
                other.unidadePadrao == unidadePadrao) &&
            (identical(other.doseMin, doseMin) || other.doseMin == doseMin) &&
            (identical(other.doseMax, doseMax) || other.doseMax == doseMax) &&
            (identical(other.precoUnitario, precoUnitario) ||
                other.precoUnitario == precoUnitario) &&
            (identical(other.fabricante, fabricante) ||
                other.fabricante == fabricante) &&
            (identical(other.observacoes, observacoes) ||
                other.observacoes == observacoes) &&
            (identical(other.ativo, ativo) || other.ativo == ativo) &&
            (identical(other.isSeed, isSeed) || other.isSeed == isSeed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nomeComercial,
      ingredienteAtivo,
      categoria,
      unidadePadrao,
      doseMin,
      doseMax,
      precoUnitario,
      fabricante,
      observacoes,
      ativo,
      isSeed,
      createdAt,
      updatedAt);

  /// Create a copy of ProdutoCatalogoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdutoCatalogoEntityImplCopyWith<_$ProdutoCatalogoEntityImpl>
      get copyWith => __$$ProdutoCatalogoEntityImplCopyWithImpl<
          _$ProdutoCatalogoEntityImpl>(this, _$identity);
}

abstract class _ProdutoCatalogoEntity implements ProdutoCatalogoEntity {
  const factory _ProdutoCatalogoEntity(
      {required final String id,
      required final String nomeComercial,
      final String? ingredienteAtivo,
      required final String categoria,
      required final String unidadePadrao,
      final double? doseMin,
      final double? doseMax,
      final double? precoUnitario,
      final String? fabricante,
      final String? observacoes,
      required final bool ativo,
      required final bool isSeed,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ProdutoCatalogoEntityImpl;

  @override
  String get id;
  @override
  String get nomeComercial;
  @override
  String? get ingredienteAtivo;
  @override
  String
      get categoria; // Fungicida | Inseticida | Herbicida | Fertilizante | Bioestimulante | Adjuvante
  @override
  String get unidadePadrao;
  @override
  double? get doseMin;
  @override
  double? get doseMax;
  @override
  double? get precoUnitario;
  @override
  String? get fabricante;
  @override
  String? get observacoes;
  @override
  bool get ativo;
  @override
  bool get isSeed;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ProdutoCatalogoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProdutoCatalogoEntityImplCopyWith<_$ProdutoCatalogoEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
