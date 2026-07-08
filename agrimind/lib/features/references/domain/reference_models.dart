import 'package:flutter/material.dart';

/// Tipos de referência — extensível para insetos, nutrientes, hormônios e CESB.
enum ReferenceKind {
  doencas,
  insetos,
  nutricao,
  fisiologia,
  circularFungicidas,
  campeoesCesb,
}

extension ReferenceKindX on ReferenceKind {
  String get title => switch (this) {
        ReferenceKind.doencas => 'Doenças',
        ReferenceKind.insetos => 'Insetos',
        ReferenceKind.nutricao => 'Nutrição',
        ReferenceKind.fisiologia => 'Fisiologia',
        ReferenceKind.circularFungicidas => 'Circular fungicidas',
        ReferenceKind.campeoesCesb => 'Campeões CESB',
      };

  String get subtitle => switch (this) {
        ReferenceKind.doencas => 'Fungos, bactérias, vírus',
        ReferenceKind.insetos => 'Pragas e níveis de ação',
        ReferenceKind.nutricao => 'N, P, K, S e micronutrientes',
        ReferenceKind.fisiologia => 'Bioestimulantes e hormônios',
        ReferenceKind.circularFungicidas =>
          'Estádio → doença → fungicida (Embrapa CT-219)',
        ReferenceKind.campeoesCesb => 'Dicas dos produtores recordistas',
      };

  IconData get icon => switch (this) {
        ReferenceKind.doencas => Icons.coronavirus_outlined,
        ReferenceKind.insetos => Icons.pest_control_outlined,
        ReferenceKind.nutricao => Icons.eco_outlined,
        ReferenceKind.fisiologia => Icons.biotech_outlined,
        ReferenceKind.circularFungicidas => Icons.menu_book_outlined,
        ReferenceKind.campeoesCesb => Icons.diamond_outlined,
      };

  Color get accentColor => switch (this) {
        ReferenceKind.doencas => const Color(0xFFEF4444),
        ReferenceKind.insetos => const Color(0xFF3B82F6),
        ReferenceKind.nutricao => const Color(0xFFA855F7),
        ReferenceKind.fisiologia => const Color(0xFF22C55E),
        ReferenceKind.circularFungicidas => const Color(0xFFD4AF37),
        ReferenceKind.campeoesCesb => const Color(0xFFD4AF37),
      };

  bool get isAvailable => switch (this) {
        ReferenceKind.circularFungicidas => true,
        _ => false,
      };

  bool get isFeatured => switch (this) {
        ReferenceKind.circularFungicidas || ReferenceKind.campeoesCesb => true,
        _ => false,
      };
}

/// Recomendação de fungicida vinculada a um estádio/doença.
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

/// Entrada de referência: estádio fenológico com doenças e fungicidas.
class ReferenceStageEntry {
  const ReferenceStageEntry({
    required this.stageCode,
    required this.stageName,
    required this.diseases,
    required this.management,
    required this.recommendations,
    this.primaryDisease,
    this.incidences,
  });

  final String stageCode;
  final String stageName;
  final List<String> diseases;
  final String management;
  final List<FungicidaRecommendation> recommendations;
  final String? primaryDisease;
  final Map<String, String>? incidences;

  String get displayTitle => '$stageCode — $stageName';
}
