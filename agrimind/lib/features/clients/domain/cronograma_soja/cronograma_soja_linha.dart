/// Linha calculada do cronograma agrícola (soja).
class CronogramaSojaLinha {
  const CronogramaSojaLinha({
    required this.etapa,
    required this.dae,
    required this.data,
    required this.tipo,
    this.fungicidaIndice,
    this.notaEtapa,
  });

  final String etapa;
  final int? dae;
  final DateTime data;
  final CronogramaSojaLinhaTipo tipo;
  final int? fungicidaIndice;
  final String? notaEtapa;
}

enum CronogramaSojaLinhaTipo {
  dessecacaoPrePlantio,
  plantio,
  emergencia,
  posEmergente,
  fungicida,
  dessecanteR7,
  colheitaReal,
  colheitaEstimada,
  dessecacaoPreColheita,
}
