import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../utils/extensions.dart';

/// AppBar padrão do AgriMind com estilo iOS.
class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(
        bottom != null
            ? kToolbarHeight + bottom!.preferredSize.height
            : kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg =
        backgroundColor ?? (isDark ? AppColors.surfaceDark : context.appSurface);
    final fg = isDark ? AppColors.textPrimaryDark : context.appTextPrimary;

    return AppBar(
      backgroundColor: bg,
      foregroundColor: fg,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      leading: leading,
      actions: actions,
      bottom: bottom,
      title: subtitle != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppTypography.h3.copyWith(color: fg)),
                Text(subtitle!,
                    style: AppTypography.caption
                        .copyWith(color: context.appTextSecondary)),
              ],
            )
          : Text(title, style: AppTypography.h3.copyWith(color: fg)),
    );
  }
}
