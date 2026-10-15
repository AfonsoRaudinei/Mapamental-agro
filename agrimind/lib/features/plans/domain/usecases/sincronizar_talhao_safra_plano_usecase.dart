import '../../../clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../repositories/plans_repository.dart';
import 'sincronizar_programas_operacionais_talhao_usecase.dart';

/// Persiste TalhaoSafra e propaga datas/cards ao plano (respeitando overrides).
class SincronizarTalhaoSafraPlanoUseCase {
  const SincronizarTalhaoSafraPlanoUseCase(this._plansRepository);

  final PlansRepository _plansRepository;

  Future<SincronizarProgramasOperacionaisResultado?> call({
    required String planoId,
    required String talhaoId,
    required String talhaoNome,
    required CronogramaSojaParametros parametros,
  }) async {
    if (!parametros.plantioDefinido) return null;
    return SincronizarProgramasOperacionaisTalhaoUseCase(_plansRepository).call(
      planoId: planoId,
      talhaoId: talhaoId,
      talhaoNome: talhaoNome,
      parametros: parametros,
    );
  }
}
