import 'package:agrimind/features/clients/presentation/widgets/talhao_timeline_stepper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final hoje = DateTime(2026, 11, 10, 15);

  test('concluído antes de hoje, atual é a primeira >= hoje', () {
    final s = statusDasEtapas([
      DateTime(2026, 10, 8),
      DateTime(2026, 11, 10),
      DateTime(2026, 11, 25),
    ], hoje);
    expect(s, [
      StepperNodeStatus.concluido,
      StepperNodeStatus.atual,
      StepperNodeStatus.futuro,
    ]);
  });

  test('safra encerrada não tem nó atual', () {
    final s = statusDasEtapas([DateTime(2026, 1, 1), DateTime(2026, 2, 1)], hoje);
    expect(s.contains(StepperNodeStatus.atual), isFalse);
  });

  test('etapa em foco: última cujo topo já passou do cabeçalho', () {
    expect(indiceEtapaEmFoco([-300, -100, 50, 400], 100), 2);
    expect(indiceEtapaEmFoco([200, 400], 100), isNull);
    expect(indiceEtapaEmFoco([null, 80, null], 100), 1);
  });
}
