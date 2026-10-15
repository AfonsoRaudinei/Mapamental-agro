import '../../../clients/domain/cronograma_soja/calcular_cronograma_soja.dart'
    show parametrosFromCronograma;
import '../../../clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../repositories/plans_repository.dart';
import '../talhao_safra/estadio_cronograma_metadata.dart';
/// Atualiza datas dos sub-cards de fungicida já instanciados no talhão.
class GerarSubcardsFungicidaCanvasUseCase {
  const GerarSubcardsFungicidaCanvasUseCase(this._plansRepository);

  final PlansRepository _plansRepository;

  Future<GerarSubcardsFungicidaResultado> call({
    required String planoId,
    required String talhaoId,
    required String talhaoNome,
    required CronogramaSojaParametros parametros,
  }) async {
    final plano = await _plansRepository.getById(planoId);
    if (plano == null) {
      return const GerarSubcardsFungicidaResultado(
        criados: 0,
        atualizados: 0,
        removidos: 0,
      );
    }

    final linhas = calcularLinhaTempoSoja(
      dataPlantio: parametros.dataPlantio,
      parametros: parametrosFromCronograma(parametros),
    ).where((l) => l.tipo == LinhaTempoSojaTipo.fungicida).toList();

    final todosProgramas = await _plansRepository.listProgramasOperacionais(
      planoId,
    );
    final doTalhao = todosProgramas
        .where((p) => p.talhaoId == talhaoId)
        .toList();

    final pai = doTalhao.where((p) => p.isProgramaFungicidaPai).firstOrNull;
    final now = DateTime.now();
    if (pai == null) {
      return const GerarSubcardsFungicidaResultado(
        criados: 0,
        atualizados: 0,
        removidos: 0,
      );
    }

    final filhosExistentes = doTalhao
        .where((p) => p.programaPaiId == pai.id)
        .toList()
      ..sort((a, b) => (a.aplicacaoIndice ?? 0).compareTo(b.aplicacaoIndice ?? 0));

    var criados = 0;
    var atualizados = 0;
    var removidos = 0;

    for (final linha in linhas) {
      final indice = linha.fungicidaIndice ?? 1;
      final filho = filhosExistentes
          .where((f) => f.aplicacaoIndice == indice)
          .firstOrNull;

      if (filho == null) continue;

      if (filho.estadioId != null) {
        final planoAtualizado = await _plansRepository.getById(planoId);
        final estadioAtual = planoAtualizado?.estadios
            .where((e) => e.id == filho.estadioId)
            .firstOrNull;
        if (estadioAtual != null) {
          final precisaLabel =
              estadioAtual.label != _labelFungicida(linha.etapa, talhaoNome);
          final meta = lerMetadataCronograma(estadioAtual);
          final precisaData = !_sameDay(estadioAtual.dataAplicacao, linha.data) &&
              !meta.dataSobrescritaManualmente;
          if (precisaLabel || precisaData) {
            var atualizado = estadioAtual.copyWith(
              label: _labelFungicida(linha.etapa, talhaoNome),
            );
            if (precisaData) {
              atualizado = aplicarDataCalculadaRespeitandoOverride(
                atualizado,
                linha.data,
              );
            }
            await _plansRepository.updateEstadio(atualizado);
            atualizados++;
          }
        }
      }
      await _plansRepository.upsertProgramaOperacional(
        filho.copyWith(updatedAt: now),
      );
    }

    final indicesAtivos =
        linhas.map((l) => l.fungicidaIndice ?? 1).toSet();
    for (final filho in filhosExistentes) {
      final idx = filho.aplicacaoIndice;
      if (idx == null || indicesAtivos.contains(idx)) continue;
      if (filho.estadioId != null) {
        await _plansRepository.removeEstadio(filho.estadioId!);
      }
      await _plansRepository.deleteProgramaOperacional(filho.id);
      removidos++;
    }

    return GerarSubcardsFungicidaResultado(
      criados: criados,
      atualizados: atualizados,
      removidos: removidos,
    );
  }
}

class GerarSubcardsFungicidaResultado {
  const GerarSubcardsFungicidaResultado({
    required this.criados,
    required this.atualizados,
    required this.removidos,
  });

  final int criados;
  final int atualizados;
  final int removidos;

  int get totalAlteracoes => criados + atualizados + removidos;
}

String _labelFungicida(String etapa, String talhaoNome) {
  return 'Fungicida — $etapa · $talhaoNome';
}

bool _sameDay(DateTime? a, DateTime b) {
  if (a == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
