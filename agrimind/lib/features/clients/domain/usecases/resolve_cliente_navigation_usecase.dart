import '../entities/fazenda_entity.dart';

/// Destino ao tocar um cliente na lista.
sealed class ClienteNavigationDestination {
  const ClienteNavigationDestination();
}

class ClienteDetailDestination extends ClienteNavigationDestination {
  const ClienteDetailDestination(this.clienteId);

  final String clienteId;
}

class FarmDetailDestination extends ClienteNavigationDestination {
  const FarmDetailDestination({
    required this.clienteId,
    required this.farmId,
  });

  final String clienteId;
  final String farmId;
}

/// Regra de atalho: 1 fazenda ativa → detalhe da fazenda.
class ResolveClienteNavigationUseCase {
  const ResolveClienteNavigationUseCase();

  ClienteNavigationDestination call({
    required String clienteId,
    required List<FazendaEntity> fazendasAtivas,
  }) {
    if (fazendasAtivas.length == 1) {
      return FarmDetailDestination(
        clienteId: clienteId,
        farmId: fazendasAtivas.first.id,
      );
    }
    return ClienteDetailDestination(clienteId);
  }
}
