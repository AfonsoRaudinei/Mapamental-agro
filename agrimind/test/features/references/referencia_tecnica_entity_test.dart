import 'package:agrimind/features/references/domain/entities/referencia_tecnica_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('entidade técnica aceita fitotoxicidade opcional', () {
    const referencia = ReferenciaTecnicaEntity(
      id: 'fox-ultra-milcozeb',
      categoria: 'doencas',
      estadio: 'R1',
      titulo: 'Fox Ultra + Milcozeb',
      fitotoxPercent: 2.7,
    );

    expect(referencia.fitotoxPercent, 2.7);
  });
}
