import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/circular_fungicidas_data.dart';
import '../../domain/reference_models.dart';
import '../widgets/golden_book_icon.dart';

/// Tela detalhe — Circular fungicidas (Embrapa CT-219).
class CircularFungicidasPage extends StatelessWidget {
  const CircularFungicidasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Row(
          children: [
            const GoldenBookIcon(size: 32, iconSize: 16),
            const SizedBox(width: 10),
            Text(
              ReferenceKind.circularFungicidas.title,
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const _SourcesBanner(),
          const SizedBox(height: 16),
          ...CircularFungicidasData.stages.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _StageSection(entry: entry),
            ),
          ),
        ],
      ),
    );
  }
}

/// Alias para compatibilidade com branch cloud.
typedef CircularFungicidasScreen = CircularFungicidasPage;

class _SourcesBanner extends StatelessWidget {
  const _SourcesBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.goldSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fontes',
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          ...CircularFungicidasData.sources.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                '• $s',
                style: const TextStyle(
                  color: AppColors.onSurfaceMuted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StageSection extends StatefulWidget {
  const _StageSection({required this.entry});

  final ReferenceStageEntry entry;

  @override
  State<_StageSection> createState() => _StageSectionState();
}

class _StageSectionState extends State<_StageSection> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final hasProducts = entry.recommendations.isNotEmpty;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.goldSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.goldDark.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      entry.stageCode,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.stageName,
                          style: const TextStyle(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (entry.primaryDisease != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            entry.primaryDisease!,
                            style: const TextStyle(
                              color: AppColors.onSurfaceMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.onSurfaceMuted,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (entry.diseases.isNotEmpty) ...[
                    const _SectionLabel('Doenças presentes'),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: entry.diseases
                          .map(
                            (d) => Chip(
                              label: Text(d),
                              labelStyle: const TextStyle(fontSize: 11),
                              visualDensity: VisualDensity.compact,
                              backgroundColor: AppColors.surfaceElevated,
                              side: const BorderSide(color: AppColors.border),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (entry.incidences != null && entry.incidences!.isNotEmpty) ...[
                    const _SectionLabel('Incidência'),
                    const SizedBox(height: 4),
                    ...entry.incidences!.entries.map(
                      (e) => Text(
                        '${e.key}: ${e.value}',
                        style: const TextStyle(
                          color: AppColors.onSurfaceMuted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const _SectionLabel('Manejo'),
                  const SizedBox(height: 4),
                  Text(
                    entry.management,
                    style: const TextStyle(
                      color: AppColors.onSurfaceMuted,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  if (hasProducts) ...[
                    const SizedBox(height: 16),
                    const _SectionLabel('Fungicidas recomendados'),
                    const SizedBox(height: 8),
                    ...entry.recommendations.map(
                      (r) => _FungicidaTile(recommendation: r),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    );
  }
}

class _FungicidaTile extends StatelessWidget {
  const _FungicidaTile({required this.recommendation});

  final FungicidaRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final r = recommendation;
    final metrics = <String>[
      if (r.controlPercent != null) 'Controle: ${r.controlPercent!.toStringAsFixed(1)}%',
      if (r.productivityKgHa != null) 'Prod.: ${r.productivityKgHa!.toStringAsFixed(0)} kg/ha',
      if (r.fitotoxPercent != null) 'Fitotox.: ${r.fitotoxPercent!.toStringAsFixed(1)}%',
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.goldSurface,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${r.rank}',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  r.product,
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            r.activeIngredient,
            style: const TextStyle(color: AppColors.onSurfaceMuted, fontSize: 12),
          ),
          if (metrics.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              metrics.join(' · '),
              style: const TextStyle(color: AppColors.onSurfaceDim, fontSize: 11),
            ),
          ],
          if (r.notes != null) ...[
            const SizedBox(height: 4),
            Text(
              r.notes!,
              style: const TextStyle(color: AppColors.goldMuted, fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
