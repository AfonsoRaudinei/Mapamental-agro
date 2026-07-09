// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plano_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlanoEntity {
  String get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  String get cultura => throw _privateConstructorUsedError;
  String get safra => throw _privateConstructorUsedError;
  double get areaHaTotal => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // rascunho | ativo | consolidado
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Referências opcionais (snapshotadas da fazenda/cliente)
  String? get clienteId => throw _privateConstructorUsedError;
  String? get clienteNome => throw _privateConstructorUsedError;
  String? get fazendaId => throw _privateConstructorUsedError;
  String? get fazendaNome => throw _privateConstructorUsedError;
  String? get produtorNomeLivre => throw _privateConstructorUsedError;
  String? get fazendaNomeLivre => throw _privateConstructorUsedError;
  String? get cidadeUf => throw _privateConstructorUsedError;
  String? get consultorNome => throw _privateConstructorUsedError;
  bool get consultorExibirNome => throw _privateConstructorUsedError;
  String? get logoLocalPath => throw _privateConstructorUsedError;
  double? get precoGraoSc60 => throw _privateConstructorUsedError;
  DateTime? get dataVencimento =>
      throw _privateConstructorUsedError; // Estádios eager-loaded para o canvas
  List<EstadioEntity> get estadios => throw _privateConstructorUsedError;

  /// Create a copy of PlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanoEntityCopyWith<PlanoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanoEntityCopyWith<$Res> {
  factory $PlanoEntityCopyWith(
          PlanoEntity value, $Res Function(PlanoEntity) then) =
      _$PlanoEntityCopyWithImpl<$Res, PlanoEntity>;
  @useResult
  $Res call(
      {String id,
      String nome,
      String cultura,
      String safra,
      double areaHaTotal,
      String status,
      DateTime createdAt,
      DateTime updatedAt,
      String? clienteId,
      String? clienteNome,
      String? fazendaId,
      String? fazendaNome,
      String? produtorNomeLivre,
      String? fazendaNomeLivre,
      String? cidadeUf,
      String? consultorNome,
      bool consultorExibirNome,
      String? logoLocalPath,
      double? precoGraoSc60,
      DateTime? dataVencimento,
      List<EstadioEntity> estadios});
}

