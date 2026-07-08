import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/theme/app_colors.dart';
import 'package:agrimind/core/theme/theme_dark_black.dart';
import 'package:agrimind/features/references/data/circular_fungicidas_data.dart';
import 'package:agrimind/features/references/domain/reference_models.dart';
import 'package:agrimind/features/references/presentation/references_screen.dart';
import 'package:agrimind/features/references/presentation/widgets/golden_book_icon.dart';
import 'package:agrimind/features/references/presentation/widgets/reference_featured_card.dart';
import 'package:agrimind/features/references/presentation/widgets/reference_grid_card.dart';

void main() {
  group('ReferenceKind', () {
    test('circularFungicidas está disponível', () {
      expect(ReferenceKind.circularFungicidas.isAvailable, isTrue);
      expect(ReferenceKind.circularFungicidas.title, 'Circular fungicidas');
    });

    test('outras referências ainda em breve', () {
      expect(ReferenceKind.insetos.isAvailable, isFalse);
      expect(ReferenceKind.nutricao.isAvailable, isFalse);
      expect(ReferenceKind.fisiologia.isAvailable, isFalse);
      expect(ReferenceKind.campeoesCesb.isAvailable, isFalse);
    });
  });

  group('CircularFungicidasData', () {
    test('contém estádios VE a R8', () {
      expect(CircularFungicidasData.stages, isNotEmpty);
      expect(
        CircularFungicidasData.stages.map((s) => s.stageCode),
        containsAll(['V4', 'V5', 'R1', 'R5', 'R8']),
      );
    });

    test('V5 tem recomendações de ferrugem', () {
      final v5 = CircularFungicidasData.stages.firstWhere((s) => s.stageCode == 'V5');
      expect(v5.recommendations.length, greaterThanOrEqualTo(3));
      expect(v5.recommendations.first.product, 'Blindado TOV');
    });
  });

  testWidgets('GoldenBookIcon usa cor dourada', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: GoldenBookIcon())),
    );

    final icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, AppColors.gold);
  });

  testWidgets('ReferencesScreen exibe grid e Circular fungicidas', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: const Scaffold(body: ReferencesScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Referências'), findsOneWidget);
    expect(find.text('Doenças'), findsOneWidget);
    expect(find.text('Insetos'), findsOneWidget);
    expect(find.text('Nutrição'), findsOneWidget);
    expect(find.text('Fisiologia'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Circular fungicidas'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Circular fungicidas'), findsOneWidget);
    expect(find.text('Campeões CESB'), findsOneWidget);
    expect(find.byType(GoldenBookIcon), findsOneWidget);
  });

  testWidgets('ReferenceGridCard usa DarkSurfaceCard escuro', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: const Scaffold(
          body: ReferenceGridCard(kind: ReferenceKind.doencas),
        ),
      ),
    );

    expect(find.text('Em breve'), findsOneWidget);
  });

  testWidgets('ReferenceFeaturedCard com livro dourado navega', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: Scaffold(
          body: ReferenceFeaturedCard(
            kind: ReferenceKind.circularFungicidas,
            useGoldenBookIcon: true,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.byType(GoldenBookIcon), findsOneWidget);
    expect(find.text('Circular fungicidas'), findsOneWidget);
  });
}
