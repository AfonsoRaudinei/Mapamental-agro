import 'package:agrimind/features/plans/domain/entities/semente_talhao_entity.dart';
import 'package:agrimind/features/plans/domain/usecases/resolver_cultivar_talhao_plano_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = ResolverCultivarTalhaoPlanoUseCase();
  final now = DateTime(2026);

  SementeTalhaoEntity semente(String talhaoId, String cultivar) =>
      SementeTalhaoEntity(
        id: cultivar,
        planoId: 'p1',
        estadioId: 'e1',
        talhaoId: talhaoId,
        cultivar: cultivar,
        populacaoSementesPorHa: 0,
        sementesPorEmbalagem: 1,
        espacamentoPlantioCm: 0,
        createdAt: now,
        updatedAt: now,
      );

  test('lista cultivares distintas do talhão', () {
    final list = useCase.call(
      talhaoId: 't1',
      sementes: [
        semente('t1', 'Olimpo'),
        semente('t1', 'cruzada'),
        semente('t2', 'Outra'),
      ],
    );
    expect(list, ['Olimpo', 'cruzada']);
  });

  test('escolherCultivar preserva salva quando válida', () {
    final escolhida = useCase.escolherCultivar(
      talhaoId: 't1',
      sementes: [semente('t1', 'Olimpo'), semente('t1', 'cruzada')],
      cultivarSalva: 'cruzada',
    );
    expect(escolhida, 'cruzada');
  });

  test('escolherCultivar usa primeira quando salva inválida', () {
    final escolhida = useCase.escolherCultivar(
      talhaoId: 't1',
      sementes: [semente('t1', 'Olimpo'), semente('t1', 'cruzada')],
      cultivarSalva: 'Antiga',
    );
    expect(escolhida, 'Olimpo');
  });
}
