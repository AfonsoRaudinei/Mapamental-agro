import '../../../clients/domain/entities/talhao_entity.dart';
import '../../../plans/domain/entities/semente_talhao_entity.dart';
import '../../../plans/domain/usecases/calcular_sementes_talhao.dart';
import '../entities/consolidacao_semente_linha.dart';

/// Monta linhas de semente para consolidação/export a partir do cadastro.
List<ConsolidacaoSementeLinha> mapearSementesConsolidacao({
  required List<SementeTalhaoEntity> sementes,
  required List<TalhaoEntity> talhoes,
}) {
  final byId = {for (final t in talhoes) t.id: t};
  final linhas = [...sementes]
    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  return [
    for (final s in linhas)
      _linha(s, s.talhaoId == null ? null : byId[s.talhaoId]),
  ];
}

ConsolidacaoSementeLinha _linha(
  SementeTalhaoEntity s,
  TalhaoEntity? talhao,
) {
  final cultivar = s.cultivar.trim();
  if (talhao == null ||
      s.populacaoSementesPorHa <= 0 ||
      s.sementesPorEmbalagem <= 0) {
    return ConsolidacaoSementeLinha(
      cultivar: cultivar.isEmpty ? '—' : cultivar,
      talhaoNome: talhao?.nome ?? '—',
      areaHa: talhao?.areaHa ?? 0,
      populacaoSementesPorHa: s.populacaoSementesPorHa,
      embalagens: 0,
    );
  }

  final calc = calcularSementesTalhao(
    populacaoSementesPorHa: s.populacaoSementesPorHa,
    sementesPorEmbalagem: s.sementesPorEmbalagem,
    areaTalhaoHa: talhao.areaHa,
    espacamentoPlantioCm: s.espacamentoPlantioCm,
  );

  return ConsolidacaoSementeLinha(
    cultivar: cultivar.isEmpty ? '—' : cultivar,
    talhaoNome: talhao.nome,
    areaHa: talhao.areaHa,
    populacaoSementesPorHa: s.populacaoSementesPorHa,
    embalagens: calc.embalagensNecessarias,
    sementesPorMetroLinear: calc.sementesPorMetroLinear,
  );
}
