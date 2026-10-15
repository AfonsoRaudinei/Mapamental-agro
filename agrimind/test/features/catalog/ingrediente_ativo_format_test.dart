import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/features/catalog/domain/ingrediente_ativo_format.dart';

void main() {
  group('parseIngredientesAtivos', () {
    test('splita formato com +', () {
      expect(
        parseIngredientesAtivos('Trifloxistrobina + Protioconazol'),
        ['Trifloxistrobina', 'Protioconazol'],
      );
    });

    test('valor único sem +', () {
      expect(parseIngredientesAtivos('Azoxistrobina'), ['Azoxistrobina']);
    });

    test('null ou vazio retorna lista vazia', () {
      expect(parseIngredientesAtivos(null), isEmpty);
      expect(parseIngredientesAtivos('   '), isEmpty);
    });
  });

  group('joinIngredientesAtivos', () {
    test('une com separador padrão', () {
      expect(
        joinIngredientesAtivos(['A', 'B']),
        'A + B',
      );
    });

    test('ignora entradas vazias', () {
      expect(joinIngredientesAtivos(['A', '', '  ']), 'A');
      expect(joinIngredientesAtivos([]), isNull);
    });
  });
}
