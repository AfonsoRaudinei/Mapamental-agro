import 'dart:io';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/consolidacao_entity.dart';

/// Gera um arquivo Excel com 3 abas a partir da consolidação.
class ExportExcelUseCase {
  const ExportExcelUseCase();

  static final _nf = NumberFormat('#,##0.00', 'pt_BR');
  static final _nfQtd = NumberFormat('#,##0.0', 'pt_BR');

  Future<File> call(ConsolidacaoEntity c) async {
    final excel = Excel.createExcel();

    // Remove sheet padrão criado automaticamente
    excel.delete('Sheet1');

    _buildResumo(excel, c);
    _buildDetalhamento(excel, c);
    _buildInformacoes(excel, c);

    final dir = await getTemporaryDirectory();
    final safeName = c.plano.nome.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_');
    final file = File('${dir.path}/pedido_$safeName.xlsx');

    final bytes = excel.save();
    if (bytes == null) throw Exception('Falha ao salvar Excel');
    await file.writeAsBytes(bytes);
    return file;
  }

  // ── Aba 1: Resumo ─────────────────────────────────────────────────────────

  void _buildResumo(Excel excel, ConsolidacaoEntity c) {
    final sheet = excel['Resumo'];

    // Cabeçalho do plano
    _setCell(sheet, 0, 0, 'PEDIDO DE PRODUTOS — AgriMind',
        bold: true, fontSize: 14);
    _setCell(sheet, 1, 0,
        'Plano: ${c.plano.nome}  ·  ${c.plano.cultura}  ·  ${c.plano.safra}');
    if (c.plano.clienteNome != null) {
      _setCell(sheet, 2, 0, 'Produtor: ${c.plano.clienteNome}');
    }
    if (c.plano.fazendaNome != null) {
      _setCell(sheet, 3, 0, 'Fazenda: ${c.plano.fazendaNome}');
    }
    _setCell(sheet, 4, 0, 'Área: ${_nf.format(c.plano.areaHaTotal)} ha');
    _setCell(sheet, 5, 0,
        'Gerado em: ${DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(c.geradoEm)}');

    // Linha em branco
    int row = 7;

    // Cabeçalho da tabela
    _setCell(sheet, row, 0, 'PRODUTO', bold: true, bgColor: '007AFF');
    _setCell(sheet, row, 1, 'CATEGORIA', bold: true, bgColor: '007AFF');
    _setCell(sheet, row, 2, 'QUANTIDADE', bold: true, bgColor: '007AFF');
    _setCell(sheet, row, 3, 'UNIDADE', bold: true, bgColor: '007AFF');
    _setCell(sheet, row, 4, 'PREÇO UNIT. (R\$)', bold: true, bgColor: '007AFF');
    _setCell(sheet, row, 5, 'CUSTO TOTAL (R\$)', bold: true, bgColor: '007AFF');
    _setCell(sheet, row, 6, 'UN. MISTA', bold: true, bgColor: '007AFF');
    row++;

    String? categoriaAtual;
    for (final item in c.itens) {
      if (item.categoria != categoriaAtual) {
        categoriaAtual = item.categoria;
        _setCell(sheet, row, 0, '— ${item.categoria.toUpperCase()} —',
            bold: true, bgColor: 'F0F0F0');
        row++;
      }
      _setCell(sheet, row, 0, item.produtoNome);
      _setCell(sheet, row, 1, item.categoria);
      _setCell(sheet, row, 2, _nfQtd.format(item.quantidadeTotal));
      _setCell(sheet, row, 3, item.unidade);
      _setCell(sheet, row, 4,
          item.precoUnitario != null ? _nf.format(item.precoUnitario) : '—');
      _setCell(sheet, row, 5,
          item.custoTotal != null ? _nf.format(item.custoTotal) : '—');
      _setCell(sheet, row, 6, item.temUnidadeMista ? '⚠ Mista' : '');
      row++;
    }

    // Total geral
    row++;
    _setCell(sheet, row, 4, 'TOTAL GERAL', bold: true);
    _setCell(
      sheet,
      row,
      5,
      c.custoGeral != null ? 'R\$ ${_nf.format(c.custoGeral)}' : '—',
      bold: true,
    );

    // Largura das colunas
    sheet.setColumnWidth(0, 30);
    sheet.setColumnWidth(1, 18);
    sheet.setColumnWidth(2, 14);
    sheet.setColumnWidth(3, 10);
    sheet.setColumnWidth(4, 18);
    sheet.setColumnWidth(5, 18);
    sheet.setColumnWidth(6, 12);
  }

  // ── Aba 2: Detalhamento por Estádio ───────────────────────────────────────

