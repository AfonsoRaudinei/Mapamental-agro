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

  test('texto relativo na linguagem do campo', () {
    final h = DateTime(2026, 10, 17, 9);
    expect(textoRelativo(DateTime(2026, 10, 17), h), 'hoje');
    expect(textoRelativo(DateTime(2026, 10, 18), h), 'amanhã');
    expect(textoRelativo(DateTime(2026, 10, 16), h), 'ontem');
    expect(textoRelativo(DateTime(2026, 11, 8), h), 'em 22 dias');
    expect(textoRelativo(DateTime(2026, 10, 9), h), 'há 8 dias');
  });

  test('marcador Hoje fica entre a última concluída e a próxima', () {
    final datas = [
      DateTime(2026, 9, 24), // OP
      DateTime(2026, 10, 9), // SEM
      DateTime(2026, 10, 14), // VE
      DateTime(2026, 11, 8), // V5
    ];
    final p = posicaoHoje(datas, DateTime(2026, 10, 17));
    expect(p, greaterThan(2));
    expect(p, lessThan(3));
    // No dia exato da etapa, o marcador fica sobre o nó.
    expect(posicaoHoje(datas, DateTime(2026, 11, 8)), 3);
    // Antes de tudo / depois de tudo.
    expect(posicaoHoje(datas, DateTime(2026, 9, 1)), lessThan(0));
    expect(posicaoHoje(datas, DateTime(2027, 3, 1)), greaterThan(3));
  });
}
