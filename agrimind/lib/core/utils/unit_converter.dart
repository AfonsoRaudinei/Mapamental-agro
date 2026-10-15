/// Conversor de unidades para normalização na Consolidação.
/// Garante comparação e soma correta de doses com unidades mistas.
class UnitConverter {
  UnitConverter._();

  // Fator para converter para a unidade base do grupo
  static const Map<String, double> _factorsToBase = {
    'L/ha': 1.0,
    'mL/ha': 0.001, // mL → L
    'kg/ha': 1.0,
    'g/ha': 0.001, // g → kg
    'unid/ha': 1.0,
  };

  // Unidade base normalizada de cada grupo
  static const Map<String, String> _baseUnit = {
    'L/ha': 'L/ha',
    'mL/ha': 'L/ha',
    'kg/ha': 'kg/ha',
    'g/ha': 'kg/ha',
    'unid/ha': 'unid/ha',
  };

  /// Converte [valor] da [unidade] para a unidade base do grupo.
  /// Ex: converter(400, 'mL/ha') → 0.4 (L/ha)
  static double converter(double valor, String unidade) =>
      valor * (_factorsToBase[unidade] ?? 1.0);

  /// Converte somente unidades menores para exibição na unidade base.
  static double valorDisplay(double valor, String unidade) {
    if (unidade == 'mL/ha' || unidade == 'g/ha') {
      return converter(valor, unidade);
    }
    return valor;
  }

  /// Retorna a unidade base (normalizada).
  /// Ex: unidadeBase('mL/ha') → 'L/ha'
  static String unidadeBase(String unidade) => _baseUnit[unidade] ?? unidade;

  /// Retorna a unidade total equivalente à unidade base por hectare.
  /// Ex: unidadeTotal('mL/ha') → 'L'
  static String unidadeTotal(String unidade) =>
      unidadeBase(unidade).replaceAll('/ha', '');

  /// Verifica se duas unidades pertencem ao mesmo grupo (somáveis).
  static bool isMesmoGrupo(String u1, String u2) =>
      _baseUnit[u1] == _baseUnit[u2];

  /// Soma de totais de entradas com unidades potencialmente mistas.
  /// Retorna null se as unidades forem de grupos incompatíveis.
  static double? totalNormalizado(
    List<({double total, String unidade})> entradas,
  ) {
    if (entradas.isEmpty) return 0;
    final grupoBase = unidadeBase(entradas.first.unidade);
    for (final e in entradas) {
      if (unidadeBase(e.unidade) != grupoBase) return null;
    }
    return entradas.fold<double>(
      0.0,
      (soma, e) => soma + converter(e.total, e.unidade),
    );
  }

  /// Verifica se há unidades mistas do mesmo grupo.
  /// Ex: ['L/ha', 'mL/ha'] → true (mesmo grupo, unidades diferentes)
  static bool temUnidadeMista(List<String> unidades) {
    if (unidades.length <= 1) return false;
    final base = unidadeBase(unidades.first);
    if (!unidades.every((u) => unidadeBase(u) == base)) return false;
    return unidades.toSet().length > 1;
  }
}
