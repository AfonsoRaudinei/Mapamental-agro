class FungicidaRecommendation {
  const FungicidaRecommendation({
    required this.rank,
    required this.product,
    required this.activeIngredient,
    this.controlPercent,
    this.productivityKgHa,
    this.fitotoxPercent,
    this.source,
    this.notes,
  });

  final int rank;
  final String product;
  final String activeIngredient;
  final double? controlPercent;
  final double? productivityKgHa;
  final double? fitotoxPercent;
  final String? source;
  final String? notes;
}

class ReferenceStageEntry {
  const ReferenceStageEntry({
    required this.stageCode,
    required this.stageName,
    required this.diseases,
    required this.management,
    required this.recommendations,
    this.primaryDisease,
    this.incidences,
    this.aliases = const [],
  });

  final String stageCode;
  final String stageName;
  final List<String> diseases;
  final String management;
  final List<FungicidaRecommendation> recommendations;
  final String? primaryDisease;
  final Map<String, String>? incidences;

  /// Códigos de estádio do canvas que mapeiam para esta entrada (ex.: VE, V1).
  final List<String> aliases;

  bool matchesStage(String codigo) {
    final normalized = codigo.trim().toUpperCase();
    if (stageCode.toUpperCase() == normalized) return true;
    return aliases.any((alias) => alias.toUpperCase() == normalized);
  }
}
