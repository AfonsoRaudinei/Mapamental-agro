import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/utils/extensions.dart';

// ── Modelo de dados de referência (independente da feature de referências) ──

/// Dados de referência para exibição no bottom sheet.
/// Classe independente — sem importação cruzada de features.
class ReferenciaDisplayItem {
  const ReferenciaDisplayItem({
    required this.titulo,
    this.descricao,
    this.focoManejo,
    this.praticas,
    this.padrao,
    this.destaque,
  });

  final String titulo;
  final String? descricao;
  final String? focoManejo; // CESB
  final String? praticas; // CESB
  final String? padrao; // CESB: "Nutrologia" | "Hormonal" | "Biológico"
  final String? destaque; // CESB: "Agro Mallon — 135,49 sc/ha"
}

// ── Bottom Sheet ────────────────────────────────────────────────────────────

/// Bottom sheet das referências técnicas de uma categoria num dado estádio.
///
/// Exibe a lista de itens (doenças, insetos, nutrição, fisiologia ou CESB)
/// e botão [+ Usar no Plano] para cada item.
class CategoriaBottomSheet extends StatelessWidget {
  const CategoriaBottomSheet({
    super.key,
    required this.categoria,
    required this.estadioCodigo,
    required this.itens,
    required this.onUsarNoPlano,
  });

  final CategoriaReferencia categoria;
  final String estadioCodigo;
  final List<ReferenciaDisplayItem> itens;

  /// Chamado quando o técnico toca em [+ Usar no Plano].
  final void Function(ReferenciaDisplayItem) onUsarNoPlano;

  /// Abre o bottom sheet de forma estática.
  static Future<void> show({
    required BuildContext context,
    required CategoriaReferencia categoria,
    required String estadioCodigo,
    required List<ReferenciaDisplayItem> itens,
    required void Function(ReferenciaDisplayItem) onUsarNoPlano,
  }) {
    return showAppBottomSheet(
      context: context,
      builder: (_) => CategoriaBottomSheet(
        categoria: categoria,
        estadioCodigo: estadioCodigo,
        itens: itens,
        onUsarNoPlano: onUsarNoPlano,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (ctx, scrollCtrl) => AppBottomSheetScaffold(
        header:
            _SheetHeader(categoria: categoria, estadioCodigo: estadioCodigo),
        body: itens.isEmpty
            ? _EmptyState(categoria: categoria)
            : ListView.separated(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: itens.length,
                separatorBuilder: (_, __) => Divider(
                  height: AppSpacing.lg,
                  color: context.appBorderSoft,
                ),
                itemBuilder: (_, i) => categoria == CategoriaReferencia.cesb
                    ? _CesbTile(
                        item: itens[i],
                        cor: categoria.color,
                        onUsar: () => onUsarNoPlano(itens[i]),
                      )
                    : _ReferenciaTile(
                        item: itens[i],
                        cor: categoria.color,
                        onUsar: () => onUsarNoPlano(itens[i]),
                      ),
              ),
      ),
    );
  }
}

// ── Widgets internos ────────────────────────────────────────────────────────

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({
    required this.categoria,
    required this.estadioCodigo,
  });

  final CategoriaReferencia categoria;
  final String estadioCodigo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: categoria.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: PhosphorIcon(
                categoria.icone,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoria.label, style: AppTypography.h3),
                Text(
                  'Estádio $estadioCodigo · ${categoria.subtitle}',
                  style: AppTypography.caption.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenciaTile extends StatelessWidget {
  const _ReferenciaTile({
    required this.item,
    required this.cor,
    required this.onUsar,
  });

  final ReferenciaDisplayItem item;
  final Color cor;
  final VoidCallback onUsar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.titulo,
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
        ),
        if (item.descricao != null) ...[
          const SizedBox(height: 4),
          Text(
            item.descricao!,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
        ],
        if (item.focoManejo != null) ...[
          const SizedBox(height: 4),
          Text(
            'Foco: ${item.focoManejo}',
            style: AppTypography.caption.copyWith(
              color: cor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: Alignment.centerRight,
          child: _UsarNoPlanoBtn(cor: cor, onTap: onUsar),
        ),
      ],
    );
  }
}

class _CesbTile extends StatelessWidget {
  const _CesbTile({
    required this.item,
    required this.cor,
    required this.onUsar,
  });

  final ReferenciaDisplayItem item;
  final Color cor;
  final VoidCallback onUsar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.catCESB.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.catCESB.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PhosphorIcon(
                PhosphorIconsRegular.trophy,
                color: AppColors.catCESB,
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item.titulo,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.catCESB,
                  ),
                ),
              ),
            ],
          ),
          if (item.focoManejo != null) ...[
            const SizedBox(height: 4),
            Text(
              'Foco: ${item.focoManejo}',
              style: AppTypography.caption.copyWith(
                color: context.appTextPrimary,
              ),
            ),
          ],
          if (item.praticas != null) ...[
            const SizedBox(height: 4),
            Text(
              item.praticas!,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ],
          if (item.destaque != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.catCESB.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '🏆 ${item.destaque}',
                style: AppTypography.label.copyWith(
                  color: AppColors.catCESB,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: _UsarNoPlanoBtn(cor: cor, onTap: onUsar),
          ),
        ],
      ),
    );
  }
}

class _UsarNoPlanoBtn extends StatelessWidget {
  const _UsarNoPlanoBtn({required this.cor, required this.onTap});

  final Color cor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: PhosphorIcon(PhosphorIconsRegular.plus, size: 14, color: cor),
      label: Text(
        'Usar no Plano',
        style: AppTypography.label.copyWith(
          color: cor,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: cor.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 6,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.categoria});

  final CategoriaReferencia categoria;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: 0.3,
              child: PhosphorIcon(
                categoria.icone,
                size: 48,
                color: categoria.color,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Sem referências neste estádio',
              style: AppTypography.body.copyWith(
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Base técnica disponível no Sprint 5',
              style: AppTypography.caption.copyWith(
                color: context.appTextDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
