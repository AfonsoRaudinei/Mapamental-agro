import '../cronograma_soja/cronograma_soja_linha.dart';
import 'confirmacao_etapa.dart';
import 'etapa_talhao.dart';
import 'produto_aplicado.dart';

DateTime _dia(DateTime d) => DateTime(d.year, d.month, d.day);

/// Dias de calendário de [a] até [b] (imune a horário de verão).
int _diasEntre(DateTime a, DateTime b) =>
    DateTime.utc(b.year, b.month, b.day)
        .difference(DateTime.utc(a.year, a.month, a.day))
        .inDays;

typedef _Desvio = ({int indice, DateTime prevista, int dias});

/// Etapas ancoradas no plantio informado: não andam com atraso de aplicação.
bool _ancoradaNoPlantio(CronogramaSojaLinhaTipo tipo) =>
    tipo == CronogramaSojaLinhaTipo.dessecacaoPrePlantio ||
    tipo == CronogramaSojaLinhaTipo.plantio;

/// Aplica as confirmações manuais sobre as etapas calculadas.
///
/// - Etapa confirmada passa a ter a data real (e os produtos confirmados).
/// - Etapas posteriores à confirmação (pela data prevista) deslocam o mesmo
///   desvio da confirmação mais recente anterior a elas: o cronograma é
///   recalculado a partir do que realmente aconteceu.
/// - Dessecação pré-plantio e plantio não deslocam nem são deslocados: o
///   plantio é a data informada pelo usuário.
/// - O DAE (dias após emergência) acompanha: confirmar a emergência move as
///   datas seguintes sem mudar o DAE delas.
/// - [EtapaTalhao.dataPrevista] guarda a data original quando mudou.
List<EtapaTalhao> aplicarConfirmacoes(
  List<EtapaTalhao> etapas,
  List<ConfirmacaoEtapa> confirmacoes,
) {
  if (confirmacoes.isEmpty) return etapas;
  final porChave = {for (final c in confirmacoes) c.chaveEtapa: c};

  DateTime? plantio;
  for (final e in etapas) {
    if (e.linha.tipo == CronogramaSojaLinhaTipo.plantio) {
      plantio = _dia(e.linha.data);
    }
  }

  // Desvios (dataReal − prevista) das etapas confirmadas, em ordem de data.
  final desvios = <_Desvio>[];
  var desvioEmergencia = 0;
  for (var i = 0; i < etapas.length; i++) {
    final c = porChave[etapas[i].chave];
    final tipo = etapas[i].linha.tipo;
    if (c == null || !etapas[i].exigeConfirmacao) continue;
    final prevista = _dia(etapas[i].linha.data);
    final dias = _diasEntre(prevista, c.dataReal);
    if (tipo == CronogramaSojaLinhaTipo.emergencia) desvioEmergencia = dias;
    if (tipo == CronogramaSojaLinhaTipo.dessecacaoPrePlantio) continue;
    desvios.add((indice: i, prevista: prevista, dias: dias));
  }
  desvios.sort((a, b) {
    final c = a.prevista.compareTo(b.prevista);
    return c != 0 ? c : a.indice.compareTo(b.indice);
  });

  return [
    for (var i = 0; i < etapas.length; i++)
      _aplicar(
        etapas[i],
        i,
        porChave[etapas[i].chave],
        desvios,
        desvioEmergencia,
        plantio,
      ),
  ];
}

EtapaTalhao _aplicar(
  EtapaTalhao etapa,
  int indice,
  ConfirmacaoEtapa? confirmacao,
  List<_Desvio> desvios,
  int desvioEmergencia,
  DateTime? plantio,
) {
  final linha = etapa.linha;
  final prevista = _dia(linha.data);
  final emergencia = linha.tipo == CronogramaSojaLinhaTipo.emergencia;

  if (confirmacao != null && etapa.exigeConfirmacao) {
    final real = _dia(confirmacao.dataReal);
    final dias = _diasEntre(prevista, real);
    return EtapaTalhao(
      linha: _comData(
        linha,
        real,
        // A emergência é o DAE 0; as demais andam com o desvio, menos o da
        // própria emergência (que já moveu a referência do DAE).
        dae: emergencia || _ancoradaNoPlantio(linha.tipo)
            ? linha.dae
            : _deslocarDae(linha.dae, dias - desvioEmergencia),
        nota: emergencia && plantio != null
            ? '${_diasEntre(plantio, real)} dias após o plantio'
            : null,
      ),
      // Etapa confirmada mostra o que foi realmente usado.
      produtosVinculados: [
        for (final p in confirmacao.produtos)
          ProdutoAplicado(
            produtoId: p.produtoId,
            nome: p.nome,
            dosePorHa: p.dosePorHa,
            unidade: p.unidade,
            totalCalculado: p.total,
          ),
      ],
      confirmacao: confirmacao,
      dataPrevista: real == prevista ? null : prevista,
    );
  }

  if (_ancoradaNoPlantio(linha.tipo)) return etapa;

  // Último desvio estritamente anterior a esta etapa.
  int? desvio;
  for (final d in desvios) {
    final antes = d.prevista.isBefore(prevista) ||
        (d.prevista == prevista && d.indice < indice);
    if (!antes) break;
    desvio = d.dias;
  }
  if (desvio == null || desvio == 0) return etapa;

  return EtapaTalhao(
    linha: _comData(
      linha,
      DateTime(prevista.year, prevista.month, prevista.day + desvio),
      dae: _deslocarDae(linha.dae, desvio - desvioEmergencia),
    ),
    produtosVinculados: etapa.produtosVinculados,
    dataPrevista: prevista,
  );
}

int? _deslocarDae(int? dae, int dias) => dae == null ? null : dae + dias;

CronogramaSojaLinha _comData(
  CronogramaSojaLinha l,
  DateTime data, {
  required int? dae,
  String? nota,
}) =>
    CronogramaSojaLinha(
      etapa: l.etapa,
      dae: dae,
      data: data,
      tipo: l.tipo,
      fungicidaIndice: l.fungicidaIndice,
      notaEtapa: nota ?? l.notaEtapa,
    );
