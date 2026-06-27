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
import '../providers/catalog_provider.dart';
import '../widgets/produto_list_tile.dart';
import '../../../../core/utils/extensions.dart';

/// Catálogo de Produtos.
class CatalogListPage extends ConsumerStatefulWidget {
  const CatalogListPage({super.key});

  @override
  ConsumerState<CatalogListPage> createState() => _CatalogListPageState();
}

class _CatalogListPageState extends ConsumerState<CatalogListPage> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _categoriaFiltro;
  bool _mostrarInativos = false;

  static const _categorias = ['Todos', ...AppConstants.categoriasProduto];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = _query.length >= 2
        ? ref.watch(searchProdutosProvider(_query, categoria: _categoriaFiltro))
        : ref.watch(catalogNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Catálogo'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),
            border: Border.all(color: Colors.transparent),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.push('/catalog/new'),
              child: const PhosphorIcon(
                PhosphorIconsRegular.plus,
                size: 22,
                color: AppColors.primary,
              ),
            ),
          ),

          // ── Barra de busca ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Buscar produto...',
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
          ),

          // ── Filtro por categoria ──────────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: _categorias.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.xs),
                itemBuilder: (ctx, i) {
                  final cat = _categorias[i];
                  final isSelected =
                      (cat == 'Todos' && _categoriaFiltro == null) ||
                          cat == _categoriaFiltro;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _categoriaFiltro = cat == 'Todos' ? null : cat;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.primary : context.appSurface,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color:
                              isSelected ? AppColors.primary : context.appBorder,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: AppTypography.label.copyWith(
                          color: isSelected
                              ? Colors.white
                              : context.appTextSecondary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          // ── Toggle inativos ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 4,
              ),
              child: Row(
                children: [
                  CupertinoSwitch(
                    value: _mostrarInativos,
                    onChanged: (v) => setState(() => _mostrarInativos = v),
                    activeTrackColor: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Mostrar inativos',
                    style: AppTypography.caption
                        .copyWith(color: context.appTextSecondary),
                  ),
                ],
              ),
            ),
          ),

          // ── Lista ─────────────────────────────────────────────────────
          catalogAsync.when(
            data: (produtos) {
              final filtrados = produtos
                  .where((p) =>
                      (_mostrarInativos || p.ativo) &&
                      (_categoriaFiltro == null ||
                          p.categoria == _categoriaFiltro))
                  .toList();

              if (filtrados.isEmpty) {
                return const SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: PhosphorIconsRegular.package,
                    title: 'Nenhum produto encontrado',
                    subtitle: 'Ajuste os filtros ou cadastre um novo produto',
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => ProdutoListTile(
                    produto: filtrados[i],
                    onTap: () => context.push(
                      '/catalog/${filtrados[i].id}/edit',
                    ),
                    onEdit: () => context.push(
                      '/catalog/${filtrados[i].id}/edit',
                    ),
                    onToggleAtivo: () => ref
                        .read(catalogNotifierProvider.notifier)
                        .toggleAtivo(filtrados[i].id),
                  ),
                  childCount: filtrados.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: LoadingSkeleton(),
            ),
            error: (e, _) => SliverFillRemaining(
              child: ErrorStateWidget(
                onRetry: () => ref.invalidate(catalogNotifierProvider),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}
