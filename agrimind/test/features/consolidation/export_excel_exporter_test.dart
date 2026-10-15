import 'dart:io';

import 'package:agrimind/features/consolidation/data/exporters/export_excel_exporter.dart';
import 'package:agrimind/features/consolidation/domain/entities/consolidacao_entity.dart';
import 'package:agrimind/features/consolidation/domain/entities/consolidacao_item_entity.dart';
import 'package:agrimind/features/consolidation/domain/entities/consolidacao_semente_linha.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/plano_entity.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:excel/excel.dart';
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

  test('exporta Excel por estádio sem locale inicializado antes', () async {
    final now = DateTime(2026, 9, 29, 19, 51);
    final plano = PlanoEntity(
      id: 'plano-excel',
      nome: 'Plano soja',
      cultura: 'Soja',
      safra: '2026/27',
      areaHaTotal: 720,
      status: 'ativo',
      createdAt: now,
      updatedAt: now,
      produtorNomeLivre: 'Jonatha Pereira',
      fazendaNomeLivre: 'Fazenda São Domingo',
      cidadeUf: 'Sorriso / MT',
      consultorNome: 'Consultor Agri',
      precoGraoSc60: 120,
      dataVencimento: DateTime(2026, 12, 15),
      estadios: [
        EstadioEntity(
          id: 'est-1',
          planoId: 'plano-excel',
          codigo: 'DES',
          label: 'Dessecacao',
          ordem: 1,
          createdAt: now,
          produtos: [
            _produto(
              id: 'p1',
              estadioId: 'est-1',
              nome: 'Glyfosato 720 wg',
              dose: 2.5,
              area: 720,
              preco: 33,
              now: now,
            ),
            _produto(
              id: 'p2',
              estadioId: 'est-1',
              nome: 'Clorimurin 250',
              dose: 0.07,
              area: 720,
              now: now,
            ),
          ],
        ),
        EstadioEntity(
          id: 'est-vazio',
          planoId: 'plano-excel',
          codigo: 'V1',
          label: 'V1',
          ordem: 2,
          createdAt: now,
        ),
        EstadioEntity(
          id: 'est-2',
          planoId: 'plano-excel',
          codigo: 'POS',
          label: 'Pos - Emergente',
          ordem: 3,
          createdAt: now,
          produtos: [
            _produto(
              id: 'p3',
              estadioId: 'est-2',
              nome: 'Haloxip 124',
              dose: 0.8,
              area: 720,
              now: now,
            ),
          ],
        ),
      ],
    );

    final file = await const ExportExcelExporter().call(
      ConsolidacaoEntity(
        plano: plano,
        geradoEm: now,
        itens: const [
          ConsolidacaoItemEntity(
            produtoNome: 'Glyfosato 720 wg',
            categoria: 'Herbicida',
            quantidadeTotal: 1800,
            unidade: 'L',
            precoUnitario: 33,
            temUnidadeMista: false,
            detalhe: [],
          ),
        ],
      ),
    );
    addTearDown(() => file.existsSync() ? file.delete() : null);

    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    expect(excel.sheets.keys.toSet(), {'Aplicações', 'Resumo'});
    expect(excel.getDefaultSheet(), 'Aplicações');

    final values = _sheetText(excel['Aplicações']);
    expect(values, isNot(contains('Identificação do plano')));
    expect(values, isNot(contains('Status')));
    expect(values, isNot(contains('Ativo')));
    expect(values, isNot(contains('Rascunho')));
    expect(values, contains('Produtor'));
    expect(values, contains('Jonatha Pereira'));
    expect(values, contains('Fazenda São Domingo'));
    expect(values, contains('Sorriso / MT'));
    expect(values, contains('Consultor Agri'));
    expect(values, contains('Plano'));
    expect(values, contains('Plano soja'));
    expect(values, contains('Estádio'));
    expect(values, contains('Dose'));
    expect(values, contains('Produto'));
    expect(values, contains('DES — Dessecacao'));
    expect(values, contains('Glyfosato 720 wg'));
    expect(values, contains('2,5 L/ha'));
    expect(values, contains('720'));
    expect(values, contains('1.800 L'));
    expect(values, contains(r'R$ 33,00'));
    expect(values, contains(r'R$ 59.400,00'));
    expect(values, contains('Clorimurin 250'));
    expect(values, contains('0,07 L/ha'));
    expect(values, contains(r'R$ 0,00'));
    expect(values, contains('POS — Pos - Emergente'));
    expect(values, contains('Haloxip 124'));
    expect(values, isNot(contains('V1')));

    final resumo = _sheetText(excel['Resumo']);
    expect(resumo, contains('Produtor'));
    expect(resumo, contains('Jonatha Pereira'));
    expect(resumo, contains('Categoria'));
    expect(resumo, contains('Herbicida'));
    expect(resumo, contains('Glyfosato 720 wg'));
  });

  test('exporta V5 com unidades, área efetiva e aba Sementes', () async {
    final now = DateTime(2026, 10, 4, 16);
    final plano = PlanoEntity(
      id: 'plano-v5',
      nome: 'Plano Morro Vermelho',
      cultura: 'Soja',
      safra: '2025/26',
      areaHaTotal: 720,
      status: 'ativo',
      createdAt: now,
      updatedAt: now,
      produtorNomeLivre: 'Jhonata Pereira',
      fazendaNomeLivre: 'Morro Vermelho',
      estadios: [
        EstadioEntity(
          id: 'est-v5',
          planoId: 'plano-v5',
          codigo: 'V5',
          label: 'Pós-emergente',
          ordem: 1,
          createdAt: now,
          produtos: [
            ProdutoAplicacaoEntity(
              id: 'p-gli',
              estadioId: 'est-v5',
              produtoNome: 'Glifosato WG',
              produtoCategoria: 'Herbicida',
              dose: 2.5,
              doseUnidade: 'kg/ha',
              areaHa: 625,
              precoUnitario: null,
              ordem: 0,
              createdAt: now,
            ),
          ],
        ),
      ],
    );

    final file = await const ExportExcelExporter().call(
      ConsolidacaoEntity(
        plano: plano,
        geradoEm: now,
        itens: const [
          ConsolidacaoItemEntity(
            produtoNome: 'Glifosato WG',
            categoria: 'Herbicida',
            quantidadeTotal: 1562.5,
            unidade: 'kg',
            temUnidadeMista: false,
            detalhe: [],
          ),
        ],
        sementes: const [
          ConsolidacaoSementeLinha(
            cultivar: 'Olimpo',
            talhaoNome: 'Talhão 1',
            areaHa: 95,
            populacaoSementesPorHa: 300000,
            embalagens: 6,
            sementesPorMetroLinear: 15,
          ),
        ],
      ),
    );
    addTearDown(() => file.existsSync() ? file.delete() : null);

    final excel = Excel.decodeBytes(await file.readAsBytes());
    expect(excel.sheets.keys.toSet(), {'Aplicações', 'Resumo', 'Sementes'});

    final aplicacoes = _sheetText(excel['Aplicações']);
    expect(aplicacoes, contains('V5 — Pós-emergente'));
    expect(aplicacoes, contains('Glifosato WG'));
    expect(aplicacoes, contains('2,5 kg/ha'));
    expect(aplicacoes, contains('625'));
    expect(aplicacoes, contains('1.562,5 kg'));

    final sementes = _sheetText(excel['Sementes']);
    expect(sementes, contains('Olimpo'));
    expect(sementes, contains('Talhão 1'));
    expect(sementes, contains('300.000'));
    expect(sementes, contains('15'));
    expect(sementes, contains('6'));
    expect(sementes, isNot(contains('28.500.000')));
  });
}

String _sheetText(Sheet sheet) {
  return <String>[
    for (final row in sheet.rows)
      for (final cell in row)
        if (cell?.value != null) cell!.value.toString(),
  ].join('\n');
}

ProdutoAplicacaoEntity _produto({
  required String id,
  required String estadioId,
  required String nome,
  required double dose,
  required double area,
  required DateTime now,
  double? preco,
}) {
  return ProdutoAplicacaoEntity(
    id: id,
    estadioId: estadioId,
    produtoNome: nome,
    produtoCategoria: 'Herbicida',
    dose: dose,
    doseUnidade: 'L/ha',
    areaHa: area,
    precoUnitario: preco,
    ordem: 1,
    createdAt: now,
  );
}
