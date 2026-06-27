import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Hierarquia tipográfica do AgriMind baseada em SF Pro (iOS).
/// Em iOS, o sistema usa SF Pro automaticamente como fallback.
class AppTypography {
  AppTypography._();

  // ── TÍTULOS ──────────────────────────────────────────────────────────────
  /// H1 — Título de página — 28px Bold
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// H2 — Título de seção — 22px SemiBold
  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  /// H3 — Título de card — 18px SemiBold
  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ── CORPO ─────────────────────────────────────────────────────────────────
  /// Body — Texto padrão — 16px Regular
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Body Bold — Ação/link — 16px SemiBold
  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // ── METADADOS ─────────────────────────────────────────────────────────────
  /// Caption — Metadados — 13px Regular
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // ── LABELS ────────────────────────────────────────────────────────────────
  /// Label — Badge/chip — 11px Medium
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.2,
  );

  // ── BOTÃO ─────────────────────────────────────────────────────────────────
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.2,
  );
}
