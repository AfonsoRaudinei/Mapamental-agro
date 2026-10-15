import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../widgets/circular_fungicidas_card.dart';

/// Hub de Referências Técnicas — grade 2×2 + Circular fungicidas + CESB.
class ReferencesHomePage extends ConsumerWidget {
  const ReferencesHomePage({super.key});

  static const _categorias = [
    _CatInfo(
      key: 'doencas',
      label: 'Doenças',
      subtitle: 'Fungos, bactérias, vírus',
      color: AppColors.catDoencas,
      icon: PhosphorIconsRegular.virus,
    ),
    _CatInfo(
      key: 'insetos',
      label: 'Insetos',
      subtitle: 'Pragas e níveis de ação',
      color: AppColors.catInsetos,
      icon: PhosphorIconsRegular.bug,
    ),
    _CatInfo(
      key: 'nutricao',
      label: 'Nutrição',
      subtitle: 'N, P, K, S e micronutrientes',
      color: AppColors.catNutricao,
      icon: PhosphorIconsRegular.leaf,
    ),
    _CatInfo(
      key: 'fisiologia',
      label: 'Fisiologia',
      subtitle: 'Bioestimulantes e hormônios',
      color: AppColors.catFisiologia,
      icon: PhosphorIconsRegular.dna,
    ),
  ];

  static const _cesb = _CatInfo(
    key: 'cesb',
    label: 'Campeões CESB',
    subtitle: 'Dicas dos produtores recordistas',
    color: AppColors.catCESB,
    icon: PhosphorIconsRegular.trophy,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Referências'),
            backgroundColor: Theme.of(context)
                .scaffoldBackgroundColor
                .withValues(alpha: 0.85),
            border: Border.all(color: Colors.transparent),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.15,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  final cat = _categorias[i];
                  return _CategoryCard(
                    info: cat,
                    onTap: () => context.push('/references/${cat.key}'),
                  );
                },
                childCount: _categorias.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverToBoxAdapter(
              child: CircularFungicidasCard(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ).copyWith(bottom: AppSpacing.shellBottomGap(context)),
            sliver: SliverToBoxAdapter(
              child: _CategoryCard(
                info: _cesb,
                onTap: () => context.push('/references/cesb'),
                fullWidth: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dados das categorias ──────────────────────────────────────────────────────

class _CatInfo {
  const _CatInfo({
    required this.key,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  final String key;
  final String label;
  final String subtitle;
  final Color color;
  final IconData icon;
}

// ── Card de categoria ─────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.info,
    required this.onTap,
    this.fullWidth = false,
  });

  final _CatInfo info;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: info.color.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: fullWidth ? 96 : null,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: info.color.withValues(alpha: 0.18)),
            ),
            child: fullWidth ? _fullWidthBody(context) : _gridBody(context),
          ),
        ),
      ),
    );
  }

  Widget _iconCircle({required double size, required double iconSize}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: info.color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: PhosphorIcon(
          info.icon,
          size: iconSize,
          color: info.color,
        ),
      ),
    );
  }

  Widget _fullWidthBody(BuildContext context) {
    return Row(
      children: [
        _iconCircle(size: 52, iconSize: 28),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info.label,
                style: AppTypography.h3.copyWith(
                  color: context.appTextPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                info.subtitle,
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],
          ),
        ),
        PhosphorIcon(
          PhosphorIconsRegular.caretRight,
          size: 16,
          color: context.appTextDisabled,
        ),
      ],
    );
  }

  Widget _gridBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _iconCircle(size: 44, iconSize: 24),
            const Spacer(),
            PhosphorIcon(
              PhosphorIconsRegular.caretRight,
              size: 16,
              color: context.appTextDisabled,
            ),
          ],
        ),
        const Spacer(),
        Text(
          info.label,
          style: AppTypography.h3.copyWith(
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          info.subtitle,
          style: AppTypography.caption.copyWith(
            color: context.appTextSecondary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
