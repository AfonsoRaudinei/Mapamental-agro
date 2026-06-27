import '../repositories/plans_repository.dart';

/// Remove um Estádio de um Plano.
class RemoveEstadioUseCase {
  const RemoveEstadioUseCase(this._repository);

  final PlansRepository _repository;

  Future<void> call(String estadioId) => _repository.removeEstadio(estadioId);
}
