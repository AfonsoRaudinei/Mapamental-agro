import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_linha.dart';
import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:agrimind/features/clients/domain/talhao_etapas/montar_etapas_do_talhao_usecase.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime(2026, 10, 1);

ProdutoAplicacaoEntity _prod(String id, String nome, double dose, String un) =>
    ProdutoAplicacaoEntity(
      id: id,
      estadioId: 'e',
      produtoNome: nome,
      produtoCategoria: 'Herbicida',
      dose: dose,
      doseUnidade: un,
      areaHa: 445,
      ordem: 0,
      createdAt: _now,
    );

EstadioEntity _est(String codigo, List<ProdutoAplicacaoEntity> produtos) =>
    EstadioEntity(
      id: codigo,
      planoId: 'p',
      codigo: codigo,
      label: codigo,
      ordem: 0,
      createdAt: _now,
      produtos: produtos,
    );

void main() {
  final plano = PlanoEntity(
    id: 'p',
    nome: 'Plano',
    cultura: 'Soja',
    safra: '25/26',
    areaHaTotal: 445,
    status: 'ativo',
    createdAt: _now,
    updatedAt: _now,
    estadios: [
      _est('V5', [_prod('1', 'Roundup Original', 2, 'L/ha')]),
      _est('V7', [_prod('2', 'Fungicida X', 0.5, 'L/ha')]),
    ],
  );
  final params = CronogramaSojaParametros.defaults(
    id: 'c',
    talhaoId: 't1',
    cultura: 'Soja',
    dataPlantio: DateTime(2026, 10, 15),
  );

  test('recalcula total pela área do talhão e vincula por etapa', () {
    final etapas = montarEtapasDoTalhao(
      plano: plano,
      parametros: params,
      talhaoId: 't1',
      areaTalhaoHa: 95,
    );

    final pos = etapas.firstWhere(
      (e) => e.linha.tipo == CronogramaSojaLinhaTipo.posEmergente,
    );
    expect(pos.produtosVinculados.single.totalCalculado, 190);
    expect(pos.produtosVinculados.single.dosePorHa, 2);

    final f1 = etapas.firstWhere((e) => e.linha.fungicidaIndice == 1);
    expect(f1.produtosVinculados.single.nome, 'Fungicida X');
    final f2 = etapas.firstWhere((e) => e.linha.fungicidaIndice == 2);
    expect(f2.temProdutos, isFalse);

    final emergencia = etapas.firstWhere(
      (e) => e.linha.tipo == CronogramaSojaLinhaTipo.emergencia,
    );
    expect(emergencia.temProdutos, isFalse);
  });

  test('plantio herda sementes do talhão sem regra de produto', () {
    final etapas = montarEtapasDoTalhao(
      plano: plano,
      parametros: params,
      talhaoId: 't1',
      areaTalhaoHa: 95,
      sementes: [
        SementeTalhaoEntity(
          id: 's1',
          planoId: 'p',
          estadioId: 'sem',
          talhaoId: 't1',
          cultivar: 'Olimpo',
          populacaoSementesPorHa: 300000,
          sementesPorEmbalagem: 200000,
          espacamentoPlantioCm: 50,
          createdAt: _now,
          updatedAt: _now,
        ),
        SementeTalhaoEntity(
          id: 's2',
          planoId: 'p',
          estadioId: 'sem',
          talhaoId: 't2',
          cultivar: 'Lenda',
          populacaoSementesPorHa: 300000,
          sementesPorEmbalagem: 200000,
          espacamentoPlantioCm: 50,
          createdAt: _now,
          updatedAt: _now,
        ),
      ],
    );
    final plantio = etapas.firstWhere(
      (e) => e.linha.tipo == CronogramaSojaLinhaTipo.plantio,
    );
    expect(plantio.produtosVinculados.map((p) => p.nome), ['Olimpo']);
  });
}
