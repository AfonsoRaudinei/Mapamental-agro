/// Parâmetros editáveis do cronograma (persistidos por talhão / linha).
class CronogramaSojaParametros {
  const CronogramaSojaParametros({
    required this.id,
    required this.talhaoId,
    required this.cultura,
    required this.materialCultivar,
    required this.dataPlantio,
    required this.diasEmergencia,
    required this.daePosEmergente,
    required this.diasRecuperacaoPosEmergente,
    required this.intervaloFungicidaDias,
    required this.totalAplicacoesFungicida,
    required this.daeMaturacaoCiclo,
    required this.diasAntesR8Dessecante,
    required this.diasAntecipacaoColheitaReal,
    required this.diasDessecacaoPrePlantio,
    required this.grupoRegulagemId,
    required this.plantioDefinido,
    required this.ordem,
    required this.programaOperacionalIds,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String talhaoId;
  final String cultura;
  final String materialCultivar;
  final DateTime dataPlantio;
  final int diasEmergencia;
  final int daePosEmergente;
  final int diasRecuperacaoPosEmergente;
  final int intervaloFungicidaDias;
  final int totalAplicacoesFungicida;
  final int daeMaturacaoCiclo;
  final int diasAntesR8Dessecante;
  final int diasAntecipacaoColheitaReal;
  final int diasDessecacaoPrePlantio;
  /// Vários talhões compartilham a mesma regulagem fenológica.
  final String grupoRegulagemId;
  /// Quando false, datas absolutas ficam no talhão (plantio ainda não informado).
  final bool plantioDefinido;
  final int ordem;
  /// Instâncias do roteiro persistidas em [talhoes_safra.programa_operacional_ids].
  final List<String> programaOperacionalIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  CronogramaSojaParametros copyWith({
    String? id,
    String? talhaoId,
    String? cultura,
    String? materialCultivar,
    DateTime? dataPlantio,
    int? diasEmergencia,
    int? daePosEmergente,
    int? diasRecuperacaoPosEmergente,
    int? intervaloFungicidaDias,
    int? totalAplicacoesFungicida,
    int? daeMaturacaoCiclo,
    int? diasAntesR8Dessecante,
    int? diasAntecipacaoColheitaReal,
    int? diasDessecacaoPrePlantio,
    String? grupoRegulagemId,
    bool? plantioDefinido,
    int? ordem,
    List<String>? programaOperacionalIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CronogramaSojaParametros(
      id: id ?? this.id,
      talhaoId: talhaoId ?? this.talhaoId,
      cultura: cultura ?? this.cultura,
      materialCultivar: materialCultivar ?? this.materialCultivar,
      dataPlantio: dataPlantio ?? this.dataPlantio,
      diasEmergencia: diasEmergencia ?? this.diasEmergencia,
      daePosEmergente: daePosEmergente ?? this.daePosEmergente,
      diasRecuperacaoPosEmergente:
          diasRecuperacaoPosEmergente ?? this.diasRecuperacaoPosEmergente,
      intervaloFungicidaDias:
          intervaloFungicidaDias ?? this.intervaloFungicidaDias,
      totalAplicacoesFungicida:
          totalAplicacoesFungicida ?? this.totalAplicacoesFungicida,
      daeMaturacaoCiclo: daeMaturacaoCiclo ?? this.daeMaturacaoCiclo,
      diasAntesR8Dessecante:
          diasAntesR8Dessecante ?? this.diasAntesR8Dessecante,
      diasAntecipacaoColheitaReal: diasAntecipacaoColheitaReal ??
          this.diasAntecipacaoColheitaReal,
      diasDessecacaoPrePlantio:
          diasDessecacaoPrePlantio ?? this.diasDessecacaoPrePlantio,
      grupoRegulagemId: grupoRegulagemId ?? this.grupoRegulagemId,
      plantioDefinido: plantioDefinido ?? this.plantioDefinido,
      ordem: ordem ?? this.ordem,
      programaOperacionalIds:
          programaOperacionalIds ?? this.programaOperacionalIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static CronogramaSojaParametros defaults({
    required String id,
    required String talhaoId,
    required String cultura,
    DateTime? dataPlantio,
  }) {
    final now = DateTime.now();
    final plantio = _dateOnly(dataPlantio ?? now);
    return CronogramaSojaParametros(
      id: id,
      talhaoId: talhaoId,
      cultura: cultura,
      materialCultivar: '',
      dataPlantio: plantio,
      grupoRegulagemId: id,
      plantioDefinido: dataPlantio != null,
      diasEmergencia: 5,
      daePosEmergente: 25,
      diasRecuperacaoPosEmergente: 5,
      intervaloFungicidaDias: 15,
      totalAplicacoesFungicida: 4,
      daeMaturacaoCiclo: 110,
      diasAntesR8Dessecante: 12,
      diasAntecipacaoColheitaReal: 5,
      diasDessecacaoPrePlantio: 15,
      ordem: 0,
      programaOperacionalIds: const [],
      // plantioDefinido set above
      createdAt: now,
      updatedAt: now,
    );
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
