import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrimind/core/theme/app_theme.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/presentation/models/product_view_model.dart';
import 'package:agrimind/features/plans/presentation/models/stage_view_model.dart';
import 'package:agrimind/features/plans/presentation/providers/plano_detail_provider.dart';
import 'package:agrimind/features/plans/presentation/providers/stage_provider.dart';
import 'package:agrimind/features/plans/presentation/providers/stage_view_model_key.dart';
import 'package:agrimind/features/plans/presentation/widgets/stage_card.dart';

void main() {
  group('StageCard', () {
    testWidgets('estádio com 3 produtos mostra nomes e countLabel',
        (tester) async {
      final vm = _stageViewModel(
        products: [
          _product('p1', 'Orkestra SC'),
          _product('p2', 'Fox'),
          _product('p3', 'Standak Top'),
        ],
      );

      await tester.pumpWidget(_host(
        StageCard(
          viewModel: vm,
          isExpanded: true,
          onToggle: () {},
          onAddProduct: () {},
          onEditProduct: (_) {},
          onDeleteProduct: (_) {},
        ),
      ));

      expect(find.text('3 produtos'), findsOneWidget);
      expect(find.text('Orkestra SC'), findsOneWidget);
      expect(find.text('Fox'), findsOneWidget);
      expect(find.text('Standak Top'), findsOneWidget);
    });

    testWidgets('vazio mostra Nenhum produto e Adicionar produto',
        (tester) async {
      await tester.pumpWidget(_host(
        StageCard(
          viewModel: _stageViewModel(products: []),
          isExpanded: true,
          onToggle: () {},
          onAddProduct: () {},
          onEditProduct: (_) {},
          onDeleteProduct: (_) {},
        ),
      ));

      expect(find.text('Nenhum produto'), findsOneWidget);
      expect(find.text('Adicionar produto'), findsOneWidget);
    });

    testWidgets('nome longo usa até 2 linhas sem overflow', (tester) async {
      const longName =
          'Fungicida multissítio com nome comercial muito extenso para campo';
      await tester.pumpWidget(_host(
        StageCard(
          viewModel: _stageViewModel(
            products: [_product('p1', longName)],
          ),
          isExpanded: true,
          onToggle: () {},
          onAddProduct: () {},
          onEditProduct: (_) {},
          onDeleteProduct: (_) {},
        ),
      ));

      expect(tester.takeException(), isNull);
      final text = tester.widget<Text>(find.text(longName));
      expect(text.maxLines, 2);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('toque no cabeçalho alterna expansão', (tester) async {
      var expanded = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return _host(
              StageCard(
                viewModel: _stageViewModel(products: [_product('p1', 'A')]),
                isExpanded: expanded,
                onToggle: () => setState(() => expanded = !expanded),
                onAddProduct: () {},
                onEditProduct: (_) {},
                onDeleteProduct: (_) {},
              ),
            );
          },
        ),
      );

      expect(find.text('Adicionar produto'), findsNothing);
      await tester.tap(find.text('V4 — 4º Nó'));
      await tester.pumpAndSettle();
      expect(find.text('Adicionar produto'), findsOneWidget);

      await tester.tap(find.text('V4 — 4º Nó'));
      await tester.pumpAndSettle();
      expect(find.text('Adicionar produto'), findsNothing);
    });

    testWidgets('swipe chama onDeleteProduct com id correto', (tester) async {
      String? deletedId;

      await tester.pumpWidget(_host(
        StageCard(
          viewModel: _stageViewModel(
            products: [_product('prod-42', 'Orkestra SC')],
          ),
          isExpanded: true,
          onToggle: () {},
          onAddProduct: () {},
          onEditProduct: (_) {},
          onDeleteProduct: (id) => deletedId = id,
        ),
      ));

      await tester.drag(find.text('Orkestra SC'), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(CupertinoDialogAction, 'Remover'));
      await tester.pumpAndSettle();

      expect(deletedId, 'prod-42');
    });
  });

  test('stageProvider do estádio B não notifica quando só A muda', () async {
    const planoId = 'plano-1';
    final estadioA = _estadio('stage-a', 'Produto A');
    final estadioB = _estadio('stage-b', 'Produto B');
    var plano = _plano(planoId, [estadioA, estadioB]);

    final container = ProviderContainer(
      overrides: [
        planoDetailProvider(planoId).overrideWith((ref) async => plano),
      ],
    );

    await container.read(planoDetailProvider(planoId).future);

    const keyB = StageViewModelKey(planoId: planoId, stageId: 'stage-b');
    var notificationsB = 0;
    container.listen(
      stageProvider(keyB),
      (previous, next) {
        if (previous != null) notificationsB++;
      },
    );

    final updatedA = estadioA.copyWith(
      produtos: [
        ...estadioA.produtos,
        ProdutoAplicacaoEntity(
          id: 'new',
          estadioId: 'stage-a',
          produtoNome: 'Novo',
          produtoCategoria: 'Geral',
          dose: 1,
          doseUnidade: 'L/ha',
          areaHa: 100,
          ordem: 1,
          createdAt: DateTime(2026),
        ),
      ],
    );
    plano = plano.copyWith(estadios: [updatedA, estadioB]);
    container.invalidate(planoDetailProvider(planoId));
    await container.read(planoDetailProvider(planoId).future);
    container.read(stageProvider(keyB));

    expect(notificationsB, 0);
    container.dispose();
  });
}

Widget _host(Widget child) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: child),
  );
}

StageViewModel _stageViewModel({required List<ProductViewModel> products}) {
  return StageViewModel(
    id: 'stage-1',
    stageCode: 'V4',
    title: 'V4 — 4º Nó',
    countLabel: products.isEmpty
        ? 'Nenhum produto'
        : products.length == 1
            ? '1 produto'
            : '${products.length} produtos',
    products: products,
  );
}

ProductViewModel _product(String id, String name) {
  return ProductViewModel(
    id: id,
    name: name,
    doseLabel: '0.30 L/ha',
    totalLabel: '300.0 L',
    isActive: true,
  );
}

EstadioEntity _estadio(String id, String produtoNome) {
  return EstadioEntity(
    id: id,
    planoId: 'plano-1',
    codigo: 'V4',
    label: 'V4 — 4º Nó',
    ordem: 0,
    createdAt: DateTime(2026),
    produtos: [
      ProdutoAplicacaoEntity(
        id: 'prod-$id',
        estadioId: id,
        produtoNome: produtoNome,
        produtoCategoria: 'Geral',
        dose: 0.3,
        doseUnidade: 'L/ha',
        areaHa: 1000,
        ordem: 0,
        createdAt: DateTime(2026),
      ),
    ],
  );
}

PlanoEntity _plano(String id, List<EstadioEntity> estadios) {
  return PlanoEntity(
    id: id,
    nome: 'Plano',
    cultura: 'Soja',
    safra: '26/27',
    areaHaTotal: 1000,
    status: 'ativo',
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
    estadios: estadios,
  );
}
