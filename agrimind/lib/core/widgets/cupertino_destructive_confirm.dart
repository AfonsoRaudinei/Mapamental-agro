import 'package:flutter/cupertino.dart';

/// Confirmação destrutiva no estilo iOS (CupertinoAlertDialog).
Future<bool> showCupertinoDestructiveConfirm(
  BuildContext context, {
  required String itemName,
  String confirmLabel = 'Remover',
}) async {
  final confirmed = await showCupertinoDialog<bool>(
    context: context,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text('Remover $itemName?'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return confirmed == true;
}
