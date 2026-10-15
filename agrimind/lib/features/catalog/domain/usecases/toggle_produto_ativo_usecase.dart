import '../repositories/catalog_repository.dart';

class ToggleProdutoAtivoUseCase {
  const ToggleProdutoAtivoUseCase(this._repo);
  final CatalogRepository _repo;
  Future<void> call(String id) => _repo.toggleAtivo(id);
}
