import '../entities/plano_entity.dart';
import '../repositories/plans_repository.dart';

/// Cria um novo Plano no repositório local.
class CreatePlanoUseCase {
  const CreatePlanoUseCase(this._repository);

  final PlansRepository _repository;

  Future<PlanoEntity> call(PlanoEntity plano) => _repository.create(plano);
}
