import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/theme/app_colors.dart';
import 'package:agrimind/core/theme/theme_dark_black.dart';
import 'package:agrimind/core/widgets/dark_app_bar.dart';
import 'package:agrimind/core/widgets/dark_dropdown_field.dart';
import 'package:agrimind/core/widgets/dark_surface_card.dart';
import 'package:agrimind/core/widgets/lab_template_card.dart';
import 'package:agrimind/core/widgets/primary_back_link.dart';

void main() {
  testWidgets('PrimaryBackLink usa primary legível', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: const Scaffold(
          backgroundColor: AppColors.background,
          body: PrimaryBackLink(label: 'Voltar para plantio'),
        ),
      ),
    );

    final label = tester.widget<Text>(find.text('Voltar para plantio'));
    expect(label.style?.color, AppColors.primary);

    final icon = tester.widget<Icon>(find.byIcon(Icons.arrow_back));
    expect(icon.color, AppColors.primary);
  });

  testWidgets('DarkAppBar chevron usa primary', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: Scaffold(
          appBar: DarkAppBar(title: 'Novo Template'),
          body: const SizedBox.shrink(),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.chevron_left));
    expect(icon.color, AppColors.primary);
  });

  testWidgets('LabTemplateCard usa surfaceContainer, não preto puro', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: Scaffold(
          body: LabTemplateCard(
            title: 'K, Ca, Mg: cmolc/dm³',
            badgeLabel: 'Padrão',
            onTap: () {},
          ),
        ),
      ),
    );

    final box = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byType(DarkSurfaceCard),
        matching: find.byType(DecoratedBox),
      ).first,
    );
    final decoration = box.decoration as BoxDecoration;
    expect(decoration.color, AppColors.surfaceContainer);
    expect(decoration.color, isNot(Colors.black));
  });

  testWidgets('DarkDropdownField dropdown legível', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: Scaffold(
          body: DarkDropdownField<String>(
            value: 'cmolc/dm³',
            items: const [
              DropdownMenuItem(value: 'cmolc/dm³', child: Text('cmolc/dm³')),
            ],
            onChanged: (_) {},
          ),
        ),
      ),
    );

    final dropdown = tester.widget<DropdownButtonFormField<String>>(
      find.byType(DropdownButtonFormField<String>),
    );
    expect(dropdown.style?.color, AppColors.primary);
    expect(dropdown.dropdownColor, AppColors.surfaceElevated);
  });
}
