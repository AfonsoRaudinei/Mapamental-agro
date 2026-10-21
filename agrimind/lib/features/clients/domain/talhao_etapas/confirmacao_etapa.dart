import '../cronograma_soja/cronograma_soja_linha.dart';

/// Produto realmente usado numa aplicação confirmada.
class ProdutoConfirmado {
  const ProdutoConfirmado({
    required this.produtoId,
    required this.nome,
    required this.dosePorHa,
    required this.unidade,
    required this.total,
  });

  final String produtoId;
  final String nome;
  final double dosePorHa;

  /// Unidade da dose, ex.: `L/ha`.
  final String unidade;
  final double total;

  String get unidadeDoTotal => unidade.split('/').first;
}

/// Aplicação confirmada à mão: data real + produtos realmente usados.
class ConfirmacaoEtapa {
  const ConfirmacaoEtapa({
    required this.talhaoId,
    required this.chaveEtapa,
    required this.dataReal,
    required this.produtos,
    required this.confirmadaEm,
  });

  final String talhaoId;

  /// Ver [chaveDaEtapa].
  final String chaveEtapa;
  final DateTime dataReal;
  final List<ProdutoConfirmado> produtos;
  final DateTime confirmadaEm;
}

/// Etapas que exigem confirmação manual: as aplicações e a emergência
/// (data real, que move o restante do cronograma).
bool etapaExigeConfirmacao(CronogramaSojaLinhaTipo tipo) {
  switch (tipo) {
    case CronogramaSojaLinhaTipo.dessecacaoPrePlantio:
    case CronogramaSojaLinhaTipo.emergencia:
    case CronogramaSojaLinhaTipo.posEmergente:
    case CronogramaSojaLinhaTipo.fungicida:
    case CronogramaSojaLinhaTipo.dessecanteR7:
    case CronogramaSojaLinhaTipo.dessecacaoPreColheita:
      return true;
    case CronogramaSojaLinhaTipo.plantio:
    case CronogramaSojaLinhaTipo.colheitaReal:
    case CronogramaSojaLinhaTipo.colheitaEstimada:
      return false;
  }
}

/// Chave estável da etapa dentro do talhão (ex.: `fungicida:2`).
String chaveDaEtapa(CronogramaSojaLinha linha) {
  final indice = linha.fungicidaIndice;
  return indice == null ? linha.tipo.name : '${linha.tipo.name}:$indice';
}
