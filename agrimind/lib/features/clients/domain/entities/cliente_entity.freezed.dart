// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cliente_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClienteEntity {
  String get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  String? get cpfCnpj => throw _privateConstructorUsedError;
  String? get telefone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get cidade => throw _privateConstructorUsedError;
  String? get uf => throw _privateConstructorUsedError;
  bool get ativo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<FazendaEntity> get fazendas => throw _privateConstructorUsedError;

  /// Create a copy of ClienteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClienteEntityCopyWith<ClienteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClienteEntityCopyWith<$Res> {
  factory $ClienteEntityCopyWith(
          ClienteEntity value, $Res Function(ClienteEntity) then) =
      _$ClienteEntityCopyWithImpl<$Res, ClienteEntity>;
  @useResult
  $Res call(
      {String id,
      String nome,
      String? cpfCnpj,
      String? telefone,
      String? email,
      String? cidade,
      String? uf,
      bool ativo,
      DateTime createdAt,
      DateTime updatedAt,
      List<FazendaEntity> fazendas});
}

/// @nodoc
class _$ClienteEntityCopyWithImpl<$Res, $Val extends ClienteEntity>
    implements $ClienteEntityCopyWith<$Res> {
  _$ClienteEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClienteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? cpfCnpj = freezed,
    Object? telefone = freezed,
    Object? email = freezed,
    Object? cidade = freezed,
    Object? uf = freezed,
    Object? ativo = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? fazendas = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      cpfCnpj: freezed == cpfCnpj
          ? _value.cpfCnpj
          : cpfCnpj // ignore: cast_nullable_to_non_nullable
              as String?,
      telefone: freezed == telefone
          ? _value.telefone
          : telefone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      cidade: freezed == cidade
          ? _value.cidade
          : cidade // ignore: cast_nullable_to_non_nullable
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
      fazendas: null == fazendas
          ? _value.fazendas
          : fazendas // ignore: cast_nullable_to_non_nullable
              as List<FazendaEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClienteEntityImplCopyWith<$Res>
    implements $ClienteEntityCopyWith<$Res> {
  factory _$$ClienteEntityImplCopyWith(
          _$ClienteEntityImpl value, $Res Function(_$ClienteEntityImpl) then) =
      __$$ClienteEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nome,
      String? cpfCnpj,
      String? telefone,
      String? email,
      String? cidade,
      String? uf,
      bool ativo,
      DateTime createdAt,
      DateTime updatedAt,
      List<FazendaEntity> fazendas});
}

/// @nodoc
class __$$ClienteEntityImplCopyWithImpl<$Res>
    extends _$ClienteEntityCopyWithImpl<$Res, _$ClienteEntityImpl>
    implements _$$ClienteEntityImplCopyWith<$Res> {
  __$$ClienteEntityImplCopyWithImpl(
      _$ClienteEntityImpl _value, $Res Function(_$ClienteEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClienteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? cpfCnpj = freezed,
    Object? telefone = freezed,
    Object? email = freezed,
    Object? cidade = freezed,
    Object? uf = freezed,
    Object? ativo = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? fazendas = null,
  }) {
    return _then(_$ClienteEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      cpfCnpj: freezed == cpfCnpj
          ? _value.cpfCnpj
          : cpfCnpj // ignore: cast_nullable_to_non_nullable
              as String?,
      telefone: freezed == telefone
          ? _value.telefone
          : telefone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      cidade: freezed == cidade
          ? _value.cidade
          : cidade // ignore: cast_nullable_to_non_nullable
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
      fazendas: null == fazendas
          ? _value._fazendas
          : fazendas // ignore: cast_nullable_to_non_nullable
              as List<FazendaEntity>,
    ));
  }
}

/// @nodoc

class _$ClienteEntityImpl implements _ClienteEntity {
  const _$ClienteEntityImpl(
      {required this.id,
      required this.nome,
      this.cpfCnpj,
      this.telefone,
      this.email,
      this.cidade,
      this.uf,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt,
      final List<FazendaEntity> fazendas = const []})
      : _fazendas = fazendas;

  @override
  final String id;
  @override
  final String nome;
  @override
  final String? cpfCnpj;
  @override
  final String? telefone;
  @override
  final String? email;
  @override
  final String? cidade;
  @override
  final String? uf;
  @override
  final bool ativo;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<FazendaEntity> _fazendas;
  @override
  @JsonKey()
  List<FazendaEntity> get fazendas {
    if (_fazendas is EqualUnmodifiableListView) return _fazendas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fazendas);
  }

  @override
  String toString() {
    return 'ClienteEntity(id: $id, nome: $nome, cpfCnpj: $cpfCnpj, telefone: $telefone, email: $email, cidade: $cidade, uf: $uf, ativo: $ativo, createdAt: $createdAt, updatedAt: $updatedAt, fazendas: $fazendas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClienteEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.cpfCnpj, cpfCnpj) || other.cpfCnpj == cpfCnpj) &&
            (identical(other.telefone, telefone) ||
                other.telefone == telefone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.cidade, cidade) || other.cidade == cidade) &&
            (identical(other.uf, uf) || other.uf == uf) &&
            (identical(other.ativo, ativo) || other.ativo == ativo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._fazendas, _fazendas));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nome,
      cpfCnpj,
      telefone,
      email,
      cidade,
      uf,
      ativo,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_fazendas));

  /// Create a copy of ClienteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClienteEntityImplCopyWith<_$ClienteEntityImpl> get copyWith =>
      __$$ClienteEntityImplCopyWithImpl<_$ClienteEntityImpl>(this, _$identity);
}

abstract class _ClienteEntity implements ClienteEntity {
  const factory _ClienteEntity(
      {required final String id,
      required final String nome,
      final String? cpfCnpj,
      final String? telefone,
      final String? email,
      final String? cidade,
      final String? uf,
      required final bool ativo,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final List<FazendaEntity> fazendas}) = _$ClienteEntityImpl;

  @override
  String get id;
  @override
  String get nome;
  @override
  String? get cpfCnpj;
  @override
  String? get telefone;
  @override
  String? get email;
  @override
  String? get cidade;
  @override
  String? get uf;
  @override
  bool get ativo;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<FazendaEntity> get fazendas;

  /// Create a copy of ClienteEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClienteEntityImplCopyWith<_$ClienteEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
