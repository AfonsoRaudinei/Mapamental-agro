import 'package:agrimind/features/clients/presentation/widgets/cronograma_modo_avulso_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/theme/app_theme.dart';

void main() {
  testWidgets('banner explica modo avulso sem plano', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: CronogramaModoAvulsoBanner()),
      ),
    );
    expect(find.text(CronogramaModoAvulsoBanner.titulo), findsOneWidget);
    expect(find.textContaining('modo avulso'), findsOneWidget);
    expect(find.text('Criar plano para esta fazenda'), findsOneWidget);
  });
}
