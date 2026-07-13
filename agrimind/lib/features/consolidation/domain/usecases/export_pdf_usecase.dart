import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/utils/unit_converter.dart';
import '../entities/consolidacao_entity.dart';
import '../entities/consolidacao_item_entity.dart';

/// Gera um PDF de pedido de produtos a partir da consolidação.
class ExportPdfUseCase {
  const ExportPdfUseCase();

  static final _nf = NumberFormat('#,##0.00', 'pt_BR');
  static final _nfQtd = NumberFormat('#,##0.0', 'pt_BR');

  Future<File> call(ConsolidacaoEntity c) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (_) => _buildHeader(c),
        footer: (ctx) => _buildFooter(ctx),
        build: (ctx) => [
          _buildInfoSection(c),
          pw.SizedBox(height: 16),
          ..._buildGrupos(c),
          pw.SizedBox(height: 16),
          _buildTotalSection(c),
          pw.SizedBox(height: 24),
          _buildAssinaturaSection(),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final safeName = c.plano.nome.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_');
    final file = File('${dir.path}/pedido_$safeName.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // ── Seções do PDF ─────────────────────────────────────────────────────────

  pw.Widget _buildHeader(ConsolidacaoEntity c) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'PEDIDO DE PRODUTOS',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue700,
                  ),
                ),
                pw.Text(
                  'AgriMind · Gerado em ${_formatData(c.geradoEm)}',
                  style:
                      const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                ),
              ],
            ),
            pw.Text(
              '🌿 AgriMind',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue700,
              ),
            ),
          ],
        ),
        pw.Divider(color: PdfColors.blue700, thickness: 2),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context ctx) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'AgriMind — Mapa Mental Agronômico',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
        pw.Text(
          'Página ${ctx.pageNumber} de ${ctx.pagesCount}',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
      ],
    );
  }

  pw.Widget _buildInfoSection(ConsolidacaoEntity c) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        border: pw.Border.all(color: PdfColors.blue200),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (c.plano.clienteNome != null)
            _infoRow('PRODUTOR', c.plano.clienteNome!),
          if (c.plano.fazendaNome != null)
            _infoRow('FAZENDA', c.plano.fazendaNome!),
          _infoRow(
            'ÁREA',
            '${_nf.format(c.plano.areaHaTotal)} ha  ·  '
                '${c.plano.cultura}  ·  ${c.plano.safra}',
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _buildGrupos(ConsolidacaoEntity c) {
    final grupos = <String, List<ConsolidacaoItemEntity>>{};
    for (final item in c.itens) {
      grupos.putIfAbsent(item.categoria, () => []).add(item);
    }

    final widgets = <pw.Widget>[];
    for (final entry in grupos.entries) {
      widgets.add(_buildGrupoHeader(entry.key));
      widgets.add(pw.SizedBox(height: 4));
      for (final item in entry.value) {
        widgets.add(_buildItemRow(item));
      }
      widgets.add(pw.SizedBox(height: 8));
    }
    return widgets;
  }

  pw.Widget _buildGrupoHeader(String categoria) {
    return pw.Container(
      color: PdfColors.grey200,
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: pw.Text(
        categoria.toUpperCase(),
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
          color: PdfColors.grey800,
        ),
      ),
    );
  }

  pw.Widget _buildItemRow(ConsolidacaoItemEntity item) {
    final detalheTexto = item.detalhe
        .map((d) {
          final dose = UnitConverter.valorDisplay(d.dose, d.doseUnidade);
          final total = UnitConverter.valorDisplay(d.total, d.doseUnidade);
          final doseUnit = UnitConverter.unidadeBase(d.doseUnidade);
          final totalUnit = UnitConverter.unidadeTotal(d.doseUnidade);
          return '${d.estadioCodigo}: ${_nfQtd.format(dose)} $doseUnit×${_nfQtd.format(d.areaHa)}ha=${_nfQtd.format(total)} $totalUnit${d.isOverride ? '⚠' : ''}';
        })
        .join(' | ');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(1.5),
            2: const pw.FlexColumnWidth(1.5),
            3: const pw.FlexColumnWidth(1.5),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(
                    item.produtoNome + (item.temUnidadeMista ? ' ⚠' : ''),
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 10),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(
                    '${_nfQtd.format(item.quantidadeTotal)} ${item.unidade}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(
                    item.precoUnitario != null
                        ? 'R\$ ${_nf.format(item.precoUnitario)}'
                        : '—',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(
                    item.custoTotal != null
                        ? 'R\$ ${_nf.format(item.custoTotal)}'
                        : '—',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 8, bottom: 4),
          child: pw.Text(
            detalheTexto,
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),
        ),
        pw.Divider(color: PdfColors.grey300, thickness: 0.5),
      ],
    );
  }

  pw.Widget _buildTotalSection(ConsolidacaoEntity c) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.blue700, width: 1.5),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${c.totalProdutos} produto(s) · ${c.totalCategorias} categoria(s)',
                style:
                    const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'TOTAL GERAL',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey800,
                ),
              ),
              if (c.custoGeral != null)
                pw.Text(
                  'R\$ ${_nf.format(c.custoGeral)}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue700,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildAssinaturaSection() {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Técnico responsável: ___________________________',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                  pw.SizedBox(height: 24),
                  pw.Text(
                    'Assinatura: ___________________ Data: ___/___/______',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  pw.Widget _infoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(
              text: '$label: ',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
                color: PdfColors.grey800,
              ),
            ),
            pw.TextSpan(
              text: value,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ),
      ),
    );
  }

  String _formatData(DateTime d) {
    return DateFormat('dd/MM/yyyy', 'pt_BR').format(d);
  }
}
