import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import 'produto_aplicacao_row.dart';
import 'stage_references_button.dart';
import '../../../../core/utils/extensions.dart';

/// EstadioBlock — Bloco central do canvas fenológico.
///
/// Anatomia (3 zonas):
/// ┌──────────────────────────────────────────────────────┐
/// │ ESTÁDIO R1 — Início do Florescimento                │
/// ├───────────┬─────────────────────────────┬────────────┤
/// │  ZONA A   │         ZONA B              │  ZONA C   │
/// │           │                             │           │
/// │  [R1]     │  Fox Xpro                   │  🔴 38×38 │
/// │  72×72    │  0,4L/ha × [80] ha = 32,0L  │  🔵 38×38 │
/// │           │  Engeo Pleno ...            │  🟣 38×38 │
/// │  [+] btn  │  [+ Produto do catálogo...] │  📖 refs  │
/// └───────────┴─────────────────────────────┴────────────┘
class EstadioBlock extends StatelessWidget {
  const EstadioBlock({
    super.key,
    required this.plano,
    required this.estadio,
    required this.onAddProduto,
    required this.onAddProdutoFromReferencia,
    required this.onEditProduto,
    required this.onDeleteProduto,
    required this.onAreaChanged,
    this.onRemoveEstadio,
  });

  final PlanoEntity plano;
  final EstadioEntity estadio;

  /// Callbacks de mutação
  final VoidCallback onAddProduto;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;
  final void Function(ProdutoAplicacaoEntity) onEditProduto;
  final void Function(String produtoId) onDeleteProduto;
  final void Function(ProdutoAplicacaoEntity, double) onAreaChanged;

  /// Remove estádio inteiro (null = não exibido)
  final VoidCallback? onRemoveEstadio;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cabeçalho do estádio ─────────────────────────────────────
          _EstadioHeader(
            estadio: estadio,
            onRemove: onRemoveEstadio,
          ),

          Divider(height: 1, color: context.appBorderSoft),

          // ── Corpo: 3 zonas ────────────────────────────────────────────
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Zona A: Círculo + botão Adicionar ────────────────
                _ZonaA(
                  codigo: estadio.codigo,
                  onAdd: onAddProduto,
                ),

                VerticalDivider(
                  width: 1,
                  color: context.appBorderSoft,
                ),

                // ── Zona B: Lista de produtos ─────────────────────────
                Expanded(
                  child: _ZonaB(
                    estadio: estadio,
                    onAddProduto: onAddProduto,
                    onEditProduto: onEditProduto,
                    onDeleteProduto: onDeleteProduto,
                    onAreaChanged: onAreaChanged,
                  ),
                ),

                VerticalDivider(
                  width: 1,
                  color: context.appBorderSoft,
                ),

                // ── Zona C: referências técnicas ──────────────────────
                _ZonaC(
                  estadio: estadio,
                  plano: plano,
                  onAddProdutoFromReferencia: onAddProdutoFromReferencia,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Cabeçalho ───────────────────────────────────────────────────────────────

class _EstadioHeader extends StatelessWidget {
  const _EstadioHeader({required this.estadio, this.onRemove});

  final EstadioEntity estadio;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text(
            estadio.codigo,
            style: AppTypography.label.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              estadio.label != estadio.codigo
                  ? '— ${estadio.label}'
                  : _labelPadrao(estadio.codigo),
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (estadio.dataAplicacao != null)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: Text(
                _formatDate(estadio.dataAplicacao!),
                style: AppTypography.label.copyWith(
                  color: context.appTextDisabled,
                ),
              ),
            ),
          if (onRemove != null)
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: PhosphorIcon(
                  PhosphorIconsRegular.x,
                  size: 16,
                  color: context.appTextDisabled,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _labelPadrao(String codigo) => switch (codigo) {
        'Operacional' => '— Operacional',
        'VE' => '— Emergência',
        'VC' => '— Cotilédone',
        'R1' => '— Início do Florescimento',
        'R2' => '— Pleno Florescimento',
        'R3' => '— Início do Enchimento',
        'R4' => '— Pleno Enchimento',
        'R5.1' => '— Início do Enchimento de Grãos',
        'R5.3' => '— 30% Enchimento de Grãos',
        'R5.5' => '— 50% Enchimento de Grãos',
        'R6' => '— Plena Maturidade Fisiológica',
        'R7' => '— Início da Maturação',
        'R8' => '— Maturação Plena',
        _ => '',
      };

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
}

// ── Zona A: círculo 72×72 + botão [+] ──────────────────────────────────────

class _ZonaA extends StatelessWidget {
  const _ZonaA({required this.codigo, required this.onAdd});

  final String codigo;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Círculo com código do estádio
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appSurface,
                border: Border.all(
                  color: context.appBorderSoft,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  codigo,
                  style: AppTypography.h3.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.appTextPrimary,
                    fontSize: codigo.length > 3 ? 13 : 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Botão [+] adicionar produto
            GestureDetector(
              onTap: onAdd,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: PhosphorIcon(
                    PhosphorIconsRegular.plus,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Zona B: lista de produtos ────────────────────────────────────────────────

class _ZonaB extends StatelessWidget {
  const _ZonaB({
    required this.estadio,
    required this.onAddProduto,
    required this.onEditProduto,
    required this.onDeleteProduto,
    required this.onAreaChanged,
  });

  final EstadioEntity estadio;
  final VoidCallback onAddProduto;
  final void Function(ProdutoAplicacaoEntity) onEditProduto;
  final void Function(String) onDeleteProduto;
  final void Function(ProdutoAplicacaoEntity, double) onAreaChanged;

  Color _colorForCategoria(String categoria) => switch (categoria) {
        'Fungicida' => AppColors.catDoencas,
        'Inseticida' => AppColors.catInsetos,
        'Fertilizante' => AppColors.catNutricao,
        'Bioestimulante' => AppColors.catFisiologia,
        _ => AppColors.catCESB,
      };

  @override
  Widget build(BuildContext context) {
    final produtos = estadio.produtos;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lista de produtos
          if (produtos.isNotEmpty)
            ...produtos.map(
              (p) => ProdutoAplicacaoRow(
                key: ValueKey(p.id),
                produto: p,
                categoriaColor: _colorForCategoria(p.produtoCategoria),
                onEdit: () => onEditProduto(p),
                onDelete: () => onDeleteProduto(p.id),
                onAreaChanged: (area) => onAreaChanged(p, area),
              ),
            ),

          // Botão [+ Produto do catálogo...]
          GestureDetector(
            onTap: onAddProduto,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                children: [
                  const PhosphorIcon(
                    PhosphorIconsRegular.plusCircle,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+ Produto do catálogo...',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Zona C: ícones de categoria ──────────────────────────────────────────────

class _ZonaC extends StatelessWidget {
  const _ZonaC({
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: StageReferencesButton(
        estadio: estadio,
        plano: plano,
        onAddProdutoFromReferencia: onAddProdutoFromReferencia,
      ),
    );
  }
}
