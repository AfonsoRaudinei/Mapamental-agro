import 'package:agrimind/core/agronomy/linha_tempo_soja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const parametros = ParametrosFenologicosSoja.padrao;

  test('formato de referência Olimpo 10/10/2026', () {
    final linhas = calcularLinhaTempoSoja(
      dataPlantio: DateTime(2026, 10, 10),
      parametros: parametros,
    );

    expect(linhas[0].tipo, LinhaTempoSojaTipo.dessecacaoPrePlantio);
    expect(linhas[2].etapa, 'Emergência (5 dias)');
    expect(linhas[2].dae, 0);
    expect(linhas[4].etapa, contains('1ª aplicação fungicida'));
    expect(linhas[5].etapa, '2ª aplicação fungicida (+15 dias)');
    expect(linhas[7].dae, 75);

    final colheita = linhas
        .where((l) => l.tipo == LinhaTempoSojaTipo.colheitaEstimada)
        .single;
    expect(colheita.data, DateTime(2027, 1, 28));
    expect(colheita.dae, 105);
    expect(colheita.etapa, contains('R8'));

    final dessecante = linhas
        .where((l) => l.tipo == LinhaTempoSojaTipo.dessecanteR7)
        .single;
    expect(dessecante.data, DateTime(2027, 1, 16));
    expect(dessecante.notaEtapa, contains('12 dias'));

    final colheitaReal = linhas
        .where((l) => l.tipo == LinhaTempoSojaTipo.colheitaReal)
        .single;
    expect(colheitaReal.data, DateTime(2027, 1, 23));
    expect(colheitaReal.notaEtapa, 'Antecipa a colheita em 5 dias');
  });

  test('uma aplicação de fungicida não usa intervalo', () {
    final linhas = calcularLinhaTempoSoja(
      dataPlantio: DateTime(2026, 10, 10),
      parametros: const ParametrosFenologicosSoja(
        diasEmergencia: 5,
        daePosEmergente: 25,
        diasRecuperacaoPosEmergente: 5,
        intervaloFungicidaDias: 15,
        totalAplicacoesFungicida: 1,
        daeMaturacaoCiclo: 110,
        diasAntesR8Dessecante: 12,
        diasAntecipacaoColheitaReal: 5,
        diasDessecacaoPrePlantio: 15,
      ),
    );
    final fung = linhas.where((l) => l.tipo == LinhaTempoSojaTipo.fungicida);
    expect(fung.length, 1);
  });

  test('campos 10 e 11 iguais não geram dessecante nem colheita real', () {
    final linhas = calcularLinhaTempoSoja(
      dataPlantio: DateTime(2026, 10, 10),
      parametros: const ParametrosFenologicosSoja(
        diasEmergencia: 5,
        daePosEmergente: 25,
        diasRecuperacaoPosEmergente: 5,
        intervaloFungicidaDias: 15,
        totalAplicacoesFungicida: 1,
        daeMaturacaoCiclo: 110,
        diasAntesR8Dessecante: 10,
        diasAntecipacaoColheitaReal: 10,
        diasDessecacaoPrePlantio: 0,
      ),
    );
    expect(
      linhas.where((l) => l.tipo == LinhaTempoSojaTipo.dessecanteR7),
      isEmpty,
    );
    expect(
      linhas.where((l) => l.tipo == LinhaTempoSojaTipo.colheitaReal),
      isEmpty,
    );
    expect(
      linhas.where((l) => l.tipo == LinhaTempoSojaTipo.colheitaEstimada).length,
      1,
    );
  });

  test('alterar plantio recalcula emergência e colheita', () {
    final a = calcularLinhaTempoSoja(
      dataPlantio: DateTime(2026, 10, 10),
      parametros: parametros,
    );
    final b = calcularLinhaTempoSoja(
      dataPlantio: DateTime(2026, 10, 15),
      parametros: parametros,
    );
    expect(a[2].data, DateTime(2026, 10, 15));
    expect(b[2].data, DateTime(2026, 10, 20));
    final colheitaB = b
        .where((l) => l.tipo == LinhaTempoSojaTipo.colheitaEstimada)
        .single;
    expect(colheitaB.data, DateTime(2027, 2, 2));
  });
}
