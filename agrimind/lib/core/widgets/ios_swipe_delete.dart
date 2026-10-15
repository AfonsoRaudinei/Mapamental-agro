import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import 'cupertino_destructive_confirm.dart';

/// Swipe para excluir com confirmação Cupertino (padrão iOS do app).
class IosSwipeDelete extends StatelessWidget {
  const IosSwipeDelete({
    super.key,
    required this.dismissKey,
    required this.itemName,
    required this.onDelete,
    required this.child,
  });

  final Key dismissKey;
  final String itemName;
  final VoidCallback onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismissKey,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.error,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PhosphorIcon(
              PhosphorIconsRegular.trash,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Excluir',
              style: AppTypography.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (_) async {
        final confirmed = await showCupertinoDestructiveConfirm(
          context,
          itemName: itemName,
        );
        if (confirmed) onDelete();
        return false;
      },
      child: child,
    );
  }
}
