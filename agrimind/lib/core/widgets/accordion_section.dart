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
    this.titleWidget,
    this.subtitle,
    this.leading,
    this.trailing,
    this.subtitleWidget,
    this.quiet = false,
    this.color,
    this.borderColor,
    this.subtitleFullWidth = false,
    this.hideSubtitleWhenExpanded = false,
    this.contentPadding = const EdgeInsets.fromLTRB(
      AppSpacing.md,
      0,
      AppSpacing.md,
      AppSpacing.md,
    ),
  });

  final String title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? subtitleWidget;
  final bool quiet;
  final Color? color;
  final Color? borderColor;
  final bool subtitleFullWidth;
  final bool hideSubtitleWhenExpanded;
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
        color: color ?? context.appSurface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: borderColor ?? context.appBorder),
        boxShadow: isDark
            ? null
            : const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 10,
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
              titleWidget: titleWidget,
              subtitle: subtitle,
              subtitleWidget: subtitleWidget,
              quiet: quiet,
              leading: leading,
              trailing: trailing,
              subtitleFullWidth: subtitleFullWidth,
              hideSubtitleWhenExpanded: hideSubtitleWhenExpanded,
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
    this.titleWidget,
    required this.isExpanded,
    required this.onTap,
    this.subtitle,
    this.subtitleWidget,
    this.quiet = false,
    this.leading,
    this.trailing,
    this.subtitleFullWidth = false,
    this.hideSubtitleWhenExpanded = false,
  });

  final String title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final bool quiet;
  final Widget? leading;
  final Widget? trailing;
  final bool subtitleFullWidth;
  final bool hideSubtitleWhenExpanded;
  final bool isExpanded;
  final VoidCallback onTap;

  bool get _hasSubtitle {
    if (subtitleWidget == null && subtitle == null) return false;
    if (hideSubtitleWhenExpanded && isExpanded) return false;
    return true;
  }

  TextStyle _titleStyle(BuildContext context) {
    if (quiet) {
      return AppTypography.body.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: context.appTextPrimary,
        height: 1.25,
      );
    }
    return AppTypography.h3.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: context.appTextPrimary,
    );
  }

  Widget _subtitleChild(BuildContext context) {
    if (subtitleWidget != null) return subtitleWidget!;
    return Text(
      subtitle!,
      style: AppTypography.caption.copyWith(
        color: context.appTextSecondary,
        height: 1.35,
      ),
    );
  }

  Widget _titleChild(BuildContext context) {
    if (titleWidget != null) return titleWidget!;
    return Text(
      title,
      style: _titleStyle(context),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _chevronTapTarget() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 36,
          height: 36,
          child: _Chevron(isExpanded: isExpanded),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (subtitleFullWidth) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.md, 14, 0, 14),
                  child: leading!,
                ),
              Expanded(
                child: titleWidget != null
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                          leading != null ? 8 : AppSpacing.md,
                          14,
                          8,
                          _hasSubtitle ? 6 : 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _titleChild(context)),
                            _chevronTapTarget(),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: onTap,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            leading != null ? 8 : AppSpacing.md,
                            14,
                            8,
                            _hasSubtitle ? 6 : 14,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: _titleChild(context)),
                              _Chevron(isExpanded: isExpanded),
                            ],
                          ),
                        ),
                      ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (_hasSubtitle)
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  12,
                ),
                child: _subtitleChild(context),
              ),
            ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, 14, 0, 14),
            child: leading!,
          ),
        Expanded(
          child: titleWidget != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(
                    leading != null ? 12 : AppSpacing.md,
                    quiet ? 12 : 14,
                    12,
                    quiet ? 12 : 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleChild(context),
                            if (_hasSubtitle) ...[
                              const SizedBox(height: 3),
                              _subtitleChild(context),
                            ],
                          ],
                        ),
                      ),
                      _chevronTapTarget(),
                    ],
                  ),
                )
              : InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      leading != null ? 12 : AppSpacing.md,
                      quiet ? 12 : 14,
                      12,
                      quiet ? 12 : 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _titleChild(context),
                              if (_hasSubtitle) ...[
                                const SizedBox(height: 3),
                                _subtitleChild(context),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: _Chevron(isExpanded: isExpanded),
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

class _Chevron extends StatelessWidget {
  const _Chevron({required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: isExpanded ? 0.5 : 0,
      duration: AccordionSection.chevronDuration,
      curve: Curves.easeInOut,
      child: PhosphorIcon(
        PhosphorIconsRegular.caretDown,
        size: 18,
        color: context.appTextDisabled,
      ),
    );
  }
}
