import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dark_surface_card.dart';
import '../../data/plan_repository.dart';
import '../../domain/plan_models.dart';

class StageCard extends ConsumerStatefulWidget {
  const StageCard({
    super.key,
    required this.stage,
    required this.products,
  });

  final StageModel stage;
  final List<ProductModel> products;

  @override
  ConsumerState<StageCard> createState() => _StageCardState();
}

class _StageCardState extends ConsumerState<StageCard> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.stage.name);
  }

  @override
  void didUpdateWidget(covariant StageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stage.id != widget.stage.id ||
        (oldWidget.stage.name != widget.stage.name &&
            _nameController.text == oldWidget.stage.name)) {
      _nameController.text = widget.stage.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stage = widget.stage;
    final products = widget.products;
    final productHint = products.isEmpty
        ? 'Nenhum produto — toque para adicionar'
        : products.map((p) => p.name).join(', ');

    return DarkSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            onTap: () =>
                ref.read(planStateProvider.notifier).toggleExpanded(stage.id),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StageBadge(code: stage.code),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.displayTitle,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.onSurface,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          productHint,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.onSurfaceMuted,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    icon: Icon(
                      stage.isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.onSurfaceMuted,
                    ),
                    onPressed: () => ref
                        .read(planStateProvider.notifier)
                        .toggleExpanded(stage.id),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    icon: const Icon(Icons.close_rounded, size: 20),
                    color: AppColors.onSurfaceMuted,
                    onPressed: () => ref
                        .read(planStateProvider.notifier)
                        .removeStage(stage.id),
                  ),
                ],
              ),
            ),
          ),
          if (stage.isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nome do estádio',
                    style: TextStyle(
                      color: AppColors.onSurfaceMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    key: ValueKey('stage-name-${stage.id}'),
                    controller: _nameController,
                    style: const TextStyle(color: AppColors.onSurface),
                    decoration: InputDecoration(
                      hintText: 'Ex: ${stage.name}',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.check_rounded, color: AppColors.primary),
                        onPressed: () => ref
                            .read(planStateProvider.notifier)
                            .renameStage(stage, _nameController.text.trim()),
                      ),
                    ),
                    onSubmitted: (value) => ref
                        .read(planStateProvider.notifier)
                        .renameStage(stage, value.trim()),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _StageBadge(code: stage.code, small: true),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                products.isEmpty
                                    ? 'Nenhum produto'
                                    : '${products.length} produto(s)',
                                style: const TextStyle(color: AppColors.onSurfaceMuted),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextButton.icon(
                          onPressed: () => _addProduct(context),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Adicionar produto'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        if (products.isNotEmpty)
                          ...products.map(
                            (p) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                p.name,
                                style: const TextStyle(color: AppColors.onSurface),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, size: 18),
                                color: AppColors.onSurfaceMuted,
                                onPressed: () => ref
                                    .read(planRepositoryProvider)
                                    .removeProduct(p.id)
                                    .then((_) => ref
                                        .read(planStateProvider.notifier)
                                        .refresh()),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _addProduct(BuildContext context) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: const Text('Adicionar produto'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nome do produto'),
          style: const TextStyle(color: AppColors.onSurface),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salvar')),
        ],
      ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      await ref
          .read(planStateProvider.notifier)
          .addProduct(widget.stage.id, ctrl.text.trim());
    }
    ctrl.dispose();
  }
}

class _StageBadge extends StatelessWidget {
  const _StageBadge({required this.code, this.small = false});

  final String code;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 28.0 : 36.0;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.onSurface,
        shape: BoxShape.circle,
      ),
      child: Text(
        code,
        style: TextStyle(
          color: AppColors.background,
          fontSize: small ? 11 : 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
