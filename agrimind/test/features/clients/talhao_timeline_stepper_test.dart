import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_linha.dart';
import 'package:agrimind/features/clients/domain/talhao_etapas/etapa_talhao.dart';
import 'package:agrimind/features/clients/presentation/widgets/talhao_timeline_stepper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final hoje = DateTime(2026, 11, 10, 15);

  test('concluído antes de hoje, atual é a primeira >= hoje', () {
    final s = statusDasEtapas([
      DateTime(2026, 10, 8),
      DateTime(2026, 11, 10),
      DateTime(2026, 11, 25),
    ], hoje);
    expect(s, [
      StepperNodeStatus.concluido,
      StepperNodeStatus.atual,
      StepperNodeStatus.futuro,
    ]);
  });

  test('safra encerrada não tem nó atual', () {
    final s = statusDasEtapas([DateTime(2026, 1, 1), DateTime(2026, 2, 1)], hoje);
    expect(s.contains(StepperNodeStatus.atual), isFalse);
  });

  test('texto relativo na linguagem do campo', () {
    final h = DateTime(2026, 10, 17, 9);
    expect(textoRelativo(DateTime(2026, 10, 17), h), 'hoje');
    expect(textoRelativo(DateTime(2026, 10, 18), h), 'amanhã');
    expect(textoRelativo(DateTime(2026, 10, 16), h), 'ontem');
    expect(textoRelativo(DateTime(2026, 11, 8), h), 'em 22 dias');
    expect(textoRelativo(DateTime(2026, 10, 9), h), 'há 8 dias');
  });

  test('marcador Hoje fica entre a última concluída e a próxima', () {
    final datas = [
      DateTime(2026, 9, 24), // OP
      DateTime(2026, 10, 9), // SEM
      DateTime(2026, 10, 14), // VE
      DateTime(2026, 11, 8), // V5
    ];
    final p = posicaoHoje(datas, DateTime(2026, 10, 17));
    expect(p, greaterThan(2));
    expect(p, lessThan(3));
    // No dia exato da etapa, o marcador fica sobre o nó.
    expect(posicaoHoje(datas, DateTime(2026, 11, 8)), 3);
    // Antes de tudo / depois de tudo.
    expect(posicaoHoje(datas, DateTime(2026, 9, 1)), lessThan(0));
    expect(posicaoHoje(datas, DateTime(2027, 3, 1)), greaterThan(3));
  });

  test('nota curta tira o detalhe do título do card', () {
    CronogramaSojaLinha linha(
      String etapa,
      CronogramaSojaLinhaTipo tipo, {
      int? fung,
      String? nota,
    }) =>
        CronogramaSojaLinha(
          etapa: etapa,
          dae: null,
          data: DateTime(2026, 11, 13),
          tipo: tipo,
          fungicidaIndice: fung,
          notaEtapa: nota,
        );

    final f1 = linha(
      'Recuperação do pós-emergente (6 dias) → 1ª aplicação fungicida',
      CronogramaSojaLinhaTipo.fungicida,
      fung: 1,
    );
    expect(nomeCurtoEtapa(f1), '1ª aplicação fungicida');
    expect(notaCurtaEtapa(f1), '6 dias após o pós-emergente');

    final f2 = linha(
      '2ª aplicação fungicida (+15 dias)',
      CronogramaSojaLinhaTipo.fungicida,
      fung: 2,
    );
    expect(notaCurtaEtapa(f2), '+15 dias da aplicação anterior');

    expect(
      notaCurtaEtapa(
        linha('Emergência (5 dias)', CronogramaSojaLinhaTipo.emergencia),
      ),
      '5 dias após o plantio',
    );
    expect(
      notaCurtaEtapa(
        linha(
          'Dessecação (pré-plantio)',
          CronogramaSojaLinhaTipo.dessecacaoPrePlantio,
          nota: '15 dias antes do plantio',
        ),
      ),
      '15 dias antes do plantio',
    );
    expect(
      notaCurtaEtapa(linha('Plantio', CronogramaSojaLinhaTipo.plantio)),
      isNull,
    );
  });

  test('card da colheita real aponta para o nó R8 do stepper', () {
    EtapaTalhao etapa(CronogramaSojaLinhaTipo tipo, int dia) => EtapaTalhao(
          linha: CronogramaSojaLinha(
            etapa: tipo.name,
            dae: null,
            data: DateTime(2027, 1, dia),
            tipo: tipo,
          ),
        );
    final etapas = [
      etapa(CronogramaSojaLinhaTipo.emergencia, 1),
      etapa(CronogramaSojaLinhaTipo.colheitaReal, 20),
      etapa(CronogramaSojaLinhaTipo.colheitaEstimada, 25),
    ];
    // Nós: emergência (0) e colheita estimada (1); a real não é nó.
    expect(posicaoNoStepper(etapas, 0), 0);
    expect(posicaoNoStepper(etapas, 1), 1);
    expect(posicaoNoStepper(etapas, 2), 1);
  });
}
