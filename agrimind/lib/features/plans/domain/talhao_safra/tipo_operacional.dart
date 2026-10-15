/// Tipos do dropdown Operacional no plano (spec: [ProgramaOperacionalTipo]).
enum TipoOperacional {
  indefinido('Tipo indefinido — reclassifique'),
  dessecacaoPrePlantio('Dessecação (pré-plantio)'),
  plantio('Plantio'),
  adubacao('Adubação'),
  posEmergente('Pós-emergente'),
  fungicidaRecorrente('Fungicida (recorrente)'),
  dessecacaoPreColheita('Dessecação da soja (pré-colheita)'),
  aplicacaoExtra('Aplicação extra');

  const TipoOperacional(this.label);

  final String label;

  bool get agrupavel =>
      this == TipoOperacional.plantio || this == TipoOperacional.adubacao;

  /// Label padrão do card operacional no canvas.
  String get cardLabel => label;

  static TipoOperacional? tryParseStorage(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final v in TipoOperacional.values) {
      if (v.name == raw) return v;
    }
    return null;
  }
}

enum RegraCalculoOperacional {
  dataFixa,
  porDae,
  recorrente,
  referenciaPlantio,
}
