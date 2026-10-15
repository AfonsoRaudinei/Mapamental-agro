// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produto_aplicacao_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProdutoAplicacaoEntity {
  String get id => throw _privateConstructorUsedError;
  String get estadioId => throw _privateConstructorUsedError;
  String get produtoNome =>
      throw _privateConstructorUsedError; // snapshot do catálogo
  String get produtoCategoria =>
      throw _privateConstructorUsedError; // snapshot: Fungicida, Inseticida...
  double get dose => throw _privateConstructorUsedError;
  String get doseUnidade =>
      throw _privateConstructorUsedError; // L/ha | mL/ha | kg/ha | g/ha | unid/ha
  double get areaHa =>
      throw _privateConstructorUsedError; // padrão = fazenda.areaHa
  String? get talhaoRef =>
      throw _privateConstructorUsedError; // Override manual do total
  double? get totalOverride => throw _privateConstructorUsedError;
  String? get overrideMotivo =>
      throw _privateConstructorUsedError; // ex: "Estoque limitado"
// Custo opcional
  double? get precoUnitario => throw _privateConstructorUsedError;
  String? get observacao => throw _privateConstructorUsedError;
  DateTime? get dataPrevista => throw _privateConstructorUsedError;
  int get ordem => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of ProdutoAplicacaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProdutoAplicacaoEntityCopyWith<ProdutoAplicacaoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdutoAplicacaoEntityCopyWith<$Res> {
  factory $ProdutoAplicacaoEntityCopyWith(ProdutoAplicacaoEntity value,
          $Res Function(ProdutoAplicacaoEntity) then) =
      _$ProdutoAplicacaoEntityCopyWithImpl<$Res, ProdutoAplicacaoEntity>;
  @useResult
  $Res call(
      {String id,
      String estadioId,
      String produtoNome,
      String produtoCategoria,
      double dose,
      String doseUnidade,
      double areaHa,
      String? talhaoRef,
      double? totalOverride,
      String? overrideMotivo,
      double? precoUnitario,
      String? observacao,
      DateTime? dataPrevista,
      int ordem,
      DateTime createdAt});
}

/// @nodoc
class _$ProdutoAplicacaoEntityCopyWithImpl<$Res,
        $Val extends ProdutoAplicacaoEntity>
    implements $ProdutoAplicacaoEntityCopyWith<$Res> {
  _$ProdutoAplicacaoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProdutoAplicacaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estadioId = null,
    Object? produtoNome = null,
    Object? produtoCategoria = null,
    Object? dose = null,
    Object? doseUnidade = null,
    Object? areaHa = null,
    Object? talhaoRef = freezed,
    Object? totalOverride = freezed,
    Object? overrideMotivo = freezed,
    Object? precoUnitario = freezed,
    Object? observacao = freezed,
    Object? dataPrevista = freezed,
    Object? ordem = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      estadioId: null == estadioId
          ? _value.estadioId
          : estadioId // ignore: cast_nullable_to_non_nullable
              as String,
      produtoNome: null == produtoNome
          ? _value.produtoNome
          : produtoNome // ignore: cast_nullable_to_non_nullable
              as String,
      produtoCategoria: null == produtoCategoria
          ? _value.produtoCategoria
          : produtoCategoria // ignore: cast_nullable_to_non_nullable
              as String,
      dose: null == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as double,
      doseUnidade: null == doseUnidade
          ? _value.doseUnidade
          : doseUnidade // ignore: cast_nullable_to_non_nullable
              as String,
      areaHa: null == areaHa
          ? _value.areaHa
          : areaHa // ignore: cast_nullable_to_non_nullable
              as double,
      talhaoRef: freezed == talhaoRef
          ? _value.talhaoRef
          : talhaoRef // ignore: cast_nullable_to_non_nullable
              as String?,
      totalOverride: freezed == totalOverride
          ? _value.totalOverride
          : totalOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      overrideMotivo: freezed == overrideMotivo
          ? _value.overrideMotivo
          : overrideMotivo // ignore: cast_nullable_to_non_nullable
              as String?,
      precoUnitario: freezed == precoUnitario
          ? _value.precoUnitario
          : precoUnitario // ignore: cast_nullable_to_non_nullable
              as double?,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      dataPrevista: freezed == dataPrevista
          ? _value.dataPrevista
          : dataPrevista // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ordem: null == ordem
          ? _value.ordem
          : ordem // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProdutoAplicacaoEntityImplCopyWith<$Res>
    implements $ProdutoAplicacaoEntityCopyWith<$Res> {
  factory _$$ProdutoAplicacaoEntityImplCopyWith(
          _$ProdutoAplicacaoEntityImpl value,
          $Res Function(_$ProdutoAplicacaoEntityImpl) then) =
      __$$ProdutoAplicacaoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String estadioId,
      String produtoNome,
      String produtoCategoria,
      double dose,
      String doseUnidade,
      double areaHa,
      String? talhaoRef,
      double? totalOverride,
      String? overrideMotivo,
      double? precoUnitario,
      String? observacao,
      DateTime? dataPrevista,
      int ordem,
      DateTime createdAt});
}

