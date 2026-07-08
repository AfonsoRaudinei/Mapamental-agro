import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// AppBar escura com botão voltar visível (primary, área de toque ≥ 48px).
class DarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DarkAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onBack,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return AppBar(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: leading ??
          (automaticallyImplyLeading && canPop
              ? IconButton(
                  icon: const Icon(Icons.chevron_left, color: AppColors.primary),
                  iconSize: 28,
                  onPressed: onBack ?? () => Navigator.maybePop(context),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                )
              : null),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.onSurface,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
    );
  }
}
