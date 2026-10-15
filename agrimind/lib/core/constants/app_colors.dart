import 'package:flutter/material.dart';

/// Paleta de cores do Design System SoloForte — iOS + Samsung Blue.
class AppColors {
  AppColors._();

  // ── IDENTIDADE ──────────────────────────────────────────────────────────────
  /// iOS Blue — CTA, links, estado ativo, tabs
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryDark = Color(0xFF0051D5); // pressed
  static const Color primaryLight = Color(0xFFEAF2FF); // hover / bg leve

  // ── CATEGORIAS FENOLÓGICAS ───────────────────────────────────────────────────
  static const Color catDoencas = Color(0xFFFF3B30); // Doenças — vermelho
  static const Color catInsetos = Color(0xFF007AFF); // Insetos — azul
  static const Color catNutricao = Color(0xFFAF52DE); // Nutrição — roxo
  static const Color catFisiologia = Color(0xFF34C759); // Fisiologia — verde
  static const Color catCESB = Color(0xFFFF9500); // Campeões CESB — âmbar

  // ── REFERÊNCIAS — livro do canvas (ondas por categoria) ───────────────────
  /// Circular fungicidas / doenças — livro dourado (onda atual).
  static const Color refBookFungicidas = Color(0xFFD4AF37);
  static const Color refBookFungicidasMuted = Color(0xFFCA8A04);
  static const Color refBookFungicidasDark = Color(0xFF92670A);
  static const Color refBookFungicidasSurface = Color(0xFF2A2210);

  /// Próximas ondas (terreno preparado — ainda não usadas no canvas).
  static const Color refBookInsetos = catInsetos;
  static const Color refBookNutricao = catNutricao;
  static const Color refBookFisiologia = catFisiologia;
  static const Color refBookCesb = catCESB;

  // ── NEUTROS — Base iOS Light ──────────────────────────────────────────────
  static const Color background = Color(0xFFF5F5F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderSoft = Color(0xFFE5E5E7);
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);

  // ── FEEDBACK SEMÂNTICO ────────────────────────────────────────────────────
  /// Verde = APENAS feedback de sucesso — nunca como identidade/botão
  static const Color success = Color(0xFF34C759);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFFF3B30);
  static const Color errorLight = Color(0xFFFFE5E5);
  static const Color warning = Color(0xFFFFCC00);

  // ── DARK MODE ────────────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0A0A0F);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color borderDark = Color(0xFF2C2C2E);
  static const Color textPrimaryDark = Color(0xFFF5F5F7);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
}
