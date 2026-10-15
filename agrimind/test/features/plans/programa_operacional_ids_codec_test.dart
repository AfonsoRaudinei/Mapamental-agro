import 'package:agrimind/features/plans/domain/talhao_safra/programa_operacional_ids_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encode/decode preserva IDs únicos', () {
    const ids = ['a', 'b', 'a'];
    final raw = encodeProgramaOperacionalIds(ids);
    expect(decodeProgramaOperacionalIds(raw), ['a', 'b']);
  });

  test('mesclar não duplica', () {
    expect(
      mesclarProgramaOperacionalIds(['x'], ['y', 'x']),
      containsAll(['x', 'y']),
    );
    expect(
      mesclarProgramaOperacionalIds(['x'], ['y', 'x']).length,
      2,
    );
  });
}
