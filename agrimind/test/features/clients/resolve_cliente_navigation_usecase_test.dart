import 'package:agrimind/features/clients/domain/entities/fazenda_entity.dart';
import 'package:agrimind/features/clients/domain/usecases/resolve_cliente_navigation_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = ResolveClienteNavigationUseCase();

  FazendaEntity fazenda(String id) => FazendaEntity(
        id: id,
        clienteId: 'c1',
        nome: 'F',
        areaHa: 100,
        cultura: 'Soja',
        safra: '25/26',
        ativo: true,
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
      );

  test('0 fazendas → detalhe do cliente', () {
    final dest = useCase(clienteId: 'c1', fazendasAtivas: const []);
    expect(dest, isA<ClienteDetailDestination>());
  });

  test('1 fazenda → detalhe da fazenda', () {
    final dest = useCase(
      clienteId: 'c1',
      fazendasAtivas: [fazenda('f1')],
    );
    expect(dest, isA<FarmDetailDestination>());
    final farm = dest as FarmDetailDestination;
    expect(farm.farmId, 'f1');
  });

  test('2+ fazendas → detalhe do cliente', () {
    final dest = useCase(
      clienteId: 'c1',
      fazendasAtivas: [fazenda('f1'), fazenda('f2')],
    );
    expect(dest, isA<ClienteDetailDestination>());
  });
}
