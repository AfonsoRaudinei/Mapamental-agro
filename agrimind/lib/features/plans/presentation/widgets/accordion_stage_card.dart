import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/accordion_section.dart';
import '../../../../core/widgets/cupertino_destructive_confirm.dart';

/// Especialização de [AccordionSection] para um estádio fenológico
/// dentro de um plano (ex.: "V5 — 5º Nó").
class AccordionStageCard extends StatelessWidget {
  const AccordionStageCard({
    super.key,
    required this.stageCode,
    required this.stageName,
    required this.productCount,
    required this.isExpanded,
    required this.onToggle,
    required this.onRemove,
    required this.child,
  });

  final String stageCode;
  final String stageName;
  final int productCount;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onRemove;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: '$stageCode — $stageName',
      subtitle: productCount == 0
          ? 'Nenhum produto — toque para adicionar'
          : '$productCount produto(s)',
      leading: _StageAvatar(code: stageCode),
      trailing: IconButton(
        tooltip: 'Remover estádio',
        onPressed: () async {
          final label = '$stageCode — $stageName';
          final confirmed = await showCupertinoDestructiveConfirm(
            context,
            itemName: label,
          );
          if (confirmed) onRemove();
        },
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        icon: PhosphorIcon(
          PhosphorIconsRegular.x,
          size: 18,
          color: context.appTextDisabled,
        ),
      ),
      isExpanded: isExpanded,
      onToggle: (_) => onToggle(),
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
