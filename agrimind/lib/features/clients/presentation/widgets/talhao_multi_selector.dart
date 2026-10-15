import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/talhao_entity.dart';

/// Seleção de um ou mais talhões para a mesma regulagem de cronograma.
class TalhaoMultiSelector extends StatelessWidget {
  const TalhaoMultiSelector({
    super.key,
    required this.talhoes,
    required this.selectedIds,
    required this.onChanged,
  });

  final List<TalhaoEntity> talhoes;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Talhões',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: talhoes.map((t) {
              final selected = selectedIds.contains(t.id);
              return FilterChip(
                label: Text('${t.nome} · ${t.areaHa.toStringAsFixed(1)} ha'),
                selected: selected,
                onSelected: (v) {
                  final next = Set<String>.from(selectedIds);
                  if (v) {
                    next.add(t.id);
                  } else {
                    next.remove(t.id);
                  }
                  if (next.isNotEmpty) onChanged(next);
                },
              );
            }).toList(),
          ),
          Text(
            'Selecione todos os talhões que seguem esta regulagem.',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
