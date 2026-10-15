/// Use case para calcular total de dose × área.
/// Responsabilidade única: cálculo agronômico central.
///
/// Regras:
/// - totalCalculado = dose × areaHa
/// - totalFinal = totalOverride ?? totalCalculado
class CalcularTotalUseCase {
  const CalcularTotalUseCase();

  /// Calcula o total de aplicação.
  /// Se [totalOverride] for informado, retorna ele (sem cálculo).
  double call({
    required double dose,
    required double areaHa,
    double? totalOverride,
  }) {
    return totalOverride ?? (dose * areaHa);
  }

  /// Calcula custo total (opcional).
  double? calcularCusto({
    required double totalFinal,
    double? precoUnitario,
  }) {
    if (precoUnitario == null) return null;
    return totalFinal * precoUnitario;
  }
}
