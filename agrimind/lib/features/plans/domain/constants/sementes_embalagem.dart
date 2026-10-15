/// Tamanhos de embalagem de sementes (sementes por embalagem).
/// Pendência de produto: validar lista definitiva com responsável.
abstract final class SementesEmbalagem {
  static const List<int> valores = [
    200000,
    500000,
    1000000,
    5000000,
  ];

  static String label(int sementesPorEmbalagem) {
    switch (sementesPorEmbalagem) {
      case 200000:
        return '200.000 sementes';
      case 500000:
        return '500.000 sementes';
      case 1000000:
        return '1.000.000 sementes (1 milhão)';
      case 5000000:
        return '5.000.000 sementes (5 milhões)';
      default:
        return '$sementesPorEmbalagem sementes';
    }
  }
}
