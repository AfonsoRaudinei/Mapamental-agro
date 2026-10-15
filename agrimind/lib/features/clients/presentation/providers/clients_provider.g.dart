// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clienteDetailHash() => r'0ab1b7db85fad59a64dc9ebf231b1d0612d9d6b1';

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

/// See also [clienteDetail].
@ProviderFor(clienteDetail)
const clienteDetailProvider = ClienteDetailFamily();

/// See also [clienteDetail].
class ClienteDetailFamily extends Family<AsyncValue<ClienteEntity?>> {
  /// See also [clienteDetail].
  const ClienteDetailFamily();

  /// See also [clienteDetail].
  ClienteDetailProvider call(
    String clienteId,
  ) {
    return ClienteDetailProvider(
      clienteId,
    );
  }

  @override
  ClienteDetailProvider getProviderOverride(
    covariant ClienteDetailProvider provider,
  ) {
    return call(
      provider.clienteId,
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
  String? get name => r'clienteDetailProvider';
}

/// See also [clienteDetail].
class ClienteDetailProvider extends AutoDisposeFutureProvider<ClienteEntity?> {
  /// See also [clienteDetail].
  ClienteDetailProvider(
    String clienteId,
  ) : this._internal(
          (ref) => clienteDetail(
            ref as ClienteDetailRef,
            clienteId,
          ),
          from: clienteDetailProvider,
          name: r'clienteDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clienteDetailHash,
          dependencies: ClienteDetailFamily._dependencies,
          allTransitiveDependencies:
              ClienteDetailFamily._allTransitiveDependencies,
          clienteId: clienteId,
        );

  ClienteDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.clienteId,
  }) : super.internal();

  final String clienteId;

