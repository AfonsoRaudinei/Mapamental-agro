// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referencia_tecnica_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReferenciaTecnicaEntity {
  String get id => throw _privateConstructorUsedError;
  String get categoria =>
      throw _privateConstructorUsedError; // doencas | insetos | nutricao | fisiologia | cesb
  String get estadio =>
      throw _privateConstructorUsedError; // VE, VC, V1...R8, Operacional
  String get titulo => throw _privateConstructorUsedError;
  String? get descricao => throw _privateConstructorUsedError;
  String? get focoManejo =>
      throw _privateConstructorUsedError; // CESB: "Fixação de Flores"
  String? get praticas =>
      throw _privateConstructorUsedError; // CESB: lista de práticas
  String? get padrao =>
      throw _privateConstructorUsedError; // CESB: "Nutrologia" | "Hormonal" | "Biológico"
  String? get destaque => throw _privateConstructorUsedError;

  /// Create a copy of ReferenciaTecnicaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferenciaTecnicaEntityCopyWith<ReferenciaTecnicaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenciaTecnicaEntityCopyWith<$Res> {
  factory $ReferenciaTecnicaEntityCopyWith(ReferenciaTecnicaEntity value,
          $Res Function(ReferenciaTecnicaEntity) then) =
      _$ReferenciaTecnicaEntityCopyWithImpl<$Res, ReferenciaTecnicaEntity>;
  @useResult
  $Res call(
      {String id,
      String categoria,
      String estadio,
      String titulo,
      String? descricao,
      String? focoManejo,
      String? praticas,
      String? padrao,
      String? destaque});
}

/// @nodoc
class _$ReferenciaTecnicaEntityCopyWithImpl<$Res,
        $Val extends ReferenciaTecnicaEntity>
    implements $ReferenciaTecnicaEntityCopyWith<$Res> {
  _$ReferenciaTecnicaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReferenciaTecnicaEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoria = null,
    Object? estadio = null,
    Object? titulo = null,
    Object? descricao = freezed,
    Object? focoManejo = freezed,
    Object? praticas = freezed,
    Object? padrao = freezed,
    Object? destaque = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoria: null == categoria
          ? _value.categoria
          : categoria // ignore: cast_nullable_to_non_nullable
              as String,
      estadio: null == estadio
          ? _value.estadio
          : estadio // ignore: cast_nullable_to_non_nullable
              as String,
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      descricao: freezed == descricao
          ? _value.descricao
          : descricao // ignore: cast_nullable_to_non_nullable
              as String?,
      focoManejo: freezed == focoManejo
          ? _value.focoManejo
          : focoManejo // ignore: cast_nullable_to_non_nullable
              as String?,
      praticas: freezed == praticas
          ? _value.praticas
          : praticas // ignore: cast_nullable_to_non_nullable
              as String?,
      padrao: freezed == padrao
          ? _value.padrao
          : padrao // ignore: cast_nullable_to_non_nullable
              as String?,
      destaque: freezed == destaque
          ? _value.destaque
          : destaque // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferenciaTecnicaEntityImplCopyWith<$Res>
    implements $ReferenciaTecnicaEntityCopyWith<$Res> {
  factory _$$ReferenciaTecnicaEntityImplCopyWith(
          _$ReferenciaTecnicaEntityImpl value,
          $Res Function(_$ReferenciaTecnicaEntityImpl) then) =
      __$$ReferenciaTecnicaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String categoria,
      String estadio,
      String titulo,
      String? descricao,
      String? focoManejo,
      String? praticas,
      String? padrao,
      String? destaque});
}

