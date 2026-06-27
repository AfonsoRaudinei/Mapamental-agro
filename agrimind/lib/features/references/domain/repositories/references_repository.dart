import '../entities/referencia_tecnica_entity.dart';

/// Contrato abstrato do repositório de Referências Técnicas.
abstract class ReferencesRepository {
  Future<List<ReferenciaTecnicaEntity>> getByCategoria(String categoria);
  Future<List<ReferenciaTecnicaEntity>> getByEstadio(
    String categoria,
    String estadio,
  );
  Future<List<ReferenciaTecnicaEntity>> getCesb({String? estadio});
  Future<void> seedIfEmpty();
}
