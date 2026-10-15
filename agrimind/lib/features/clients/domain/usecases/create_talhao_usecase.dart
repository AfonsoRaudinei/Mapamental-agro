import '../entities/talhao_entity.dart';
import '../repositories/clients_repository.dart';

class CreateTalhaoUseCase {
  const CreateTalhaoUseCase(this._repo);
  final ClientsRepository _repo;
  Future<TalhaoEntity> call(TalhaoEntity t) => _repo.createTalhao(t);
}
