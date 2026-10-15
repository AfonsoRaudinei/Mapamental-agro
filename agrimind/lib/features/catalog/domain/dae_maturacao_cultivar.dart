import 'entities/produto_catalogo_entity.dart';

/// Categoria dos cultivares de soja no catálogo global.
const kCategoriaSementeCatalogo = 'Semente';

/// Lê o DAE de maturação gravado em [observacoes] do produto (ex.: `daeMaturacaoCiclo=110`).
int? daeMaturacaoFromObservacoes(String? observacoes) {
  if (observacoes == null || observacoes.trim().isEmpty) return null;
  final match = RegExp(
    r'daeMaturacaoCiclo\s*[=:]\s*(\d+)',
    caseSensitive: false,
  ).firstMatch(observacoes);
  if (match == null) return null;
  return int.tryParse(match.group(1)!);
}

String observacoesDaeMaturacao(int dias) => 'daeMaturacaoCiclo=$dias';

/// Busca DAE de maturação no catálogo pela cultivar (match exato ou por substring).
int? resolverDaeMaturacaoCultivar(
  String cultivar,
  List<ProdutoCatalogoEntity> catalogo,
) {
  final termo = cultivar.trim().toLowerCase();
  if (termo.isEmpty) return null;

  final sementes = catalogo.where(
    (p) =>
        p.ativo &&
        p.categoria == kCategoriaSementeCatalogo &&
        p.culturas.any((c) => c.toLowerCase().contains('soja')),
  );

  for (final p in sementes) {
    if (p.nomeComercial.trim().toLowerCase() == termo) {
      return daeMaturacaoFromObservacoes(p.observacoes);
    }
  }

  ProdutoCatalogoEntity? melhor;
  for (final p in sementes) {
    final nome = p.nomeComercial.trim().toLowerCase();
    if (nome.isEmpty) continue;
    if (!termo.contains(nome) && !nome.contains(termo)) continue;
    if (melhor == null ||
        p.nomeComercial.length > melhor.nomeComercial.length) {
      melhor = p;
    }
  }
  return melhor == null
      ? null
      : daeMaturacaoFromObservacoes(melhor.observacoes);
}
