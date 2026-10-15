import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/produto_catalogo_entity.dart';
import 'categoria_badge.dart';
import '../../../../core/utils/extensions.dart';

/// Tile de produto no catálogo com ações de swipe.
class ProdutoListTile extends StatelessWidget {
  const ProdutoListTile({
    super.key,
    required this.produto,
    required this.onTap,
    this.onEdit,
    this.onToggleAtivo,
  });

  final ProdutoCatalogoEntity produto;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onToggleAtivo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicador de categoria
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: CategoriaBadge.corDaCategoria(produto.categoria),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Dados do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          produto.nomeComercial,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: produto.ativo
                                ? context.appTextPrimary
                                : context.appTextDisabled,
                          ),
                        ),
                      ),
                      CategoriaBadge(categoria: produto.categoria),
                    ],
                  ),
                  if (produto.ingredienteAtivo != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      produto.ingredienteAtivo!,
                      style: AppTypography.caption.copyWith(
                        color: context.appTextSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 4),
                  if (produto.doseMin != null && produto.doseMax != null)
                    Text(
                      '${produto.doseMin}–${produto.doseMax} '
                      '${produto.unidadePadrao}',
                      style: AppTypography.label.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  if (produto.culturas.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      produto.culturas.length <= 3
                          ? produto.culturas.join(' · ')
                          : '${produto.culturas.take(3).join(' · ')} +${produto.culturas.length - 3}',
                      style: AppTypography.caption.copyWith(
                        color: context.appTextDisabled,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Ações
            Column(
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: PhosphorIcon(
                      PhosphorIconsRegular.pencilSimple,
                      size: 18,
                      color: context.appTextSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onToggleAtivo,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: PhosphorIcon(
                      produto.ativo
                          ? PhosphorIconsRegular.eyeSlash
                          : PhosphorIconsRegular.eye,
                      size: 18,
                      color: produto.ativo
                          ? context.appTextSecondary
                          : AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
