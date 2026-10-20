/// Resultado derivado (não persistido) da calculadora de sementes.
class SementesTalhaoCalculo {
  const SementesTalhaoCalculo({
    required this.totalSementes,
    required this.embalagensNecessarias,
    this.metrosLinearesPorHa,
    this.sementesPorMetroLinear,
  });

  final double totalSementes;
  final int embalagensNecessarias;
  final double? metrosLinearesPorHa;
  final double? sementesPorMetroLinear;
}

/// Aplica as fórmulas do PRD (ordem e nomes fixos).
SementesTalhaoCalculo calcularSementesTalhao({
  required double populacaoSementesPorHa,
  required int sementesPorEmbalagem,
  required double areaTalhaoHa,
  required double espacamentoPlantioCm,
}) {
  final totalSementes = populacaoSementesPorHa * areaTalhaoHa;
  final embalagensNecessarias = (totalSementes / sementesPorEmbalagem).ceil();

  double? metrosLinearesPorHa;
  double? sementesPorMetroLinear;
  if (espacamentoPlantioCm > 0) {
    final espacamentoMetros = espacamentoPlantioCm / 100;
    metrosLinearesPorHa = 10000 / espacamentoMetros;
    sementesPorMetroLinear = populacaoSementesPorHa / metrosLinearesPorHa;
  }

  return SementesTalhaoCalculo(
    totalSementes: totalSementes,
    embalagensNecessarias: embalagensNecessarias,
    metrosLinearesPorHa: metrosLinearesPorHa,
    sementesPorMetroLinear: sementesPorMetroLinear,
  );
}

/// Embalagens a usar: o ajuste manual, quando existe, senão o calculado.
int embalagensFinais(SementesTalhaoCalculo calc, int? manual) =>
    manual ?? calc.embalagensNecessarias;