/// @nodoc
class _$PlanoEntityCopyWithImpl<$Res, $Val extends PlanoEntity>
    implements $PlanoEntityCopyWith<$Res> {
  _$PlanoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? cultura = null,
    Object? safra = null,
    Object? areaHaTotal = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? clienteId = freezed,
    Object? clienteNome = freezed,
    Object? fazendaId = freezed,
    Object? fazendaNome = freezed,
    Object? produtorNomeLivre = freezed,
    Object? fazendaNomeLivre = freezed,
    Object? cidadeUf = freezed,
    Object? consultorNome = freezed,
    Object? consultorExibirNome = null,
    Object? logoLocalPath = freezed,
    Object? precoGraoSc60 = freezed,
    Object? dataVencimento = freezed,
    Object? estadios = null,
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
      cultura: null == cultura
          ? _value.cultura
          : cultura // ignore: cast_nullable_to_non_nullable
              as String,
      safra: null == safra
          ? _value.safra
          : safra // ignore: cast_nullable_to_non_nullable
              as String,
      areaHaTotal: null == areaHaTotal
          ? _value.areaHaTotal
          : areaHaTotal // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clienteId: freezed == clienteId
          ? _value.clienteId
          : clienteId // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteNome: freezed == clienteNome
          ? _value.clienteNome
          : clienteNome // ignore: cast_nullable_to_non_nullable
              as String?,
      fazendaId: freezed == fazendaId
          ? _value.fazendaId
          : fazendaId // ignore: cast_nullable_to_non_nullable
              as String?,
      fazendaNome: freezed == fazendaNome
          ? _value.fazendaNome
          : fazendaNome // ignore: cast_nullable_to_non_nullable
              as String?,
      produtorNomeLivre: freezed == produtorNomeLivre
          ? _value.produtorNomeLivre
          : produtorNomeLivre // ignore: cast_nullable_to_non_nullable
              as String?,
      fazendaNomeLivre: freezed == fazendaNomeLivre
          ? _value.fazendaNomeLivre
          : fazendaNomeLivre // ignore: cast_nullable_to_non_nullable
              as String?,
      cidadeUf: freezed == cidadeUf
          ? _value.cidadeUf
          : cidadeUf // ignore: cast_nullable_to_non_nullable
              as String?,
      consultorNome: freezed == consultorNome
          ? _value.consultorNome
          : consultorNome // ignore: cast_nullable_to_non_nullable
              as String?,
      consultorExibirNome: null == consultorExibirNome
          ? _value.consultorExibirNome
          : consultorExibirNome // ignore: cast_nullable_to_non_nullable
              as bool,
      logoLocalPath: freezed == logoLocalPath
          ? _value.logoLocalPath
          : logoLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      precoGraoSc60: freezed == precoGraoSc60
          ? _value.precoGraoSc60
          : precoGraoSc60 // ignore: cast_nullable_to_non_nullable
              as double?,
      dataVencimento: freezed == dataVencimento
          ? _value.dataVencimento
          : dataVencimento // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estadios: null == estadios
          ? _value.estadios
          : estadios // ignore: cast_nullable_to_non_nullable
              as List<EstadioEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanoEntityImplCopyWith<$Res>
    implements $PlanoEntityCopyWith<$Res> {
  factory _$$PlanoEntityImplCopyWith(
          _$PlanoEntityImpl value, $Res Function(_$PlanoEntityImpl) then) =
      __$$PlanoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nome,
      String cultura,
      String safra,
      double areaHaTotal,
      String status,
      DateTime createdAt,
      DateTime updatedAt,
      String? clienteId,
      String? clienteNome,
      String? fazendaId,
      String? fazendaNome,
      String? produtorNomeLivre,
      String? fazendaNomeLivre,
      String? cidadeUf,
      String? consultorNome,
      bool consultorExibirNome,
      String? logoLocalPath,
      double? precoGraoSc60,
      DateTime? dataVencimento,
      List<EstadioEntity> estadios});
}

/// @nodoc
class __$$PlanoEntityImplCopyWithImpl<$Res>
    extends _$PlanoEntityCopyWithImpl<$Res, _$PlanoEntityImpl>
    implements _$$PlanoEntityImplCopyWith<$Res> {
  __$$PlanoEntityImplCopyWithImpl(
      _$PlanoEntityImpl _value, $Res Function(_$PlanoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? cultura = null,
    Object? safra = null,
    Object? areaHaTotal = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? clienteId = freezed,
    Object? clienteNome = freezed,
    Object? fazendaId = freezed,
    Object? fazendaNome = freezed,
    Object? produtorNomeLivre = freezed,
    Object? fazendaNomeLivre = freezed,
    Object? cidadeUf = freezed,
    Object? consultorNome = freezed,
    Object? consultorExibirNome = null,
    Object? logoLocalPath = freezed,
    Object? precoGraoSc60 = freezed,
    Object? dataVencimento = freezed,
    Object? estadios = null,
  }) {
    return _then(_$PlanoEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      cultura: null == cultura
          ? _value.cultura
          : cultura // ignore: cast_nullable_to_non_nullable
              as String,
      safra: null == safra
          ? _value.safra
          : safra // ignore: cast_nullable_to_non_nullable
              as String,
      areaHaTotal: null == areaHaTotal
          ? _value.areaHaTotal
          : areaHaTotal // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clienteId: freezed == clienteId
          ? _value.clienteId
          : clienteId // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteNome: freezed == clienteNome
          ? _value.clienteNome
          : clienteNome // ignore: cast_nullable_to_non_nullable
              as String?,
      fazendaId: freezed == fazendaId
          ? _value.fazendaId
          : fazendaId // ignore: cast_nullable_to_non_nullable
              as String?,
      fazendaNome: freezed == fazendaNome
          ? _value.fazendaNome
          : fazendaNome // ignore: cast_nullable_to_non_nullable
              as String?,
      produtorNomeLivre: freezed == produtorNomeLivre
          ? _value.produtorNomeLivre
          : produtorNomeLivre // ignore: cast_nullable_to_non_nullable
              as String?,
      fazendaNomeLivre: freezed == fazendaNomeLivre
          ? _value.fazendaNomeLivre
          : fazendaNomeLivre // ignore: cast_nullable_to_non_nullable
              as String?,
      cidadeUf: freezed == cidadeUf
          ? _value.cidadeUf
          : cidadeUf // ignore: cast_nullable_to_non_nullable
              as String?,
      consultorNome: freezed == consultorNome
          ? _value.consultorNome
          : consultorNome // ignore: cast_nullable_to_non_nullable
              as String?,
      consultorExibirNome: null == consultorExibirNome
          ? _value.consultorExibirNome
          : consultorExibirNome // ignore: cast_nullable_to_non_nullable
              as bool,
      logoLocalPath: freezed == logoLocalPath
          ? _value.logoLocalPath
          : logoLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      precoGraoSc60: freezed == precoGraoSc60
          ? _value.precoGraoSc60
          : precoGraoSc60 // ignore: cast_nullable_to_non_nullable
              as double?,
      dataVencimento: freezed == dataVencimento
          ? _value.dataVencimento
          : dataVencimento // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estadios: null == estadios
          ? _value._estadios
          : estadios // ignore: cast_nullable_to_non_nullable
              as List<EstadioEntity>,
    ));
  }
}

