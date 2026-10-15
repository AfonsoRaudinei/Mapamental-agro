import '../../../clients/domain/entities/talhao_entity.dart';
import '../entities/alocacao_talhao_entity.dart';
import '../entities/escopo_alocacao_entity.dart';
import '../entities/rateio_area_validation.dart';
import '../entities/tipo_escopo_alocacao.dart';

/// Gera lançamentos proporcionais por área; não persiste.
class RatearProdutoPorTalhaoUseCase {
  const RatearProdutoPorTalhaoUseCase();

  RateioAreaValidation validarArea({
    required TipoEscopoAlocacao tipo,
    required double fazendaAreaTotalHa,
    required List<TalhaoEntity> talhoesDaFazenda,
    required List<String> talhoesIdsEscopo,
  }) {
    final areaBase = tipo == TipoEscopoAlocacao.fazendaInteira
        ? fazendaAreaTotalHa
        : _somaAreas(
            talhoesDaFazenda,
            talhoesIdsEscopo,
          );

    final idsNoEscopo = tipo == TipoEscopoAlocacao.fazendaInteira
        ? talhoesDaFazenda.map((t) => t.id).toList()
        : talhoesIdsEscopo;

    final areaTalhoes = _somaAreas(talhoesDaFazenda, idsNoEscopo);

    return RateioAreaValidation(
      areaBaseHa: areaBase,
      areaTalhoesNoEscopoHa: areaTalhoes,
    );
  }

  /// Retorna escopo + lançamentos prontos para persistência.
  RateioGerado call({
    required String escopoId,
    required String produtoAplicacaoId,
    required double quantidadeTotal,
    required TipoEscopoAlocacao tipo,
    required List<String> talhoesIdsEscopo,
    required List<TalhaoEntity> talhoesDaFazenda,
    required double fazendaAreaTotalHa,
    DateTime? agora,
  }) {
    final now = agora ?? DateTime.now();
    final validacao = validarArea(
      tipo: tipo,
      fazendaAreaTotalHa: fazendaAreaTotalHa,
      talhoesDaFazenda: talhoesDaFazenda,
      talhoesIdsEscopo: talhoesIdsEscopo,
    );

    final talhoesNoEscopo = tipo == TipoEscopoAlocacao.fazendaInteira
        ? talhoesDaFazenda
        : talhoesDaFazenda
            .where((t) => talhoesIdsEscopo.contains(t.id))
            .toList();

    if (talhoesNoEscopo.isEmpty || validacao.areaBaseHa <= 0) {
      return RateioGerado(
        escopo: EscopoAlocacaoEntity(
          id: escopoId,
          produtoAplicacaoId: produtoAplicacaoId,
          tipo: tipo,
          talhoesIds: tipo == TipoEscopoAlocacao.fazendaInteira
              ? const []
              : List<String>.from(talhoesIdsEscopo),
          quantidadeTotal: quantidadeTotal,
          dataCriacao: now,
        ),
        lancamentos: const [],
        validacao: validacao,
      );
    }

    final dosePorHa = quantidadeTotal / validacao.areaBaseHa;
    final lancamentos = <AlocacaoTalhaoEntity>[];
    for (final talhao in talhoesNoEscopo) {
      lancamentos.add(
        AlocacaoTalhaoEntity(
          id: '',
          produtoAplicacaoId: produtoAplicacaoId,
          talhaoId: talhao.id,
          quantidadeAlocada: dosePorHa * talhao.areaHa,
          origemEscopoId: escopoId,
          dataLancamento: now,
        ),
      );
    }

    return RateioGerado(
      escopo: EscopoAlocacaoEntity(
        id: escopoId,
        produtoAplicacaoId: produtoAplicacaoId,
        tipo: tipo,
        talhoesIds: tipo == TipoEscopoAlocacao.fazendaInteira
            ? const []
            : List<String>.from(talhoesIdsEscopo),
        quantidadeTotal: quantidadeTotal,
        dataCriacao: now,
      ),
      lancamentos: lancamentos,
      validacao: validacao,
    );
  }

  double _somaAreas(List<TalhaoEntity> talhoes, List<String> ids) {
    var sum = 0.0;
    for (final t in talhoes) {
      if (ids.contains(t.id)) sum += t.areaHa;
    }
    return sum;
  }
}

class RateioGerado {
  const RateioGerado({
    required this.escopo,
    required this.lancamentos,
    required this.validacao,
  });

  final EscopoAlocacaoEntity escopo;
  final List<AlocacaoTalhaoEntity> lancamentos;
  final RateioAreaValidation validacao;
}
