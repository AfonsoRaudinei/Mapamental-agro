import '../../../../core/agronomy/linha_tempo_soja.dart';

/// Planejamento operacional de um talhão na safra do plano (camada domain).
class TalhaoSafraEntity {
  const TalhaoSafraEntity({
    required this.id,
    required this.planoId,
    required this.talhaoId,
    required this.cultura,
    required this.cultivar,
    required this.dataPlantio,
    required this.parametros,
    this.programaOperacionalIds = const [],
  });

  final String id;
  final String planoId;
  final String talhaoId;
  final String cultura;
  final String cultivar;
  final DateTime dataPlantio;
  final ParametrosFenologicosSoja parametros;

  /// Instâncias do roteiro no plano (via [ProgramaOperacionalEntity.talhaoId]).
  final List<String> programaOperacionalIds;

  bool get roteiroAtribuido => programaOperacionalIds.isNotEmpty;

  List<LinhaTempoSojaItem> linhaTempoCalculada() => calcularLinhaTempoSoja(
        dataPlantio: dataPlantio,
        parametros: parametros,
      );

  String get tituloCronograma {
    final mat = cultivar.trim();
    if (mat.isEmpty) return 'Cronograma calculado — $cultura';
    return 'Cronograma calculado — $cultura ($mat)';
  }
}
