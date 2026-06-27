import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Enum das 5 categorias agronômicas do AgriMind.
///
/// Cada categoria tem: cor iOS, ícone Phosphor outline,
/// label PT-BR e filtro para o catálogo de produtos.
enum CategoriaReferencia {
  doencas(
    label: 'Doenças',
    cor: 0xFFFF3B30,
    icone: PhosphorIconsRegular.virus,
    subtitle: 'Fungos, bactérias, vírus',
    filtroCatalogo: 'Fungicida',
  ),
  insetos(
    label: 'Insetos',
    cor: 0xFF007AFF,
    icone: PhosphorIconsRegular.bug,
    subtitle: 'Pragas e níveis de ação',
    filtroCatalogo: 'Inseticida',
  ),
  nutricao(
    label: 'Nutrição',
    cor: 0xFFAF52DE,
    icone: PhosphorIconsRegular.leaf,
    subtitle: 'N, P, K, S e micronutrientes',
    filtroCatalogo: 'Fertilizante',
  ),
  fisiologia(
    label: 'Fisiologia',
    cor: 0xFF34C759,
    icone: PhosphorIconsRegular.dna,
    subtitle: 'Bioestimulantes e hormônios',
    filtroCatalogo: 'Bioestimulante',
  ),
  cesb(
    label: 'Campeões',
    cor: 0xFFFF9500,
    icone: PhosphorIconsRegular.trophy,
    subtitle: 'Dicas CESB por estádio',
    filtroCatalogo: null,
  );

  const CategoriaReferencia({
    required this.label,
    required this.cor,
    required this.icone,
    required this.subtitle,
    required this.filtroCatalogo,
  });

  final String label;
  final int cor;
  final IconData icone;
  final String subtitle;

  /// Categoria de produto correspondente no catálogo.
  /// Null para CESB (não filtra catálogo diretamente).
  final String? filtroCatalogo;

  /// Cor Flutter compilada a partir do valor hex.
  Color get color => Color(cor);
}
