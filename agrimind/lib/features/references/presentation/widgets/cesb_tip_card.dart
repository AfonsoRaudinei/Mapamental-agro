import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/referencia_tecnica_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Card especializado para dicas CESB.
class CesbTipCard extends StatelessWidget {
  const CesbTipCard({super.key, required this.cesb});

  final ReferenciaTecnicaEntity cesb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.catCESB.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.catCESB.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título com ícone troféu
            Row(
              children: [
                const PhosphorIcon(
                  PhosphorIconsRegular.trophy,
                  size: 18,
                  color: AppColors.catCESB,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    cesb.titulo,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.appTextPrimary,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 6,
                  children: [
                    _Tag(label: cesb.estadio),
                    if (cesb.safraReferencia != null)
                      _Tag(label: 'Safra ${cesb.safraReferencia}'),
                  ],
                ),
              ],
            ),

            if (_legendLine != null) ...[
              const SizedBox(height: 6),
              Text(
                _legendLine!,
                style: AppTypography.caption.copyWith(
                  color: context.appTextPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],

            if (cesb.focoManejo != null) ...[
              const SizedBox(height: 6),
              Text(
                'Foco: ${cesb.focoManejo}',
                style: AppTypography.caption.copyWith(
                  color: context.appTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

            if (_metadataLine.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                _metadataLine,
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

            if (_contextLine.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                _contextLine,
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],

            if (cesb.praticas != null) ...[
              const SizedBox(height: 6),
              Text(
                cesb.praticas!,
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],

            if (cesb.fonte != null) ...[
              const SizedBox(height: 6),
              Text(
                'Fonte: ${cesb.fonte}',
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],

            if (cesb.destaque != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.catCESB.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PhosphorIcon(
                      PhosphorIconsFill.trophy,
                      size: 14,
                      color: AppColors.catCESB,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cesb.destaque!,
                      style: AppTypography.label.copyWith(
                        color: AppColors.catCESB,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String get _metadataLine {
    return [
      if (cesb.dataReferencia != null)
        'Data ${_formatDate(cesb.dataReferencia!)}',
      if (cesb.resultado != null) cesb.resultado,
      if (cesb.local != null) cesb.local,
    ].join(' · ');
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String? get _legendLine {
    final descricao = cesb.descricao;
    if (descricao == null) return null;
    for (final line in descricao.split('\n')) {
      if (line.startsWith('Legenda da dica:')) {
        return line.replaceFirst('Legenda da dica:', 'Dica:').trim();
      }
    }
    return null;
  }

  String get _contextLine {
    final descricao = cesb.descricao;
    if (descricao == null) return '';
    return descricao
        .split('\n')
        .where(
          (line) =>
              line.startsWith('Produtor campeão:') ||
              line.startsWith('Fazenda:'),
        )
        .join(' · ');
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.catCESB.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: AppTypography.label.copyWith(
          color: AppColors.catCESB,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
