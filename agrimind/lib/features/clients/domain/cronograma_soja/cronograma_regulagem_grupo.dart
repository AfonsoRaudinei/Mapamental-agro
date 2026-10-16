import 'cronograma_soja_parametros.dart';

/// Regulagem compartilhada entre vários talhões (plantio e cultivar por talhão).
class CronogramaRegulagemGrupo {
  const CronogramaRegulagemGrupo({
    required this.grupoId,
    required this.linhas,
  });

  final String grupoId;
  final List<CronogramaSojaParametros> linhas;

  CronogramaSojaParametros get modelo => linhas.first;

  int get ordem => modelo.ordem;

  Set<String> get talhaoIds => linhas.map((l) => l.talhaoId).toSet();

  CronogramaSojaParametros? linhaDoTalhao(String talhaoId) =>
      linhas.where((l) => l.talhaoId == talhaoId).firstOrNull;
}

List<CronogramaRegulagemGrupo> agruparCronogramasPorRegulagem(
  List<CronogramaSojaParametros> linhas,
) {
  final map = <String, List<CronogramaSojaParametros>>{};
  for (final l in linhas) {
    final gid = l.grupoRegulagemId.isEmpty ? l.id : l.grupoRegulagemId;
    map.putIfAbsent(gid, () => []).add(l);
  }
  final grupos = map.entries
      .map((e) => CronogramaRegulagemGrupo(grupoId: e.key, linhas: e.value))
      .toList();
  grupos.sort((a, b) => a.ordem.compareTo(b.ordem));
  for (final g in grupos) {
    g.linhas.sort((a, b) => a.talhaoId.compareTo(b.talhaoId));
  }
  return grupos;
}

/// Copia parâmetros fenológicos do [modelo] para cada linha do grupo.
///
/// Data de plantio, cultivar e ciclo (DAE maturação) são **do talhão** e
/// nunca são copiados entre talhões.
List<CronogramaSojaParametros> aplicarModeloNoGrupo({
  required CronogramaRegulagemGrupo grupo,
  required CronogramaSojaParametros modelo,
}) {
  return grupo.linhas.map((linha) {
    if (linha.id == modelo.id) {
      return modelo.copyWith(grupoRegulagemId: grupo.grupoId);
    }
    return linha.copyWith(
      cultura: modelo.cultura,
      diasEmergencia: modelo.diasEmergencia,
      daePosEmergente: modelo.daePosEmergente,
      diasRecuperacaoPosEmergente: modelo.diasRecuperacaoPosEmergente,
      intervaloFungicidaDias: modelo.intervaloFungicidaDias,
      totalAplicacoesFungicida: modelo.totalAplicacoesFungicida,
      diasAntesR8Dessecante: modelo.diasAntesR8Dessecante,
      diasAntecipacaoColheitaReal: modelo.diasAntecipacaoColheitaReal,
      diasDessecacaoPrePlantio: modelo.diasDessecacaoPrePlantio,
      grupoRegulagemId: grupo.grupoId,
    );
  }).toList();
}
