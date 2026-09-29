import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../utils/extensions.dart';

/// Painel expansível/recolhível genérico (padrão "disclosure widget"),
/// reutilizável em qualquer feature. Não guarda estado próprio:
/// o pai controla [isExpanded] e reage a [onToggle].
class AccordionSection extends StatelessWidget {
  const AccordionSection({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
    this.subtitle,
    this.leading,
    this.trailing,
    this.contentPadding = const EdgeInsets.fromLTRB(
      AppSpacing.md,
      0,
      AppSpacing.md,
      AppSpacing.md,
    ),
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool isExpanded;
  final ValueChanged<bool> onToggle;
  final Widget child;
  final EdgeInsets contentPadding;

  static const Duration expandDuration = Duration(milliseconds: 220);
  static const Duration chevronDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: context.appBorder),
        boxShadow: isDark
            ? null
            : const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AccordionHeader(
              title: title,
              subtitle: subtitle,
              leading: leading,
              trailing: trailing,
              isExpanded: isExpanded,
              onTap: () => onToggle(!isExpanded),
            ),
            AnimatedSize(
              duration: expandDuration,
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isExpanded
                  ? Padding(padding: contentPadding, child: child)
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccordionHeader extends StatelessWidget {
  const _AccordionHeader({
    required this.title,
    required this.isExpanded,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 14, 12, 14),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.h3.copyWith(
                            fontSize: 17,
                            color: context.appTextPrimary,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: AppTypography.caption.copyWith(
                              color: context.appTextDisabled,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: AccordionSection.chevronDuration,
                      curve: Curves.easeInOut,
                      child: PhosphorIcon(
                        PhosphorIconsRegular.caretDown,
                        size: 18,
                        color: context.appTextDisabled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
