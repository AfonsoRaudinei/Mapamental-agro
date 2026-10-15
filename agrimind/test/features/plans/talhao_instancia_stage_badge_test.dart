import 'package:agrimind/features/plans/presentation/widgets/talhao_instancia_stage_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/theme/app_theme.dart';

void main() {
  testWidgets('badge mostra nome do talhão', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: TalhaoInstanciaStageBadge(talhaoLabel: 'Área Norte'),
        ),
      ),
    );
    expect(find.text('Área Norte'), findsOneWidget);
  });
}