  void _buildDetalhamento(Excel excel, ConsolidacaoEntity c) {
    final sheet = excel['Detalhamento por Estádio'];

    int row = 0;
    _setCell(sheet, row, 0, 'DETALHAMENTO POR ESTÁDIO',
        bold: true, fontSize: 13);
    row += 2;

    // Cabeçalho da tabela
    _setCell(sheet, row, 0, 'PRODUTO', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 1, 'ESTÁDIO', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 2, 'DOSE', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 3, 'UNIDADE DOSE', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 4, 'ÁREA (ha)', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 5, 'TOTAL', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 6, 'OVERRIDE', bold: true, bgColor: '0051D5');
    _setCell(sheet, row, 7, 'MOTIVO', bold: true, bgColor: '0051D5');
    row++;

    for (final item in c.itens) {
      for (final d in item.detalhe) {
        _setCell(sheet, row, 0, item.produtoNome);
        _setCell(sheet, row, 1, d.estadioCodigo);
        _setCell(sheet, row, 2, _nfQtd.format(d.dose));
        _setCell(sheet, row, 3, d.doseUnidade);
        _setCell(sheet, row, 4, _nfQtd.format(d.areaHa));
        _setCell(
          sheet,
          row,
          5,
          '${_nfQtd.format(d.total)} ${item.unidade}',
        );
        _setCell(sheet, row, 6, d.isOverride ? 'Sim' : '');
        _setCell(sheet, row, 7, d.overrideMotivo ?? '');
        row++;
      }
    }

    sheet.setColumnWidth(0, 28);
    sheet.setColumnWidth(1, 12);
    sheet.setColumnWidth(2, 10);
    sheet.setColumnWidth(3, 14);
    sheet.setColumnWidth(4, 10);
    sheet.setColumnWidth(5, 14);
    sheet.setColumnWidth(6, 10);
    sheet.setColumnWidth(7, 24);
  }

  // ── Aba 3: Informações ────────────────────────────────────────────────────

  void _buildInformacoes(Excel excel, ConsolidacaoEntity c) {
    final sheet = excel['Informações'];

    _setCell(sheet, 0, 0, 'AgriMind — Mapa Mental Agronômico',
        bold: true, fontSize: 13);
    _setCell(sheet, 1, 0, 'Gerado automaticamente pelo aplicativo AgriMind');
    _setCell(sheet, 3, 0, 'DADOS DO PLANO', bold: true);
    _setCell(sheet, 4, 0, 'Nome do plano');
    _setCell(sheet, 4, 1, c.plano.nome);
    _setCell(sheet, 5, 0, 'Cultura');
    _setCell(sheet, 5, 1, c.plano.cultura);
    _setCell(sheet, 6, 0, 'Safra');
    _setCell(sheet, 6, 1, c.plano.safra);
    _setCell(sheet, 7, 0, 'Área total (ha)');
    _setCell(sheet, 7, 1, _nf.format(c.plano.areaHaTotal));
    if (c.plano.clienteNome != null) {
      _setCell(sheet, 8, 0, 'Produtor');
      _setCell(sheet, 8, 1, c.plano.clienteNome!);
    }
    if (c.plano.fazendaNome != null) {
      _setCell(sheet, 9, 0, 'Fazenda');
      _setCell(sheet, 9, 1, c.plano.fazendaNome!);
    }
    _setCell(sheet, 11, 0, 'GERAÇÃO', bold: true);
    _setCell(sheet, 12, 0, 'Data/hora de geração');
    _setCell(sheet, 12, 1,
        DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(c.geradoEm));
    _setCell(sheet, 13, 0, 'Total de produtos');
    _setCell(sheet, 13, 1, '${c.totalProdutos}');
    _setCell(sheet, 14, 0, 'Total de categorias');
    _setCell(sheet, 14, 1, '${c.totalCategorias}');
    if (c.custoGeral != null) {
      _setCell(sheet, 15, 0, 'Custo geral estimado (R\$)');
      _setCell(sheet, 15, 1, _nf.format(c.custoGeral));
    }

    sheet.setColumnWidth(0, 26);
    sheet.setColumnWidth(1, 28);
  }

  // ── Helper ────────────────────────────────────────────────────────────────

  void _setCell(
    Sheet sheet,
    int row,
    int col,
    String value, {
    bool bold = false,
    int? fontSize,
    String? bgColor,
  }) {
    final cell = sheet.cell(CellIndex.indexByColumnRow(
      columnIndex: col,
      rowIndex: row,
    ));
    cell.value = TextCellValue(value);
    cell.cellStyle = bgColor != null && bgColor.isNotEmpty
        ? CellStyle(
            bold: bold,
            fontSize: fontSize,
            backgroundColorHex: ExcelColor.fromHexString(bgColor),
            fontColorHex: ExcelColor.white,
          )
        : CellStyle(bold: bold, fontSize: fontSize);
  }
}
