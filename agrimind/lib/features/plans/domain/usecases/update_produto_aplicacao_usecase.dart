import '../entities/produto_aplicacao_entity.dart';
import '../repositories/plans_repository.dart';

/// Atualiza um ProdutoAplicacao existente (dose, área, override, etc.).
class UpdateProdutoAplicacaoUseCase {
  const UpdateProdutoAplicacaoUseCase(this._repository);

  final PlansRepository _repository;

  Future<ProdutoAplicacaoEntity> call(ProdutoAplicacaoEntity produto) =>
      _repository.updateProduto(produto);
}
