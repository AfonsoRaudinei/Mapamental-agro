import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/di/providers.dart';
import '../../../plans/domain/entities/plano_entity.dart';
import '../../../plans/domain/usecases/resolver_plano_ativo_fazenda_usecase.dart';
import '../providers/clients_provider.dart';
import '../widgets/talhao_add_sheet.dart';
import '../widgets/talhao_list_card.dart';
import '../../../../core/utils/extensions.dart';

/// Detalhe da fazenda — resumo, talhões e atalho para edição.
class FarmDetailPage extends ConsumerWidget {
  const FarmDetailPage({
    super.key,
    required this.clienteId,
    required this.farmId,
  });

  final String clienteId;
  final String farmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fazendasAsync = ref.watch(fazendasNotifierProvider(clienteId));

    return fazendasAsync.when(
      data: (fazendas) {
        final fazenda = fazendas.where((f) => f.id == farmId).firstOrNull;
        if (fazenda == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Fazenda')),
            body: const Center(child: Text('Fazenda não encontrada.')),
          );
        }

        final talhoesAsync = ref.watch(talhoesNotifierProvider(farmId));

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(fazenda.nome),
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
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.push(
                    AppRoutes.farmEditPath(clienteId, farmId),
                  ),
                  child: const PhosphorIcon(
                    PhosphorIconsRegular.pencilSimple,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.appSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ResumoRow(
                        label: 'Área total',
                        value: '${fazenda.areaHa.toStringAsFixed(1)} ha',
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _ResumoRow(label: 'Cultura', value: fazenda.cultura),
                      const SizedBox(height: AppSpacing.xs),
                      _ResumoRow(label: 'Safra', value: fazenda.safra),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: _CronogramaFazendaEntryCard(
                    clienteId: clienteId,
                    farmId: farmId,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TALHÕES',
                        style: AppTypography.label.copyWith(
                          color: context.appTextSecondary,
                          letterSpacing: 0.6,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => TalhaoAddSheet.show(
                          context: context,
                          ref: ref,
                          fazendaId: farmId,
                          fazendaAreaTotalHa: fazenda.areaHa,
                        ),
                        child: const Text(
                          '+ Adicionar',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              talhoesAsync.when(
                data: (talhoes) {
                  if (talhoes.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.lg,
                        ),
                        child: EmptyStateWidget(
                          icon: PhosphorIconsRegular.gridFour,
                          title: 'Nenhum talhão',
                          subtitle: 'Adicione o primeiro talhão desta fazenda',
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) => TalhaoListCard(
                          talhao: talhoes[i],
                          onTap: () => _abrirCronogramaTalhao(
                            context,
                            farmId: farmId,
                            clienteId: clienteId,
                            talhaoId: talhoes[i].id,
                          ),
                        ),
                        childCount: talhoes.length,
                      ),
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: LoadingSkeleton(),
                ),
                error: (_, __) => SliverToBoxAdapter(
                  child: ErrorStateWidget(
                    onRetry: () =>
                        ref.invalidate(talhoesNotifierProvider(farmId)),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xxl),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: LoadingSkeleton()),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Fazenda')),
        body: ErrorStateWidget(
          onRetry: () => ref.invalidate(fazendasNotifierProvider(clienteId)),
        ),
      ),
    );
  }
}

void _abrirCronogramaTalhao(
  BuildContext context, {
  required String farmId,
  required String clienteId,
  String? talhaoId,
}) {
  if (!context.mounted) return;
  context.push(
    AppRoutes.farmCronogramaSojaPath(
      clienteId,
      farmId,
      talhaoId: talhaoId,
    ),
  );
}

class _CronogramaFazendaEntryCard extends ConsumerWidget {
  const _CronogramaFazendaEntryCard({
    required this.clienteId,
    required this.farmId,
  });

  final String clienteId;
  final String farmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planoAsync = ref.watch(_planoAtivoFazendaProvider(farmId));

    final temPlano = planoAsync.valueOrNull != null;
    final subtitle = planoAsync.isLoading
        ? 'Carregando vínculo com o plano…'
        : temPlano
            ? 'Integrado ao plano ativo · ficha do talhão'
            : 'Modo avulso — sem plano ativo (calculadora)';

    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _abrirCronogramaTalhao(
          context,
          farmId: farmId,
          clienteId: clienteId,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: temPlano ? context.appBorder : AppColors.warning.withValues(alpha: 0.45),
            ),
          ),
          child: Row(
            children: [
              PhosphorIcon(
                temPlano
                    ? PhosphorIconsRegular.calendarDots
                    : PhosphorIconsRegular.calculator,
                size: 22,
                color: temPlano ? AppColors.primary : AppColors.warning,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temPlano
                          ? 'Cronograma Agrícola (Soja)'
                          : 'Cronograma avulso (Soja)',
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.appTextPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                        color: context.appTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              PhosphorIcon(
                PhosphorIconsRegular.caretRight,
                size: 18,
                color: context.appTextSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final _planoAtivoFazendaProvider =
    FutureProvider.family<PlanoEntity?, String>((ref, fazendaId) async {
  return ResolverPlanoAtivoFazendaUseCase(ref.read(plansRepoProvider))
      .call(fazendaId);
});

class _ResumoRow extends StatelessWidget {
  const _ResumoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: AppTypography.caption.copyWith(
            color: context.appTextSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.body.copyWith(color: context.appTextPrimary),
          ),
        ),
      ],
    );
  }
}
