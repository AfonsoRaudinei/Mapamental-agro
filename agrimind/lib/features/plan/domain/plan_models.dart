class ClientModel {
  const ClientModel({
    required this.id,
    required this.name,
    required this.areaHa,
    required this.harvest,
  });

  final String id;
  final String name;
  final double areaHa;
  final String harvest;

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'area_ha': areaHa,
        'harvest': harvest,
      };

  factory ClientModel.fromMap(Map<String, Object?> map) => ClientModel(
        id: map['id']! as String,
        name: map['name']! as String,
        areaHa: (map['area_ha'] as num).toDouble(),
        harvest: map['harvest']! as String,
      );

  String get subtitle => '${areaHa.toStringAsFixed(1)} ha · $harvest';
}

class StageModel {
  const StageModel({
    required this.id,
    required this.planId,
    required this.code,
    required this.name,
    required this.sortOrder,
    this.isExpanded = false,
  });

  final String id;
  final String planId;
  final String code;
  final String name;
  final int sortOrder;
  final bool isExpanded;

  String get displayTitle => '$code — $name';

  StageModel copyWith({
    String? name,
    int? sortOrder,
    bool? isExpanded,
  }) =>
      StageModel(
        id: id,
        planId: planId,
        code: code,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'plan_id': planId,
        'code': code,
        'name': name,
        'sort_order': sortOrder,
      };

  factory StageModel.fromMap(Map<String, Object?> map) => StageModel(
        id: map['id']! as String,
        planId: map['plan_id']! as String,
        code: map['code']! as String,
        name: map['name']! as String,
        sortOrder: map['sort_order']! as int,
      );
}

class ProductModel {
  const ProductModel({
    required this.id,
    required this.stageId,
    required this.name,
  });

  final String id;
  final String stageId;
  final String name;

  Map<String, Object?> toMap() => {
        'id': id,
        'stage_id': stageId,
        'name': name,
      };

  factory ProductModel.fromMap(Map<String, Object?> map) => ProductModel(
        id: map['id']! as String,
        stageId: map['stage_id']! as String,
        name: map['name']! as String,
      );
}

class PlanModel {
  const PlanModel({
    required this.id,
    required this.clientId,
  });

  final String id;
  final String clientId;

  Map<String, Object?> toMap() => {
        'id': id,
        'client_id': clientId,
      };

  factory PlanModel.fromMap(Map<String, Object?> map) => PlanModel(
        id: map['id']! as String,
        clientId: map['client_id']! as String,
      );
}
