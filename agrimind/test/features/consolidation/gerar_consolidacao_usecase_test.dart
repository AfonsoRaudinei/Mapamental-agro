import 'package:agrimind/features/consolidation/domain/usecases/gerar_consolidacao_usecase.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('agrupa produtos e normaliza unidades na consolidação', () {
    final plano = _plano([
      _estadio(
        id: 'v4',
        codigo: 'V4',
        ordem: 1,
        produtos: [
          _produto(
            id: 'fungicida-v4',
            estadioId: 'v4',
            nome: 'Fox Ultra + Milcozeb',
            categoria: 'Fungicida',
            dose: 200,
            unidade: 'mL/ha',
            areaHa: 10,
            precoUnitario: 50,
          ),
          _produto(
            id: 'inseticida-v4',
            estadioId: 'v4',
            nome: 'Inseticida Teste',
            categoria: 'Inseticida',
            dose: 10,
            unidade: 'unid/ha',
            areaHa: 10,
            totalOverride: 80,
            overrideMotivo: 'Ajuste técnico',
          ),
        ],
      ),
      _estadio(
        id: 'r1',
        codigo: 'R1',
        ordem: 2,
        produtos: [
          _produto(
            id: 'fungicida-r1',
            estadioId: 'r1',
            nome: 'Fox Ultra + Milcozeb',
            categoria: 'Fungicida',
            dose: 1,
            unidade: 'L/ha',
            areaHa: 5,
            precoUnitario: 50,
          ),
        ],
      ),
    ]);

    final consolidacao = const GerarConsolidacaoUseCase().call(plano);

    expect(consolidacao.itens, hasLength(2));
    expect(consolidacao.totalProdutos, 2);
    expect(consolidacao.totalCategorias, 2);

    final fungicida = consolidacao.itens.first;
    expect(fungicida.produtoNome, 'Fox Ultra + Milcozeb');
    expect(fungicida.categoria, 'Fungicida');
    expect(fungicida.quantidadeTotal, closeTo(7, 0.0001));
    expect(fungicida.unidade, 'L');
    expect(fungicida.temUnidadeMista, isFalse);
    expect(fungicida.custoTotal, closeTo(350, 0.0001));
    expect(fungicida.detalhe.map((d) => d.estadioCodigo), ['V4', 'R1']);

    final inseticida = consolidacao.itens.last;
    expect(inseticida.produtoNome, 'Inseticida Teste');
    expect(inseticida.quantidadeTotal, closeTo(80, 0.0001));
    expect(inseticida.unidade, 'unid');
    expect(inseticida.detalhe.single.isOverride, isTrue);
    expect(inseticida.detalhe.single.overrideMotivo, 'Ajuste técnico');
  });
}

PlanoEntity _plano(List<EstadioEntity> estadios) {
  final now = DateTime(2026);
  return PlanoEntity(
    id: 'plano-1',
    nome: 'Plano Soja',
    cultura: 'Soja',
    safra: '2026/2027',
    areaHaTotal: 10,
    status: 'ativo',
    createdAt: now,
    updatedAt: now,
    estadios: estadios,
  );
}

EstadioEntity _estadio({
  required String id,
  required String codigo,
  required int ordem,
  required List<ProdutoAplicacaoEntity> produtos,
}) {
  return EstadioEntity(
    id: id,
    planoId: 'plano-1',
    codigo: codigo,
    label: codigo,
    ordem: ordem,
    createdAt: DateTime(2026),
    produtos: produtos,
  );
}

ProdutoAplicacaoEntity _produto({
  required String id,
  required String estadioId,
  required String nome,
  required String categoria,
  required double dose,
  required String unidade,
  required double areaHa,
  double? totalOverride,
  String? overrideMotivo,
  double? precoUnitario,
}) {
  return ProdutoAplicacaoEntity(
    id: id,
    estadioId: estadioId,
    produtoNome: nome,
    produtoCategoria: categoria,
    dose: dose,
    doseUnidade: unidade,
    areaHa: areaHa,
    totalOverride: totalOverride,
    overrideMotivo: overrideMotivo,
    precoUnitario: precoUnitario,
    ordem: 1,
    createdAt: DateTime(2026),
  );
}