/// @nodoc
class __$$ReferenciaTecnicaEntityImplCopyWithImpl<$Res>
    extends _$ReferenciaTecnicaEntityCopyWithImpl<$Res,
        _$ReferenciaTecnicaEntityImpl>
    implements _$$ReferenciaTecnicaEntityImplCopyWith<$Res> {
  __$$ReferenciaTecnicaEntityImplCopyWithImpl(
      _$ReferenciaTecnicaEntityImpl _value,
      $Res Function(_$ReferenciaTecnicaEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReferenciaTecnicaEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoria = null,
    Object? estadio = null,
    Object? titulo = null,
    Object? descricao = freezed,
    Object? focoManejo = freezed,
    Object? praticas = freezed,
    Object? padrao = freezed,
    Object? destaque = freezed,
  }) {
    return _then(_$ReferenciaTecnicaEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoria: null == categoria
          ? _value.categoria
          : categoria // ignore: cast_nullable_to_non_nullable
              as String,
      estadio: null == estadio
          ? _value.estadio
          : estadio // ignore: cast_nullable_to_non_nullable
              as String,
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      descricao: freezed == descricao
          ? _value.descricao
          : descricao // ignore: cast_nullable_to_non_nullable
              as String?,
      focoManejo: freezed == focoManejo
          ? _value.focoManejo
          : focoManejo // ignore: cast_nullable_to_non_nullable
              as String?,
      praticas: freezed == praticas
          ? _value.praticas
          : praticas // ignore: cast_nullable_to_non_nullable
              as String?,
      padrao: freezed == padrao
          ? _value.padrao
          : padrao // ignore: cast_nullable_to_non_nullable
              as String?,
      destaque: freezed == destaque
          ? _value.destaque
          : destaque // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReferenciaTecnicaEntityImpl implements _ReferenciaTecnicaEntity {
  const _$ReferenciaTecnicaEntityImpl(
      {required this.id,
      required this.categoria,
      required this.estadio,
      required this.titulo,
      this.descricao,
      this.focoManejo,
      this.praticas,
      this.padrao,
      this.destaque});

  @override
  final String id;
  @override
  final String categoria;
// doencas | insetos | nutricao | fisiologia | cesb
  @override
  final String estadio;
// VE, VC, V1...R8, Operacional
  @override
  final String titulo;
  @override
  final String? descricao;
  @override
  final String? focoManejo;
// CESB: "Fixação de Flores"
  @override
  final String? praticas;
// CESB: lista de práticas
  @override
  final String? padrao;
// CESB: "Nutrologia" | "Hormonal" | "Biológico"
  @override
  final String? destaque;

  @override
  String toString() {
    return 'ReferenciaTecnicaEntity(id: $id, categoria: $categoria, estadio: $estadio, titulo: $titulo, descricao: $descricao, focoManejo: $focoManejo, praticas: $praticas, padrao: $padrao, destaque: $destaque)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferenciaTecnicaEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoria, categoria) ||
                other.categoria == categoria) &&
            (identical(other.estadio, estadio) || other.estadio == estadio) &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.descricao, descricao) ||
                other.descricao == descricao) &&
            (identical(other.focoManejo, focoManejo) ||
                other.focoManejo == focoManejo) &&
            (identical(other.praticas, praticas) ||
                other.praticas == praticas) &&
            (identical(other.padrao, padrao) || other.padrao == padrao) &&
            (identical(other.destaque, destaque) ||
                other.destaque == destaque));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, categoria, estadio, titulo,
      descricao, focoManejo, praticas, padrao, destaque);

  /// Create a copy of ReferenciaTecnicaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferenciaTecnicaEntityImplCopyWith<_$ReferenciaTecnicaEntityImpl>
      get copyWith => __$$ReferenciaTecnicaEntityImplCopyWithImpl<
          _$ReferenciaTecnicaEntityImpl>(this, _$identity);
}

abstract class _ReferenciaTecnicaEntity implements ReferenciaTecnicaEntity {
  const factory _ReferenciaTecnicaEntity(
      {required final String id,
      required final String categoria,
      required final String estadio,
      required final String titulo,
      final String? descricao,
      final String? focoManejo,
      final String? praticas,
      final String? padrao,
      final String? destaque}) = _$ReferenciaTecnicaEntityImpl;

  @override
  String get id;
  @override
  String get categoria; // doencas | insetos | nutricao | fisiologia | cesb
  @override
  String get estadio; // VE, VC, V1...R8, Operacional
  @override
  String get titulo;
  @override
  String? get descricao;
  @override
  String? get focoManejo; // CESB: "Fixação de Flores"
  @override
  String? get praticas; // CESB: lista de práticas
  @override
  String? get padrao; // CESB: "Nutrologia" | "Hormonal" | "Biológico"
  @override
  String? get destaque;

  /// Create a copy of ReferenciaTecnicaEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferenciaTecnicaEntityImplCopyWith<_$ReferenciaTecnicaEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
