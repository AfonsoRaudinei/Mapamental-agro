import '../repositories/plans_repository.dart';

/// Remove um Plano por ID.
class DeletePlanoUseCase {
  const DeletePlanoUseCase(this._repository);

  final PlansRepository _repository;

  Future<void> call(String planoId) => _repository.delete(planoId);
}
