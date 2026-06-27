import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/entities/plano_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Card de plano na lista principal.
/// Exibe: nome, cliente, cultura, safra, área e status.
class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plano,
    this.onDelete,
  });

  final PlanoEntity plano;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.planCanvasPath(plano.id)),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.appBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header com gradiente azul ──────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plano.nome,
                          style: AppTypography.h3.copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (plano.clienteNome != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            plano.clienteNome!,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _StatusBadge(status: plano.status),
                  if (onDelete != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    GestureDetector(
                      onTap: onDelete,
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: PhosphorIcon(
                          PhosphorIconsRegular.trash,
                          size: 18,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ── Metadados ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  _MetaItem(label: 'Cultura', value: plano.cultura),
                  const SizedBox(width: AppSpacing.lg),
                  _MetaItem(label: 'Safra', value: plano.safra),
                  const SizedBox(width: AppSpacing.lg),
                  _MetaItem(
                    label: 'Área',
                    value: '${plano.areaHaTotal.toStringAsFixed(1)} ha',
                  ),
                  const Spacer(),
                  if (plano.estadios.isNotEmpty)
                    Row(
                      children: [
                        const PhosphorIcon(
                          PhosphorIconsRegular.mapTrifold,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${plano.estadios.length}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widgets internos ────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      'ativo' => ('Ativo', AppColors.success, Colors.white),
      'consolidado' => ('Consolidado', AppColors.catCESB, Colors.white),
      _ => ('Rascunho', Colors.white24, Colors.white),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(label, style: AppTypography.label.copyWith(color: fg)),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label.copyWith(color: context.appTextSecondary),
        ),
        Text(
          value,
          style: AppTypography.caption.copyWith(
            color: context.appTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
