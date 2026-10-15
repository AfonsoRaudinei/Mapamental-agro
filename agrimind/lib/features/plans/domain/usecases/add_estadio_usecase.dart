import '../entities/estadio_entity.dart';
import '../repositories/plans_repository.dart';

/// Adiciona um Estádio a um Plano existente.
class AddEstadioUseCase {
  const AddEstadioUseCase(this._repository);

  final PlansRepository _repository;

  Future<EstadioEntity> call(String planoId, EstadioEntity estadio) =>
      _repository.addEstadio(planoId, estadio);
}
