import '../../../clients/domain/cronograma_soja/calcular_cronograma_soja.dart'
    show calcularCronogramaSoja, parametrosFromCronograma;
import '../../../clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../entities/programa_operacional_entity.dart';
import '../repositories/plans_repository.dart';
import '../talhao_safra/estadio_cronograma_metadata.dart';
import '../talhao_safra/operacional_linha_tempo_map.dart';
import '../talhao_safra/tipo_operacional.dart';
import 'gerar_subcards_fungicida_canvas_usecase.dart';
import 'sincronizar_cronograma_soja_plano_usecase.dart';

/// Sincroniza datas fenológicas + programas operacionais (dataFixa / porDae / recorrente).
class SincronizarProgramasOperacionaisTalhaoUseCase {
  const SincronizarProgramasOperacionaisTalhaoUseCase(this._plansRepository);

  final PlansRepository _plansRepository;

  Future<SincronizarProgramasOperacionaisResultado> call({
    required String planoId,
    required String talhaoId,
    required String talhaoNome,
    required CronogramaSojaParametros parametros,
  }) async {
    final linhasCronograma = calcularCronogramaSoja(parametros);
    final fenologicos = await SincronizarCronogramaSojaPlanoUseCase(
      _plansRepository,
    ).aplicarNoPlano(planoId: planoId, linhas: linhasCronograma);

    final linhas = calcularLinhaTempoSoja(
      dataPlantio: parametros.dataPlantio,
      parametros: parametrosFromCronograma(parametros),
    );

    var atualizados = 0;
    final now = DateTime.now();

    final programasAtualizados =
        await _plansRepository.listProgramasOperacionais(planoId);
    final doTalhaoAtualizado =
        programasAtualizados.where((p) => p.talhaoId == talhaoId).toList();

    for (final linha in linhas) {
      final spec = operacionalSpecParaLinha(linha.tipo);
      if (spec == null) continue;

      final existente = _programaSimples(doTalhaoAtualizado, spec.tipo);
      if (existente == null) continue;

      if (existente.estadioId != null) {
        final plano = await _plansRepository.getById(planoId);
        final estadio = plano?.estadios
            .where((e) => e.id == existente.estadioId)
            .firstOrNull;
        if (estadio != null) {
          final mudouData =
              !_sameDay(estadio.dataAplicacao, linha.data) &&
              !lerMetadataCronograma(estadio).dataSobrescritaManualmente;
          if (mudouData) {
            await _plansRepository.updateEstadio(
              aplicarDataCalculadaRespeitandoOverride(estadio, linha.data),
            );
            atualizados++;
          }
        }
      }
      await _plansRepository.upsertProgramaOperacional(
        existente.copyWith(
          regraCalculo: spec.regra,
          updatedAt: now,
        ),
      );
    }

    final fungicidas = await GerarSubcardsFungicidaCanvasUseCase(
      _plansRepository,
    ).call(
      planoId: planoId,
      talhaoId: talhaoId,
      talhaoNome: talhaoNome,
      parametros: parametros,
    );

    return SincronizarProgramasOperacionaisResultado(
      estadiosFenologicosAtualizados: fenologicos,
      operacionaisCriados: 0,
      operacionaisAtualizados: atualizados,
      fungicidasCriados: fungicidas.criados,
      fungicidasAtualizados: fungicidas.atualizados,
      fungicidasRemovidos: fungicidas.removidos,
    );
  }
}

class SincronizarProgramasOperacionaisResultado {
  const SincronizarProgramasOperacionaisResultado({
    required this.estadiosFenologicosAtualizados,
    required this.operacionaisCriados,
    required this.operacionaisAtualizados,
    required this.fungicidasCriados,
    required this.fungicidasAtualizados,
    required this.fungicidasRemovidos,
  });

  final int estadiosFenologicosAtualizados;
  final int operacionaisCriados;
  final int operacionaisAtualizados;
  final int fungicidasCriados;
  final int fungicidasAtualizados;
  final int fungicidasRemovidos;

  int get totalAlteracoes =>
      estadiosFenologicosAtualizados +
      operacionaisCriados +
      operacionaisAtualizados +
      fungicidasCriados +
      fungicidasAtualizados +
      fungicidasRemovidos;
}

ProgramaOperacionalEntity? _programaSimples(
  List<ProgramaOperacionalEntity> doTalhao,
  TipoOperacional tipo,
) {
  return doTalhao
      .where(
        (p) =>
            p.tipo == tipo &&
            !p.isAplicacaoFungicida &&
            !p.isProgramaFungicidaPai,
      )
      .firstOrNull;
}

bool _sameDay(DateTime? a, DateTime b) {
  if (a == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
