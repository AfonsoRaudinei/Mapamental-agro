import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/utils/extensions.dart';

/// Sheet compacto para escolher a categoria de referência de um estádio.
class CategoriaPickerSheet extends StatelessWidget {
  const CategoriaPickerSheet({
    super.key,
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
      builder: (_) => CategoriaPickerSheet(
        estadioCodigo: estadioCodigo,
        categorias: categorias,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.38,
      minChildSize: 0.25,
      maxChildSize: 0.6,
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
            return _CategoriaPickerTile(
              categoria: categoria,
              onTap: () => Navigator.of(context).pop(categoria),
            );
          },
        ),
      ),
    );
  }
}

class _CategoriaPickerTile extends StatelessWidget {
  const _CategoriaPickerTile({
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
