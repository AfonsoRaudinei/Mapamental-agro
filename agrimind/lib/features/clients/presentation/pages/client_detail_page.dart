import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/clients_provider.dart';
import '../widgets/farm_card.dart';
import '../../../../core/utils/extensions.dart';

/// Detalhe do Cliente — fazendas e informações gerais.
class ClientDetailPage extends ConsumerWidget {
  const ClientDetailPage({super.key, required this.clienteId});

  final String clienteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clienteAsync = ref.watch(clienteDetailProvider(clienteId));

    return clienteAsync.when(
      data: (cliente) {
        if (cliente == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cliente')),
            body: const Center(child: Text('Cliente não encontrado.')),
          );
        }

        final fazendasAsync = ref.watch(fazendasNotifierProvider(clienteId));

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(cliente.nome),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),
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
                  onPressed: () => context.push('/clients/$clienteId/edit'),
                  child: const Text(
                    'Editar',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),

              // ── Info do cliente ───────────────────────────────────────────
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
                    children: [
                      if (cliente.telefone != null)
                        _InfoRow(
                          icon: PhosphorIconsRegular.phone,
                          label: cliente.telefone!,
                        ),
                      if (cliente.email != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        _InfoRow(
                          icon: PhosphorIconsRegular.envelope,
                          label: cliente.email!,
                        ),
                      ],
                      if (cliente.cidade != null || cliente.uf != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        _InfoRow(
                          icon: PhosphorIconsRegular.mapPin,
                          label: [
                            if (cliente.cidade != null) cliente.cidade!,
                            if (cliente.uf != null) cliente.uf!,
                          ].join(' — '),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // ── Header fazendas ───────────────────────────────────────────
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
                        'FAZENDAS',
                        style: AppTypography.label.copyWith(
                          color: context.appTextSecondary,
                          letterSpacing: 0.6,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.push(
                          '/clients/$clienteId/farms/new',
                        ),
                        child: const Row(
                          children: [
                            PhosphorIcon(
                              PhosphorIconsRegular.plus,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Nova fazenda',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Lista de fazendas ─────────────────────────────────────────
              fazendasAsync.when(
                data: (fazendas) {
                  if (fazendas.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                        child: EmptyStateWidget(
                          icon: PhosphorIconsRegular.barn,
                          title: 'Nenhuma fazenda',
                          subtitle: 'Adicione a primeira fazenda deste cliente',
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
                        (ctx, i) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: FarmCard(
                            fazenda: fazendas[i],
                            onTap: () => context.push(
                              '/clients/$clienteId/farms/${fazendas[i].id}/edit',
                            ),
                          ),
                        ),
                        childCount: fazendas.length,
                      ),
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: LoadingSkeleton(),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: ErrorStateWidget(
                    onRetry: () =>
                        ref.invalidate(fazendasNotifierProvider(clienteId)),
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
        appBar: AppBar(title: const Text('Cliente')),
        body: ErrorStateWidget(
          onRetry: () => ref.invalidate(clienteDetailProvider(clienteId)),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PhosphorIcon(icon, size: 16, color: context.appTextSecondary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: AppTypography.body.copyWith(color: context.appTextPrimary),
          ),
        ),
      ],
    );
  }
}
