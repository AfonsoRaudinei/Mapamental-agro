import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:agrimind/core/theme/app_theme.dart';
import 'package:agrimind/core/widgets/accordion_section.dart';

void main() {
  testWidgets('abre e fecha o conteúdo no cenário feliz', (tester) async {
    await tester.pumpWidget(const _AccordionHost());

    expect(find.text('Identificação do plano'), findsOneWidget);
    expect(find.text('100.0 ha · 2025/26'), findsOneWidget);
    expect(find.text('Formulário'), findsNothing);

    await tester.tap(find.text('Identificação do plano'));
    await tester.pumpAndSettle();

    expect(find.text('Formulário'), findsOneWidget);

    await tester.tap(find.text('Identificação do plano'));
    await tester.pumpAndSettle();

    expect(find.text('Formulário'), findsNothing);
  });

  testWidgets('chevron rotaciona com o estado expandido', (tester) async {
    await tester.pumpWidget(const _AccordionHost());

    final closed =
        tester.widget<AnimatedRotation>(find.byType(AnimatedRotation));
    expect(closed.turns, 0);

    await tester.tap(find.text('Identificação do plano'));
    await tester.pumpAndSettle();

    final open = tester.widget<AnimatedRotation>(find.byType(AnimatedRotation));
    expect(open.turns, 0.5);
    expect(find.byIcon(PhosphorIconsRegular.caretDown), findsOneWidget);
  });
}

class _AccordionHost extends StatefulWidget {
  const _AccordionHost();

  @override
  State<_AccordionHost> createState() => _AccordionHostState();
}

class _AccordionHostState extends State<_AccordionHost> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: AccordionSection(
          title: 'Identificação do plano',
          subtitle: '100.0 ha · 2025/26',
          isExpanded: expanded,
          onToggle: (value) => setState(() => expanded = value),
          child: const Text('Formulário'),
        ),
      ),
    );
  }
}
