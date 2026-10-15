import 'dart:io';

import 'package:excel/excel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../plans/domain/entities/estadio_entity.dart';
import '../../../plans/domain/entities/plano_entity.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../domain/entities/consolidacao_entity.dart';

/// Gera um arquivo Excel a partir da consolidação.
///
/// Abas: Aplicações, Resumo e Sementes (esta última só se houver linhas).
class ExportExcelExporter {
  const ExportExcelExporter();

  static const _sheetAplicacoes = 'Aplicações';
  static const _sheetResumo = 'Resumo';
  static const _sheetSementes = 'Sementes';
  static const _cols = 7;
  static const _headerBg = 'FF007AFF';
  static const _labelBg = 'FFEAF2FF';
  static const _valueBg = 'FFFFFFFF';
  static const _zebraBg = 'FFF5F5F7';
  static const _stageBg = 'FFE8EEF5';
  static const _white = 'FFFFFFFF';
  static const _ink = 'FF1D1D1F';

  static final _nf = NumberFormat('#,##0.00', 'pt_BR');
  static final _nfQtd = NumberFormat('#,##0.0', 'pt_BR');
  static final _nfFlex = NumberFormat('#,##0.##', 'pt_BR');

  Future<File> call(ConsolidacaoEntity c) async {
    await initializeDateFormatting('pt_BR');
    final excel = Excel.createExcel();
    excel.rename('Sheet1', _sheetAplicacoes);

    _buildAplicacoes(excel, c);
    _buildResumo(excel, c);
    if (c.sementes.isNotEmpty) {
      _buildSementes(excel, c);
    }

    if (excel.sheets.containsKey('Sheet1')) {
      excel.delete('Sheet1');
    }
    excel.setDefaultSheet(_sheetAplicacoes);

    final dir = await getTemporaryDirectory();
    final safeName = c.plano.nome.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_');
    final file = File('${dir.path}/pedido_$safeName.xlsx');

    final bytes = excel.save();
    if (bytes == null) throw Exception('Falha ao salvar Excel');
    await file.writeAsBytes(bytes);
    return file;
  }

