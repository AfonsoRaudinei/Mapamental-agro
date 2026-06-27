import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/app_bar_custom.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/plans_list_provider.dart';
import '../widgets/plan_card.dart';

/// Lista de Planos — Tab 1 do AgriMind.
class PlansListPage extends ConsumerWidget {
  const PlansListPage({super.key});

  Future<void> _deletePlan(
    BuildContext context,
    WidgetRef ref,
    String planoId,
    String planoNome,
  ) async {
    final confirm = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Excluir plano?'),
        content: Text('O plano "$planoNome" será excluído permanentemente.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await ref.read(plansRepoProvider).delete(planoId);
    ref.invalidate(plansListNotifierProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansListNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarCustom(
        title: 'Planos',
        actions: [
          IconButton(
            icon: const PhosphorIcon(
              PhosphorIconsRegular.plus,
              size: 22,
              color: AppColors.primary,
            ),
            tooltip: 'Novo Plano',
            onPressed: () => context.push(AppRoutes.planNew),
          ),
        ],
      ),
      body: plansAsync.when(
        data: (planos) => planos.isEmpty
            ? EmptyStateWidget(
                title: 'Nenhum plano ainda',
                subtitle:
                    'Crie seu primeiro plano fenológico tocando no + acima.',
                icon: PhosphorIconsRegular.mapTrifold,
                actionLabel: 'Criar Plano',
                action: () => context.push(AppRoutes.planNew),
              )
            : RefreshIndicator(
                onRefresh: () =>
                    ref.read(plansListNotifierProvider.notifier).refresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  itemCount: planos.length,
                  itemBuilder: (context, i) => PlanCard(
                    plano: planos[i],
                    onDelete: () => _deletePlan(
                      context,
                      ref,
                      planos[i].id,
                      planos[i].nome,
                    ),
                  ),
                ),
              ),
        loading: () => const LoadingSkeleton(),
        error: (e, _) => ErrorStateWidget(
          onRetry: () => ref.invalidate(plansListNotifierProvider),
        ),
      ),
    );
  }
}
