import 'package:agrimind/features/plans/domain/usecases/calcular_sementes_talhao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('caso de validação do PRD', () {
    final r = calcularSementesTalhao(
      populacaoSementesPorHa: 300000,
      sementesPorEmbalagem: 5000000,
      areaTalhaoHa: 300,
      espacamentoPlantioCm: 50,
    );

    expect(r.totalSementes, 90000000);
    expect(r.embalagensNecessarias, 18);
    expect(r.metrosLinearesPorHa, 20000);
    expect(r.sementesPorMetroLinear, 15);
  });

  test('embalagens arredondam para cima', () {
    final r = calcularSementesTalhao(
      populacaoSementesPorHa: 1,
      sementesPorEmbalagem: 5000000,
      areaTalhaoHa: 90000001,
      espacamentoPlantioCm: 50,
    );
    expect(r.totalSementes, 90000001);
    expect(r.embalagensNecessarias, 19);
  });

  test('espaçamento zero não calcula sementes por metro', () {
    final r = calcularSementesTalhao(
      populacaoSementesPorHa: 300000,
      sementesPorEmbalagem: 5000000,
      areaTalhaoHa: 300,
      espacamentoPlantioCm: 0,
    );
    expect(r.totalSementes, 90000000);
    expect(r.embalagensNecessarias, 18);
    expect(r.sementesPorMetroLinear, isNull);
    expect(r.metrosLinearesPorHa, isNull);
  });

  test('embalagensFinais usa o ajuste manual quando existe', () {
    final r = calcularSementesTalhao(
      populacaoSementesPorHa: 260000,
      sementesPorEmbalagem: 5000000,
      areaTalhaoHa: 76,
      espacamentoPlantioCm: 50,
    );

    expect(embalagensFinais(r, null), r.embalagensNecessarias);
    expect(embalagensFinais(r, 6), 6);
  });
}
