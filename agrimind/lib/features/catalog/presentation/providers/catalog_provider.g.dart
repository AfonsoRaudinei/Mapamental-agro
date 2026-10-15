// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchProdutosHash() => r'f2610cf99c5fa90b6a22ef3d18c116f084420130';

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

/// See also [searchProdutos].
@ProviderFor(searchProdutos)
const searchProdutosProvider = SearchProdutosFamily();

/// See also [searchProdutos].
class SearchProdutosFamily
    extends Family<AsyncValue<List<ProdutoCatalogoEntity>>> {
  /// See also [searchProdutos].
  const SearchProdutosFamily();

  /// See also [searchProdutos].
  SearchProdutosProvider call(
    String query, {
    String? categoria,
  }) {
    return SearchProdutosProvider(
      query,
      categoria: categoria,
    );
  }

  @override
  SearchProdutosProvider getProviderOverride(
    covariant SearchProdutosProvider provider,
  ) {
    return call(
      provider.query,
      categoria: provider.categoria,
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
  String? get name => r'searchProdutosProvider';
}

/// See also [searchProdutos].
class SearchProdutosProvider
    extends AutoDisposeFutureProvider<List<ProdutoCatalogoEntity>> {
  /// See also [searchProdutos].
  SearchProdutosProvider(
    String query, {
    String? categoria,
  }) : this._internal(
          (ref) => searchProdutos(
            ref as SearchProdutosRef,
            query,
            categoria: categoria,
          ),
          from: searchProdutosProvider,
          name: r'searchProdutosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchProdutosHash,
          dependencies: SearchProdutosFamily._dependencies,
          allTransitiveDependencies:
              SearchProdutosFamily._allTransitiveDependencies,
          query: query,
          categoria: categoria,
        );

  SearchProdutosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.categoria,
  }) : super.internal();

  final String query;
  final String? categoria;

  @override
  Override overrideWith(
    FutureOr<List<ProdutoCatalogoEntity>> Function(SearchProdutosRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchProdutosProvider._internal(
        (ref) => create(ref as SearchProdutosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        categoria: categoria,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProdutoCatalogoEntity>>
      createElement() {
    return _SearchProdutosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProdutosProvider &&
        other.query == query &&
        other.categoria == categoria;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, categoria.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchProdutosRef
    on AutoDisposeFutureProviderRef<List<ProdutoCatalogoEntity>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `categoria` of this provider.
  String? get categoria;
}

class _SearchProdutosProviderElement
    extends AutoDisposeFutureProviderElement<List<ProdutoCatalogoEntity>>
    with SearchProdutosRef {
  _SearchProdutosProviderElement(super.provider);

  @override
  String get query => (origin as SearchProdutosProvider).query;
  @override
  String? get categoria => (origin as SearchProdutosProvider).categoria;
}

String _$catalogNotifierHash() => r'5bd389ee3e3d068de18d01223ac4c53c6c87b9a1';

/// See also [CatalogNotifier].
@ProviderFor(CatalogNotifier)
final catalogNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CatalogNotifier, List<ProdutoCatalogoEntity>>.internal(
  CatalogNotifier.new,
  name: r'catalogNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$catalogNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CatalogNotifier
    = AutoDisposeAsyncNotifier<List<ProdutoCatalogoEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
