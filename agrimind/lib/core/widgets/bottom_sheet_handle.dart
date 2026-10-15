import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/extensions.dart';

/// Handle visual de bottom sheets — linha arredondada no topo.
class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? AppColors.textSecondaryDark
        : context.appTextDisabled;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}