  void _buildAplicacoes(Excel excel, ConsolidacaoEntity c) {
    final sheet = excel[_sheetAplicacoes];
    var row = _writeCompactHeader(sheet, c);

    const headers = [
      'Estádio',
      'Produto',
      'Dose',
      'Área',
      'Quantidade',
      'R\$ unitário',
      'R\$ total',
    ];
    _writeTableHeader(sheet, row, headers);
    row++;

    var totalCusto = 0.0;
    for (final estadio in c.plano.estadios) {
      if (estadio.isSementes) continue;
      final produtos = estadio.produtos;
      if (produtos.isEmpty) continue;

      final start = row;
      for (var i = 0; i < produtos.length; i++) {
        final produto = produtos[i];
        final custo = produto.custoTotal ?? 0;
        totalCusto += custo;
        final zebra = i.isOdd ? _zebraBg : _valueBg;

        _setCell(
          sheet,
          row,
          0,
          i == 0 ? _estadioExportLabel(estadio) : '',
          bold: true,
          bgColor: _stageBg,
          fontColor: _ink,
        );
        _setCell(
          sheet,
          row,
          1,
          produto.produtoNome,
          bgColor: zebra,
          fontColor: _ink,
        );
        _setCell(
          sheet,
          row,
          2,
          _formatDose(produto.dose, produto.doseUnidade),
          bgColor: zebra,
          fontColor: _ink,
          align: HorizontalAlign.Right,
        );
        _setCell(
          sheet,
          row,
          3,
          _nfFlex.format(produto.areaHa),
          bgColor: zebra,
          fontColor: _ink,
          align: HorizontalAlign.Right,
        );
        _setCell(
          sheet,
          row,
          4,
          _formatQuantidade(produto.totalFinal, produto.doseUnidade),
          bgColor: zebra,
          fontColor: _ink,
          align: HorizontalAlign.Right,
        );
        _setCell(
          sheet,
          row,
          5,
          produto.precoUnitario != null
              ? _fmtMoney(produto.precoUnitario!)
              : '',
          bgColor: zebra,
          fontColor: _ink,
          align: HorizontalAlign.Right,
        );
        _setCell(
          sheet,
          row,
          6,
          _fmtMoney(custo),
          bgColor: zebra,
          fontColor: _ink,
          align: HorizontalAlign.Right,
        );
        row++;
      }

      if (produtos.length > 1) {
        sheet.merge(
          CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: start),
          CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row - 1),
        );
      }
    }

    _writeTotalBar(sheet, row, _fmtMoney(totalCusto));
    _setAplicacoesWidths(sheet);
  }

  void _buildResumo(Excel excel, ConsolidacaoEntity c) {
    final sheet = excel[_sheetResumo];
    var row = _writeCompactHeader(sheet, c);

    const headers = [
      'Produto',
      'Categoria',
      'Quantidade',
      'Unidade',
      'R\$ unitário',
      'R\$ total',
      'Un. mista',
    ];
    _writeTableHeader(sheet, row, headers);
    row++;

    String? categoriaAtual;
    var zebraIndex = 0;
    for (final item in c.itens) {
      if (item.categoria != categoriaAtual) {
        categoriaAtual = item.categoria;
        for (var col = 0; col < _cols; col++) {
          _setCell(
            sheet,
            row,
            col,
            col == 0 ? item.categoria : '',
            bold: true,
            bgColor: _labelBg,
            fontColor: _ink,
          );
        }
        sheet.merge(
          CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row),
          CellIndex.indexByColumnRow(columnIndex: _cols - 1, rowIndex: row),
        );
        row++;
        zebraIndex = 0;
      }

      final zebra = zebraIndex.isOdd ? _zebraBg : _valueBg;
      zebraIndex++;
      _setCell(sheet, row, 0, item.produtoNome, bgColor: zebra, fontColor: _ink);
      _setCell(sheet, row, 1, item.categoria, bgColor: zebra, fontColor: _ink);
      _setCell(
        sheet,
        row,
        2,
        _nfQtd.format(item.quantidadeTotal),
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      _setCell(sheet, row, 3, item.unidade, bgColor: zebra, fontColor: _ink);
      _setCell(
        sheet,
        row,
        4,
        item.precoUnitario != null ? _fmtMoney(item.precoUnitario!) : '',
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      _setCell(
        sheet,
        row,
        5,
        _fmtMoney(item.custoTotal ?? 0),
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      _setCell(
        sheet,
        row,
        6,
        item.temUnidadeMista ? 'Sim' : '',
        bgColor: zebra,
        fontColor: _ink,
      );
      row++;
    }

    _writeTotalBar(
      sheet,
      row,
      c.custoGeral != null ? _fmtMoney(c.custoGeral!) : _fmtMoney(0),
    );

    sheet.setColumnWidth(0, 28);
    sheet.setColumnWidth(1, 16);
    sheet.setColumnWidth(2, 14);
    sheet.setColumnWidth(3, 12);
    sheet.setColumnWidth(4, 16);
    sheet.setColumnWidth(5, 16);
    sheet.setColumnWidth(6, 12);
  }

  void _buildSementes(Excel excel, ConsolidacaoEntity c) {
    final sheet = excel[_sheetSementes];
    var row = _writeCompactHeader(sheet, c);

    const headers = [
      'Cultivar',
      'Talhão',
      'Área (ha)',
      'Dose (sem/ha)',
      'sem/m',
      'Embalagens',
    ];
    _writeTableHeader(sheet, row, headers);
    row++;

    for (var i = 0; i < c.sementes.length; i++) {
      final s = c.sementes[i];
      final zebra = i.isOdd ? _zebraBg : _valueBg;
      _setCell(sheet, row, 0, s.cultivar, bgColor: zebra, fontColor: _ink);
      _setCell(sheet, row, 1, s.talhaoNome, bgColor: zebra, fontColor: _ink);
      _setCell(
        sheet,
        row,
        2,
        s.areaHa > 0 ? _nfFlex.format(s.areaHa) : '',
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      _setCell(
        sheet,
        row,
        3,
        s.populacaoSementesPorHa > 0
            ? _nfFlex.format(s.populacaoSementesPorHa)
            : '',
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      _setCell(
        sheet,
        row,
        4,
        s.sementesPorMetroLinear != null
            ? _nfFlex.format(s.sementesPorMetroLinear!)
            : '—',
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      _setCell(
        sheet,
        row,
        5,
        s.embalagens > 0 ? '${s.embalagens}' : '',
        bgColor: zebra,
        fontColor: _ink,
        align: HorizontalAlign.Right,
      );
      row++;
    }

    sheet.setColumnWidth(0, 22);
    sheet.setColumnWidth(1, 18);
    sheet.setColumnWidth(2, 12);
    sheet.setColumnWidth(3, 16);
    sheet.setColumnWidth(4, 12);
    sheet.setColumnWidth(5, 14);
  }

  int _writeCompactHeader(Sheet sheet, ConsolidacaoEntity c) {
    final plano = c.plano;
    final pairs = <(String, String)>[
      (
        'Plano',
        plano.nome,
      ),
      (
        'Produtor',
        _displayOrDash(
          _firstNonEmpty([plano.produtorNomeLivre, plano.clienteNome]),
        ),
      ),
      (
        'Fazenda',
        _displayOrDash(
          _firstNonEmpty([plano.fazendaNomeLivre, plano.fazendaNome]),
        ),
      ),
      ('Área (ha)', _nfFlex.format(plano.areaHaTotal)),
      ('Cidade / UF', _displayOrDash(plano.cidadeUf)),
      ('Safra / Talhão', plano.safra),
      ('Cultura', plano.cultura),
    ];

    final consultor = plano.footerConsultorDisplayName;
    if (consultor != null) {
      pairs.add(('Consultor', consultor));
    }
    if (plano.precoGraoSc60 != null) {
      pairs.add(('Preço grão (sc/60)', _fmtMoney(plano.precoGraoSc60!)));
    }
    if (plano.dataVencimento != null) {
      pairs.add((
        'Vencimento',
        DateFormat('dd/MM/yyyy', 'pt_BR').format(plano.dataVencimento!),
      ));
    }
    pairs.add((
      'Gerado em',
      DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(c.geradoEm),
    ));

    var row = 0;
    for (var i = 0; i < pairs.length; i += 2) {
      _writeHeaderPair(sheet, row, 0, pairs[i].$1, pairs[i].$2);
      if (i + 1 < pairs.length) {
        _writeHeaderPair(sheet, row, 3, pairs[i + 1].$1, pairs[i + 1].$2);
      } else {
        _writeHeaderPair(sheet, row, 3, '', '');
      }
      row++;
    }

    return row + 1;
  }

  void _writeHeaderPair(
    Sheet sheet,
    int row,
    int startCol,
    String label,
    String value,
  ) {
    _setCell(
      sheet,
      row,
      startCol,
      label,
      bold: true,
      bgColor: _labelBg,
      fontColor: _ink,
    );
    final valueCols = startCol == 0 ? 2 : 3;
    for (var offset = 1; offset <= valueCols; offset++) {
      _setCell(
        sheet,
        row,
        startCol + offset,
        offset == 1 ? value : '',
        bgColor: _valueBg,
        fontColor: _ink,
      );
    }
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: startCol + 1, rowIndex: row),
      CellIndex.indexByColumnRow(
        columnIndex: startCol + valueCols,
        rowIndex: row,
      ),
    );
  }

  void _writeTableHeader(Sheet sheet, int row, List<String> headers) {
    for (var col = 0; col < headers.length; col++) {
      _setCell(
        sheet,
        row,
        col,
        headers[col],
        bold: true,
        bgColor: _headerBg,
        fontColor: _white,
      );
    }
  }

  void _writeTotalBar(Sheet sheet, int row, String value) {
    for (var col = 0; col < _cols; col++) {
      final text = col == 5
          ? 'Total'
          : col == 6
              ? value
              : '';
      _setCell(
        sheet,
        row,
        col,
        text,
        bold: true,
        bgColor: _headerBg,
        fontColor: _white,
        align: col >= 5 ? HorizontalAlign.Right : HorizontalAlign.Left,
      );
    }
  }

  void _setAplicacoesWidths(Sheet sheet) {
    sheet.setColumnWidth(0, 22);
    sheet.setColumnWidth(1, 28);
    sheet.setColumnWidth(2, 12);
    sheet.setColumnWidth(3, 12);
    sheet.setColumnWidth(4, 14);
    sheet.setColumnWidth(5, 16);
    sheet.setColumnWidth(6, 16);
  }

  String _fmtMoney(double value) => 'R\$ ${_nf.format(value)}';

  String _estadioExportLabel(EstadioEntity estadio) {
    final code = estadio.isOperacional ? 'OP' : estadio.codigo;
    final label = estadio.label.trim();
    if (label.isEmpty || label == code) return code;
    final prefix = '$code — ';
    if (label.startsWith(prefix) || label.startsWith('$code - ')) {
      return label;
    }
    return '$code — $label';
  }

  String _formatDose(double dose, String unidade) {
    final display = UnitConverter.valorDisplay(dose, unidade);
    return '${_nfFlex.format(display)} ${UnitConverter.unidadeBase(unidade)}';
  }

  String _formatQuantidade(double total, String unidade) {
    final display = UnitConverter.valorDisplay(total, unidade);
    return '${_nfFlex.format(display)} ${UnitConverter.unidadeTotal(unidade)}';
  }

  String _displayOrDash(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return '—';
    return trimmed;
  }

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }

  void _setCell(
    Sheet sheet,
    int row,
    int col,
    String value, {
    bool bold = false,
    String? bgColor,
    String? fontColor,
    HorizontalAlign align = HorizontalAlign.Left,
  }) {
    final cell = sheet.cell(CellIndex.indexByColumnRow(
      columnIndex: col,
      rowIndex: row,
    ));
    cell.value = TextCellValue(value);
    if (!bold &&
        bgColor == null &&
        fontColor == null &&
        align == HorizontalAlign.Left) {
      return;
    }

    cell.cellStyle = CellStyle(
      bold: bold,
      horizontalAlign: align,
      backgroundColorHex: bgColor != null
          ? ExcelColor.fromHexString(bgColor)
          : ExcelColor.white,
      fontColorHex: fontColor != null
          ? ExcelColor.fromHexString(fontColor)
          : ExcelColor.black,
    );
  }
}
