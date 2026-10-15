import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/cliente_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Tile de cliente na lista principal.
class ClientListTile extends StatelessWidget {
  const ClientListTile({
    super.key,
    required this.cliente,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final ClienteEntity cliente;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  /// Gera cor de avatar a partir do nome (determinístico).
  Color _avatarColor() {
    final colors = [
      AppColors.primary,
      AppColors.catDoencas,
      AppColors.catNutricao,
      AppColors.catFisiologia,
      AppColors.catCESB,
    ];
    return colors[cliente.nome.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final inicial =
        cliente.nome.isNotEmpty ? cliente.nome[0].toUpperCase() : '?';
    final cor = _avatarColor();

    return Dismissible(
      key: ValueKey(cliente.id),
      background: const _SwipeAction(
        alignment: Alignment.centerLeft,
        icon: PhosphorIconsRegular.pencilSimple,
        color: AppColors.primary,
        label: 'Editar',
      ),
      secondaryBackground: const _SwipeAction(
        alignment: Alignment.centerRight,
        icon: PhosphorIconsRegular.trash,
        color: AppColors.error,
        label: 'Excluir',
      ),
      confirmDismiss: (dir) async {
        if (dir == DismissDirection.startToEnd) {
          onEdit?.call();
          return false;
        } else {
          onDelete?.call();
          return false;
        }
      },
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.appBorder),
          ),
          child: Row(
            children: [
              // Avatar com inicial
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: cor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    inicial,
                    style: AppTypography.h3.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Dados do cliente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.nome,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _subtitle(),
                      style: AppTypography.caption.copyWith(
                        color: context.appTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              PhosphorIcon(
                PhosphorIconsRegular.caretRight,
                size: 16,
                color: context.appTextDisabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle() {
    final parts = <String>[];
    if (cliente.cidade != null) parts.add(cliente.cidade!);
    if (cliente.uf != null) parts.add(cliente.uf!);
    final loc = parts.join(', ');
    return loc.isNotEmpty ? loc : 'Sem localização';
  }
}

class _SwipeAction extends StatelessWidget {
  const _SwipeAction({
    required this.alignment,
    required this.icon,
    required this.color,
    required this.label,
  });

  final AlignmentGeometry alignment;
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.label.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
