import '../entities/cliente_entity.dart';
import '../repositories/clients_repository.dart';

class UpdateClienteUseCase {
  const UpdateClienteUseCase(this._repo);
  final ClientsRepository _repo;
  Future<ClienteEntity> call(ClienteEntity c) => _repo.update(c);
}
