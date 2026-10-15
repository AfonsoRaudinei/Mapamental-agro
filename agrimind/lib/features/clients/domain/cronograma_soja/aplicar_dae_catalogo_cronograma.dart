import '../../../catalog/domain/dae_maturacao_cultivar.dart';
import '../../../catalog/domain/entities/produto_catalogo_entity.dart';
import 'cronograma_soja_parametros.dart';

/// Atualiza DAE ao escolher cultivar (valor do catálogo ou mantém o atual).
CronogramaSojaParametros aplicarDaeAoEscolherCultivar({
  required CronogramaSojaParametros params,
  required String cultivar,
  required List<ProdutoCatalogoEntity> catalogo,
}) {
  final dae = resolverDaeMaturacaoCultivar(cultivar, catalogo);
  return params.copyWith(
    materialCultivar: cultivar,
    daeMaturacaoCiclo: dae ?? params.daeMaturacaoCiclo,
  );
}

/// Na carga, substitui o default 110 pelo DAE do catálogo quando houver match.
CronogramaSojaParametros enriquecerDaeMaturacaoDoCatalogo(
  CronogramaSojaParametros params,
  List<ProdutoCatalogoEntity> catalogo, {
  int defaultGenerico = 110,
}) {
  final dae = resolverDaeMaturacaoCultivar(params.materialCultivar, catalogo);
  if (dae == null) return params;
  if (params.daeMaturacaoCiclo != defaultGenerico) return params;
  return params.copyWith(daeMaturacaoCiclo: dae);
}
