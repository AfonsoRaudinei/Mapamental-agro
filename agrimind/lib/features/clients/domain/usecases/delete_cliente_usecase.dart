import '../repositories/clients_repository.dart';

class DeleteClienteUseCase {
  const DeleteClienteUseCase(this._repo);
  final ClientsRepository _repo;
  Future<void> call(String id) => _repo.delete(id);
}
