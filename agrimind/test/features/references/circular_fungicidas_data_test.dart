import 'package:flutter_test/flutter_test.dart';
import 'package:agrimind/features/references/data/circular_fungicidas_data.dart';

void main() {
  group('CircularFungicidasData', () {
    test('covers VE–R8 stage aliases from the circular docs', () {
      expect(CircularFungicidasData.entryForStage('VE')?.stageCode, 'VE–V3');
      expect(CircularFungicidasData.entryForStage('V4')?.stageCode, 'V4');
      expect(CircularFungicidasData.entryForStage('V7')?.stageCode, 'V6');
      expect(CircularFungicidasData.entryForStage('R2')?.stageCode, 'R2');
      expect(CircularFungicidasData.entryForStage('R4')?.stageCode, 'R4');
      expect(CircularFungicidasData.entryForStage('R5.1')?.stageCode, 'R5');
      expect(CircularFungicidasData.entryForStage('R5.3')?.stageCode, 'R5');
      expect(CircularFungicidasData.entryForStage('R5.5')?.stageCode, 'R5');
      expect(CircularFungicidasData.entryForStage('R6')?.stageCode, 'R6');
      expect(CircularFungicidasData.entryForStage('R8')?.stageCode, 'R8');
    });

    test('has fungicide recommendations on critical stages', () {
      expect(
        CircularFungicidasData.entryForStage('R1')!.recommendations,
        isNotEmpty,
      );
      expect(
        CircularFungicidasData.entryForStage('R5')!
            .recommendations
            .any((item) => item.product == 'Fox Ultra + Milcozeb'),
        isTrue,
      );
    });

    test('keeps Fox Ultra fitotoxicity contrast in R1 and R2', () {
      for (final stageCode in ['R1', 'R2']) {
        final recommendations =
            CircularFungicidasData.entryForStage(stageCode)!.recommendations;
        final withMultisite = recommendations.singleWhere(
          (item) => item.product == 'Fox Ultra + Milcozeb',
        );
        final withoutMultisite = recommendations.singleWhere(
          (item) => item.product == 'Fox Ultra (sem Milcozeb)',
        );

        expect(withMultisite.fitotoxPercent, closeTo(2.7, 0.001));
        expect(withoutMultisite.fitotoxPercent, closeTo(9.4, 0.001));
        expect(withMultisite.notes, contains('fitotoxicidade elevada'));
        expect(withoutMultisite.notes, contains('fitotoxicidade elevada'));
      }
    });

    test('critical stages expose complete registered rust ranking', () {
      for (final stageCode in ['V5', 'R1', 'R2', 'R3', 'R4', 'R5.1']) {
        final products = CircularFungicidasData.entryForStage(stageCode)!
            .recommendations
            .map((item) => item.product)
            .toSet();
        expect(products, contains('Blindado TOV'));
        expect(products, contains('Fox Ultra + Milcozeb'));
        expect(products, contains('Fox Ultra (sem Milcozeb)'));
        expect(products, contains('Evolution'));
      }
    });

    test('R8 has management but no foliar products', () {
      final r8 = CircularFungicidasData.entryForStage('R8')!;
      expect(r8.recommendations, isEmpty);
      expect(r8.management, contains('Sem aplicação'));
      expect(CircularFungicidasData.hasContentForStage('R8'), isTrue);
    });

    test('empty-recommendation stages are not usable in plan', () {
      final ve = CircularFungicidasData.entryForStage('VE')!;
      expect(ve.recommendations, isEmpty);
      final r8 = CircularFungicidasData.entryForStage('R8')!;
      expect(r8.recommendations, isEmpty);
    });
  });
}
