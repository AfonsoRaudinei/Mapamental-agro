import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'categoria_referencia.dart';

/// Acentos do ícone de livro no canvas por categoria.
///
/// Onda atual: fungicidas (doenças / Circular) → dourado.
/// Próximas ondas: insetos, nutrição, fisiologia, CESB.
abstract final class ReferencesBookAccents {
  static const Color fungicidas = AppColors.refBookFungicidas;
  static const Color insetos = AppColors.refBookInsetos;
  static const Color nutricao = AppColors.refBookNutricao;
  static const Color fisiologia = AppColors.refBookFisiologia;
  static const Color cesb = AppColors.refBookCesb;

  static Color forCategoria(CategoriaReferencia categoria) {
    return switch (categoria) {
      CategoriaReferencia.doencas => fungicidas,
      CategoriaReferencia.insetos => insetos,
      CategoriaReferencia.nutricao => nutricao,
      CategoriaReferencia.fisiologia => fisiologia,
      CategoriaReferencia.cesb => cesb,
    };
  }

  /// Cor do livro no header do estádio (onda fungicidas tem prioridade).
  static Color canvasAccent({
    required bool hasCircularFungicidas,
    required List<CategoriaReferencia> available,
  }) {
    if (hasCircularFungicidas ||
        available.contains(CategoriaReferencia.doencas)) {
      return fungicidas;
    }
    if (available.isEmpty) return AppColors.textDisabled;
    return forCategoria(available.first);
  }
}
