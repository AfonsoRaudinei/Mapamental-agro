import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Grupo de configurações com header em caixa alta.
///
/// Uso:
/// ```dart
/// SettingsSection(
///   title: 'Aparência',
///   children: [
///     SettingsToggle(...),
///     SettingsTile(...),
///   ],
/// )
/// ```
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sectionLabelColor =
        isDark ? AppColors.textSecondaryDark : context.appTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.lg,
            bottom: AppSpacing.xs,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.label.copyWith(
              color: sectionLabelColor,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline),
          ),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  Divider(
                    height: 1,
                    indent: AppSpacing.md,
                    color: colorScheme.outline,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
