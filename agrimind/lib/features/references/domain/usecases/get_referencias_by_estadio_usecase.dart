import '../entities/referencia_tecnica_entity.dart';
import '../repositories/references_repository.dart';

class GetReferenciasByEstadioUseCase {
  const GetReferenciasByEstadioUseCase(this._repo);
  final ReferencesRepository _repo;
  Future<List<ReferenciaTecnicaEntity>> call(
    String categoria,
    String estadio,
  ) =>
      _repo.getByEstadio(categoria, estadio);
}
