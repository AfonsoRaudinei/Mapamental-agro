import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../providers/estadio_referencias_content_provider.dart';
import 'categoria_bottom_sheet.dart';
import 'categoria_picker_sheet.dart';

/// Botão único de referências por estádio — badge + picker + bottom sheet.
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

    return contentAsync.when(
      data: (contentMap) {
        final available = CategoriaReferencia.values
            .where((cat) => contentMap[cat] == true)
            .toList();
        final count = available.length;
        final hasContent = count > 0;

        return _ReferencesIconButton(
          count: count,
          enabled: hasContent,
          compact: compact,
          onTap: hasContent
              ? () => _openReferences(context, ref, available)
              : null,
        );
      },
      loading: () => _ReferencesIconButton(count: 0, enabled: false, compact: compact),
      error: (_, __) => _ReferencesIconButton(count: 0, enabled: false, compact: compact),
    );
  }

  Future<void> _openReferences(
    BuildContext context,
    WidgetRef ref,
    List<CategoriaReferencia> available,
  ) async {
    final selected = await CategoriaPickerSheet.show(
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

class _ReferencesIconButton extends StatelessWidget {
  const _ReferencesIconButton({
    required this.count,
    required this.enabled,
    this.compact = false,
    this.onTap,
  });

  final int count;
  final bool enabled;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 32.0 : AppConstants.minTouchTarget;
    final iconSize = compact ? 16.0 : 20.0;
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: SizedBox(
        width: size,
        height: size,
        child: Material(
          color: context.appSurface,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.appBorder),
              ),
              child: Center(
                child: PhosphorIcon(
                  PhosphorIconsRegular.bookOpen,
                  size: iconSize,
                  color: enabled
                      ? context.appTextPrimary
                      : context.appTextDisabled,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
