import 'package:flutter/material.dart';

import '../../domain/reference_models.dart';
import '../pages/circular_fungicidas_page.dart';
import 'reference_featured_card.dart';

/// Card plug-and-play para a tela Referências do MacBook.
///
/// Uso na sua `references_page.dart` (ou equivalente):
/// ```dart
/// const SizedBox(height: 12),
/// const CircularFungicidasCard(),
/// ```
class CircularFungicidasCard extends StatelessWidget {
  const CircularFungicidasCard({super.key});

  static void open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const CircularFungicidasPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReferenceFeaturedCard(
      kind: ReferenceKind.circularFungicidas,
      useGoldenBookIcon: true,
      onTap: () => open(context),
    );
  }
}
