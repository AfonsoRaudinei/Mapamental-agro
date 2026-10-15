import 'package:agrimind/features/plans/domain/talhao_safra/mapear_tipo_operacional_label.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/tipo_operacional.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mapeia labels legados comuns', () {
    final dessecacao = mapearLabelOperacionalParaTipo('Dessecação');
    expect(dessecacao, isA<TipoOperacionalMapeado>());
    expect(
      (dessecacao as TipoOperacionalMapeado).tipo,
      TipoOperacional.dessecacaoPrePlantio,
    );

    final pos = mapearLabelOperacionalParaTipo('Pós-emergente');
    expect((pos as TipoOperacionalMapeado).tipo, TipoOperacional.posEmergente);

    final plantioAdub =
        mapearLabelOperacionalParaTipo('Plantio + Adubação');
    expect(plantioAdub, isA<TipoOperacionalMapeado>());
    final pa = plantioAdub as TipoOperacionalMapeado;
    expect(pa.tipo, TipoOperacional.plantio);
    expect(pa.incluirAdubacao, isTrue);
  });

  test('texto desconhecido fica indefinido', () {
    final r = mapearLabelOperacionalParaTipo('Operação custom XYZ');
    expect(r, isA<TipoOperacionalIndefinido>());
  });
}
