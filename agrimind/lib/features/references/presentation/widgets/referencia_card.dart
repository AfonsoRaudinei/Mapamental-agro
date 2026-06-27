import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../domain/entities/referencia_tecnica_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Card de referência técnica (doenças, insetos, etc.).
class ReferenciaCard extends StatelessWidget {
  const ReferenciaCard({
    super.key,
    required this.referencia,
    required this.categoria,
    this.onUsarNoPlano,
  });

  final ReferenciaTecnicaEntity referencia;
  final CategoriaReferencia categoria;
  final VoidCallback? onUsarNoPlano;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: categoria.color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(right: 8, top: 1),
                decoration: BoxDecoration(
                  color: categoria.color,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  referencia.titulo,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.appTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          if (referencia.descricao != null) ...[
            const SizedBox(height: 4),
            Text(
              referencia.descricao!,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ],
          if (referencia.focoManejo != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                PhosphorIcon(
                  PhosphorIconsRegular.arrowRight,
                  size: 12,
                  color: categoria.color,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Manejo: ${referencia.focoManejo}',
                    style: AppTypography.caption.copyWith(
                      color: categoria.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (onUsarNoPlano != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onUsarNoPlano,
                icon: PhosphorIcon(
                  PhosphorIconsRegular.plus,
                  size: 13,
                  color: categoria.color,
                ),
                label: Text(
                  'Usar no Plano',
                  style: AppTypography.label.copyWith(
                    color: categoria.color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: categoria.color.withValues(alpha: 0.08),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
