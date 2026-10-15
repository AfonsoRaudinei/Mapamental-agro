import 'product_view_model.dart';

/// Dados de apresentação de um estádio no canvas do plano.
class StageViewModel {
  const StageViewModel({
    required this.id,
    required this.stageCode,
    required this.title,
    required this.countLabel,
    required this.products,
  });

  final String id;
  final String stageCode;
  final String title;
  final String countLabel;
  final List<ProductViewModel> products;

  @override
  bool operator ==(Object other) {
    return other is StageViewModel &&
        other.id == id &&
        other.stageCode == stageCode &&
        other.title == title &&
        other.countLabel == countLabel &&
        _listEquals(other.products, products);
  }

  @override
  int get hashCode => Object.hash(id, stageCode, title, countLabel, products);

  static bool _listEquals(List<ProductViewModel> a, List<ProductViewModel> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
