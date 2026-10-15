import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart' as ds;
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_dark_black.dart';
import '../../../../core/widgets/dark_surface_card.dart';
import '../../data/circular_fungicidas_data.dart';
import '../../domain/reference_models.dart';

/// Tela detalhe da Circular fungicidas.
class CircularFungicidasPage extends StatelessWidget {
  const CircularFungicidasPage({super.key});

  static const _gold = ds.AppColors.refBookFungicidas;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkBlackTheme,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.primary,
          elevation: 0,
          titleSpacing: 0,
          title: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ds.AppColors.refBookFungicidasSurface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ds.AppColors.refBookFungicidasDark
                        .withValues(alpha: 0.5),
                  ),
                ),
                child: const PhosphorIcon(
                  PhosphorIconsFill.bookOpen,
                  size: 18,
                  color: _gold,
                ),
              ),
              const SizedBox(width: 10),
              const Flexible(
                child: Text(
                  'Circular fungicidas',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            12,
            16,
            AppSpacing.shellBottomGap(context),
          ),
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
      ),
    );
  }
}

class _SourcesBanner extends StatelessWidget {
  const _SourcesBanner();

  @override
  Widget build(BuildContext context) {
    return DarkSurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fontes',
            style: TextStyle(
              color: CircularFungicidasPage._gold,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ...CircularFungicidasData.sources.map(
            (source) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                '• $source',
                style: const TextStyle(
                  color: AppColors.onSurfaceMuted,
                  fontSize: 12,
                  height: 1.35,
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

    return DarkSurfaceCard(
      borderRadius: BorderRadius.circular(16),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ds.AppColors.refBookFungicidasSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ds.AppColors.refBookFungicidasDark
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      entry.stageCode,
                      style: const TextStyle(
                        color: CircularFungicidasPage._gold,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
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
                            fontWeight: FontWeight.w700,
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
            const Divider(height: 1, color: AppColors.border),
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
                            (disease) => Chip(
                              label: Text(disease),
                              labelStyle: const TextStyle(
                                color: AppColors.onSurface,
                                fontSize: 11,
                              ),
                              visualDensity: VisualDensity.compact,
                              backgroundColor: AppColors.surfaceElevated,
                              side: const BorderSide(color: AppColors.border),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (entry.incidences != null &&
                      entry.incidences!.isNotEmpty) ...[
                    const _SectionLabel('Incidência'),
                    const SizedBox(height: 4),
                    ...entry.incidences!.entries.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '${item.key}: ${item.value}',
                          style: const TextStyle(
                            color: AppColors.onSurface,
                            fontSize: 12,
                          ),
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
                      color: AppColors.onSurface,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  if (entry.recommendations.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const _SectionLabel('Fungicidas recomendados'),
                    const SizedBox(height: 8),
                    ...entry.recommendations.map(
                      (recommendation) =>
                          _RecommendationTile(recommendation: recommendation),
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
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile({required this.recommendation});

  final FungicidaRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final metrics = <String>[
      if (recommendation.controlPercent != null)
        'Controle ${recommendation.controlPercent!.toStringAsFixed(1)}%',
      if (recommendation.productivityKgHa != null)
        'Produtividade ${recommendation.productivityKgHa!.toStringAsFixed(0)} kg/ha',
      if (recommendation.fitotoxPercent != null)
        'Fitotox ${recommendation.fitotoxPercent!.toStringAsFixed(1)}%',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DarkSurfaceCard(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ds.AppColors.refBookFungicidasSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ds.AppColors.refBookFungicidasDark
                          .withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    '${recommendation.rank}',
                    style: const TextStyle(
                      color: CircularFungicidasPage._gold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recommendation.product,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              recommendation.activeIngredient,
              style: const TextStyle(
                color: AppColors.onSurfaceMuted,
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
            if (metrics.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                metrics.join(' · '),
                style: const TextStyle(
                  color: AppColors.onSurfaceMuted,
                  fontSize: 11.5,
                ),
              ),
            ],
            if (recommendation.notes != null) ...[
              const SizedBox(height: 6),
              Text(
                recommendation.notes!,
                style: const TextStyle(
                  color: CircularFungicidasPage._gold,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (recommendation.source != null) ...[
              const SizedBox(height: 6),
              Text(
                recommendation.source!,
                style: const TextStyle(
                  color: AppColors.onSurfaceMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
