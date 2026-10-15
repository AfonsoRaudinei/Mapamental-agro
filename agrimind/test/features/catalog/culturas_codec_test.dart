import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/features/catalog/domain/cultura_label.dart';
import 'package:agrimind/features/catalog/domain/culturas_codec.dart';

void main() {
  test('encode e decode culturas', () {
    final raw = encodeCulturas(['Soja', 'Milho']);
    expect(decodeCulturas(raw), ['Soja', 'Milho']);
  });

  test('parse culturas com ponto e vírgula', () {
    final list = parseCulturasTexto(
      'Soja, milho; tratamento de sementes: arroz, trigo',
    );
    expect(list, contains('Soja'));
    expect(list, contains('Milho'));
    expect(list, contains('Arroz'));
    expect(list, contains('Trigo'));
  });
}
