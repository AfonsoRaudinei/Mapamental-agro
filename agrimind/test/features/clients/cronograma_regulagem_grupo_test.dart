import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_regulagem_grupo.dart';
import 'package:agrimind/features/clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('regulagem do grupo não copia plantio, cultivar nem ciclo', () {
    final t1 = CronogramaSojaParametros.defaults(
      id: 'a',
      talhaoId: 't1',
      cultura: 'Soja',
      dataPlantio: DateTime(2026, 10, 10),
    ).copyWith(
      grupoRegulagemId: 'g',
      materialCultivar: 'Olimpo',
      daeMaturacaoCiclo: 118,
    );
    final t2 = CronogramaSojaParametros.defaults(
      id: 'b',
      talhaoId: 't2',
      cultura: 'Soja',
      dataPlantio: DateTime(2026, 10, 20),
    ).copyWith(
      grupoRegulagemId: 'g',
      materialCultivar: 'Cruzada',
      daeMaturacaoCiclo: 105,
    );
    final grupo = agruparCronogramasPorRegulagem([t1, t2]).single;

    final modelo = t1.copyWith(intervaloFungicidaDias: 20, daeMaturacaoCiclo: 120);
    final r = aplicarModeloNoGrupo(grupo: grupo, modelo: modelo);

    final r1 = r.firstWhere((l) => l.talhaoId == 't1');
    final r2 = r.firstWhere((l) => l.talhaoId == 't2');
    expect(r1.daeMaturacaoCiclo, 120);
    expect(r2.intervaloFungicidaDias, 20);
    expect(r2.daeMaturacaoCiclo, 105);
    expect(r2.materialCultivar, 'Cruzada');
    expect(r2.dataPlantio, DateTime(2026, 10, 20));
  });
}
