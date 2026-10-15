import '../../domain/entities/tipo_escopo_alocacao.dart';

/// Escolha do usuário antes de informar dose/quantidade.
class EscopoSelecionado {
  const EscopoSelecionado({
    required this.tipo,
    this.talhoesIds = const [],
  });

  final TipoEscopoAlocacao tipo;
  final List<String> talhoesIds;
}
