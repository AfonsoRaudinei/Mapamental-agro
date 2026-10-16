import '../cronograma_soja/cronograma_soja_linha.dart';
import 'produto_aplicado.dart';

/// Etapa de um talhão: data vinda do Cronograma + produtos vindos do Plano.
class EtapaTalhao {
  const EtapaTalhao({
    required this.linha,
    this.produtosVinculados = const [],
  });

  final CronogramaSojaLinha linha;
  final List<ProdutoAplicado> produtosVinculados;

  String get etapa => linha.etapa;
  DateTime get data => linha.data;
  bool get temProdutos => produtosVinculados.isNotEmpty;
}
