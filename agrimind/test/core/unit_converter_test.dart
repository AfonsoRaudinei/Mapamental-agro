import 'package:agrimind/core/utils/unit_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnitConverter', () {
    test('converte mL/ha para L/ha', () {
      expect(UnitConverter.converter(200, 'mL/ha'), closeTo(0.2, 0.0001));
      expect(UnitConverter.valorDisplay(200, 'mL/ha'), closeTo(0.2, 0.0001));
      expect(UnitConverter.unidadeBase('mL/ha'), 'L/ha');
      expect(UnitConverter.unidadeTotal('mL/ha'), 'L');
    });

    test('converte g/ha para kg/ha', () {
      expect(UnitConverter.converter(1000, 'g/ha'), closeTo(1.0, 0.0001));
      expect(UnitConverter.valorDisplay(1000, 'g/ha'), closeTo(1.0, 0.0001));
      expect(UnitConverter.unidadeBase('g/ha'), 'kg/ha');
      expect(UnitConverter.unidadeTotal('g/ha'), 'kg');
    });

    test('mantem unidades do mesmo grupo como somaveis', () {
      expect(UnitConverter.isMesmoGrupo('L/ha', 'mL/ha'), isTrue);
      expect(UnitConverter.temUnidadeMista(['L/ha', 'mL/ha']), isTrue);
    });
  });
}
