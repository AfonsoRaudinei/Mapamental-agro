import '../cronograma_soja/cronograma_soja_linha.dart';
import 'confirmacao_etapa.dart';
import 'produto_aplicado.dart';

/// Etapa de um talhão: data vinda do Cronograma + produtos vindos do Plano.
class EtapaTalhao {
  const EtapaTalhao({
    required this.linha,
    this.produtosVinculados = const [],
    this.confirmacao,
    this.dataPrevista,
  });

  final CronogramaSojaLinha linha;
  final List<ProdutoAplicado> produtosVinculados;

  /// Aplicação confirmada à mão (null = ainda não confirmada).
  final ConfirmacaoEtapa? confirmacao;

  /// Data original do cronograma, quando [linha] foi deslocada por atraso.
  final DateTime? dataPrevista;

  bool get exigeConfirmacao => etapaExigeConfirmacao(linha.tipo);
  bool get confirmada => confirmacao != null;
  String get chave => chaveDaEtapa(linha);

  String get etapa => linha.etapa;
  DateTime get data => linha.data;
  bool get temProdutos => produtosVinculados.isNotEmpty;
}
