// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'references_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$referenciasByEstadioHash() =>
    r'80203699ebacaf4675e8c3ea66ea94c7a3202d3a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [referenciasByEstadio].
@ProviderFor(referenciasByEstadio)
const referenciasByEstadioProvider = ReferenciasByEstadioFamily();

/// See also [referenciasByEstadio].
class ReferenciasByEstadioFamily
    extends Family<AsyncValue<List<ReferenciaTecnicaEntity>>> {
  /// See also [referenciasByEstadio].
  const ReferenciasByEstadioFamily();

  /// See also [referenciasByEstadio].
  ReferenciasByEstadioProvider call({
    required String categoria,
    required String estadio,
  }) {
    return ReferenciasByEstadioProvider(
      categoria: categoria,
      estadio: estadio,
    );
  }

  @override
  ReferenciasByEstadioProvider getProviderOverride(
    covariant ReferenciasByEstadioProvider provider,
  ) {
    return call(
      categoria: provider.categoria,
      estadio: provider.estadio,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'referenciasByEstadioProvider';
}

/// See also [referenciasByEstadio].
class ReferenciasByEstadioProvider
    extends AutoDisposeFutureProvider<List<ReferenciaTecnicaEntity>> {
  /// See also [referenciasByEstadio].
  ReferenciasByEstadioProvider({
    required String categoria,
    required String estadio,
  }) : this._internal(
          (ref) => referenciasByEstadio(
            ref as ReferenciasByEstadioRef,
            categoria: categoria,
            estadio: estadio,
          ),
          from: referenciasByEstadioProvider,
          name: r'referenciasByEstadioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$referenciasByEstadioHash,
          dependencies: ReferenciasByEstadioFamily._dependencies,
          allTransitiveDependencies:
              ReferenciasByEstadioFamily._allTransitiveDependencies,
          categoria: categoria,
          estadio: estadio,
        );

  ReferenciasByEstadioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoria,
    required this.estadio,
  }) : super.internal();

  final String categoria;
  final String estadio;

  @override
  Override overrideWith(
    FutureOr<List<ReferenciaTecnicaEntity>> Function(
            ReferenciasByEstadioRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReferenciasByEstadioProvider._internal(
        (ref) => create(ref as ReferenciasByEstadioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoria: categoria,
        estadio: estadio,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ReferenciaTecnicaEntity>>
      createElement() {
    return _ReferenciasByEstadioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReferenciasByEstadioProvider &&
        other.categoria == categoria &&
        other.estadio == estadio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoria.hashCode);
    hash = _SystemHash.combine(hash, estadio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReferenciasByEstadioRef
    on AutoDisposeFutureProviderRef<List<ReferenciaTecnicaEntity>> {
  /// The parameter `categoria` of this provider.
  String get categoria;

  /// The parameter `estadio` of this provider.
  String get estadio;
}

class _ReferenciasByEstadioProviderElement
    extends AutoDisposeFutureProviderElement<List<ReferenciaTecnicaEntity>>
    with ReferenciasByEstadioRef {
  _ReferenciasByEstadioProviderElement(super.provider);

  @override
  String get categoria => (origin as ReferenciasByEstadioProvider).categoria;
  @override
  String get estadio => (origin as ReferenciasByEstadioProvider).estadio;
}

String _$referenciasByCategoriaHash() =>
    r'eb201e4267deafeca3026c35697e780b045cbe54';

/// See also [referenciasByCategoria].
@ProviderFor(referenciasByCategoria)
const referenciasByCategoriaProvider = ReferenciasByCategoriaFamily();

/// See also [referenciasByCategoria].
class ReferenciasByCategoriaFamily
    extends Family<AsyncValue<List<ReferenciaTecnicaEntity>>> {
  /// See also [referenciasByCategoria].
  const ReferenciasByCategoriaFamily();

  /// See also [referenciasByCategoria].
  ReferenciasByCategoriaProvider call(
    String categoria,
  ) {
    return ReferenciasByCategoriaProvider(
      categoria,
    );
  }

  @override
  ReferenciasByCategoriaProvider getProviderOverride(
    covariant ReferenciasByCategoriaProvider provider,
  ) {
    return call(
      provider.categoria,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'referenciasByCategoriaProvider';
}

/// See also [referenciasByCategoria].
class ReferenciasByCategoriaProvider
    extends AutoDisposeFutureProvider<List<ReferenciaTecnicaEntity>> {
  /// See also [referenciasByCategoria].
  ReferenciasByCategoriaProvider(
    String categoria,
  ) : this._internal(
          (ref) => referenciasByCategoria(
            ref as ReferenciasByCategoriaRef,
            categoria,
          ),
          from: referenciasByCategoriaProvider,
          name: r'referenciasByCategoriaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$referenciasByCategoriaHash,
          dependencies: ReferenciasByCategoriaFamily._dependencies,
          allTransitiveDependencies:
              ReferenciasByCategoriaFamily._allTransitiveDependencies,
          categoria: categoria,
        );

  ReferenciasByCategoriaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoria,
  }) : super.internal();

  final String categoria;

  @override
  Override overrideWith(
    FutureOr<List<ReferenciaTecnicaEntity>> Function(
            ReferenciasByCategoriaRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReferenciasByCategoriaProvider._internal(
        (ref) => create(ref as ReferenciasByCategoriaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoria: categoria,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ReferenciaTecnicaEntity>>
      createElement() {
    return _ReferenciasByCategoriaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReferenciasByCategoriaProvider &&
        other.categoria == categoria;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoria.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReferenciasByCategoriaRef
    on AutoDisposeFutureProviderRef<List<ReferenciaTecnicaEntity>> {
  /// The parameter `categoria` of this provider.
  String get categoria;
}

class _ReferenciasByCategoriaProviderElement
    extends AutoDisposeFutureProviderElement<List<ReferenciaTecnicaEntity>>
    with ReferenciasByCategoriaRef {
  _ReferenciasByCategoriaProviderElement(super.provider);

  @override
  String get categoria => (origin as ReferenciasByCategoriaProvider).categoria;
}

String _$cesbReferenciasHash() => r'019bc83adece4889bcca0cf8ce273787e4e3864e';

/// See also [cesbReferencias].
@ProviderFor(cesbReferencias)
const cesbReferenciasProvider = CesbReferenciasFamily();

/// See also [cesbReferencias].
class CesbReferenciasFamily
    extends Family<AsyncValue<List<ReferenciaTecnicaEntity>>> {
  /// See also [cesbReferencias].
  const CesbReferenciasFamily();

  /// See also [cesbReferencias].
  CesbReferenciasProvider call({
    String? estadio,
  }) {
    return CesbReferenciasProvider(
      estadio: estadio,
    );
  }

  @override
  CesbReferenciasProvider getProviderOverride(
    covariant CesbReferenciasProvider provider,
  ) {
    return call(
      estadio: provider.estadio,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cesbReferenciasProvider';
}

/// See also [cesbReferencias].
class CesbReferenciasProvider
    extends AutoDisposeFutureProvider<List<ReferenciaTecnicaEntity>> {
  /// See also [cesbReferencias].
  CesbReferenciasProvider({
    String? estadio,
  }) : this._internal(
          (ref) => cesbReferencias(
            ref as CesbReferenciasRef,
            estadio: estadio,
          ),
          from: cesbReferenciasProvider,
          name: r'cesbReferenciasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cesbReferenciasHash,
          dependencies: CesbReferenciasFamily._dependencies,
          allTransitiveDependencies:
              CesbReferenciasFamily._allTransitiveDependencies,
          estadio: estadio,
        );

  CesbReferenciasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.estadio,
  }) : super.internal();

  final String? estadio;

  @override
  Override overrideWith(
    FutureOr<List<ReferenciaTecnicaEntity>> Function(
            CesbReferenciasRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CesbReferenciasProvider._internal(
        (ref) => create(ref as CesbReferenciasRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        estadio: estadio,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ReferenciaTecnicaEntity>>
      createElement() {
    return _CesbReferenciasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CesbReferenciasProvider && other.estadio == estadio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, estadio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CesbReferenciasRef
    on AutoDisposeFutureProviderRef<List<ReferenciaTecnicaEntity>> {
  /// The parameter `estadio` of this provider.
  String? get estadio;
}

class _CesbReferenciasProviderElement
    extends AutoDisposeFutureProviderElement<List<ReferenciaTecnicaEntity>>
    with CesbReferenciasRef {
  _CesbReferenciasProviderElement(super.provider);

  @override
  String? get estadio => (origin as CesbReferenciasProvider).estadio;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
