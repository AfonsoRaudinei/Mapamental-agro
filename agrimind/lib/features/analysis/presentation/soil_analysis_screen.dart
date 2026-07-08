import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/dark_surface_card.dart';
import '../../../core/widgets/primary_back_link.dart';

class SoilAnalysisScreen extends StatelessWidget {
  const SoilAnalysisScreen({super.key});

  static const _samples = [
    _SampleCard(id: 'T01', code: '58A25.147294', crop: 'Soja', date: '2025/01/28', depth: '0-20', farm: 'MOEMA'),
    _SampleCard(id: 'T02', code: '58A25.147295', crop: 'Soja', date: '2025/01/28', depth: '0-20', farm: 'MOEMA'),
    _SampleCard(id: 'T03', code: '58A25.147296', crop: 'Milho', date: '2025/02/10', depth: '0-20', farm: 'MOEMA'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Análise de Solo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar área, produtor, cultura...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.onSurfaceMuted),
                  filled: true,
                  fillColor: AppColors.surfaceElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: AppColors.onSurface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  _FilterChip(label: 'Todas culturas'),
                  const SizedBox(width: 8),
                  _FilterChip(label: '2025/2026'),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.checklist, size: 18),
                    label: const Text('Selecionar'),
                  ),
                ],
              ),
            ),
            const PrimaryBackLink(label: 'Voltar para plantio'),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.92,
                ),
                itemCount: _samples.length,
                itemBuilder: (context, index) {
                  final s = _samples[index];
                  return DarkSurfaceCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.eco, color: Color(0xFF22C55E), size: 22),
                        const SizedBox(height: 8),
                        Text(
                          s.id,
                          style: const TextStyle(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          s.code,
                          style: const TextStyle(color: AppColors.primary, fontSize: 12),
                        ),
                        const Spacer(),
                        Text(
                          '${s.crop} · ${s.date} · ${s.depth}',
                          style: const TextStyle(color: AppColors.onSurfaceMuted, fontSize: 11),
                        ),
                        Text(
                          s.farm,
                          style: const TextStyle(color: AppColors.onSurfaceMuted, fontSize: 11),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.onSurface, fontSize: 13)),
    );
  }
}

class _SampleCard {
  const _SampleCard({
    required this.id,
    required this.code,
    required this.crop,
    required this.date,
    required this.depth,
    required this.farm,
  });
  final String id;
  final String code;
  final String crop;
  final String date;
  final String depth;
  final String farm;
}
