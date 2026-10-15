import 'package:flutter/material.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/theme/plan_stage_card_tokens.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/accordion_section.dart';

/// Especialização de [AccordionSection] para um estádio fenológico
/// dentro de um plano (ex.: "V5 — 5º Nó").
class AccordionStageCard extends StatelessWidget {
  const AccordionStageCard({
    super.key,
    required this.stageCode,
    required this.stageName,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.headerReferences,
    this.borderColor,
    this.instanceTalhaoBadge,
  });

  final String stageCode;
  final String stageName;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  /// Referências técnicas (livros) ao lado do badge do estádio — visível fechado.
  final Widget? headerReferences;

  final Color? borderColor;

  /// Selo de talhão (instância do roteiro); null = card template neutro.
  final Widget? instanceTalhaoBadge;

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: stageName,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      subtitleFullWidth: true,
      borderColor: borderColor ?? PlanStageCardTokens.border(context),
      trailing: instanceTalhaoBadge,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _StageAvatar(code: stageCode),
          if (headerReferences != null) ...[
            const SizedBox(width: 6),
            headerReferences!,
          ],
        ],
      ),
      isExpanded: isExpanded,
      onToggle: (_) => onToggle(),
      hideSubtitleWhenExpanded: true,
      contentPadding: EdgeInsets.zero,
      child: child,
    );
  }
}

class _StageAvatar extends StatelessWidget {
  const _StageAvatar({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.appBorderSoft,
        shape: BoxShape.circle,
      ),
      child: Text(
        code,
        style: AppTypography.caption.copyWith(
          fontWeight: FontWeight.w800,
          color: context.appTextPrimary,
        ),
      ),
    );
  }
}
