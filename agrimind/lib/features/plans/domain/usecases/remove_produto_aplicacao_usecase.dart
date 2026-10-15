import '../repositories/plans_repository.dart';

/// Remove um ProdutoAplicacao de um Estádio.
class RemoveProdutoAplicacaoUseCase {
  const RemoveProdutoAplicacaoUseCase(this._repository);

  final PlansRepository _repository;

  Future<void> call(String produtoId) => _repository.removeProduto(produtoId);
}
