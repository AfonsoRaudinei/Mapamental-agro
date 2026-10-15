import 'database_service.dart';

/// Escopo do usuário autenticado para leitura/gravação no Drift local.
class LocalUserScope {
  const LocalUserScope([this._overrideUserId]);

  final String? _overrideUserId;

  String get userId {
    final id = _overrideUserId ?? DatabaseService.ownerUserId;
    if (id == null || id.isEmpty) {
      throw StateError('Operação local requer usuário autenticado.');
    }
    return id;
  }

  String? get optionalUserId => _overrideUserId ?? DatabaseService.ownerUserId;
}
