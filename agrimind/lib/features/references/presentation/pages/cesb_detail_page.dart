import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/references_provider.dart';
import '../widgets/cesb_tip_card.dart';
import '../widgets/estadio_chip_row.dart';
import '../../../../core/utils/extensions.dart';

/// Página das dicas CESB (Campeões) com filtro por estádio.
class CesbDetailPage extends ConsumerStatefulWidget {
  const CesbDetailPage({super.key});

  @override
  ConsumerState<CesbDetailPage> createState() => _CesbDetailPageState();
}

class _CesbDetailPageState extends ConsumerState<CesbDetailPage> {
  String _estadioSelecionado = 'Todos';

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(
      cesbReferenciasProvider(
        estadio: _estadioSelecionado == 'Todos' ? null : _estadioSelecionado,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Campeões CESB'),
            backgroundColor: Theme.of(context)
                .scaffoldBackgroundColor
                .withValues(alpha: 0.85),
            border: Border.all(color: Colors.transparent),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.pop(),
              child: const PhosphorIcon(
                PhosphorIconsRegular.caretLeft,
                size: 22,
                color: AppColors.primary,
              ),
            ),
          ),

          // ── Subtítulo ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                'Práticas de campeões de produtividade por estádio fenológico',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ),
          ),

          // ── Filtro por estádio ────────────────────────────────────────
          SliverToBoxAdapter(
            child: EstadioChipRow(
              estadiosDisponiveis: const [
                'Todos',
                ...AppConstants.estadiosCodigos,
              ],
              selectedEstadio: _estadioSelecionado,
              onSelect: (e) => setState(() => _estadioSelecionado = e),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xs)),

          // ── Lista CESB ────────────────────────────────────────────────
          async.when(
            data: (refs) {
              if (refs.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: PhosphorIconsRegular.trophy,
                    title: 'Nenhuma dica CESB',
                    subtitle: _estadioSelecionado != 'Todos'
                        ? 'Sem dicas para o estádio $_estadioSelecionado'
                        : 'Sem informações disponíveis',
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => CesbTipCard(cesb: refs[i]),
                  childCount: refs.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: LoadingSkeleton(),
            ),
            error: (e, _) => SliverFillRemaining(
              child: ErrorStateWidget(
                onRetry: () => ref.invalidate(
                  cesbReferenciasProvider(
                    estadio: _estadioSelecionado == 'Todos'
                        ? null
                        : _estadioSelecionado,
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}
