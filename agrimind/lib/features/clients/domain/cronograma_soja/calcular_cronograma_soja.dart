import '../../../../core/agronomy/linha_tempo_soja.dart';
import 'cronograma_soja_linha.dart';
import 'cronograma_soja_parametros.dart';

ParametrosFenologicosSoja parametrosFromCronograma(CronogramaSojaParametros p) {
  return ParametrosFenologicosSoja(
    diasEmergencia: p.diasEmergencia,
    daePosEmergente: p.daePosEmergente,
    diasRecuperacaoPosEmergente: p.diasRecuperacaoPosEmergente,
    intervaloFungicidaDias: p.intervaloFungicidaDias,
    totalAplicacoesFungicida: p.totalAplicacoesFungicida,
    daeMaturacaoCiclo: p.daeMaturacaoCiclo,
    diasAntesR8Dessecante: p.diasAntesR8Dessecante,
    diasAntecipacaoColheitaReal: p.diasAntecipacaoColheitaReal,
    diasDessecacaoPrePlantio: p.diasDessecacaoPrePlantio,
  );
}

/// Calcula o cronograma de aplicações conforme regras de negócio (soja).
List<CronogramaSojaLinha> calcularCronogramaSoja(CronogramaSojaParametros p) {
  final linhas = calcularLinhaTempoSoja(
    dataPlantio: p.dataPlantio,
    parametros: parametrosFromCronograma(p),
  );
  return linhas.map(_mapLinha).toList();
}

CronogramaSojaLinha _mapLinha(LinhaTempoSojaItem item) {
  return CronogramaSojaLinha(
    etapa: item.etapa,
    dae: item.dae,
    data: item.data,
    tipo: switch (item.tipo) {
      LinhaTempoSojaTipo.dessecacaoPrePlantio =>
        CronogramaSojaLinhaTipo.dessecacaoPrePlantio,
      LinhaTempoSojaTipo.plantio => CronogramaSojaLinhaTipo.plantio,
      LinhaTempoSojaTipo.emergencia => CronogramaSojaLinhaTipo.emergencia,
      LinhaTempoSojaTipo.posEmergente => CronogramaSojaLinhaTipo.posEmergente,
      LinhaTempoSojaTipo.fungicida => CronogramaSojaLinhaTipo.fungicida,
      LinhaTempoSojaTipo.colheitaEstimada =>
        CronogramaSojaLinhaTipo.colheitaEstimada,
      LinhaTempoSojaTipo.dessecanteR7 => CronogramaSojaLinhaTipo.dessecanteR7,
      LinhaTempoSojaTipo.colheitaReal => CronogramaSojaLinhaTipo.colheitaReal,
      LinhaTempoSojaTipo.dessecacaoPreColheita =>
        CronogramaSojaLinhaTipo.dessecanteR7,
    },
    fungicidaIndice: item.fungicidaIndice,
    notaEtapa: item.notaEtapa,
  );
}

/// Resumo completo (fungicidas + colheita + dessecação).
String resumoCronogramaSoja(CronogramaSojaParametros p) =>
    resumoCronogramaSojaCompleto(parametrosFromCronograma(p));
