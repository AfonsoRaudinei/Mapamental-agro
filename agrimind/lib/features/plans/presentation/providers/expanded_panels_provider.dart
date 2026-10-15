import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Estado efêmero: quais painéis accordion estão abertos na tela atual.
/// autoDispose porque não é dado de negócio — não deve sobreviver à navegação.
final expandedPanelsProvider =
    StateProvider.autoDispose<Set<String>>((ref) => <String>{});

const identificacaoPanelId = 'identificacao';
const cultivarPanelId = 'cultivar';

extension ExpandedPanelsX on WidgetRef {
  bool isPanelExpanded(String id) =>
      watch(expandedPanelsProvider.select((ids) => ids.contains(id)));

  void togglePanel(String id) {
    final notifier = read(expandedPanelsProvider.notifier);
    final next = Set<String>.from(notifier.state);
    next.contains(id) ? next.remove(id) : next.add(id);
    notifier.state = next;
  }

  void collapsePanel(String id) {
    final notifier = read(expandedPanelsProvider.notifier);
    if (!notifier.state.contains(id)) return;
    notifier.state = Set<String>.from(notifier.state)..remove(id);
  }

  void expandPanel(String id) {
    final notifier = read(expandedPanelsProvider.notifier);
    if (notifier.state.contains(id)) return;
    notifier.state = Set<String>.from(notifier.state)..add(id);
  }
}