/// @nodoc

class _$PlanoEntityImpl implements _PlanoEntity {
  const _$PlanoEntityImpl(
      {required this.id,
      required this.nome,
      required this.cultura,
      required this.safra,
      required this.areaHaTotal,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      this.clienteId,
      this.clienteNome,
      this.fazendaId,
      this.fazendaNome,
      this.produtorNomeLivre,
      this.fazendaNomeLivre,
      this.cidadeUf,
      this.consultorNome,
      this.consultorExibirNome = true,
      this.logoLocalPath,
      this.precoGraoSc60,
      this.dataVencimento,
      final List<EstadioEntity> estadios = const []})
      : _estadios = estadios;

  @override
  final String id;
  @override
  final String nome;
  @override
  final String cultura;
  @override
  final String safra;
  @override
  final double areaHaTotal;
  @override
  final String status;
// rascunho | ativo | consolidado
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// Referências opcionais (snapshotadas da fazenda/cliente)
  @override
  final String? clienteId;
  @override
  final String? clienteNome;
  @override
  final String? fazendaId;
  @override
  final String? fazendaNome;
  @override
  final String? produtorNomeLivre;
  @override
  final String? fazendaNomeLivre;
  @override
  final String? cidadeUf;
  @override
  final String? consultorNome;
  @override
  @JsonKey()
  final bool consultorExibirNome;
  @override
  final String? logoLocalPath;
  @override
  final double? precoGraoSc60;
  @override
  final DateTime? dataVencimento;
// Estádios eager-loaded para o canvas
  final List<EstadioEntity> _estadios;
// Estádios eager-loaded para o canvas
  @override
  @JsonKey()
  List<EstadioEntity> get estadios {
    if (_estadios is EqualUnmodifiableListView) return _estadios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_estadios);
  }

  @override
  String toString() {
    return 'PlanoEntity(id: $id, nome: $nome, cultura: $cultura, safra: $safra, areaHaTotal: $areaHaTotal, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, clienteId: $clienteId, clienteNome: $clienteNome, fazendaId: $fazendaId, fazendaNome: $fazendaNome, produtorNomeLivre: $produtorNomeLivre, fazendaNomeLivre: $fazendaNomeLivre, cidadeUf: $cidadeUf, consultorNome: $consultorNome, consultorExibirNome: $consultorExibirNome, logoLocalPath: $logoLocalPath, precoGraoSc60: $precoGraoSc60, dataVencimento: $dataVencimento, estadios: $estadios)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.cultura, cultura) || other.cultura == cultura) &&
            (identical(other.safra, safra) || other.safra == safra) &&
            (identical(other.areaHaTotal, areaHaTotal) ||
                other.areaHaTotal == areaHaTotal) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.clienteId, clienteId) ||
                other.clienteId == clienteId) &&
            (identical(other.clienteNome, clienteNome) ||
                other.clienteNome == clienteNome) &&
            (identical(other.fazendaId, fazendaId) ||
                other.fazendaId == fazendaId) &&
            (identical(other.fazendaNome, fazendaNome) ||
                other.fazendaNome == fazendaNome) &&
            (identical(other.produtorNomeLivre, produtorNomeLivre) ||
                other.produtorNomeLivre == produtorNomeLivre) &&
            (identical(other.fazendaNomeLivre, fazendaNomeLivre) ||
                other.fazendaNomeLivre == fazendaNomeLivre) &&
            (identical(other.cidadeUf, cidadeUf) ||
                other.cidadeUf == cidadeUf) &&
            (identical(other.consultorNome, consultorNome) ||
                other.consultorNome == consultorNome) &&
            (identical(other.consultorExibirNome, consultorExibirNome) ||
                other.consultorExibirNome == consultorExibirNome) &&
            (identical(other.logoLocalPath, logoLocalPath) ||
                other.logoLocalPath == logoLocalPath) &&
            (identical(other.precoGraoSc60, precoGraoSc60) ||
                other.precoGraoSc60 == precoGraoSc60) &&
            (identical(other.dataVencimento, dataVencimento) ||
                other.dataVencimento == dataVencimento) &&
            const DeepCollectionEquality().equals(other._estadios, _estadios));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        nome,
        cultura,
        safra,
        areaHaTotal,
        status,
        createdAt,
        updatedAt,
        clienteId,
        clienteNome,
        fazendaId,
        fazendaNome,
        produtorNomeLivre,
        fazendaNomeLivre,
        cidadeUf,
        consultorNome,
        consultorExibirNome,
        logoLocalPath,
        precoGraoSc60,
        dataVencimento,
        const DeepCollectionEquality().hash(_estadios)
      ]);

  /// Create a copy of PlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanoEntityImplCopyWith<_$PlanoEntityImpl> get copyWith =>
      __$$PlanoEntityImplCopyWithImpl<_$PlanoEntityImpl>(this, _$identity);
}

