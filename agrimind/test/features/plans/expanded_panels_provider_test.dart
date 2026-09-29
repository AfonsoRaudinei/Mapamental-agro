import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/features/plans/presentation/providers/expanded_panels_provider.dart';

void main() {
  test('inicia vazio e toggle adiciona/remove o id', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(expandedPanelsProvider), isEmpty);

    container.read(expandedPanelsProvider.notifier).state = {'v5'};
    expect(container.read(expandedPanelsProvider), {'v5'});

    container.read(expandedPanelsProvider.notifier).state = <String>{};
    expect(container.read(expandedPanelsProvider), isEmpty);
  });

  testWidgets('painéis abrem de forma independente', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: _PanelsProbe())),
      ),
    );

    expect(find.text('a-closed'), findsOneWidget);
    expect(find.text('b-closed'), findsOneWidget);

    await tester.tap(find.text('toggle-a'));
    await tester.pump();
    expect(find.text('a-open'), findsOneWidget);
    expect(find.text('b-closed'), findsOneWidget);

    await tester.tap(find.text('toggle-b'));
    await tester.pump();
    expect(find.text('a-open'), findsOneWidget);
    expect(find.text('b-open'), findsOneWidget);

    await tester.tap(find.text('toggle-a'));
    await tester.pump();
    expect(find.text('a-closed'), findsOneWidget);
    expect(find.text('b-open'), findsOneWidget);
  });
}

class _PanelsProbe extends ConsumerWidget {
  const _PanelsProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(ref.isPanelExpanded('a') ? 'a-open' : 'a-closed'),
        Text(ref.isPanelExpanded('b') ? 'b-open' : 'b-closed'),
        TextButton(
          onPressed: () => ref.togglePanel('a'),
          child: const Text('toggle-a'),
        ),
        TextButton(
          onPressed: () => ref.togglePanel('b'),
          child: const Text('toggle-b'),
        ),
      ],
    );
  }
}
