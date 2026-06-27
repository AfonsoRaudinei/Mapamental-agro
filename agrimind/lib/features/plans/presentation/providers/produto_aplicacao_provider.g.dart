// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_aplicacao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$produtoAplicacaoNotifierHash() =>
    r'78720d6a581cf6d77cbcd9cb199cc76d4f107260';

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

abstract class _$ProdutoAplicacaoNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ProdutoAplicacaoEntity>> {
  late final String estadioId;

  FutureOr<List<ProdutoAplicacaoEntity>> build(
    String estadioId,
  );
}

/// Provider dos produtos de um estádio específico.
/// Family: recebe o estadioId como parâmetro.
///
/// Copied from [ProdutoAplicacaoNotifier].
@ProviderFor(ProdutoAplicacaoNotifier)
const produtoAplicacaoNotifierProvider = ProdutoAplicacaoNotifierFamily();

/// Provider dos produtos de um estádio específico.
/// Family: recebe o estadioId como parâmetro.
///
/// Copied from [ProdutoAplicacaoNotifier].
class ProdutoAplicacaoNotifierFamily
    extends Family<AsyncValue<List<ProdutoAplicacaoEntity>>> {
  /// Provider dos produtos de um estádio específico.
  /// Family: recebe o estadioId como parâmetro.
  ///
  /// Copied from [ProdutoAplicacaoNotifier].
  const ProdutoAplicacaoNotifierFamily();

  /// Provider dos produtos de um estádio específico.
  /// Family: recebe o estadioId como parâmetro.
  ///
  /// Copied from [ProdutoAplicacaoNotifier].
  ProdutoAplicacaoNotifierProvider call(
    String estadioId,
  ) {
    return ProdutoAplicacaoNotifierProvider(
      estadioId,
    );
  }

  @override
  ProdutoAplicacaoNotifierProvider getProviderOverride(
    covariant ProdutoAplicacaoNotifierProvider provider,
  ) {
    return call(
      provider.estadioId,
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
  String? get name => r'produtoAplicacaoNotifierProvider';
}

/// Provider dos produtos de um estádio específico.
/// Family: recebe o estadioId como parâmetro.
///
/// Copied from [ProdutoAplicacaoNotifier].
class ProdutoAplicacaoNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProdutoAplicacaoNotifier,
        List<ProdutoAplicacaoEntity>> {
  /// Provider dos produtos de um estádio específico.
  /// Family: recebe o estadioId como parâmetro.
  ///
  /// Copied from [ProdutoAplicacaoNotifier].
  ProdutoAplicacaoNotifierProvider(
    String estadioId,
  ) : this._internal(
          () => ProdutoAplicacaoNotifier()..estadioId = estadioId,
          from: produtoAplicacaoNotifierProvider,
          name: r'produtoAplicacaoNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$produtoAplicacaoNotifierHash,
          dependencies: ProdutoAplicacaoNotifierFamily._dependencies,
          allTransitiveDependencies:
              ProdutoAplicacaoNotifierFamily._allTransitiveDependencies,
          estadioId: estadioId,
        );

  ProdutoAplicacaoNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.estadioId,
  }) : super.internal();

  final String estadioId;

  @override
  FutureOr<List<ProdutoAplicacaoEntity>> runNotifierBuild(
    covariant ProdutoAplicacaoNotifier notifier,
  ) {
    return notifier.build(
      estadioId,
    );
  }

  @override
  Override overrideWith(ProdutoAplicacaoNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProdutoAplicacaoNotifierProvider._internal(
        () => create()..estadioId = estadioId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        estadioId: estadioId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProdutoAplicacaoNotifier,
      List<ProdutoAplicacaoEntity>> createElement() {
    return _ProdutoAplicacaoNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProdutoAplicacaoNotifierProvider &&
        other.estadioId == estadioId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, estadioId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProdutoAplicacaoNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProdutoAplicacaoEntity>> {
  /// The parameter `estadioId` of this provider.
  String get estadioId;
}

class _ProdutoAplicacaoNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProdutoAplicacaoNotifier,
        List<ProdutoAplicacaoEntity>> with ProdutoAplicacaoNotifierRef {
  _ProdutoAplicacaoNotifierProviderElement(super.provider);

  @override
  String get estadioId =>
      (origin as ProdutoAplicacaoNotifierProvider).estadioId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
