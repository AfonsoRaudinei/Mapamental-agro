import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../data/plan_repository.dart';
import '../domain/plan_models.dart';
import 'widgets/client_selector_card.dart';
import 'widgets/stage_card.dart';

class PlanScreen extends ConsumerWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(planStateProvider);

    return planAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (e, _) => Center(
        child: Text('Erro: $e', style: const TextStyle(color: AppColors.error)),
      ),
      data: (planState) {
        final client = ref.watch(selectedClientProvider)!;
        return ColoredBox(
          color: AppColors.background,
          child: Stack(
          children: [
            RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => ref.read(planStateProvider.notifier).refresh(),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                children: [
                  FutureBuilder<List<ClientModel>>(
                    future: ref.read(planRepositoryProvider).getClients(),
                    builder: (context, snapshot) {
                      final clients = snapshot.data ?? [client];
                      return ClientSelectorCard(
                        client: client,
                        clients: clients,
                        onChanged: (c) {
                          ref.read(selectedClientProvider.notifier).state = c;
                          ref.invalidate(planStateProvider);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ...planState.stages.map(
                    (stage) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StageCard(
                        stage: stage,
                        products: planState.productsByStage[stage.id] ?? [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 16,
              child: FilledButton.icon(
                onPressed: () => _addStage(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Adicionar estádio'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  minimumSize: const Size.fromHeight(52),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
        );
      },
    );
  }

  Future<void> _addStage(BuildContext context, WidgetRef ref) async {
    final codeCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: const Text('Novo estádio', style: TextStyle(color: AppColors.onSurface)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeCtrl,
              decoration: const InputDecoration(labelText: 'Código (ex: V3)'),
              style: const TextStyle(color: AppColors.onSurface),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nome do estádio'),
              style: const TextStyle(color: AppColors.onSurface),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Adicionar')),
        ],
      ),
    );
    if (ok == true && codeCtrl.text.isNotEmpty && nameCtrl.text.isNotEmpty) {
      await ref
          .read(planStateProvider.notifier)
          .addStage(codeCtrl.text.trim(), nameCtrl.text.trim());
    }
    codeCtrl.dispose();
    nameCtrl.dispose();
  }
}
