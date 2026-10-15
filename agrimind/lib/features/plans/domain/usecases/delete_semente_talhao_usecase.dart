import '../repositories/plans_repository.dart';

class DeleteSementeTalhaoUseCase {
  const DeleteSementeTalhaoUseCase(this._repository);

  final PlansRepository _repository;

  Future<void> call(String sementeId) =>
      _repository.deleteSementeTalhao(sementeId);
}
