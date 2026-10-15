/// Resultado da validação de cobertura de área no escopo.
class RateioAreaValidation {
  const RateioAreaValidation({
    required this.areaBaseHa,
    required this.areaTalhoesNoEscopoHa,
  });

  final double areaBaseHa;
  final double areaTalhoesNoEscopoHa;

  double get areaNaoCobertaHa =>
      areaBaseHa > areaTalhoesNoEscopoHa
          ? areaBaseHa - areaTalhoesNoEscopoHa
          : 0;

  bool get temAreaNaoCoberta => areaNaoCobertaHa > 0.001;
}
