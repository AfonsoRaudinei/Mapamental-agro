// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cultivar_plano_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CultivarPlanoEntity {
  String? get nome => throw _privateConstructorUsedError;
  String? get obtentora => throw _privateConstructorUsedError;
  String? get grupoMaturacao => throw _privateConstructorUsedError;
  double? get populacao => throw _privateConstructorUsedError;
  String get populacaoUnidade => throw _privateConstructorUsedError;
  String? get observacoes => throw _privateConstructorUsedError;

  /// Create a copy of CultivarPlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CultivarPlanoEntityCopyWith<CultivarPlanoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CultivarPlanoEntityCopyWith<$Res> {
  factory $CultivarPlanoEntityCopyWith(
          CultivarPlanoEntity value, $Res Function(CultivarPlanoEntity) then) =
      _$CultivarPlanoEntityCopyWithImpl<$Res, CultivarPlanoEntity>;
  @useResult
  $Res call(
      {String? nome,
      String? obtentora,
      String? grupoMaturacao,
      double? populacao,
      String populacaoUnidade,
      String? observacoes});
}

/// @nodoc
class _$CultivarPlanoEntityCopyWithImpl<$Res, $Val extends CultivarPlanoEntity>
    implements $CultivarPlanoEntityCopyWith<$Res> {
  _$CultivarPlanoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CultivarPlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nome = freezed,
    Object? obtentora = freezed,
    Object? grupoMaturacao = freezed,
    Object? populacao = freezed,
    Object? populacaoUnidade = null,
    Object? observacoes = freezed,
  }) {
    return _then(_value.copyWith(
      nome: freezed == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String?,
      obtentora: freezed == obtentora
          ? _value.obtentora
          : obtentora // ignore: cast_nullable_to_non_nullable
              as String?,
      grupoMaturacao: freezed == grupoMaturacao
          ? _value.grupoMaturacao
          : grupoMaturacao // ignore: cast_nullable_to_non_nullable
              as String?,
      populacao: freezed == populacao
          ? _value.populacao
          : populacao // ignore: cast_nullable_to_non_nullable
              as double?,
      populacaoUnidade: null == populacaoUnidade
          ? _value.populacaoUnidade
          : populacaoUnidade // ignore: cast_nullable_to_non_nullable
              as String,
      observacoes: freezed == observacoes
          ? _value.observacoes
          : observacoes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CultivarPlanoEntityImplCopyWith<$Res>
    implements $CultivarPlanoEntityCopyWith<$Res> {
  factory _$$CultivarPlanoEntityImplCopyWith(_$CultivarPlanoEntityImpl value,
          $Res Function(_$CultivarPlanoEntityImpl) then) =
      __$$CultivarPlanoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nome,
      String? obtentora,
      String? grupoMaturacao,
      double? populacao,
      String populacaoUnidade,
      String? observacoes});
}

/// @nodoc
class __$$CultivarPlanoEntityImplCopyWithImpl<$Res>
    extends _$CultivarPlanoEntityCopyWithImpl<$Res, _$CultivarPlanoEntityImpl>
    implements _$$CultivarPlanoEntityImplCopyWith<$Res> {
  __$$CultivarPlanoEntityImplCopyWithImpl(_$CultivarPlanoEntityImpl _value,
      $Res Function(_$CultivarPlanoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CultivarPlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nome = freezed,
    Object? obtentora = freezed,
    Object? grupoMaturacao = freezed,
    Object? populacao = freezed,
    Object? populacaoUnidade = null,
    Object? observacoes = freezed,
  }) {
    return _then(_$CultivarPlanoEntityImpl(
      nome: freezed == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String?,
      obtentora: freezed == obtentora
          ? _value.obtentora
          : obtentora // ignore: cast_nullable_to_non_nullable
              as String?,
      grupoMaturacao: freezed == grupoMaturacao
          ? _value.grupoMaturacao
          : grupoMaturacao // ignore: cast_nullable_to_non_nullable
              as String?,
      populacao: freezed == populacao
          ? _value.populacao
          : populacao // ignore: cast_nullable_to_non_nullable
              as double?,
      populacaoUnidade: null == populacaoUnidade
          ? _value.populacaoUnidade
          : populacaoUnidade // ignore: cast_nullable_to_non_nullable
              as String,
      observacoes: freezed == observacoes
          ? _value.observacoes
          : observacoes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CultivarPlanoEntityImpl extends _CultivarPlanoEntity {
  const _$CultivarPlanoEntityImpl(
      {this.nome,
      this.obtentora,
      this.grupoMaturacao,
      this.populacao,
      this.populacaoUnidade = 'plantas/ha',
      this.observacoes})
      : super._();

  @override
  final String? nome;
  @override
  final String? obtentora;
  @override
  final String? grupoMaturacao;
  @override
  final double? populacao;
  @override
  @JsonKey()
  final String populacaoUnidade;
  @override
  final String? observacoes;

  @override
  String toString() {
    return 'CultivarPlanoEntity(nome: $nome, obtentora: $obtentora, grupoMaturacao: $grupoMaturacao, populacao: $populacao, populacaoUnidade: $populacaoUnidade, observacoes: $observacoes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CultivarPlanoEntityImpl &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.obtentora, obtentora) ||
                other.obtentora == obtentora) &&
            (identical(other.grupoMaturacao, grupoMaturacao) ||
                other.grupoMaturacao == grupoMaturacao) &&
            (identical(other.populacao, populacao) ||
                other.populacao == populacao) &&
            (identical(other.populacaoUnidade, populacaoUnidade) ||
                other.populacaoUnidade == populacaoUnidade) &&
            (identical(other.observacoes, observacoes) ||
                other.observacoes == observacoes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nome, obtentora, grupoMaturacao,
      populacao, populacaoUnidade, observacoes);

  /// Create a copy of CultivarPlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CultivarPlanoEntityImplCopyWith<_$CultivarPlanoEntityImpl> get copyWith =>
      __$$CultivarPlanoEntityImplCopyWithImpl<_$CultivarPlanoEntityImpl>(
          this, _$identity);
}

abstract class _CultivarPlanoEntity extends CultivarPlanoEntity {
  const factory _CultivarPlanoEntity(
      {final String? nome,
      final String? obtentora,
      final String? grupoMaturacao,
      final double? populacao,
      final String populacaoUnidade,
      final String? observacoes}) = _$CultivarPlanoEntityImpl;
  const _CultivarPlanoEntity._() : super._();

  @override
  String? get nome;
  @override
  String? get obtentora;
  @override
  String? get grupoMaturacao;
  @override
  double? get populacao;
  @override
  String get populacaoUnidade;
  @override
  String? get observacoes;

  /// Create a copy of CultivarPlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CultivarPlanoEntityImplCopyWith<_$CultivarPlanoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
