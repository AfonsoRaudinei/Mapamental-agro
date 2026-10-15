import '../entities/estadio_entity.dart';
import '../entities/operacional_estadio_config.dart';
import '../repositories/plans_repository.dart';
import '../talhao_safra/fungicida_aplicacao_label.dart';
import '../talhao_safra/roteiro_plano_template.dart';

/// Numera aplicações de fungicida no plano (1ª, 2ª…) no próprio card do estádio/OP.
/// Remove sub-cards OP legados criados como filhos separados.
class SincronizarSubcardsFungicidaEstadioUseCase {
  const SincronizarSubcardsFungicidaEstadioUseCase(this._repository);

  final PlansRepository _repository;

  Future<void> call({required String planoId}) async {
    var plano = await _repository.getById(planoId);
    if (plano == null) return;

    for (final e in plano.estadios) {
      if (_ehSubcardLegado(e)) {
        await _repository.removeEstadio(e.id);
      }
    }

    plano = await _repository.getById(planoId);
    if (plano == null) return;

    final fungicidaCards = templatesFungicidaRoteiro(plano.estadios);

    for (var i = 0; i < fungicidaCards.length; i++) {
      final indice = i + 1;
      final e = fungicidaCards[i];
      final cfg = (e.operacionalConfig ?? const OperacionalEstadioConfig())
          .copyWith(
        aplicacaoIndice: indice,
        fungicidaPaiEstadioId: null,
      );
      final label = labelAplicacaoFungicida(indice);
      if (e.label != label ||
          e.operacionalConfig?.aplicacaoIndice != indice ||
          e.operacionalConfig?.fungicidaPaiEstadioId != null) {
        await _repository.updateEstadio(
          e.copyWith(label: label, operacionalConfig: cfg),
        );
      }
    }
  }

  bool _ehSubcardLegado(EstadioEntity e) {
    if (e.isSubcardFungicida) return true;
    final paiId = e.operacionalConfig?.fungicidaPaiEstadioId;
    return paiId != null && paiId.isNotEmpty;
  }
}
