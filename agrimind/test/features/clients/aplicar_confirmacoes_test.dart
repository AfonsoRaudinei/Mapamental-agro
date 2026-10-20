import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_linha.dart';
import 'package:agrimind/features/clients/domain/talhao_etapas/aplicar_confirmacoes.dart';
import 'package:agrimind/features/clients/domain/talhao_etapas/confirmacao_etapa.dart';
import 'package:agrimind/features/clients/domain/talhao_etapas/etapa_talhao.dart';
import 'package:agrimind/features/clients/presentation/widgets/talhao_timeline_stepper.dart';
import 'package:flutter_test/flutter_test.dart';

EtapaTalhao _etapa(
  CronogramaSojaLinhaTipo tipo,
  DateTime data, {
  int? dae,
  int? fung,
}) =>
    EtapaTalhao(
      linha: CronogramaSojaLinha(
        etapa: tipo.name,
        dae: dae,
        data: data,
        tipo: tipo,
        fungicidaIndice: fung,
      ),
    );

ConfirmacaoEtapa _conf(EtapaTalhao e, DateTime real) => ConfirmacaoEtapa(
      talhaoId: 't1',
      chaveEtapa: e.chave,
      dataReal: real,
      produtos: const [
        ProdutoConfirmado(
          produtoId: 'p1',
          nome: 'Verdict R',
          dosePorHa: 0.5,
          unidade: 'L/ha',
          total: 47.5,
        ),
      ],
      confirmadaEm: DateTime(2026, 11, 10),
    );

void main() {
  final plantio = _etapa(CronogramaSojaLinhaTipo.plantio, DateTime(2026, 10, 8));
  final pos = _etapa(
    CronogramaSojaLinhaTipo.posEmergente,
    DateTime(2026, 11, 7),
    dae: 25,
  );
  final f1 = _etapa(
    CronogramaSojaLinhaTipo.fungicida,
    DateTime(2026, 11, 20),
    dae: 38,
    fung: 1,
  );
  final f2 = _etapa(
    CronogramaSojaLinhaTipo.fungicida,
    DateTime(2026, 12, 5),
    dae: 53,
    fung: 2,
  );
  final etapas = [plantio, pos, f1, f2];

  test('sem confirmações nada muda', () {
    expect(aplicarConfirmacoes(etapas, const []), same(etapas));
  });

  test('atraso confirmado desloca as etapas seguintes (data e DAE)', () {
    final r = aplicarConfirmacoes(etapas, [_conf(pos, DateTime(2026, 11, 10))]);

    expect(r[0].data, DateTime(2026, 10, 8));
    expect(r[0].dataPrevista, isNull);

    expect(r[1].confirmada, isTrue);
    expect(r[1].data, DateTime(2026, 11, 10));
    expect(r[1].dataPrevista, DateTime(2026, 11, 7));
    expect(r[1].linha.dae, 28);
    expect(r[1].produtosVinculados.single.nome, 'Verdict R');

    expect(r[2].confirmada, isFalse);
    expect(r[2].data, DateTime(2026, 11, 23));
    expect(r[2].linha.dae, 41);
    expect(r[3].data, DateTime(2026, 12, 8));
  });

  test('a confirmação mais recente manda; atraso não acumula', () {
    final r = aplicarConfirmacoes(etapas, [
      _conf(pos, DateTime(2026, 11, 10)), // +3
      _conf(f1, DateTime(2026, 11, 22)), // +2 sobre a data original
    ]);
    expect(r[2].data, DateTime(2026, 11, 22));
    expect(r[3].data, DateTime(2026, 12, 7));
  });

  test('confirmar na data prevista não gera dataPrevista nem deslocamento', () {
    final r = aplicarConfirmacoes(etapas, [_conf(pos, DateTime(2026, 11, 7))]);
    expect(r[1].dataPrevista, isNull);
    expect(r[2].data, DateTime(2026, 11, 20));
  });

  test('aplicação vencida e não confirmada fica atrasada e é a atual', () {
    final hoje = DateTime(2026, 11, 10, 9);
    final status = statusDasEtapasTalhao(etapas, hoje);
    expect(status, [
      StepperNodeStatus.concluido, // plantio: pela data
      StepperNodeStatus.atual, // pós vencido sem confirmar
      StepperNodeStatus.futuro,
      StepperNodeStatus.futuro,
    ]);
    expect(etapaAtrasada(pos, hoje), isTrue);

    final r = aplicarConfirmacoes(etapas, [_conf(pos, DateTime(2026, 11, 9))]);
    final depois = statusDasEtapasTalhao(r, hoje);
    expect(depois[1], StepperNodeStatus.concluido);
    expect(depois[2], StepperNodeStatus.atual);
    expect(etapaAtrasada(r[1], hoje), isFalse);
  });
}
