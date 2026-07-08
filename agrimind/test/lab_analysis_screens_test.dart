import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/theme/app_colors.dart';
import 'package:agrimind/core/theme/theme_dark_black.dart';
import 'package:agrimind/core/widgets/primary_back_link.dart';
import 'package:agrimind/features/analysis/presentation/soil_analysis_screen.dart';
import 'package:agrimind/features/lab/presentation/lab_template_form_screen.dart';
import 'package:agrimind/features/lab/presentation/lab_templates_screen.dart';

void main() {
  testWidgets('SoilAnalysisScreen exibe PrimaryBackLink legível', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: const SoilAnalysisScreen(),
      ),
    );

    expect(find.byType(PrimaryBackLink), findsOneWidget);
    expect(find.text('Voltar para plantio'), findsOneWidget);

    final label = tester.widget<Text>(find.text('Voltar para plantio'));
    expect(label.style?.color, AppColors.primary);
  });

  testWidgets('LabTemplatesScreen usa LabTemplateCard escuro', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: const LabTemplatesScreen(),
      ),
    );

    expect(find.text('Modelos de Laboratório'), findsOneWidget);
    expect(find.text('K, Ca, Mg: cmolc/dm³ · M.O.: g/dm³'), findsOneWidget);
    expect(find.text('Padrão'), findsWidgets);
  });

  testWidgets('LabTemplateFormScreen dropdowns legíveis', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkBlackTheme,
        home: const LabTemplateFormScreen(),
      ),
    );

    expect(find.text('Novo Template'), findsOneWidget);
    expect(find.text('UNIDADES PADRÃO'), findsOneWidget);
    expect(find.text('Criar Template'), findsOneWidget);
    expect(find.text('cmolc/dm³'), findsWidgets);
  });
}