abstract class _PlanoEntity implements PlanoEntity {
  const factory _PlanoEntity(
      {required final String id,
      required final String nome,
      required final String cultura,
      required final String safra,
      required final double areaHaTotal,
      required final String status,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? clienteId,
      final String? clienteNome,
      final String? fazendaId,
      final String? fazendaNome,
      final String? produtorNomeLivre,
      final String? fazendaNomeLivre,
      final String? cidadeUf,
      final String? consultorNome,
      final bool consultorExibirNome,
      final String? logoLocalPath,
      final double? precoGraoSc60,
      final DateTime? dataVencimento,
      final List<EstadioEntity> estadios}) = _$PlanoEntityImpl;

  @override
  String get id;
  @override
  String get nome;
  @override
  String get cultura;
  @override
  String get safra;
  @override
  double get areaHaTotal;
  @override
  String get status; // rascunho | ativo | consolidado
  @override
  DateTime get createdAt;
  @override
  DateTime
      get updatedAt; // Referências opcionais (snapshotadas da fazenda/cliente)
  @override
  String? get clienteId;
  @override
  String? get clienteNome;
  @override
  String? get fazendaId;
  @override
  String? get fazendaNome;
  @override
  String? get produtorNomeLivre;
  @override
  String? get fazendaNomeLivre;
  @override
  String? get cidadeUf;
  @override
  String? get consultorNome;
  @override
  bool get consultorExibirNome;
  @override
  String? get logoLocalPath;
  @override
  double? get precoGraoSc60;
  @override
  DateTime? get dataVencimento; // Estádios eager-loaded para o canvas
  @override
  List<EstadioEntity> get estadios;

  /// Create a copy of PlanoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanoEntityImplCopyWith<_$PlanoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
