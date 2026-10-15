import 'package:agrimind/features/clients/domain/entities/talhao_entity.dart';
import 'package:agrimind/features/consolidation/domain/usecases/mapear_sementes_consolidacao.dart';
import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calcula sem/m e embalagens iguais ao canvas', () {
    final now = DateTime(2026, 10, 4);
    final linhas = mapearSementesConsolidacao(
      sementes: [
        SementeTalhaoEntity(
          id: 's1',
          planoId: 'p1',
          estadioId: 'e1',
          talhaoId: 't1',
          cultivar: 'Olimpo',
          populacaoSementesPorHa: 300000,
          sementesPorEmbalagem: 5000000,
          espacamentoPlantioCm: 50,
          createdAt: now,
          updatedAt: now,
        ),
      ],
      talhoes: [
        TalhaoEntity(
          id: 't1',
          fazendaId: 'f1',
          nome: 'Talhão 1',
          areaHa: 95,
          ativo: true,
          createdAt: now,
        ),
      ],
    );

    expect(linhas, hasLength(1));
    expect(linhas.single.cultivar, 'Olimpo');
    expect(linhas.single.talhaoNome, 'Talhão 1');
    expect(linhas.single.areaHa, 95);
    expect(linhas.single.sementesPorMetroLinear, 15);
    expect(linhas.single.populacaoSementesPorHa, 300000);
    expect(linhas.single.embalagens, 6);
  });
}
