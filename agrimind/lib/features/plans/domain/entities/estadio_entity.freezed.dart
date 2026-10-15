// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estadio_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EstadioEntity {
  String get id => throw _privateConstructorUsedError;
  String get planoId => throw _privateConstructorUsedError;
  String get codigo =>
      throw _privateConstructorUsedError; // 'VE','VC','V1'...'R8' ou 'Operacional'
  EstadioTipo get tipo => throw _privateConstructorUsedError;
  String get label =>
      throw _privateConstructorUsedError; // editável pelo técnico (padrão = codigo)
  int get ordem => throw _privateConstructorUsedError;
  DateTime? get dataAplicacao => throw _privateConstructorUsedError;
  String? get imageLocalPath => throw _privateConstructorUsedError;
  String? get observacao => throw _privateConstructorUsedError;
  TipoOperacional? get tipoOperacional => throw _privateConstructorUsedError;
  OperacionalEstadioConfig? get operacionalConfig =>
      throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Produtos eager-loaded para o canvas
  List<ProdutoAplicacaoEntity> get produtos =>
      throw _privateConstructorUsedError;

  /// Create a copy of EstadioEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstadioEntityCopyWith<EstadioEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstadioEntityCopyWith<$Res> {
  factory $EstadioEntityCopyWith(
          EstadioEntity value, $Res Function(EstadioEntity) then) =
      _$EstadioEntityCopyWithImpl<$Res, EstadioEntity>;
  @useResult
  $Res call(
      {String id,
      String planoId,
      String codigo,
      EstadioTipo tipo,
      String label,
      int ordem,
      DateTime? dataAplicacao,
      String? imageLocalPath,
      String? observacao,
      TipoOperacional? tipoOperacional,
      OperacionalEstadioConfig? operacionalConfig,
      DateTime createdAt,
      List<ProdutoAplicacaoEntity> produtos});
}

/// @nodoc
class _$EstadioEntityCopyWithImpl<$Res, $Val extends EstadioEntity>
    implements $EstadioEntityCopyWith<$Res> {
  _$EstadioEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstadioEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planoId = null,
    Object? codigo = null,
    Object? tipo = null,
    Object? label = null,
    Object? ordem = null,
    Object? dataAplicacao = freezed,
    Object? imageLocalPath = freezed,
    Object? observacao = freezed,
    Object? tipoOperacional = freezed,
    Object? operacionalConfig = freezed,
    Object? createdAt = null,
    Object? produtos = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      planoId: null == planoId
          ? _value.planoId
          : planoId // ignore: cast_nullable_to_non_nullable
              as String,
      codigo: null == codigo
          ? _value.codigo
          : codigo // ignore: cast_nullable_to_non_nullable
              as String,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as EstadioTipo,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      ordem: null == ordem
          ? _value.ordem
          : ordem // ignore: cast_nullable_to_non_nullable
              as int,
      dataAplicacao: freezed == dataAplicacao
          ? _value.dataAplicacao
          : dataAplicacao // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageLocalPath: freezed == imageLocalPath
          ? _value.imageLocalPath
          : imageLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      tipoOperacional: freezed == tipoOperacional
          ? _value.tipoOperacional
          : tipoOperacional // ignore: cast_nullable_to_non_nullable
              as TipoOperacional?,
      operacionalConfig: freezed == operacionalConfig
          ? _value.operacionalConfig
          : operacionalConfig // ignore: cast_nullable_to_non_nullable
              as OperacionalEstadioConfig?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      produtos: null == produtos
          ? _value.produtos
          : produtos // ignore: cast_nullable_to_non_nullable
              as List<ProdutoAplicacaoEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EstadioEntityImplCopyWith<$Res>
    implements $EstadioEntityCopyWith<$Res> {
  factory _$$EstadioEntityImplCopyWith(
          _$EstadioEntityImpl value, $Res Function(_$EstadioEntityImpl) then) =
      __$$EstadioEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String planoId,
      String codigo,
      EstadioTipo tipo,
      String label,
      int ordem,
      DateTime? dataAplicacao,
      String? imageLocalPath,
      String? observacao,
      TipoOperacional? tipoOperacional,
      OperacionalEstadioConfig? operacionalConfig,
      DateTime createdAt,
      List<ProdutoAplicacaoEntity> produtos});
}

/// @nodoc
class __$$EstadioEntityImplCopyWithImpl<$Res>
    extends _$EstadioEntityCopyWithImpl<$Res, _$EstadioEntityImpl>
    implements _$$EstadioEntityImplCopyWith<$Res> {
  __$$EstadioEntityImplCopyWithImpl(
      _$EstadioEntityImpl _value, $Res Function(_$EstadioEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EstadioEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planoId = null,
    Object? codigo = null,
    Object? tipo = null,
    Object? label = null,
    Object? ordem = null,
    Object? dataAplicacao = freezed,
    Object? imageLocalPath = freezed,
    Object? observacao = freezed,
    Object? tipoOperacional = freezed,
    Object? operacionalConfig = freezed,
    Object? createdAt = null,
    Object? produtos = null,
  }) {
    return _then(_$EstadioEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      planoId: null == planoId
          ? _value.planoId
          : planoId // ignore: cast_nullable_to_non_nullable
              as String,
      codigo: null == codigo
          ? _value.codigo
          : codigo // ignore: cast_nullable_to_non_nullable
              as String,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as EstadioTipo,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      ordem: null == ordem
          ? _value.ordem
          : ordem // ignore: cast_nullable_to_non_nullable
              as int,
      dataAplicacao: freezed == dataAplicacao
          ? _value.dataAplicacao
          : dataAplicacao // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageLocalPath: freezed == imageLocalPath
          ? _value.imageLocalPath
          : imageLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      tipoOperacional: freezed == tipoOperacional
          ? _value.tipoOperacional
          : tipoOperacional // ignore: cast_nullable_to_non_nullable
              as TipoOperacional?,
      operacionalConfig: freezed == operacionalConfig
          ? _value.operacionalConfig
          : operacionalConfig // ignore: cast_nullable_to_non_nullable
              as OperacionalEstadioConfig?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      produtos: null == produtos
          ? _value._produtos
          : produtos // ignore: cast_nullable_to_non_nullable
              as List<ProdutoAplicacaoEntity>,
    ));
  }
}

