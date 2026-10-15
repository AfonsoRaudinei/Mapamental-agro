// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estadio_referencias_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$estadioReferenciasContentMapHash() =>
    r'995cb87791ee135b5e722a633fb320e164ea9a8b';

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

/// Mapa categoria → há referências técnicas para o estádio informado.
///
/// Copied from [estadioReferenciasContentMap].
@ProviderFor(estadioReferenciasContentMap)
const estadioReferenciasContentMapProvider =
    EstadioReferenciasContentMapFamily();

/// Mapa categoria → há referências técnicas para o estádio informado.
///
/// Copied from [estadioReferenciasContentMap].
class EstadioReferenciasContentMapFamily
    extends Family<AsyncValue<Map<CategoriaReferencia, bool>>> {
  /// Mapa categoria → há referências técnicas para o estádio informado.
  ///
  /// Copied from [estadioReferenciasContentMap].
  const EstadioReferenciasContentMapFamily();

  /// Mapa categoria → há referências técnicas para o estádio informado.
  ///
  /// Copied from [estadioReferenciasContentMap].
  EstadioReferenciasContentMapProvider call(
    String estadioCodigo,
  ) {
    return EstadioReferenciasContentMapProvider(
      estadioCodigo,
    );
  }

  @override
  EstadioReferenciasContentMapProvider getProviderOverride(
    covariant EstadioReferenciasContentMapProvider provider,
  ) {
    return call(
      provider.estadioCodigo,
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
  String? get name => r'estadioReferenciasContentMapProvider';
}

/// Mapa categoria → há referências técnicas para o estádio informado.
///
/// Copied from [estadioReferenciasContentMap].
class EstadioReferenciasContentMapProvider
    extends AutoDisposeFutureProvider<Map<CategoriaReferencia, bool>> {
  /// Mapa categoria → há referências técnicas para o estádio informado.
  ///
  /// Copied from [estadioReferenciasContentMap].
  EstadioReferenciasContentMapProvider(
    String estadioCodigo,
  ) : this._internal(
          (ref) => estadioReferenciasContentMap(
            ref as EstadioReferenciasContentMapRef,
            estadioCodigo,
          ),
          from: estadioReferenciasContentMapProvider,
          name: r'estadioReferenciasContentMapProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estadioReferenciasContentMapHash,
          dependencies: EstadioReferenciasContentMapFamily._dependencies,
          allTransitiveDependencies:
              EstadioReferenciasContentMapFamily._allTransitiveDependencies,
          estadioCodigo: estadioCodigo,
        );

  EstadioReferenciasContentMapProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.estadioCodigo,
  }) : super.internal();

  final String estadioCodigo;

  @override
  Override overrideWith(
    FutureOr<Map<CategoriaReferencia, bool>> Function(
            EstadioReferenciasContentMapRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EstadioReferenciasContentMapProvider._internal(
        (ref) => create(ref as EstadioReferenciasContentMapRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        estadioCodigo: estadioCodigo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<CategoriaReferencia, bool>>
      createElement() {
    return _EstadioReferenciasContentMapProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EstadioReferenciasContentMapProvider &&
        other.estadioCodigo == estadioCodigo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, estadioCodigo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EstadioReferenciasContentMapRef
    on AutoDisposeFutureProviderRef<Map<CategoriaReferencia, bool>> {
  /// The parameter `estadioCodigo` of this provider.
  String get estadioCodigo;
}

class _EstadioReferenciasContentMapProviderElement
    extends AutoDisposeFutureProviderElement<Map<CategoriaReferencia, bool>>
    with EstadioReferenciasContentMapRef {
  _EstadioReferenciasContentMapProviderElement(super.provider);

  @override
  String get estadioCodigo =>
      (origin as EstadioReferenciasContentMapProvider).estadioCodigo;
}

String _$referenciasDisplayByCategoriaHash() =>
    r'33236ccdd43609903f49f71bcc7f3fceffca13be';

/// Itens de referência formatados para exibição no bottom sheet.
///
/// Copied from [referenciasDisplayByCategoria].
@ProviderFor(referenciasDisplayByCategoria)
const referenciasDisplayByCategoriaProvider =
    ReferenciasDisplayByCategoriaFamily();

/// Itens de referência formatados para exibição no bottom sheet.
///
/// Copied from [referenciasDisplayByCategoria].
class ReferenciasDisplayByCategoriaFamily
    extends Family<AsyncValue<List<ReferenciaDisplayItem>>> {
  /// Itens de referência formatados para exibição no bottom sheet.
  ///
  /// Copied from [referenciasDisplayByCategoria].
  const ReferenciasDisplayByCategoriaFamily();

  /// Itens de referência formatados para exibição no bottom sheet.
  ///
  /// Copied from [referenciasDisplayByCategoria].
  ReferenciasDisplayByCategoriaProvider call({
    required CategoriaReferencia categoria,
    required String estadioCodigo,
  }) {
    return ReferenciasDisplayByCategoriaProvider(
      categoria: categoria,
      estadioCodigo: estadioCodigo,
    );
  }

  @override
  ReferenciasDisplayByCategoriaProvider getProviderOverride(
    covariant ReferenciasDisplayByCategoriaProvider provider,
  ) {
    return call(
      categoria: provider.categoria,
      estadioCodigo: provider.estadioCodigo,
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
  String? get name => r'referenciasDisplayByCategoriaProvider';
}

/// Itens de referência formatados para exibição no bottom sheet.
///
/// Copied from [referenciasDisplayByCategoria].
class ReferenciasDisplayByCategoriaProvider
    extends AutoDisposeFutureProvider<List<ReferenciaDisplayItem>> {
  /// Itens de referência formatados para exibição no bottom sheet.
  ///
  /// Copied from [referenciasDisplayByCategoria].
  ReferenciasDisplayByCategoriaProvider({
    required CategoriaReferencia categoria,
    required String estadioCodigo,
  }) : this._internal(
          (ref) => referenciasDisplayByCategoria(
            ref as ReferenciasDisplayByCategoriaRef,
            categoria: categoria,
            estadioCodigo: estadioCodigo,
          ),
          from: referenciasDisplayByCategoriaProvider,
          name: r'referenciasDisplayByCategoriaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$referenciasDisplayByCategoriaHash,
          dependencies: ReferenciasDisplayByCategoriaFamily._dependencies,
          allTransitiveDependencies:
              ReferenciasDisplayByCategoriaFamily._allTransitiveDependencies,
          categoria: categoria,
          estadioCodigo: estadioCodigo,
        );

  ReferenciasDisplayByCategoriaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoria,
    required this.estadioCodigo,
  }) : super.internal();

  final CategoriaReferencia categoria;
  final String estadioCodigo;

  @override
  Override overrideWith(
    FutureOr<List<ReferenciaDisplayItem>> Function(
            ReferenciasDisplayByCategoriaRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReferenciasDisplayByCategoriaProvider._internal(
        (ref) => create(ref as ReferenciasDisplayByCategoriaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoria: categoria,
        estadioCodigo: estadioCodigo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ReferenciaDisplayItem>>
      createElement() {
    return _ReferenciasDisplayByCategoriaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReferenciasDisplayByCategoriaProvider &&
        other.categoria == categoria &&
        other.estadioCodigo == estadioCodigo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoria.hashCode);
    hash = _SystemHash.combine(hash, estadioCodigo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReferenciasDisplayByCategoriaRef
    on AutoDisposeFutureProviderRef<List<ReferenciaDisplayItem>> {
  /// The parameter `categoria` of this provider.
  CategoriaReferencia get categoria;

  /// The parameter `estadioCodigo` of this provider.
  String get estadioCodigo;
}

class _ReferenciasDisplayByCategoriaProviderElement
    extends AutoDisposeFutureProviderElement<List<ReferenciaDisplayItem>>
    with ReferenciasDisplayByCategoriaRef {
  _ReferenciasDisplayByCategoriaProviderElement(super.provider);

  @override
  CategoriaReferencia get categoria =>
      (origin as ReferenciasDisplayByCategoriaProvider).categoria;
  @override
  String get estadioCodigo =>
      (origin as ReferenciasDisplayByCategoriaProvider).estadioCodigo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
