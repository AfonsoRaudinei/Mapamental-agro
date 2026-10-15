import '../entities/semente_talhao_entity.dart';
import '../repositories/plans_repository.dart';

class GetSementesByPlanoUseCase {
  const GetSementesByPlanoUseCase(this._repository);

  final PlansRepository _repository;

  Future<List<SementeTalhaoEntity>> call(String planoId) =>
      _repository.getSementesByPlano(planoId);
}
