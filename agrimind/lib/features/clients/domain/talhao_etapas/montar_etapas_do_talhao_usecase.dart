import '../../../plans/domain/entities/estadio_entity.dart';
import '../../../plans/domain/entities/plano_entity.dart';
import '../../../plans/domain/entities/semente_talhao_entity.dart';
import '../../../plans/domain/repositories/plans_repository.dart';
import '../../../plans/domain/talhao_safra/roteiro_plano_template.dart';
import '../../../plans/domain/talhao_safra/tipo_operacional.dart';
import '../../../plans/domain/usecases/calcular_sementes_talhao.dart';
import '../cronograma_soja/calcular_cronograma_soja.dart';
import '../cronograma_soja/cronograma_soja_linha.dart';
import '../cronograma_soja/cronograma_soja_parametros.dart';
import '../repositories/clients_repository.dart';
import 'etapa_talhao.dart';
import 'produto_aplicado.dart';

/// Estádios do Plano que recebem as 1ª–4ª aplicações de fungicida.
const _codigosFungicida = ['V7', 'R3', 'R5.1', 'R5.5'];

/// Une datas do Cronograma e produtos do Plano para um talhão.
///
/// O Cronograma só calcula datas; este use case é quem conhece produto.
class MontarEtapasDoTalhaoUseCase {
  const MontarEtapasDoTalhaoUseCase({
    required PlansRepository plansRepository,
    required ClientsRepository clientsRepository,
  })  : _plans = plansRepository,
        _clients = clientsRepository;

  final PlansRepository _plans;
  final ClientsRepository _clients;

  Future<List<EtapaTalhao>> call({
    required String planoId,
    required String talhaoId,

    /// Parâmetros em edição (ainda não persistidos); senão lê os salvos.
    CronogramaSojaParametros? parametros,
  }) async {
    final plano = await _plans.getById(planoId);
    if (plano == null) return const [];

    final params = parametros ??
        (await _clients.getCronogramasSojaByPlano(planoId))
            .where((p) => p.talhaoId == talhaoId)
            .firstOrNull;
    if (params == null || !params.plantioDefinido) return const [];

    final fazendaId = plano.fazendaId;
    if (fazendaId == null) return const [];
    final talhao = (await _clients.getTalhoes(fazendaId))
        .where((t) => t.id == talhaoId)
        .firstOrNull;
    if (talhao == null) return const [];

    final sementes = await _plans.getSementesByPlano(planoId);
    return montarEtapasDoTalhao(
      plano: plano,
      parametros: params,
      talhaoId: talhaoId,
      areaTalhaoHa: talhao.areaHa,
      sementes: sementes,
    );
  }
}

/// Núcleo puro (testável): datas via [calcularCronogramaSoja], produtos do plano.
List<EtapaTalhao> montarEtapasDoTalhao({
  required PlanoEntity plano,
  required CronogramaSojaParametros parametros,
  required String talhaoId,
  required double areaTalhaoHa,
  List<SementeTalhaoEntity> sementes = const [],
}) {
  final estadios = plano.estadios
      .where((e) => !estadioEhInstanciaTalhao(e) && !e.isSubcardFungicida)
      .toList()
    ..sort((a, b) => a.ordem.compareTo(b.ordem));

  return calcularCronogramaSoja(parametros).map((linha) {
    final produtos = linha.tipo == CronogramaSojaLinhaTipo.plantio
        ? _produtosSementes(sementes, talhaoId, areaTalhaoHa)
        : _produtosDoEstadio(
            _resolverEstadio(estadios, linha),
            areaTalhaoHa,
          );
    return EtapaTalhao(linha: linha, produtosVinculados: produtos);
  }).toList();
}

List<ProdutoAplicado> _produtosSementes(
  List<SementeTalhaoEntity> sementes,
  String talhaoId,
  double areaHa,
) {
  // Sementes já são cadastradas por talhão no plano: não passam pela regra
  // dose × área de produto, só exibem o que o card define.
  return sementes.where((s) => s.talhaoId == talhaoId).map((s) {
    final calc = calcularSementesTalhao(
      populacaoSementesPorHa: s.populacaoSementesPorHa,
      sementesPorEmbalagem: s.sementesPorEmbalagem,
      areaTalhaoHa: areaHa,
      espacamentoPlantioCm: s.espacamentoPlantioCm,
    );
    return ProdutoAplicado(
      produtoId: s.id,
      nome: s.cultivar,
      dosePorHa: s.populacaoSementesPorHa,
      unidade: 'sem/ha',
      totalCalculado: calc.totalSementes,
      unidadeTotal: 'sem',
      detalhe: '${calc.embalagensNecessarias} embalagens',
    );
  }).toList();
}

List<ProdutoAplicado> _produtosDoEstadio(EstadioEntity? estadio, double areaHa) {
  if (estadio == null) return const [];
  final produtos = [...estadio.produtos]
    ..sort((a, b) => a.ordem.compareTo(b.ordem));
  return produtos
      .map(
        (p) => ProdutoAplicado(
          produtoId: p.id,
          nome: p.produtoNome,
          dosePorHa: p.dose,
          unidade: p.doseUnidade,
          totalCalculado: p.dose * areaHa,
        ),
      )
      .toList();
}

/// Mapeamento Plano → etapa (spec vínculo de produtos ao talhão, seção 3).
EstadioEntity? _resolverEstadio(
  List<EstadioEntity> estadios,
  CronogramaSojaLinha linha,
) {
  switch (linha.tipo) {
    case CronogramaSojaLinhaTipo.dessecacaoPrePlantio:
      return _operacional(
        estadios,
        TipoOperacional.dessecacaoPrePlantio,
        ['pré-plantio', 'pre-plantio'],
      );
    case CronogramaSojaLinhaTipo.posEmergente:
      return _porCodigo(estadios, 'V5') ??
          _operacional(
            estadios,
            TipoOperacional.posEmergente,
            ['pós-emergente', 'pos-emergente'],
          );
    case CronogramaSojaLinhaTipo.fungicida:
      final codigo =
          _codigosFungicida.elementAtOrNull((linha.fungicidaIndice ?? 1) - 1);
      return codigo == null ? null : _porCodigo(estadios, codigo);
    case CronogramaSojaLinhaTipo.dessecanteR7:
    case CronogramaSojaLinhaTipo.dessecacaoPreColheita:
      return _operacional(
        estadios,
        TipoOperacional.dessecacaoPreColheita,
        ['pré-colheita', 'pre-colheita', 'dessecação da soja', 'dessecacao da soja'],
      );
    case CronogramaSojaLinhaTipo.plantio:
    case CronogramaSojaLinhaTipo.emergencia:
    case CronogramaSojaLinhaTipo.colheitaReal:
    case CronogramaSojaLinhaTipo.colheitaEstimada:
      return null;
  }
}

EstadioEntity? _porCodigo(List<EstadioEntity> estadios, String codigo) {
  for (final e in estadios) {
    if (e.codigo == codigo && !e.isSementes) return e;
  }
  return null;
}

EstadioEntity? _operacional(
  List<EstadioEntity> estadios,
  TipoOperacional tipo,
  List<String> labels,
) {
  for (final e in estadios) {
    if (e.tipoOperacional == tipo) return e;
  }
  for (final e in estadios) {
    final label = e.label.toLowerCase();
    if (labels.any(label.contains)) return e;
  }
  return null;
}
