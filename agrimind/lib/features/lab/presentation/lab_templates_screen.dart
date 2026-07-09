import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/dark_app_bar.dart';
import '../../../core/widgets/lab_template_card.dart';
import 'lab_template_form_screen.dart';

class LabTemplatesScreen extends StatelessWidget {
  const LabTemplatesScreen({super.key});

  static const _templates = [
    _LabTemplateEntry(
      title: 'K, Ca, Mg: cmolc/dm³ · M.O.: g/dm³',
      badge: 'Padrão',
    ),
    _LabTemplateEntry(
      title: 'K, Ca, Mg: cmolc/dm³ · M.O.: %',
      badge: 'Padrão',
    ),
    _LabTemplateEntry(
      title: 'K, Ca, Mg: dag/kg · M.O.: g/dm³',
      badge: 'Padrão',
    ),
    _LabTemplateEntry(
      title: 'K, Ca, Mg: cmolc/dm³ · M.O.: g/kg',
      badge: 'Padrão',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DarkAppBar(
        title: 'Modelos de Laboratório',
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const LabTemplateFormScreen()),
            ),
            child: const Text('+ Novo'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Templates definem unidades e campos esperados de cada laboratório, '
                    'garantindo importação correta dos PDFs.',
                    style: TextStyle(color: AppColors.onSurface, fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'PADRÃO',
            style: TextStyle(
              color: AppColors.onSurfaceMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          for (final t in _templates) ...[
            LabTemplateCard(
              title: t.title,
              badgeLabel: t.badge,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => LabTemplateFormScreen(initialName: t.title),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _LabTemplateEntry {
  const _LabTemplateEntry({required this.title, required this.badge});
  final String title;
  final String badge;
}
