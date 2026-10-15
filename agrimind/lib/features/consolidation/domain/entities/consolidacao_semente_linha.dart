/// Linha de semente pronta para export (não mistura com produtos).
class ConsolidacaoSementeLinha {
  const ConsolidacaoSementeLinha({
    required this.cultivar,
    required this.talhaoNome,
    required this.areaHa,
    required this.populacaoSementesPorHa,
    required this.embalagens,
    this.sementesPorMetroLinear,
  });

  final String cultivar;
  final String talhaoNome;
  final double areaHa;
  final double populacaoSementesPorHa;
  final int embalagens;
  final double? sementesPorMetroLinear;
}
