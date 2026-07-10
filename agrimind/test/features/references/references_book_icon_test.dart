import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/constants/app_colors.dart';
import 'package:agrimind/core/constants/categoria_referencia.dart';
import 'package:agrimind/core/constants/references_book_accents.dart';
import 'package:agrimind/core/widgets/references_book_icon.dart';

void main() {
  test('circular tecnica accent stays golden; CESB keeps amber', () {
    expect(
      ReferencesBookAccents.circularTecnica,
      AppColors.refBookFungicidas,
    );
    expect(
      ReferencesBookAccents.forCategoria(CategoriaReferencia.cesb),
      AppColors.refBookCesb,
    );
    expect(
      ReferencesBookAccents.forCategoria(CategoriaReferencia.insetos),
      AppColors.refBookInsetos,
    );
  });

  testWidgets('outline and filled book icons both render', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              ReferencesBookIcon(
                accent: AppColors.textPrimaryDark,
                enabled: true,
                compact: true,
              ),
              ReferencesBookIcon(
                accent: AppColors.refBookFungicidas,
                enabled: true,
                compact: true,
                filled: true,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(ReferencesBookIcon), findsNWidgets(2));
  });
}