  @override
  Override overrideWith(
    FutureOr<ClienteEntity?> Function(ClienteDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClienteDetailProvider._internal(
        (ref) => create(ref as ClienteDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        clienteId: clienteId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ClienteEntity?> createElement() {
    return _ClienteDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClienteDetailProvider && other.clienteId == clienteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, clienteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClienteDetailRef on AutoDisposeFutureProviderRef<ClienteEntity?> {
  /// The parameter `clienteId` of this provider.
  String get clienteId;
}

class _ClienteDetailProviderElement
    extends AutoDisposeFutureProviderElement<ClienteEntity?>
    with ClienteDetailRef {
  _ClienteDetailProviderElement(super.provider);

  @override
  String get clienteId => (origin as ClienteDetailProvider).clienteId;
}

String _$clientsNotifierHash() => r'8013973c014d9eef01b23e38adc197cfc5a4b68a';

/// See also [ClientsNotifier].
@ProviderFor(ClientsNotifier)
final clientsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    ClientsNotifier, List<ClienteEntity>>.internal(
  ClientsNotifier.new,
  name: r'clientsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clientsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClientsNotifier = AutoDisposeAsyncNotifier<List<ClienteEntity>>;
String _$fazendasNotifierHash() => r'a46d09a32477ebe7a238b49cd0fa3a0ba8f564e6';

abstract class _$FazendasNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<FazendaEntity>> {
  late final String clienteId;

  FutureOr<List<FazendaEntity>> build(
    String clienteId,
  );
}

/// See also [FazendasNotifier].
@ProviderFor(FazendasNotifier)
const fazendasNotifierProvider = FazendasNotifierFamily();

/// See also [FazendasNotifier].
class FazendasNotifierFamily extends Family<AsyncValue<List<FazendaEntity>>> {
  /// See also [FazendasNotifier].
  const FazendasNotifierFamily();

  /// See also [FazendasNotifier].
  FazendasNotifierProvider call(
    String clienteId,
  ) {
    return FazendasNotifierProvider(
      clienteId,
    );
  }

  @override
  FazendasNotifierProvider getProviderOverride(
    covariant FazendasNotifierProvider provider,
  ) {
    return call(
      provider.clienteId,
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
  String? get name => r'fazendasNotifierProvider';
}

/// See also [FazendasNotifier].
class FazendasNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FazendasNotifier, List<FazendaEntity>> {
  /// See also [FazendasNotifier].
  FazendasNotifierProvider(
    String clienteId,
  ) : this._internal(
          () => FazendasNotifier()..clienteId = clienteId,
          from: fazendasNotifierProvider,
          name: r'fazendasNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fazendasNotifierHash,
          dependencies: FazendasNotifierFamily._dependencies,
          allTransitiveDependencies:
              FazendasNotifierFamily._allTransitiveDependencies,
          clienteId: clienteId,
        );

  FazendasNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.clienteId,
  }) : super.internal();

  final String clienteId;

  @override
  FutureOr<List<FazendaEntity>> runNotifierBuild(
    covariant FazendasNotifier notifier,
  ) {
    return notifier.build(
      clienteId,
    );
  }

  @override
  Override overrideWith(FazendasNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FazendasNotifierProvider._internal(
        () => create()..clienteId = clienteId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        clienteId: clienteId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FazendasNotifier, List<FazendaEntity>>
      createElement() {
    return _FazendasNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FazendasNotifierProvider && other.clienteId == clienteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, clienteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FazendasNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<FazendaEntity>> {
  /// The parameter `clienteId` of this provider.
  String get clienteId;
}

class _FazendasNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FazendasNotifier,
        List<FazendaEntity>> with FazendasNotifierRef {
  _FazendasNotifierProviderElement(super.provider);

  @override
  String get clienteId => (origin as FazendasNotifierProvider).clienteId;
}

String _$talhoesNotifierHash() => r'b210d1e939a6fa474dc17fab83840dcf12bd91f7';

abstract class _$TalhoesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<TalhaoEntity>> {
  late final String fazendaId;

  FutureOr<List<TalhaoEntity>> build(
    String fazendaId,
  );
}

/// See also [TalhoesNotifier].
@ProviderFor(TalhoesNotifier)
const talhoesNotifierProvider = TalhoesNotifierFamily();

/// See also [TalhoesNotifier].
class TalhoesNotifierFamily extends Family<AsyncValue<List<TalhaoEntity>>> {
  /// See also [TalhoesNotifier].
  const TalhoesNotifierFamily();

  /// See also [TalhoesNotifier].
  TalhoesNotifierProvider call(
    String fazendaId,
  ) {
    return TalhoesNotifierProvider(
      fazendaId,
    );
  }

  @override
  TalhoesNotifierProvider getProviderOverride(
    covariant TalhoesNotifierProvider provider,
  ) {
    return call(
      provider.fazendaId,
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
  String? get name => r'talhoesNotifierProvider';
}

/// See also [TalhoesNotifier].
class TalhoesNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TalhoesNotifier, List<TalhaoEntity>> {
  /// See also [TalhoesNotifier].
  TalhoesNotifierProvider(
    String fazendaId,
  ) : this._internal(
          () => TalhoesNotifier()..fazendaId = fazendaId,
          from: talhoesNotifierProvider,
          name: r'talhoesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talhoesNotifierHash,
          dependencies: TalhoesNotifierFamily._dependencies,
          allTransitiveDependencies:
              TalhoesNotifierFamily._allTransitiveDependencies,
          fazendaId: fazendaId,
        );

  TalhoesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fazendaId,
  }) : super.internal();

  final String fazendaId;

  @override
  FutureOr<List<TalhaoEntity>> runNotifierBuild(
    covariant TalhoesNotifier notifier,
  ) {
    return notifier.build(
      fazendaId,
    );
  }

  @override
  Override overrideWith(TalhoesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TalhoesNotifierProvider._internal(
        () => create()..fazendaId = fazendaId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fazendaId: fazendaId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TalhoesNotifier, List<TalhaoEntity>>
      createElement() {
    return _TalhoesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TalhoesNotifierProvider && other.fazendaId == fazendaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fazendaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TalhoesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<TalhaoEntity>> {
  /// The parameter `fazendaId` of this provider.
  String get fazendaId;
}

class _TalhoesNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TalhoesNotifier,
        List<TalhaoEntity>> with TalhoesNotifierRef {
  _TalhoesNotifierProviderElement(super.provider);

  @override
  String get fazendaId => (origin as TalhoesNotifierProvider).fazendaId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
