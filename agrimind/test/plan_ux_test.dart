import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/theme/app_colors.dart';
import 'package:agrimind/core/theme/theme_dark_black.dart';
import 'package:agrimind/core/theme/theme_provider.dart';
import 'package:agrimind/features/plan/data/plan_repository.dart';
import 'package:agrimind/features/plan/domain/plan_models.dart';
import 'package:agrimind/features/plan/presentation/widgets/stage_card.dart';

void main() {
  testWidgets('StageCard uses dark card colors, not white', (tester) async {
    const stage = StageModel(
      id: 'stage-vc',
      planId: 'plan-1',
      code: 'VC',
      name: 'Cotilédone',
      sortOrder: 0,
      isExpanded: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: darkBlackTheme,
          home: const Scaffold(
            body: StageCard(stage: stage, products: []),
          ),
        ),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, AppColors.surfaceContainer);
    expect(card.color, isNot(Colors.white));
  });

  testWidgets('StageCard shows label above input without overlap', (tester) async {
    const stage = StageModel(
      id: 'stage-v5',
      planId: 'plan-1',
      code: 'V5',
      name: '5º Nó',
      sortOrder: 1,
      isExpanded: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => throw UnimplementedError()),
          planStateProvider.overrideWith(() => _FakePlanNotifier()),
        ],
        child: MaterialApp(
          theme: darkBlackTheme,
          home: const Scaffold(
            body: StageCard(stage: stage, products: []),
          ),
        ),
      ),
    );

    expect(find.text('Nome do estádio'), findsOneWidget);
    expect(find.text('V5 — 5º Nó'), findsOneWidget);
    expect(find.text('Ex: 5º Nó'), findsOneWidget);

    final labelBox = tester.getRect(find.text('Nome do estádio'));
    final fieldBox = tester.getRect(find.byType(TextField));
    expect(labelBox.bottom, lessThan(fieldBox.top));
  });

  test('AppTheme.darkBlack is default in ThemeNotifier', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(themeProvider), AppTheme.darkBlack);
  });
}

class _FakePlanNotifier extends PlanNotifier {
  @override
  Future<PlanState> build() async {
    return PlanState(
      plan: const PlanModel(id: 'plan-1', clientId: 'client-1'),
      stages: const [],
      productsByStage: const {},
    );
  }
}
