import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/theme/plan_stage_card_tokens.dart';
import '../../../../core/widgets/ios_swipe_delete.dart';
import '../models/product_view_model.dart';
import '../models/stage_view_model.dart';
import 'product_tile.dart';

/// Accordion de estádio fenológico no canvas do plano.
class StageCard extends StatelessWidget {
  const StageCard({
    super.key,
    required this.viewModel,
    required this.isExpanded,
    required this.onToggle,
    required this.onAddProduct,
    required this.onEditProduct,
    required this.onDeleteProduct,
  });

  final StageViewModel viewModel;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onAddProduct;
  final ValueChanged<String> onEditProduct;
  final ValueChanged<String> onDeleteProduct;

  static const Duration _expandDuration = Duration(milliseconds: 220);
  static const Duration _chevronDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PlanStageCardTokens.card(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PlanStageCardTokens.border(context)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StageHeader(
            viewModel: viewModel,
            isExpanded: isExpanded,
            onTap: onToggle,
          ),
          AnimatedSize(
            duration: _expandDuration,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isExpanded
                ? _StageBody(
                    products: viewModel.products,
                    onAddProduct: onAddProduct,
                    onEditProduct: onEditProduct,
                    onDeleteProduct: onDeleteProduct,
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _StageHeader extends StatelessWidget {
  const _StageHeader({
    required this.viewModel,
    required this.isExpanded,
    required this.onTap,
  });

  final StageViewModel viewModel;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Row(
            children: [
              _StageAvatar(code: viewModel.stageCode),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.title,
                      style: AppTypography.h3.copyWith(
                        fontSize: 17,
                        color: PlanStageCardTokens.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      viewModel.countLabel,
                      style: AppTypography.caption.copyWith(
                        color: PlanStageCardTokens.textMuted(context),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: StageCard._chevronDuration,
                curve: Curves.easeInOut,
                child: PhosphorIcon(
                  PhosphorIconsRegular.caretDown,
                  size: 18,
                  color: PlanStageCardTokens.textMuted(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StageAvatar extends StatelessWidget {
  const _StageAvatar({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: PlanStageCardTokens.separator(context),
        shape: BoxShape.circle,
      ),
      child: Text(
        code,
        style: AppTypography.caption.copyWith(
          fontWeight: FontWeight.w800,
          color: PlanStageCardTokens.textPrimary(context),
        ),
      ),
    );
  }
}

class _StageBody extends StatelessWidget {
  const _StageBody({
    required this.products,
    required this.onAddProduct,
    required this.onEditProduct,
    required this.onDeleteProduct,
  });

  final List<ProductViewModel> products;
  final VoidCallback onAddProduct;
  final ValueChanged<String> onEditProduct;
  final ValueChanged<String> onDeleteProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: PlanStageCardTokens.separator(context),
        ),
        if (products.isEmpty)
          const SizedBox.shrink()
        else
          for (var i = 0; i < products.length; i++) ...[
            IosSwipeDelete(
              dismissKey: ValueKey(products[i].id),
              itemName: products[i].name,
              onDelete: () => onDeleteProduct(products[i].id),
              child: ProductTile(
                product: products[i],
                onTap: () => onEditProduct(products[i].id),
              ),
            ),
            if (i < products.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: PlanStageCardTokens.separator(context),
              ),
          ],
        _AddProductRow(onTap: onAddProduct),
      ],
    );
  }
}

class _AddProductRow extends StatelessWidget {
  const _AddProductRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              const PhosphorIcon(
                PhosphorIconsRegular.plus,
                size: 14,
                color: PlanStageCardTokens.accent,
              ),
              const SizedBox(width: 6),
              Text(
                'Adicionar produto',
                style: AppTypography.caption.copyWith(
                  color: PlanStageCardTokens.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
