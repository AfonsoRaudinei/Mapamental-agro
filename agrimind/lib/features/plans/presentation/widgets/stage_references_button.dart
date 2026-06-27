import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_typography.dart';
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
          onTap: hasContent
              ? () => _openReferences(context, ref, available)
              : null,
        );
      },
      loading: () => const _ReferencesIconButton(count: 0, enabled: false),
      error: (_, __) => const _ReferencesIconButton(count: 0, enabled: false),
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
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: selected.filtroCatalogo ?? 'Geral',
          areaHa: plano.areaHaTotal,
        );
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${item.titulo} adicionado ao plano')),
          );
        }
      },
    );
  }
}

class _ReferencesIconButton extends StatelessWidget {
  const _ReferencesIconButton({
    required this.count,
    required this.enabled,
    this.onTap,
  });

  final int count;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: SizedBox(
        width: AppConstants.minTouchTarget,
        height: AppConstants.minTouchTarget,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: context.appSurface,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onTap,
                customBorder: const CircleBorder(),
                child: Container(
                  width: AppConstants.minTouchTarget,
                  height: AppConstants.minTouchTarget,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Center(
                    child: PhosphorIcon(
                      PhosphorIconsRegular.bookOpen,
                      size: 20,
                      color: enabled
                          ? context.appTextPrimary
                          : context.appTextDisabled,
                    ),
                  ),
                ),
              ),
            ),
            if (count > 0)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1428A0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: AppTypography.label.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
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
