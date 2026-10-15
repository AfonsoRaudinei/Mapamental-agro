/// Dados de apresentação de um produto no card de estádio (já formatados).
class ProductViewModel {
  const ProductViewModel({
    required this.id,
    required this.name,
    required this.doseLabel,
    required this.totalLabel,
    required this.isActive,
  });

  final String id;
  final String name;
  final String doseLabel;
  final String totalLabel;
  final bool isActive;

  String get doseTotalLine => '$doseLabel · $totalLabel';

  @override
  bool operator ==(Object other) {
    return other is ProductViewModel &&
        other.id == id &&
        other.name == name &&
        other.doseLabel == doseLabel &&
        other.totalLabel == totalLabel &&
        other.isActive == isActive;
  }

  @override
  int get hashCode => Object.hash(id, name, doseLabel, totalLabel, isActive);
}