/// @nodoc
class __$$ProdutoAplicacaoEntityImplCopyWithImpl<$Res>
    extends _$ProdutoAplicacaoEntityCopyWithImpl<$Res,
        _$ProdutoAplicacaoEntityImpl>
    implements _$$ProdutoAplicacaoEntityImplCopyWith<$Res> {
  __$$ProdutoAplicacaoEntityImplCopyWithImpl(
      _$ProdutoAplicacaoEntityImpl _value,
      $Res Function(_$ProdutoAplicacaoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProdutoAplicacaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estadioId = null,
    Object? produtoNome = null,
    Object? produtoCategoria = null,
    Object? dose = null,
    Object? doseUnidade = null,
    Object? areaHa = null,
    Object? talhaoRef = freezed,
    Object? totalOverride = freezed,
    Object? overrideMotivo = freezed,
    Object? precoUnitario = freezed,
    Object? observacao = freezed,
    Object? dataPrevista = freezed,
    Object? ordem = null,
    Object? createdAt = null,
  }) {
    return _then(_$ProdutoAplicacaoEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      estadioId: null == estadioId
          ? _value.estadioId
          : estadioId // ignore: cast_nullable_to_non_nullable
              as String,
      produtoNome: null == produtoNome
          ? _value.produtoNome
          : produtoNome // ignore: cast_nullable_to_non_nullable
              as String,
      produtoCategoria: null == produtoCategoria
          ? _value.produtoCategoria
          : produtoCategoria // ignore: cast_nullable_to_non_nullable
              as String,
      dose: null == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as double,
      doseUnidade: null == doseUnidade
          ? _value.doseUnidade
          : doseUnidade // ignore: cast_nullable_to_non_nullable
              as String,
      areaHa: null == areaHa
          ? _value.areaHa
          : areaHa // ignore: cast_nullable_to_non_nullable
              as double,
      talhaoRef: freezed == talhaoRef
          ? _value.talhaoRef
          : talhaoRef // ignore: cast_nullable_to_non_nullable
              as String?,
      totalOverride: freezed == totalOverride
          ? _value.totalOverride
          : totalOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      overrideMotivo: freezed == overrideMotivo
          ? _value.overrideMotivo
          : overrideMotivo // ignore: cast_nullable_to_non_nullable
              as String?,
      precoUnitario: freezed == precoUnitario
          ? _value.precoUnitario
          : precoUnitario // ignore: cast_nullable_to_non_nullable
              as double?,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      dataPrevista: freezed == dataPrevista
          ? _value.dataPrevista
          : dataPrevista // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ordem: null == ordem
          ? _value.ordem
          : ordem // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$ProdutoAplicacaoEntityImpl extends _ProdutoAplicacaoEntity {
  const _$ProdutoAplicacaoEntityImpl(
      {required this.id,
      required this.estadioId,
      required this.produtoNome,
      required this.produtoCategoria,
      required this.dose,
      required this.doseUnidade,
      required this.areaHa,
      this.talhaoRef,
      this.totalOverride,
      this.overrideMotivo,
      this.precoUnitario,
      this.observacao,
      this.dataPrevista,
      required this.ordem,
      required this.createdAt})
      : super._();

  @override
  final String id;
  @override
  final String estadioId;
  @override
  final String produtoNome;
// snapshot do catálogo
  @override
  final String produtoCategoria;
// snapshot: Fungicida, Inseticida...
  @override
  final double dose;
  @override
  final String doseUnidade;
// L/ha | mL/ha | kg/ha | g/ha | unid/ha
  @override
  final double areaHa;
// padrão = fazenda.areaHa
  @override
  final String? talhaoRef;
// Override manual do total
  @override
  final double? totalOverride;
  @override
  final String? overrideMotivo;
// ex: "Estoque limitado"
// Custo opcional
  @override
  final double? precoUnitario;
  @override
  final String? observacao;
  @override
  final DateTime? dataPrevista;
  @override
  final int ordem;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ProdutoAplicacaoEntity(id: $id, estadioId: $estadioId, produtoNome: $produtoNome, produtoCategoria: $produtoCategoria, dose: $dose, doseUnidade: $doseUnidade, areaHa: $areaHa, talhaoRef: $talhaoRef, totalOverride: $totalOverride, overrideMotivo: $overrideMotivo, precoUnitario: $precoUnitario, observacao: $observacao, dataPrevista: $dataPrevista, ordem: $ordem, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdutoAplicacaoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.estadioId, estadioId) ||
                other.estadioId == estadioId) &&
            (identical(other.produtoNome, produtoNome) ||
                other.produtoNome == produtoNome) &&
            (identical(other.produtoCategoria, produtoCategoria) ||
                other.produtoCategoria == produtoCategoria) &&
            (identical(other.dose, dose) || other.dose == dose) &&
            (identical(other.doseUnidade, doseUnidade) ||
                other.doseUnidade == doseUnidade) &&
            (identical(other.areaHa, areaHa) || other.areaHa == areaHa) &&
            (identical(other.talhaoRef, talhaoRef) ||
                other.talhaoRef == talhaoRef) &&
            (identical(other.totalOverride, totalOverride) ||
                other.totalOverride == totalOverride) &&
            (identical(other.overrideMotivo, overrideMotivo) ||
                other.overrideMotivo == overrideMotivo) &&
            (identical(other.precoUnitario, precoUnitario) ||
                other.precoUnitario == precoUnitario) &&
            (identical(other.observacao, observacao) ||
                other.observacao == observacao) &&
            (identical(other.dataPrevista, dataPrevista) ||
                other.dataPrevista == dataPrevista) &&
            (identical(other.ordem, ordem) || other.ordem == ordem) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      estadioId,
      produtoNome,
      produtoCategoria,
      dose,
      doseUnidade,
      areaHa,
      talhaoRef,
      totalOverride,
      overrideMotivo,
      precoUnitario,
      observacao,
      dataPrevista,
      ordem,
      createdAt);

  /// Create a copy of ProdutoAplicacaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdutoAplicacaoEntityImplCopyWith<_$ProdutoAplicacaoEntityImpl>
      get copyWith => __$$ProdutoAplicacaoEntityImplCopyWithImpl<
          _$ProdutoAplicacaoEntityImpl>(this, _$identity);
}

