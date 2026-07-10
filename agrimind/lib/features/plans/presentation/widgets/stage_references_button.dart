import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/constants/references_book_accents.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/references_book_icon.dart';
import '../../../../core/utils/extensions.dart';
import '../../../references/data/circular_fungicidas_data.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../providers/estadio_referencias_content_provider.dart';
import 'categoria_bottom_sheet.dart';
import 'referencia_display_mapper.dart';

/// Botão único de referências por estádio — livro dourado (fungicidas) + picker.
class StageReferencesButton extends ConsumerWidget {
  const StageReferencesButton({
    super.key,
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
    this.compact = false,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;

  /// Versão compacta para o header colapsado do estádio (ao lado do badge V5).
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync =
        ref.watch(estadioReferenciasContentMapProvider(estadio.codigo));
    final hasCircular =
        CircularFungicidasData.hasContentForStage(estadio.codigo);

    return contentAsync.when(
      data: (contentMap) {
        final available = CategoriaReferencia.values
            .where((cat) => contentMap[cat] == true)
            .toList();
        final hasContent = hasCircular || available.isNotEmpty;
        final accent = ReferencesBookAccents.canvasAccent(
          hasCircularFungicidas: hasCircular,
          available: available,
        );

        return ReferencesBookIcon(
          accent: accent,
          enabled: hasContent,
          compact: compact,
          onTap: hasContent
              ? () => _openReferences(context, ref, available, hasCircular)
              : null,
        );
      },
      loading: () => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
      ),
      error: (_, __) => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
      ),
    );
  }

  Future<void> _openReferences(
    BuildContext context,
    WidgetRef ref,
    List<CategoriaReferencia> available,
    bool hasCircular,
  ) async {
    final target = await ReferencesSourcePicker.show(
      context: context,
      estadioCodigo: estadio.codigo,
      categorias: available,
      includeCircularFungicidas: hasCircular,
    );
    if (target == null || !context.mounted) return;

    if (target.isCircular) {
      await _openCircularSheet(context);
      return;
    }

    final selected = target.categoria!;
    final itens = await ref.read(
      referenciasDisplayByCategoriaProvider(
        categoria: selected,
        estadioCodigo: estadio.codigo,
      ).future,
    );
    if (!context.mounted) return;

    await CategoriaBottomSheet.show(
      context: context,
      categoria: selected,
      estadioCodigo: estadio.codigo,
      itens: itens,
      onUsarNoPlano: (item) async {
        if (context.mounted) Navigator.of(context).pop();
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: selected.filtroCatalogo ?? 'Geral',
          areaHa: plano.areaHaTotal,
        );
      },
    );
  }

  Future<void> _openCircularSheet(BuildContext context) async {
    final entry = CircularFungicidasData.entryForStage(estadio.codigo);
    if (entry == null || !context.mounted) return;

    final itens = ReferenciaDisplayMapper.fromCircularEntry(entry);
    await CategoriaBottomSheet.show(
      context: context,
      categoria: CategoriaReferencia.doencas,
      estadioCodigo: estadio.codigo,
      titleOverride: 'Circular fungicidas',
      accentOverride: ReferencesBookAccents.fungicidas,
      itens: itens,
      onUsarNoPlano: (item) async {
        if (context.mounted) Navigator.of(context).pop();
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: 'Fungicida',
          areaHa: plano.areaHaTotal,
        );
      },
    );
  }
}

/// Resultado do picker de fontes de referência no canvas.
class ReferencesSourceTarget {
  const ReferencesSourceTarget.circular()
      : isCircular = true,
        categoria = null;

  const ReferencesSourceTarget.categoria(this.categoria) : isCircular = false;

  final bool isCircular;
  final CategoriaReferencia? categoria;
}

/// Picker: Circular fungicidas (ouro) + categorias Drift.
class ReferencesSourcePicker extends StatelessWidget {
  const ReferencesSourcePicker({
    super.key,
    required this.estadioCodigo,
    required this.categorias,
    required this.includeCircularFungicidas,
  });

  final String estadioCodigo;
  final List<CategoriaReferencia> categorias;
  final bool includeCircularFungicidas;

  static Future<ReferencesSourceTarget?> show({
    required BuildContext context,
    required String estadioCodigo,
    required List<CategoriaReferencia> categorias,
    required bool includeCircularFungicidas,
  }) {
    final onlyCircular =
        includeCircularFungicidas && categorias.isEmpty;
    if (onlyCircular) {
      return Future.value(const ReferencesSourceTarget.circular());
    }
    if (!includeCircularFungicidas && categorias.length == 1) {
      return Future.value(ReferencesSourceTarget.categoria(categorias.first));
    }
    if (!includeCircularFungicidas && categorias.isEmpty) {
      return Future.value();
    }

    return showAppBottomSheet<ReferencesSourceTarget>(
      context: context,
      builder: (_) => ReferencesSourcePicker(
        estadioCodigo: estadioCodigo,
        categorias: categorias,
        includeCircularFungicidas: includeCircularFungicidas,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemCount =
        categorias.length + (includeCircularFungicidas ? 1 : 0);

    return DraggableScrollableSheet(
      initialChildSize: 0.42,
      minChildSize: 0.28,
      maxChildSize: 0.65,
      builder: (ctx, scrollCtrl) => AppBottomSheetScaffold(
        header: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Referências', style: AppTypography.h3),
              Text(
                'Estádio $estadioCodigo',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],
          ),
        ),
        body: ListView.separated(
          controller: scrollCtrl,
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: itemCount,
          separatorBuilder: (_, __) => Divider(
            height: AppSpacing.lg,
            color: context.appBorderSoft,
          ),
          itemBuilder: (_, index) {
            if (includeCircularFungicidas && index == 0) {
              return _CircularPickerTile(
                onTap: () => Navigator.of(context).pop(
                  const ReferencesSourceTarget.circular(),
                ),
              );
            }
            final catIndex =
                includeCircularFungicidas ? index - 1 : index;
            final categoria = categorias[catIndex];
            return _CategoriaSourceTile(
              categoria: categoria,
              onTap: () => Navigator.of(context).pop(
                ReferencesSourceTarget.categoria(categoria),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CircularPickerTile extends StatelessWidget {
  const _CircularPickerTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const gold = ReferencesBookAccents.fungicidas;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.refBookFungicidasSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.refBookFungicidasDark.withValues(alpha: 0.5),
                ),
              ),
              child: const Center(
                child: PhosphorIcon(
                  PhosphorIconsFill.bookOpen,
                  color: gold,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Circular fungicidas',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: gold,
                    ),
                  ),
                  Text(
                    'Estádio → doença → fungicida',
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
    );
  }
}

class _CategoriaSourceTile extends StatelessWidget {
  const _CategoriaSourceTile({
    required this.categoria,
    required this.onTap,
  });

  final CategoriaReferencia categoria;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
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
                  Text(
                    categoria.label,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    categoria.subtitle,
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
    );
  }
}
