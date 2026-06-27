import '../entities/produto_aplicacao_entity.dart';
import '../repositories/plans_repository.dart';

/// Adiciona um ProdutoAplicacao a um Estádio.
class AddProdutoAplicacaoUseCase {
  const AddProdutoAplicacaoUseCase(this._repository);

  final PlansRepository _repository;

  Future<ProdutoAplicacaoEntity> call(
    String estadioId,
    ProdutoAplicacaoEntity produto,
  ) =>
      _repository.addProduto(estadioId, produto);
}
