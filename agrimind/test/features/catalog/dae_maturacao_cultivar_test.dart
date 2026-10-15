import 'package:agrimind/features/catalog/domain/dae_maturacao_cultivar.dart';
import 'package:agrimind/features/catalog/domain/entities/produto_catalogo_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final catalogo = [
    ProdutoCatalogoEntity(
      id: '1',
      nomeComercial: 'Olimpo',
      categoria: kCategoriaSementeCatalogo,
      unidadePadrao: 'ciclo',
      observacoes: observacoesDaeMaturacao(110),
      culturas: const ['Soja'],
      ativo: true,
      isSeed: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
    ProdutoCatalogoEntity(
      id: '2',
      nomeComercial: 'Brasmax Olimpo IPRO',
      categoria: kCategoriaSementeCatalogo,
      unidadePadrao: 'ciclo',
      observacoes: observacoesDaeMaturacao(110),
      culturas: const ['Soja'],
      ativo: true,
      isSeed: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  ];

  test('resolve por nome exato', () {
    expect(resolverDaeMaturacaoCultivar('Olimpo', catalogo), 110);
  });

  test('resolve por substring na cultivar do plano', () {
    expect(
      resolverDaeMaturacaoCultivar('Brasmax Olimpo 80I82RSF IPRO', catalogo),
      110,
    );
  });

  test('observacoes parse', () {
    expect(daeMaturacaoFromObservacoes('daeMaturacaoCiclo=115'), 115);
    expect(daeMaturacaoFromObservacoes(null), isNull);
  });
}
