import 'package:agrimind/features/clients/domain/entities/talhao_entity.dart';
import 'package:agrimind/features/plans/domain/entities/tipo_escopo_alocacao.dart';
import 'package:agrimind/features/plans/domain/usecases/ratear_produto_por_talhao_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = RatearProdutoPorTalhaoUseCase();

  final talhoes = [
    TalhaoEntity(
      id: 't1',
      fazendaId: 'f1',
      nome: 'A',
      areaHa: 100,
      ativo: true,
      createdAt: DateTime(2025),
    ),
    TalhaoEntity(
      id: 't2',
      fazendaId: 'f1',
      nome: 'B',
      areaHa: 50,
      ativo: true,
      createdAt: DateTime(2025),
    ),
  ];

  test('fazenda inteira distribui proporcionalmente', () {
    final gerado = useCase.call(
      escopoId: 'e1',
      produtoAplicacaoId: 'p1',
      quantidadeTotal: 150,
      tipo: TipoEscopoAlocacao.fazendaInteira,
      talhoesIdsEscopo: const [],
      talhoesDaFazenda: talhoes,
      fazendaAreaTotalHa: 200,
      agora: DateTime(2025, 1, 1),
    );

    expect(gerado.lancamentos.length, 2);
    // Base = área total da fazenda (200 ha), não soma dos talhões.
    expect(gerado.lancamentos[0].quantidadeAlocada, 75);
    expect(gerado.lancamentos[1].quantidadeAlocada, 37.5);
  });

  test('talhões selecionados usa só ids escolhidos', () {
    final gerado = useCase.call(
      escopoId: 'e2',
      produtoAplicacaoId: 'p1',
      quantidadeTotal: 100,
      tipo: TipoEscopoAlocacao.talhoesSelecionados,
      talhoesIdsEscopo: const ['t1'],
      talhoesDaFazenda: talhoes,
      fazendaAreaTotalHa: 200,
      agora: DateTime(2025, 1, 1),
    );

    expect(gerado.lancamentos.length, 1);
    expect(gerado.lancamentos.first.talhaoId, 't1');
    expect(gerado.lancamentos.first.quantidadeAlocada, 100);
  });
}
