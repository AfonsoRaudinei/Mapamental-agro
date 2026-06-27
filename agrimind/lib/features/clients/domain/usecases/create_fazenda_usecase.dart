import '../entities/fazenda_entity.dart';
import '../repositories/clients_repository.dart';

class CreateFazendaUseCase {
  const CreateFazendaUseCase(this._repo);
  final ClientsRepository _repo;
  Future<FazendaEntity> call(FazendaEntity f) => _repo.createFazenda(f);
}
