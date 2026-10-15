// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sementes_plano_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sementesPlanoNotifierHash() =>
    r'0d040904d56bc9c15b43ca8bf19296e03f567fc0';

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

abstract class _$SementesPlanoNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<SementeTalhaoEntity>> {
  late final String planoId;

  FutureOr<List<SementeTalhaoEntity>> build(
    String planoId,
  );
}

/// See also [SementesPlanoNotifier].
@ProviderFor(SementesPlanoNotifier)
const sementesPlanoNotifierProvider = SementesPlanoNotifierFamily();

/// See also [SementesPlanoNotifier].
class SementesPlanoNotifierFamily
    extends Family<AsyncValue<List<SementeTalhaoEntity>>> {
  /// See also [SementesPlanoNotifier].
  const SementesPlanoNotifierFamily();

  /// See also [SementesPlanoNotifier].
  SementesPlanoNotifierProvider call(
    String planoId,
  ) {
    return SementesPlanoNotifierProvider(
      planoId,
    );
  }

  @override
  SementesPlanoNotifierProvider getProviderOverride(
    covariant SementesPlanoNotifierProvider provider,
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
  String? get name => r'sementesPlanoNotifierProvider';
}

/// See also [SementesPlanoNotifier].
class SementesPlanoNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SementesPlanoNotifier,
        List<SementeTalhaoEntity>> {
  /// See also [SementesPlanoNotifier].
  SementesPlanoNotifierProvider(
    String planoId,
  ) : this._internal(
          () => SementesPlanoNotifier()..planoId = planoId,
          from: sementesPlanoNotifierProvider,
          name: r'sementesPlanoNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sementesPlanoNotifierHash,
          dependencies: SementesPlanoNotifierFamily._dependencies,
          allTransitiveDependencies:
              SementesPlanoNotifierFamily._allTransitiveDependencies,
          planoId: planoId,
        );

  SementesPlanoNotifierProvider._internal(
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
  FutureOr<List<SementeTalhaoEntity>> runNotifierBuild(
    covariant SementesPlanoNotifier notifier,
  ) {
    return notifier.build(
      planoId,
    );
  }

  @override
  Override overrideWith(SementesPlanoNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SementesPlanoNotifierProvider._internal(
        () => create()..planoId = planoId,
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
  AutoDisposeAsyncNotifierProviderElement<SementesPlanoNotifier,
      List<SementeTalhaoEntity>> createElement() {
    return _SementesPlanoNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SementesPlanoNotifierProvider && other.planoId == planoId;
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
mixin SementesPlanoNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<SementeTalhaoEntity>> {
  /// The parameter `planoId` of this provider.
  String get planoId;
}

class _SementesPlanoNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SementesPlanoNotifier,
        List<SementeTalhaoEntity>> with SementesPlanoNotifierRef {
  _SementesPlanoNotifierProviderElement(super.provider);

  @override
  String get planoId => (origin as SementesPlanoNotifierProvider).planoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
