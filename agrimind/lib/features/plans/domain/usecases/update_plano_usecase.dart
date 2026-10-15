import '../entities/plano_entity.dart';
import '../repositories/plans_repository.dart';

/// Atualiza um Plano existente.
class UpdatePlanoUseCase {
  const UpdatePlanoUseCase(this._repository);

  final PlansRepository _repository;

  Future<PlanoEntity> call(PlanoEntity plano) => _repository.update(plano);
}
