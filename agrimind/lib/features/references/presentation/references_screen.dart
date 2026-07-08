import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/reference_models.dart';
import 'circular_fungicidas_screen.dart';
import 'widgets/reference_featured_card.dart';
import 'widgets/reference_grid_card.dart';

class ReferencesScreen extends StatelessWidget {
  const ReferencesScreen({super.key});

  static const _gridKinds = [
    ReferenceKind.doencas,
    ReferenceKind.insetos,
    ReferenceKind.nutricao,
    ReferenceKind.fisiologia,
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            'Referências',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.98,
            children: [
              for (final kind in _gridKinds)
                ReferenceGridCard(
                  kind: kind,
                  onTap: () => _onReferenceTap(context, kind),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ReferenceFeaturedCard(
            kind: ReferenceKind.circularFungicidas,
            useGoldenBookIcon: true,
            onTap: () => _openCircularFungicidas(context),
          ),
          const SizedBox(height: 12),
          ReferenceFeaturedBorderedCard(
            kind: ReferenceKind.campeoesCesb,
            onTap: () => _onReferenceTap(context, ReferenceKind.campeoesCesb),
          ),
        ],
      ),
    );
  }

  void _openCircularFungicidas(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const CircularFungicidasScreen(),
      ),
    );
  }

  void _onReferenceTap(BuildContext context, ReferenceKind kind) {
    if (kind == ReferenceKind.circularFungicidas) {
      _openCircularFungicidas(context);
      return;
    }

    if (!kind.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${kind.title} — em breve'),
          backgroundColor: AppColors.surfaceElevated,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
