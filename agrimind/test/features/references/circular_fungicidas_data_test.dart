import 'package:flutter_test/flutter_test.dart';
import 'package:agrimind/features/references/data/circular_fungicidas_data.dart';

void main() {
  group('CircularFungicidasData', () {
    test('covers VE–R8 stage aliases from the circular docs', () {
      expect(CircularFungicidasData.entryForStage('VE')?.stageCode, 'VE–V3');
      expect(CircularFungicidasData.entryForStage('V4')?.stageCode, 'V4');
      expect(CircularFungicidasData.entryForStage('R2')?.stageCode, 'R2');
      expect(CircularFungicidasData.entryForStage('R4')?.stageCode, 'R4');
      expect(CircularFungicidasData.entryForStage('R6')?.stageCode, 'R6');
      expect(CircularFungicidasData.entryForStage('R8')?.stageCode, 'R8');
    });

    test('has fungicide recommendations on critical stages', () {
      expect(
        CircularFungicidasData.entryForStage('R1')!.recommendations,
        isNotEmpty,
      );
      expect(
        CircularFungicidasData.entryForStage('R5')!.recommendations.first.product,
        contains('Fox Ultra'),
      );
    });

    test('R8 has management but no foliar products', () {
      final r8 = CircularFungicidasData.entryForStage('R8')!;
      expect(r8.recommendations, isEmpty);
      expect(r8.management, contains('Sem aplicação'));
      expect(CircularFungicidasData.hasContentForStage('R8'), isTrue);
    });
  });
}
