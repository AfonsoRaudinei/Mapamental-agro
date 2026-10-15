import '../entities/cliente_entity.dart';
import '../repositories/clients_repository.dart';

class CreateClienteUseCase {
  const CreateClienteUseCase(this._repo);
  final ClientsRepository _repo;
  Future<ClienteEntity> call(ClienteEntity c) => _repo.create(c);
}
