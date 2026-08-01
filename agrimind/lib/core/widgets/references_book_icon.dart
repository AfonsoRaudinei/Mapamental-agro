import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../utils/extensions.dart';

/// Ícone de livro no canvas.
///
/// - [filled] false → livro outline (referências padrão)
/// - [filled] true → livro preenchido dourado (Circular técnica / CESB)
class ReferencesBookIcon extends StatelessWidget {
  const ReferencesBookIcon({
    super.key,
    required this.accent,
    this.enabled = true,
    this.compact = false,
    this.filled = false,
    this.onTap,
  });

  final Color accent;
  final bool enabled;
  final bool compact;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 32.0 : AppConstants.minTouchTarget;
    final iconSize = compact ? 16.0 : 20.0;

    final Color borderColor;
    final Color fill;
    final Color iconColor;

    if (filled) {
      borderColor =
          enabled ? accent.withValues(alpha: 0.55) : AppColors.borderDark;
      fill = enabled ? accent.withValues(alpha: 0.14) : Colors.transparent;
      iconColor = enabled ? accent : AppColors.textDisabled;
    } else {
      borderColor = enabled ? context.appBorder : AppColors.borderDark;
      fill = enabled ? context.appSurface : Colors.transparent;
      iconColor = enabled ? context.appTextPrimary : context.appTextDisabled;
    }

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: SizedBox(
        width: size,
        height: size,
        child: Material(
          color: fill,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor),
              ),
              child: Center(
                child: PhosphorIcon(
                  filled
                      ? PhosphorIconsFill.bookOpen
                      : PhosphorIconsRegular.bookOpen,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
