import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:agrimind/core/constants/app_colors.dart';
import 'package:agrimind/core/constants/app_spacing.dart';
import 'package:agrimind/core/theme/app_colors.dart' as dark;
import 'package:agrimind/features/references/presentation/pages/circular_fungicidas_page.dart';
import 'package:agrimind/features/references/presentation/pages/references_home_page.dart';

void main() {
  testWidgets('Circular fungicidas card opens the detail page', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1800));

    final router = GoRouter(
      initialLocation: '/references',
      routes: [
        GoRoute(
          path: '/references',
          builder: (_, __) => const ReferencesHomePage(),
        ),
        GoRoute(
          path: '/references/circular-fungicidas',
          builder: (_, __) => const CircularFungicidasPage(),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.backgroundDark,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -900));
    await tester.pumpAndSettle();

    expect(find.text('Circular fungicidas'), findsOneWidget);
    expect(
      find.text('Estádio → doença → fungicida (Embrapa CT-219)'),
      findsOneWidget,
    );

    await tester.tap(find.text('Circular fungicidas'));
    await tester.pumpAndSettle();

    expect(find.text('Circular fungicidas'), findsWidgets);
    expect(find.text('Fontes'), findsOneWidget);
  });

  testWidgets('Circular list reserves shell tab gap', (tester) async {
    const viewPadding = EdgeInsets.only(bottom: 34);
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(padding: viewPadding),
        child: MaterialApp(home: CircularFungicidasPage()),
      ),
    );

    final listView = tester.widget<ListView>(find.byType(ListView));
    final padding = listView.padding! as EdgeInsets;
    expect(
      padding.bottom,
      AppSpacing.tabBarContentHeight + viewPadding.bottom + AppSpacing.md,
    );
  });

  testWidgets('Circular disease chips use on-surface label color',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 1200));
    await tester.pumpWidget(
      const MaterialApp(home: CircularFungicidasPage()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('5º nó'));
    await tester.pumpAndSettle();

    final chip = tester.widget<Chip>(find.widgetWithText(Chip, 'Antracnose'));
    expect(chip.labelStyle?.color, dark.AppColors.onSurface);
    expect(chip.backgroundColor, dark.AppColors.surfaceElevated);
  });
}
