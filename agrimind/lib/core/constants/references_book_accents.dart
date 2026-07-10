import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'categoria_referencia.dart';

/// Acentos do ícone de livro no canvas.
///
/// Dois livros no estádio:
/// - padrão (outline) → Doenças / Insetos / Nutrição / Fisiologia
/// - dourado (fill) → Circular técnica + CESB (trilha monetizável)
abstract final class ReferencesBookAccents {
  static const Color fungicidas = AppColors.refBookFungicidas;
  static const Color circularTecnica = AppColors.refBookFungicidas;
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
}
