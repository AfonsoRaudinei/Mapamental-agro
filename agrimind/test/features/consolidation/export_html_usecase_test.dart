import 'dart:io';

import 'package:agrimind/features/consolidation/domain/entities/consolidacao_entity.dart';
import 'package:agrimind/features/consolidation/domain/usecases/export_html_usecase.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/path_provider');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'getTemporaryDirectory') {
        return Directory.systemTemp.path;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('gera HTML offline com dados do plano e produto consolidado', () async {
    final now = DateTime(2026, 6, 20);
    final plano = PlanoEntity(
      id: 'plano-html',
      nome: 'Minha Lavoura',
      cultura: 'Soja',
      safra: '2026/27',
      areaHaTotal: 100,
      status: 'rascunho',
      createdAt: now,
      updatedAt: now,
      produtorNomeLivre: 'Produtor Teste',
      fazendaNomeLivre: 'Fazenda Teste',
      cidadeUf: 'Sorriso / MT',
      consultorNome: 'Consultor Teste',
      precoGraoSc60: 120,
      estadios: [
        EstadioEntity(
          id: 'estadio-1',
          planoId: 'plano-html',
          codigo: 'R1',
          label: 'R1 - Florescimento',
          ordem: 1,
          createdAt: now,
          produtos: [
            ProdutoAplicacaoEntity(
              id: 'produto-1',
              estadioId: 'estadio-1',
              produtoNome: 'Produto Teste',
              produtoCategoria: 'Fungicida',
              dose: 0.5,
              doseUnidade: 'L/ha',
              areaHa: 100,
              precoUnitario: 10,
              ordem: 1,
              createdAt: now,
            ),
          ],
        ),
      ],
    );
    final consolidacao = ConsolidacaoEntity(
      plano: plano,
      geradoEm: now,
      itens: const [],
    );

    final file = await const ExportHtmlUseCase().call(consolidacao);
    final html = await file.readAsString();

    expect(html, contains('Minha Lavoura'));
    expect(html, contains('Produtor Teste'));
    expect(html, contains('Fazenda Teste'));
    expect(html, contains('Produto Teste'));
    expect(html, contains('Consultor Teste'));
  });
}
