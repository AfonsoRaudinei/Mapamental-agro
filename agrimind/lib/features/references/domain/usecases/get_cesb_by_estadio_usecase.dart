import '../entities/referencia_tecnica_entity.dart';
import '../repositories/references_repository.dart';

class GetCesbByEstadioUseCase {
  const GetCesbByEstadioUseCase(this._repo);
  final ReferencesRepository _repo;
  Future<List<ReferenciaTecnicaEntity>> call({String? estadio}) =>
      _repo.getCesb(estadio: estadio);
}
