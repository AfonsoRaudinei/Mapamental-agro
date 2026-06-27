import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';

part 'produto_aplicacao_provider.g.dart';

/// Provider dos produtos de um estádio específico.
/// Family: recebe o estadioId como parâmetro.
@riverpod
class ProdutoAplicacaoNotifier extends _$ProdutoAplicacaoNotifier {
  @override
  FutureOr<List<ProdutoAplicacaoEntity>> build(String estadioId) async {
    return ref.read(plansRepoProvider).getProdutosByEstadio(estadioId);
  }

  Future<void> refresh() => Future(() => ref.invalidateSelf());
}
