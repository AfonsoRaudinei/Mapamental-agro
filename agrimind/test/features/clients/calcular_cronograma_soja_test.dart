import 'package:agrimind/features/clients/domain/cronograma_soja/calcular_cronograma_soja.dart';
import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_linha.dart';
import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calcula emergência, pós-emergente e fungicidas em sequência', () {
    final params = CronogramaSojaParametros(
      id: '1',
      talhaoId: 't1',
      cultura: 'Soja',
      materialCultivar: 'Olimpo',
      dataPlantio: DateTime(2026, 10, 10),
      diasEmergencia: 5,
      daePosEmergente: 25,
      diasRecuperacaoPosEmergente: 5,
      intervaloFungicidaDias: 15,
      totalAplicacoesFungicida: 2,
      daeMaturacaoCiclo: 110,
      diasAntesR8Dessecante: 12,
      diasAntecipacaoColheitaReal: 5,
      diasDessecacaoPrePlantio: 15,
      grupoRegulagemId: 'g1',
      plantioDefinido: true,
      ordem: 0,
      programaOperacionalIds: const [],
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

    final linhas = calcularCronogramaSoja(params);

    expect(linhas[0].tipo, CronogramaSojaLinhaTipo.dessecacaoPrePlantio);

    expect(linhas[2].tipo, CronogramaSojaLinhaTipo.emergencia);
    expect(linhas[2].data, DateTime(2026, 10, 15));
    expect(linhas[2].dae, 0);

    expect(linhas[3].tipo, CronogramaSojaLinhaTipo.posEmergente);
    expect(linhas[3].data, DateTime(2026, 11, 9));
    expect(linhas[3].dae, 25);

    expect(linhas[4].tipo, CronogramaSojaLinhaTipo.fungicida);
    expect(linhas[4].data, DateTime(2026, 11, 14));
    expect(linhas[4].dae, 30);
    expect(linhas[4].etapa, contains('1ª aplicação fungicida'));

    expect(linhas[5].data, DateTime(2026, 11, 29));
    expect(linhas[5].dae, 45);
    expect(linhas[5].etapa, contains('+15 dias'));
  });
}
