import '../../domain/entities/referencia_tecnica_entity.dart';
import '../../domain/repositories/references_repository.dart';
import '../datasources/references_local_datasource.dart';

class ReferencesRepositoryImpl implements ReferencesRepository {
  ReferencesRepositoryImpl(this._datasource);
  final ReferencesLocalDatasource _datasource;

  @override
  Future<List<ReferenciaTecnicaEntity>> getByCategoria(String categoria) =>
      _datasource.getByCategoria(categoria);

  @override
  Future<List<ReferenciaTecnicaEntity>> getByEstadio(
    String categoria,
    String estadio,
  ) =>
      _datasource.getByEstadio(categoria, estadio);

  @override
  Future<List<ReferenciaTecnicaEntity>> getCesb({String? estadio}) =>
      _datasource.getCesb(estadio: estadio);

  @override
  Future<void> seedIfEmpty() => _datasource.seedIfEmpty();
}