abstract class _ProdutoAplicacaoEntity extends ProdutoAplicacaoEntity {
  const factory _ProdutoAplicacaoEntity(
      {required final String id,
      required final String estadioId,
      required final String produtoNome,
      required final String produtoCategoria,
      required final double dose,
      required final String doseUnidade,
      required final double areaHa,
      final String? talhaoRef,
      final double? totalOverride,
      final String? overrideMotivo,
      final double? precoUnitario,
      final String? observacao,
      final DateTime? dataPrevista,
      required final int ordem,
      required final DateTime createdAt}) = _$ProdutoAplicacaoEntityImpl;
  const _ProdutoAplicacaoEntity._() : super._();

  @override
  String get id;
  @override
  String get estadioId;
  @override
  String get produtoNome; // snapshot do catálogo
  @override
  String get produtoCategoria; // snapshot: Fungicida, Inseticida...
  @override
  double get dose;
  @override
  String get doseUnidade; // L/ha | mL/ha | kg/ha | g/ha | unid/ha
  @override
  double get areaHa; // padrão = fazenda.areaHa
  @override
  String? get talhaoRef; // Override manual do total
  @override
  double? get totalOverride;
  @override
  String? get overrideMotivo; // ex: "Estoque limitado"
// Custo opcional
  @override
  double? get precoUnitario;
  @override
  String? get observacao;
  @override
  DateTime? get dataPrevista;
  @override
  int get ordem;
  @override
  DateTime get createdAt;

  /// Create a copy of ProdutoAplicacaoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProdutoAplicacaoEntityImplCopyWith<_$ProdutoAplicacaoEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
