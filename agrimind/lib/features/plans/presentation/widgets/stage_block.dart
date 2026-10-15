import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../providers/stage_accordion_expanded_provider.dart';
import '../providers/stage_provider.dart';
import '../providers/stage_view_model_key.dart';
import 'stage_card.dart';

/// Conecta [stageProvider] + expansão efêmera ao [StageCard] (sem lógica de domínio).
class StageBlock extends ConsumerWidget {
  const StageBlock({
    super.key,
    required this.planoId,
    required this.estadio,
    required this.onAddProduto,
    required this.onDeleteProduto,
    required this.onEditProduto,
    this.buildProbe,
  });

  final String planoId;
  final EstadioEntity estadio;
  final VoidCallback onAddProduto;
  final Future<void> Function(String estadioId, String produtoId)
      onDeleteProduto;
  final void Function(EstadioEntity estadio, ProdutoAplicacaoEntity produto)
      onEditProduto;

  /// Apenas para testes de rebuild isolado.
  final VoidCallback? buildProbe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    buildProbe?.call();

    final key = StageViewModelKey(planoId: planoId, stageId: estadio.id);
    final viewModel = ref.watch(stageProvider(key));
    final isExpanded = ref.watch(stageAccordionExpandedProvider(estadio.id));

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: StageCard(
        viewModel: viewModel,
        isExpanded: isExpanded,
        onToggle: () => ref
            .read(stageAccordionExpandedProvider(estadio.id).notifier)
            .update((value) => !value),
        onAddProduct: onAddProduto,
        onEditProduct: (productId) {
          for (final produto in estadio.produtos) {
            if (produto.id == productId) {
              onEditProduto(estadio, produto);
              return;
            }
          }
        },
        onDeleteProduct: (productId) => onDeleteProduto(estadio.id, productId),
      ),
    );
  }
}
