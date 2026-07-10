import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/constants/app_colors.dart';
import 'package:agrimind/core/constants/categoria_referencia.dart';
import 'package:agrimind/core/constants/references_book_accents.dart';
import 'package:agrimind/core/widgets/references_book_icon.dart';

void main() {
  test('canvas accent prioritizes golden fungicide book', () {
    expect(
      ReferencesBookAccents.canvasAccent(
        hasCircularFungicidas: true,
        available: const [],
      ),
      AppColors.refBookFungicidas,
    );
    expect(
      ReferencesBookAccents.forCategoria(CategoriaReferencia.doencas),
      AppColors.refBookFungicidas,
    );
    expect(
      ReferencesBookAccents.forCategoria(CategoriaReferencia.insetos),
      AppColors.refBookInsetos,
    );
  });

  testWidgets('ReferencesBookIcon renders filled golden book', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ReferencesBookIcon(
            accent: AppColors.refBookFungicidas,
            enabled: true,
            compact: true,
          ),
        ),
      ),
    );

    expect(find.byType(ReferencesBookIcon), findsOneWidget);
  });
}
