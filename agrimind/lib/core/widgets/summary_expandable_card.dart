import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../utils/extensions.dart';

/// Card recolhível com resumo visível e detalhes sob demanda.
///
/// Padrões: Progressive Disclosure, Expandable Card, Collapsible Form,
/// Summary + Detail.
class SummaryExpandableCard extends StatefulWidget {
  const SummaryExpandableCard({
    super.key,
    required this.summary,
    required this.detail,
    this.initiallyExpanded = false,
    this.leading,
    this.trailing,
    this.detailPadding = const EdgeInsets.all(10),
    this.onExpansionChanged,
  });

  final Widget summary;
  final Widget detail;
  final bool initiallyExpanded;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry detailPadding;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<SummaryExpandableCard> createState() => _SummaryExpandableCardState();
}

class _SummaryExpandableCardState extends State<SummaryExpandableCard> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(covariant SummaryExpandableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded &&
        widget.initiallyExpanded) {
      _expanded = true;
    }
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    widget.onExpansionChanged?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: context.appSurface.withValues(alpha: 0.96),
        border: Border.all(color: context.appBorderSoft),
        borderRadius: BorderRadius.circular(10),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: _toggle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.sm + 2,
                    ),
                    child: Row(
                      children: [
                        if (widget.leading != null) ...[
                          widget.leading!,
                          const SizedBox(width: AppSpacing.sm),
                        ],
                        Expanded(child: widget.summary),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: PhosphorIcon(
                            PhosphorIconsRegular.caretDown,
                            size: 14,
                            color: context.appTextDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(height: 1, color: context.appBorderSoft),
                      Padding(
                        padding: widget.detailPadding,
                        child: widget.detail,
                      ),
                    ],
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

/// Linha de resumo compacta para uso dentro de [SummaryExpandableCard].
class SummaryDetailLine extends StatelessWidget {
  const SummaryDetailLine({
    super.key,
    required this.primary,
    this.secondary,
  });

  final String primary;
  final String? secondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          primary,
          style: AppTypography.body.copyWith(
            color: context.appTextPrimary,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (secondary != null && secondary!.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            secondary!,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
