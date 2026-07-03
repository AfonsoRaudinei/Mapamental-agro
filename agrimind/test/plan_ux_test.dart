import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/theme/app_colors.dart';
import 'package:agrimind/core/theme/theme_dark_black.dart';
import 'package:agrimind/core/theme/theme_provider.dart';
import 'package:agrimind/core/widgets/dark_surface_card.dart';
import 'package:agrimind/features/plan/data/plan_repository.dart';
import 'package:agrimind/features/plan/domain/plan_models.dart';
import 'package:agrimind/features/plan/presentation/widgets/client_selector_card.dart';
import 'package:agrimind/features/plan/presentation/widgets/stage_card.dart';

void main() {
  testWidgets('DarkSurfaceCard nunca renderiza branco', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DarkSurfaceCard(
            child: SizedBox(height: 48, width: 200),
          ),
        ),
      ),
    );

    final box = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byType(DarkSurfaceCard),
        matching: find.byType(DecoratedBox),
      ).first,
    );
    final decoration = box.decoration as BoxDecoration;
    expect(decoration.color, AppColors.surfaceContainer);
    expect(decoration.color, isNot(Colors.white));
  });

  testWidgets('StageCard usa DarkSurfaceCard escuro', (tester) async {
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

    expect(find.byType(DarkSurfaceCard), findsOneWidget);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('ClientSelectorCard usa DarkSurfaceCard escuro', (tester) async {
    const client = ClientModel(
      id: 'c1',
      name: 'Adriel Pasqualli',
      areaHa: 1000,
      harvest: '2025/26',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: Scaffold(
          body: ClientSelectorCard(
            client: client,
            clients: const [client],
            onChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.byType(DarkSurfaceCard), findsOneWidget);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('M3 Card com ColorScheme incompleto pode ficar claro — Plano não usa Card', (tester) async {
    final incompleteTheme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: incompleteTheme,
        home: const Scaffold(body: Card(child: SizedBox(height: 40, width: 200))),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, isNot(AppColors.surfaceContainer));
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

  test('AppTheme.darkBlack é default antes do load async', () {
    expect(AppThemeX.fromLegacyId(null), AppTheme.darkBlack);
    expect(AppThemeX.fromLegacyId('dark'), AppTheme.darkBlack);
  });

  test('AppColors.darkScheme define surfaceContainer escuro', () {
    expect(AppColors.darkScheme.surfaceContainer, AppColors.surfaceContainer);
    expect(AppColors.darkScheme.surfaceContainer, isNot(Colors.white));
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
