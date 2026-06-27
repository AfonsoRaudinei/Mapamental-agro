import '../entities/talhao_entity.dart';
import '../repositories/clients_repository.dart';

class GetTalhoesByFazendaUseCase {
  const GetTalhoesByFazendaUseCase(this._repo);
  final ClientsRepository _repo;
  Future<List<TalhaoEntity>> call(String fazendaId) =>
      _repo.getTalhoes(fazendaId);
}
