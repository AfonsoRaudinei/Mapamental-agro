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

typedef _Atraso = ({int indice, DateTime prevista, int dias});

/// Aplica as confirmações manuais sobre as etapas calculadas.
///
/// - Etapa confirmada passa a ter a data real e os produtos confirmados.
/// - Etapas posteriores (pela data prevista) deslocam o mesmo atraso da
///   confirmação mais recente anterior a elas: o cronograma é recalculado
///   a partir do que realmente aconteceu.
/// - [EtapaTalhao.dataPrevista] guarda a data original quando mudou.
List<EtapaTalhao> aplicarConfirmacoes(
  List<EtapaTalhao> etapas,
  List<ConfirmacaoEtapa> confirmacoes,
) {
  if (confirmacoes.isEmpty) return etapas;
  final porChave = {for (final c in confirmacoes) c.chaveEtapa: c};

  // Atrasos (dataReal − prevista) das etapas confirmadas, em ordem de data.
  final atrasos = <_Atraso>[];
  for (var i = 0; i < etapas.length; i++) {
    final c = porChave[etapas[i].chave];
    if (c == null || !etapas[i].exigeConfirmacao) continue;
    final prevista = _dia(etapas[i].linha.data);
    atrasos.add((
      indice: i,
      prevista: prevista,
      dias: _diasEntre(prevista, c.dataReal),
    ));
  }
  atrasos.sort((a, b) {
    final c = a.prevista.compareTo(b.prevista);
    return c != 0 ? c : a.indice.compareTo(b.indice);
  });

  return [
    for (var i = 0; i < etapas.length; i++)
      _aplicar(etapas[i], i, porChave[etapas[i].chave], atrasos),
  ];
}

EtapaTalhao _aplicar(
  EtapaTalhao etapa,
  int indice,
  ConfirmacaoEtapa? confirmacao,
  List<_Atraso> atrasos,
) {
  final linha = etapa.linha;
  final prevista = _dia(linha.data);

  if (confirmacao != null && etapa.exigeConfirmacao) {
    final real = _dia(confirmacao.dataReal);
    return EtapaTalhao(
      linha: _comData(linha, real, _diasEntre(prevista, real)),
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

  // Última confirmação estritamente anterior a esta etapa.
  int? atraso;
  for (final a in atrasos) {
    final antes = a.prevista.isBefore(prevista) ||
        (a.prevista == prevista && a.indice < indice);
    if (!antes) break;
    atraso = a.dias;
  }
  if (atraso == null || atraso == 0) return etapa;

  return EtapaTalhao(
    linha: _comData(
      linha,
      DateTime(prevista.year, prevista.month, prevista.day + atraso),
      atraso,
    ),
    produtosVinculados: etapa.produtosVinculados,
    dataPrevista: prevista,
  );
}

/// [dias] também desloca o DAE (dias após emergência) da etapa.
CronogramaSojaLinha _comData(CronogramaSojaLinha l, DateTime data, int dias) =>
    CronogramaSojaLinha(
      etapa: l.etapa,
      dae: l.dae == null ? null : l.dae! + dias,
      data: data,
      tipo: l.tipo,
      fungicidaIndice: l.fungicidaIndice,
      notaEtapa: l.notaEtapa,
    );
