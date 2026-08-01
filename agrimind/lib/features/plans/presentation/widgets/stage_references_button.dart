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

/// Categorias do livro padrão (não monetizadas).
const _standardCategorias = <CategoriaReferencia>[
  CategoriaReferencia.doencas,
  CategoriaReferencia.insetos,
  CategoriaReferencia.nutricao,
  CategoriaReferencia.fisiologia,
];

/// Cluster: livro padrão + livro dourado (Circular técnica / CESB) lado a lado.
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StandardReferencesBook(
          estadio: estadio,
          plano: plano,
          compact: compact,
          onAddProdutoFromReferencia: onAddProdutoFromReferencia,
        ),
        SizedBox(width: compact ? 4 : 6),
        _CircularTecnicaBook(
          estadio: estadio,
          plano: plano,
          compact: compact,
          onAddProdutoFromReferencia: onAddProdutoFromReferencia,
        ),
      ],
    );
  }
}

// ── Livro padrão (outline) — Doenças / Insetos / Nutrição / Fisiologia ───────

class _StandardReferencesBook extends ConsumerWidget {
  const _StandardReferencesBook({
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
    required this.compact,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync =
        ref.watch(estadioReferenciasContentMapProvider(estadio.codigo));

    return contentAsync.when(
      data: (contentMap) {
        final available = _standardCategorias
            .where((cat) => contentMap[cat] == true)
            .toList();
        final hasContent = available.isNotEmpty;

        return ReferencesBookIcon(
          accent: context.appTextPrimary,
          enabled: hasContent,
          compact: compact,
          filled: false,
          onTap: hasContent ? () => _open(context, ref, available) : null,
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

  Future<void> _open(
    BuildContext context,
    WidgetRef ref,
    List<CategoriaReferencia> available,
  ) async {
    final selected = await _StandardCategoriaPicker.show(
      context: context,
      estadioCodigo: estadio.codigo,
      categorias: available,
    );
    if (selected == null || !context.mounted) return;

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
}

// ── Livro dourado — Circular técnica + CESB (trilha monetizável) ─────────────

class _CircularTecnicaBook extends ConsumerWidget {
  const _CircularTecnicaBook({
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
    required this.compact,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync =
        ref.watch(estadioReferenciasContentMapProvider(estadio.codigo));
    final hasCircular =
        CircularFungicidasData.hasContentForStage(estadio.codigo);

    return contentAsync.when(
      data: (contentMap) {
        final hasCesb = contentMap[CategoriaReferencia.cesb] == true;
        final hasContent = hasCircular || hasCesb;

        return ReferencesBookIcon(
          accent: ReferencesBookAccents.fungicidas,
          enabled: hasContent,
          compact: compact,
          filled: true,
          onTap: hasContent
              ? () => _open(context, ref,
                  hasCircular: hasCircular, hasCesb: hasCesb)
              : null,
        );
      },
      loading: () => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
        filled: true,
      ),
      error: (_, __) => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
        filled: true,
      ),
    );
  }

  Future<void> _open(
    BuildContext context,
    WidgetRef ref, {
    required bool hasCircular,
    required bool hasCesb,
  }) async {
    final target = await _CircularTecnicaPicker.show(
      context: context,
      estadioCodigo: estadio.codigo,
      includeCircular: hasCircular,
      includeCesb: hasCesb,
    );
    if (target == null || !context.mounted) return;

    if (target == _CircularTecnicaTarget.circular) {
      await _openCircularSheet(context);
      return;
    }

    final itens = await ref.read(
      referenciasDisplayByCategoriaProvider(
        categoria: CategoriaReferencia.cesb,
        estadioCodigo: estadio.codigo,
      ).future,
    );
    if (!context.mounted) return;

    await CategoriaBottomSheet.show(
      context: context,
      categoria: CategoriaReferencia.cesb,
      estadioCodigo: estadio.codigo,
      titleOverride: 'Campeões CESB',
      subtitleOverride: 'Manejo dos produtores recordistas',
      accentOverride: ReferencesBookAccents.cesb,
      itens: itens,
      onUsarNoPlano: (item) async {
        if (context.mounted) Navigator.of(context).pop();
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: 'Geral',
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
      titleOverride: 'Circular técnica',
      subtitleOverride: 'Estádio → doença → fungicida',
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

// ── Pickers ───────────────────────────────────────────────────────────────────

class _StandardCategoriaPicker extends StatelessWidget {
  const _StandardCategoriaPicker({
    required this.estadioCodigo,
    required this.categorias,
  });

  final String estadioCodigo;
  final List<CategoriaReferencia> categorias;

  static Future<CategoriaReferencia?> show({
    required BuildContext context,
    required String estadioCodigo,
    required List<CategoriaReferencia> categorias,
  }) {
    if (categorias.isEmpty) return Future.value();
    if (categorias.length == 1) return Future.value(categorias.first);

    return showAppBottomSheet<CategoriaReferencia>(
      context: context,
      builder: (_) => _StandardCategoriaPicker(
        estadioCodigo: estadioCodigo,
        categorias: categorias,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: categorias.length,
          separatorBuilder: (_, __) => Divider(
            height: AppSpacing.lg,
            color: context.appBorderSoft,
          ),
          itemBuilder: (_, index) {
            final categoria = categorias[index];
            return _CategoriaSourceTile(
              categoria: categoria,
              onTap: () => Navigator.of(context).pop(categoria),
            );
          },
        ),
      ),
    );
  }
}

enum _CircularTecnicaTarget { circular, cesb }

class _CircularTecnicaPicker extends StatelessWidget {
  const _CircularTecnicaPicker({
    required this.estadioCodigo,
    required this.includeCircular,
    required this.includeCesb,
  });

  final String estadioCodigo;
  final bool includeCircular;
  final bool includeCesb;

  static Future<_CircularTecnicaTarget?> show({
    required BuildContext context,
    required String estadioCodigo,
    required bool includeCircular,
    required bool includeCesb,
  }) {
    if (!includeCircular && !includeCesb) return Future.value();
    if (includeCircular && !includeCesb) {
      return Future.value(_CircularTecnicaTarget.circular);
    }
    if (!includeCircular && includeCesb) {
      return Future.value(_CircularTecnicaTarget.cesb);
    }

    return showAppBottomSheet<_CircularTecnicaTarget>(
      context: context,
      builder: (_) => _CircularTecnicaPicker(
        estadioCodigo: estadioCodigo,
        includeCircular: includeCircular,
        includeCesb: includeCesb,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      if (includeCircular)
        _CircularPickerTile(
          onTap: () =>
              Navigator.of(context).pop(_CircularTecnicaTarget.circular),
        ),
      if (includeCesb)
        _CesbPickerTile(
          onTap: () => Navigator.of(context).pop(_CircularTecnicaTarget.cesb),
        ),
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.36,
      minChildSize: 0.26,
      maxChildSize: 0.55,
      builder: (ctx, scrollCtrl) => AppBottomSheetScaffold(
        header: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Circular técnica',
                style: AppTypography.h3.copyWith(
                  color: ReferencesBookAccents.fungicidas,
                ),
              ),
              Text(
                'Estádio $estadioCodigo · conteúdo premium',
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
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(
            height: AppSpacing.lg,
            color: context.appBorderSoft,
          ),
          itemBuilder: (_, index) => items[index],
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

class _CesbPickerTile extends StatelessWidget {
  const _CesbPickerTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const gold = ReferencesBookAccents.fungicidas;
    const cesb = ReferencesBookAccents.cesb;
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
                    'Campeões CESB',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cesb,
                    ),
                  ),
                  Text(
                    'Manejo dos produtores recordistas',
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
