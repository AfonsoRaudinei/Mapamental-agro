import 'package:flutter_test/flutter_test.dart';
import 'package:agrimind/features/plans/presentation/widgets/referencia_display_mapper.dart';
import 'package:agrimind/features/references/data/circular_fungicidas_data.dart';

void main() {
  test('mapper hides Usar no Plano when circular has no products', () {
    final entry = CircularFungicidasData.entryForStage('R8')!;
    final items = ReferenciaDisplayMapper.fromCircularEntry(entry);
    expect(items, isNotEmpty);
    expect(items.every((item) => item.podeUsarNoPlano == false), isTrue);
  });

  test('mapper allows Usar no Plano for fungicide recommendations', () {
    final entry = CircularFungicidasData.entryForStage('R1')!;
    final items = ReferenciaDisplayMapper.fromCircularEntry(entry);
    expect(items, isNotEmpty);
    expect(items.every((item) => item.podeUsarNoPlano), isTrue);
    expect(items.first.titulo, isNotEmpty);
  });
}
