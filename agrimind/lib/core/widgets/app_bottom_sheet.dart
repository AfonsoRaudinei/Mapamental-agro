import 'package:flutter/material.dart';

import 'bottom_sheet_handle.dart';

/// Shell padrão para bottom sheets do AgriMind.
///
/// Regras:
/// - usa o shape e a cor do `BottomSheetTheme` do app
/// - mantém handle, borda e raio consistentes
/// - aplica o inset do teclado automaticamente
class AppBottomSheetScaffold extends StatelessWidget {
  const AppBottomSheetScaffold({
    super.key,
    required this.header,
    required this.body,
    this.showHandle = true,
    this.showDivider = true,
    this.bodyPadding = EdgeInsets.zero,
  });

  final Widget header;
  final Widget body;
  final bool showHandle;
  final bool showDivider;
  final EdgeInsetsGeometry bodyPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomSheetTheme = theme.bottomSheetTheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Material(
        color: bottomSheetTheme.backgroundColor ?? theme.colorScheme.surface,
        elevation: bottomSheetTheme.elevation ?? 0,
        shadowColor: bottomSheetTheme.shadowColor,
        surfaceTintColor: bottomSheetTheme.surfaceTintColor,
        shape: bottomSheetTheme.shape,
        clipBehavior: bottomSheetTheme.clipBehavior ?? Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (showHandle) const BottomSheetHandle(),
              header,
              if (showDivider)
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: theme.dividerTheme.color,
                ),
              Expanded(
                child: Padding(
                  padding: bodyPadding,
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Wrapper para abrir modal sheets com a configuração padrão do app.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? barrierColor,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: builder,
  );
}
