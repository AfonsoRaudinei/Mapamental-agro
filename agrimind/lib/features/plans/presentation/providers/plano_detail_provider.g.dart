// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plano_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$planoDetailHash() => r'0893dca22356294b2347ca1e5bd3984d43afe957';

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

/// Provider do detalhe de um Plano (inclui estádios + produtos).
/// Family: recebe o planoId como parâmetro.
///
/// Copied from [planoDetail].
@ProviderFor(planoDetail)
const planoDetailProvider = PlanoDetailFamily();

/// Provider do detalhe de um Plano (inclui estádios + produtos).
/// Family: recebe o planoId como parâmetro.
///
/// Copied from [planoDetail].
class PlanoDetailFamily extends Family<AsyncValue<PlanoEntity>> {
  /// Provider do detalhe de um Plano (inclui estádios + produtos).
  /// Family: recebe o planoId como parâmetro.
  ///
  /// Copied from [planoDetail].
  const PlanoDetailFamily();

  /// Provider do detalhe de um Plano (inclui estádios + produtos).
  /// Family: recebe o planoId como parâmetro.
  ///
  /// Copied from [planoDetail].
  PlanoDetailProvider call(
    String planoId,
  ) {
    return PlanoDetailProvider(
      planoId,
    );
  }

  @override
  PlanoDetailProvider getProviderOverride(
    covariant PlanoDetailProvider provider,
  ) {
    return call(
      provider.planoId,
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
  String? get name => r'planoDetailProvider';
}

/// Provider do detalhe de um Plano (inclui estádios + produtos).
/// Family: recebe o planoId como parâmetro.
///
/// Copied from [planoDetail].
class PlanoDetailProvider extends AutoDisposeFutureProvider<PlanoEntity> {
  /// Provider do detalhe de um Plano (inclui estádios + produtos).
  /// Family: recebe o planoId como parâmetro.
  ///
  /// Copied from [planoDetail].
  PlanoDetailProvider(
    String planoId,
  ) : this._internal(
          (ref) => planoDetail(
            ref as PlanoDetailRef,
            planoId,
          ),
          from: planoDetailProvider,
          name: r'planoDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$planoDetailHash,
          dependencies: PlanoDetailFamily._dependencies,
          allTransitiveDependencies:
              PlanoDetailFamily._allTransitiveDependencies,
          planoId: planoId,
        );

  PlanoDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.planoId,
  }) : super.internal();

  final String planoId;

  @override
  Override overrideWith(
    FutureOr<PlanoEntity> Function(PlanoDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanoDetailProvider._internal(
        (ref) => create(ref as PlanoDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        planoId: planoId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PlanoEntity> createElement() {
    return _PlanoDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanoDetailProvider && other.planoId == planoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, planoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlanoDetailRef on AutoDisposeFutureProviderRef<PlanoEntity> {
  /// The parameter `planoId` of this provider.
  String get planoId;
}

class _PlanoDetailProviderElement
    extends AutoDisposeFutureProviderElement<PlanoEntity> with PlanoDetailRef {
  _PlanoDetailProviderElement(super.provider);

  @override
  String get planoId => (origin as PlanoDetailProvider).planoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
