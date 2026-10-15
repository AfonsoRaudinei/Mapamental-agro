import '../entities/semente_talhao_entity.dart';
import '../repositories/plans_repository.dart';

class UpdateSementeTalhaoUseCase {
  const UpdateSementeTalhaoUseCase(this._repository);

  final PlansRepository _repository;

  Future<SementeTalhaoEntity> call(SementeTalhaoEntity entity) =>
      _repository.updateSementeTalhao(entity);
}
