import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../../../clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'talhao_safra_entity.dart';

/// Mapeamento entre SSOT [TalhaoSafraRecord] e DTO de UI do cronograma.
class TalhaoSafraRecord {
  const TalhaoSafraRecord({
    required this.id,
    required this.planoId,
    required this.talhaoId,
    required this.cultura,
    required this.cultivar,
    required this.dataPlantio,
    required this.plantioDefinido,
    required this.grupoRegulagemId,
    required this.ordem,
    required this.parametros,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String planoId;
  final String talhaoId;
  final String cultura;
  final String cultivar;
  final DateTime dataPlantio;
  final bool plantioDefinido;
  final String grupoRegulagemId;
  final int ordem;
  final ParametrosFenologicosSoja parametros;
  final DateTime createdAt;
  final DateTime updatedAt;

  TalhaoSafraEntity toEntity({List<String> programaOperacionalIds = const []}) =>
      TalhaoSafraEntity(
        id: id,
        planoId: planoId,
        talhaoId: talhaoId,
        cultura: cultura,
        cultivar: cultivar,
        dataPlantio: dataPlantio,
        parametros: parametros,
        programaOperacionalIds: programaOperacionalIds,
      );

  TalhaoSafraEntity toEntityFromCronograma(CronogramaSojaParametros dto) =>
      toEntity(programaOperacionalIds: dto.programaOperacionalIds);

  CronogramaSojaParametros toCronogramaDto({
    List<String> programaOperacionalIds = const [],
  }) =>
      CronogramaSojaParametros(
        id: id,
        talhaoId: talhaoId,
        cultura: cultura,
        materialCultivar: cultivar,
        dataPlantio: dataPlantio,
        diasEmergencia: parametros.diasEmergencia,
        daePosEmergente: parametros.daePosEmergente,
        diasRecuperacaoPosEmergente: parametros.diasRecuperacaoPosEmergente,
        intervaloFungicidaDias: parametros.intervaloFungicidaDias,
        totalAplicacoesFungicida: parametros.totalAplicacoesFungicida,
        daeMaturacaoCiclo: parametros.daeMaturacaoCiclo,
        diasAntesR8Dessecante: parametros.diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal: parametros.diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio: parametros.diasDessecacaoPrePlantio,
        grupoRegulagemId: grupoRegulagemId,
        plantioDefinido: plantioDefinido,
        ordem: ordem,
        programaOperacionalIds: programaOperacionalIds,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static TalhaoSafraRecord fromCronogramaDto({
    required String planoId,
    required CronogramaSojaParametros dto,
  }) {
    return TalhaoSafraRecord(
      id: dto.id,
      planoId: planoId,
      talhaoId: dto.talhaoId,
      cultura: dto.cultura,
      cultivar: dto.materialCultivar,
      dataPlantio: dto.dataPlantio,
      plantioDefinido: dto.plantioDefinido,
      grupoRegulagemId: dto.grupoRegulagemId,
      ordem: dto.ordem,
      parametros: ParametrosFenologicosSoja(
        diasEmergencia: dto.diasEmergencia,
        daePosEmergente: dto.daePosEmergente,
        diasRecuperacaoPosEmergente: dto.diasRecuperacaoPosEmergente,
        intervaloFungicidaDias: dto.intervaloFungicidaDias,
        totalAplicacoesFungicida: dto.totalAplicacoesFungicida,
        daeMaturacaoCiclo: dto.daeMaturacaoCiclo,
        diasAntesR8Dessecante: dto.diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal: dto.diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio: dto.diasDessecacaoPrePlantio,
      ),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
