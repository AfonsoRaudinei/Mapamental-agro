import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/produto_catalogo_entity.dart';

part 'catalog_provider.g.dart';

// ── Lista do catálogo ─────────────────────────────────────────────────────────

@riverpod
class CatalogNotifier extends _$CatalogNotifier {
  @override
  FutureOr<List<ProdutoCatalogoEntity>> build() async {
    await ref.read(catalogRepoProvider).seedIfEmpty();
    return ref.read(catalogRepoProvider).getAll();
  }

  Future<void> create(ProdutoCatalogoEntity p) async {
    await ref.read(catalogRepoProvider).create(p);
    ref.invalidateSelf();
  }

  Future<void> updateProduto(ProdutoCatalogoEntity p) async {
    await ref.read(catalogRepoProvider).update(p);
    ref.invalidateSelf();
  }

  Future<void> toggleAtivo(String id) async {
    await ref.read(catalogRepoProvider).toggleAtivo(id);
    ref.invalidateSelf();
  }
}

// ── Busca em tempo real ───────────────────────────────────────────────────────

@riverpod
Future<List<ProdutoCatalogoEntity>> searchProdutos(
  SearchProdutosRef ref,
  String query, {
  String? categoria,
}) async {
  if (query.length < 2) {
    return ref.read(catalogRepoProvider).getAll();
  }
  return ref.read(catalogRepoProvider).search(query, categoria: categoria);
}
