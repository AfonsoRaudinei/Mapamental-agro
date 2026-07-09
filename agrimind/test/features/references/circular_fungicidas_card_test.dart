import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:agrimind/core/theme/app_colors.dart';
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
          scaffoldBackgroundColor: AppColors.background,
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
}
