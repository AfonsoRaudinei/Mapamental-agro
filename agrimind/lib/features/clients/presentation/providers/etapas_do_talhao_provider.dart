import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import '../../domain/talhao_etapas/montar_etapas_do_talhao_usecase.dart';

/// Etapas do talhão (data do Cronograma + produtos do Plano).
///
/// A chave inclui os [CronogramaSojaParametros] em edição: ao mudar plantio ou
/// regulagem o provider recalcula datas e totais sem esperar o save.
final etapasDoTalhaoProvider = FutureProvider.autoDispose.family<
    List<EtapaTalhao>,
    ({String planoId, String talhaoId, CronogramaSojaParametros parametros})>(
  (ref, key) => MontarEtapasDoTalhaoUseCase(
    plansRepository: ref.read(plansRepoProvider),
    clientsRepository: ref.read(clientsRepoProvider),
  ).call(
    planoId: key.planoId,
    talhaoId: key.talhaoId,
    parametros: key.parametros,
  ),
);