/// @nodoc

class _$EstadioEntityImpl implements _EstadioEntity {
  const _$EstadioEntityImpl(
      {required this.id,
      required this.planoId,
      required this.codigo,
      this.tipo = EstadioTipo.fenologico,
      required this.label,
      required this.ordem,
      this.dataAplicacao,
      this.imageLocalPath,
      this.observacao,
      this.tipoOperacional,
      this.operacionalConfig,
      required this.createdAt,
      final List<ProdutoAplicacaoEntity> produtos = const []})
      : _produtos = produtos;

  @override
  final String id;
  @override
  final String planoId;
  @override
  final String codigo;
// 'VE','VC','V1'...'R8' ou 'Operacional'
  @override
  @JsonKey()
  final EstadioTipo tipo;
  @override
  final String label;
// editável pelo técnico (padrão = codigo)
  @override
  final int ordem;
  @override
  final DateTime? dataAplicacao;
  @override
  final String? imageLocalPath;
  @override
  final String? observacao;
  @override
  final TipoOperacional? tipoOperacional;
  @override
  final OperacionalEstadioConfig? operacionalConfig;
  @override
  final DateTime createdAt;
// Produtos eager-loaded para o canvas
  final List<ProdutoAplicacaoEntity> _produtos;
// Produtos eager-loaded para o canvas
  @override
  @JsonKey()
  List<ProdutoAplicacaoEntity> get produtos {
    if (_produtos is EqualUnmodifiableListView) return _produtos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produtos);
  }

  @override
  String toString() {
    return 'EstadioEntity(id: $id, planoId: $planoId, codigo: $codigo, tipo: $tipo, label: $label, ordem: $ordem, dataAplicacao: $dataAplicacao, imageLocalPath: $imageLocalPath, observacao: $observacao, tipoOperacional: $tipoOperacional, operacionalConfig: $operacionalConfig, createdAt: $createdAt, produtos: $produtos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstadioEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planoId, planoId) || other.planoId == planoId) &&
            (identical(other.codigo, codigo) || other.codigo == codigo) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.ordem, ordem) || other.ordem == ordem) &&
            (identical(other.dataAplicacao, dataAplicacao) ||
                other.dataAplicacao == dataAplicacao) &&
            (identical(other.imageLocalPath, imageLocalPath) ||
                other.imageLocalPath == imageLocalPath) &&
            (identical(other.observacao, observacao) ||
                other.observacao == observacao) &&
            (identical(other.tipoOperacional, tipoOperacional) ||
                other.tipoOperacional == tipoOperacional) &&
            (identical(other.operacionalConfig, operacionalConfig) ||
                other.operacionalConfig == operacionalConfig) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._produtos, _produtos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      planoId,
      codigo,
      tipo,
      label,
      ordem,
      dataAplicacao,
      imageLocalPath,
      observacao,
      tipoOperacional,
      operacionalConfig,
      createdAt,
      const DeepCollectionEquality().hash(_produtos));

  /// Create a copy of EstadioEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstadioEntityImplCopyWith<_$EstadioEntityImpl> get copyWith =>
      __$$EstadioEntityImplCopyWithImpl<_$EstadioEntityImpl>(this, _$identity);
}

abstract class _EstadioEntity implements EstadioEntity {
  const factory _EstadioEntity(
      {required final String id,
      required final String planoId,
      required final String codigo,
      final EstadioTipo tipo,
      required final String label,
      required final int ordem,
      final DateTime? dataAplicacao,
      final String? imageLocalPath,
      final String? observacao,
      final TipoOperacional? tipoOperacional,
      final OperacionalEstadioConfig? operacionalConfig,
      required final DateTime createdAt,
      final List<ProdutoAplicacaoEntity> produtos}) = _$EstadioEntityImpl;

  @override
  String get id;
  @override
  String get planoId;
  @override
  String get codigo; // 'VE','VC','V1'...'R8' ou 'Operacional'
  @override
  EstadioTipo get tipo;
  @override
  String get label; // editável pelo técnico (padrão = codigo)
  @override
  int get ordem;
  @override
  DateTime? get dataAplicacao;
  @override
  String? get imageLocalPath;
  @override
  String? get observacao;
  @override
  TipoOperacional? get tipoOperacional;
  @override
  OperacionalEstadioConfig? get operacionalConfig;
  @override
  DateTime get createdAt; // Produtos eager-loaded para o canvas
  @override
  List<ProdutoAplicacaoEntity> get produtos;

  /// Create a copy of EstadioEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstadioEntityImplCopyWith<_$EstadioEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
