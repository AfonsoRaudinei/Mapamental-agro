import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/references_provider.dart';
import '../widgets/estadio_chip_row.dart';
import '../widgets/referencia_card.dart';

/// Página de detalhe de uma categoria de referência técnica.
///
/// Recebe [categoriaKey] como string: 'doencas' | 'insetos' | 'nutricao' | 'fisiologia'.
class CategoriaDetailPage extends ConsumerStatefulWidget {
  const CategoriaDetailPage({super.key, required this.categoriaKey});

  final String categoriaKey;

  @override
  ConsumerState<CategoriaDetailPage> createState() =>
      _CategoriaDetailPageState();
}

class _CategoriaDetailPageState extends ConsumerState<CategoriaDetailPage> {
  String _estadioSelecionado = 'Todos';

  CategoriaReferencia get _catEnum {
    try {
      return CategoriaReferencia.values.firstWhere(
        (c) => c.name == widget.categoriaKey,
      );
    } catch (_) {
      return CategoriaReferencia.doencas;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cat = _catEnum;

    final async = _estadioSelecionado == 'Todos'
        ? ref.watch(referenciasByCategoriaProvider(widget.categoriaKey))
        : ref.watch(
            referenciasByEstadioProvider(
              categoria: widget.categoriaKey,
              estadio: _estadioSelecionado,
            ),
          );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(cat.label),
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

          // ── Lista de referências ──────────────────────────────────────
          async.when(
            data: (refs) {
              if (refs.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: PhosphorIconsRegular.bookOpen,
                    title: 'Nenhuma referência',
                    subtitle: _estadioSelecionado != 'Todos'
                        ? 'Sem dados para $_estadioSelecionado nesta categoria'
                        : 'Nenhuma informação disponível',
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => ReferenciaCard(
                    referencia: refs[i],
                    categoria: cat,
                  ),
                  childCount: refs.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: LoadingSkeleton(),
            ),
            error: (e, _) => SliverFillRemaining(
              child: ErrorStateWidget(
                onRetry: () {
                  if (_estadioSelecionado != 'Todos') {
                    ref.invalidate(
                      referenciasByEstadioProvider(
                        categoria: widget.categoriaKey,
                        estadio: _estadioSelecionado,
                      ),
                    );
                  } else {
                    ref.invalidate(
                      referenciasByCategoriaProvider(widget.categoriaKey),
                    );
                  }
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}
