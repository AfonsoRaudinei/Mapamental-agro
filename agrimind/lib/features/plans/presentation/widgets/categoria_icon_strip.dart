import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/categoria_referencia.dart';

/// Zona C legada — preferir [StageReferencesButton] no canvas.
///
/// Coluna vertical com os 5 ícones de categoria (design anterior).
///
/// Regra de opacidade:
/// - sem conteúdo → opacity 0.4 (sem sombra)
/// - com conteúdo → opacity 1.0 (com sombra colorida)
class CategoriaIconStrip extends StatelessWidget {
  const CategoriaIconStrip({
    super.key,
    required this.contentMap,
    required this.onTap,
  });

  /// Mapa categoria → tem conteúdo disponível para este estádio.
  /// Null ou false = sem conteúdo (40% opacidade).
  final Map<CategoriaReferencia, bool> contentMap;

  /// Callback ao tocar em uma categoria.
  final void Function(CategoriaReferencia) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: CategoriaReferencia.values.map((cat) {
        final hasContent = contentMap[cat] ?? false;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: _CategoriaIconButton(
            categoria: cat,
            hasContent: hasContent,
            onTap: () => onTap(cat),
          ),
        );
      }).toList(),
    );
  }
}

// ── Botão individual 38×38 ──────────────────────────────────────────────────

class _CategoriaIconButton extends StatelessWidget {
  const _CategoriaIconButton({
    required this.categoria,
    required this.hasContent,
    required this.onTap,
  });

  final CategoriaReferencia categoria;
  final bool hasContent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        opacity: hasContent ? 1.0 : 0.4,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: categoria.color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: hasContent
                ? [
                    BoxShadow(
                      color: categoria.color.withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: PhosphorIcon(
              categoria.icone,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
