import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/consolidacao_entity.dart';

class ExportHtmlUseCase {
  const ExportHtmlUseCase();

  static final _money = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  static final _num = NumberFormat('#,##0.###', 'pt_BR');
  static final _date = DateFormat('dd/MM/yyyy', 'pt_BR');

  Future<File> call(ConsolidacaoEntity consolidacao) async {
    final dir = await getTemporaryDirectory();
    final safeName = consolidacao.plano.nome
        .replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_')
        .toLowerCase();
    final file = File('${dir.path}/${safeName}_mapa_fenologico.html');
    await file.writeAsString(await _buildHtml(consolidacao), flush: true);
    return file;
  }

  Future<String> _buildHtml(ConsolidacaoEntity c) async {
    final plano = c.plano;
    final total = c.custoGeral ?? 0;
    final custoHa = plano.areaHaTotal > 0 ? total / plano.areaHaTotal : 0;
    final custoSc = (plano.precoGraoSc60 ?? 0) > 0
        ? custoHa / ((plano.precoGraoSc60 ?? 0) / 60)
        : null;
    final logoData = await _imageDataUri(plano.logoLocalPath);

    return '''
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${_esc(plano.nome)}</title>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
body{font-family:-apple-system,BlinkMacSystemFont,"SF Pro Text","Segoe UI",Arial,sans-serif;background:#F4F4F6;color:#1D1D1F;padding:16px 14px 28px;-webkit-font-smoothing:antialiased}
.wrap{max-width:920px;margin:0 auto}
.title{font-size:18px;font-weight:700;margin-bottom:12px}
.card{background:rgba(255,255,255,.96);border:1px solid #E5E5E7;border-radius:10px;box-shadow:0 1px 3px rgba(0,0,0,.06);padding:10px 14px;margin-bottom:14px}
.line{display:flex;border-bottom:.5px solid #E5E5E7}.line:last-child{border-bottom:0}
.row{display:flex;gap:8px;align-items:center;flex:1;min-width:0;padding:6px 0}.row+.row{border-left:.5px solid #E5E5E7;padding-left:12px}
.lbl{font-size:10px;font-weight:700;color:#C7C7CC;text-transform:uppercase;letter-spacing:.5px;white-space:nowrap}
.val{font-size:14px;font-weight:500;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.stage-label{font-size:11px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.7px;margin:14px 0 6px 2px}
.stage{display:flex;gap:9px;align-items:flex-start;overflow-x:auto;padding-bottom:5px}
.circle{width:58px;height:58px;border-radius:50%;background:#EFEFF1;border:1.5px solid #E5E5E7;display:flex;align-items:center;justify-content:center;font-weight:800;flex-shrink:0;overflow:hidden}
.circle img{width:100%;height:100%;object-fit:cover}
.op{min-width:230px;max-width:320px;background:white;border:1px solid #E5E5E7;border-radius:10px;padding:8px 11px;box-shadow:0 1px 3px rgba(0,0,0,.06)}
.prod{padding:6px 0;border-bottom:.5px solid #E5E5E7}.prod:last-child{border-bottom:0}
.prod1{display:flex;align-items:center;gap:7px;font-size:14px}.dot{width:5px;height:5px;border-radius:50%;background:#34C759}.pname{font-weight:700;flex:1}.ptotal{font-weight:800}
.prod2{padding-left:12px;margin-top:3px;font-size:12px;color:#86868B}
.cats{display:flex;flex-direction:column;gap:5px}.cat{width:28px;height:28px;border-radius:50%;border:1px solid #D1D1D6;background:white;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:800;color:#86868B}
.section{font-size:12px;font-weight:800;color:#86868B;text-transform:uppercase;letter-spacing:.6px;margin:24px 0 8px;border-top:.5px solid #E5E5E7;padding-top:14px}
.table{background:white;border:1px solid #E5E5E7;border-radius:10px;overflow:hidden;margin-bottom:12px}
.th,.tr{display:grid;grid-template-columns:1fr 86px 86px 96px;gap:8px;align-items:center;padding:9px 12px;border-bottom:.5px solid #E5E5E7}.th{background:#EFEFF1;font-size:10px;font-weight:800;color:#86868B;text-transform:uppercase}.tr:last-child{border-bottom:0}
.right{text-align:right}.bold{font-weight:800}.summary{display:flex;flex-direction:column;gap:8px}.sumrow{display:flex;justify-content:space-between}.blue{color:#007AFF;font-weight:800}
.footer{display:flex;align-items:center;gap:10px}.logo{width:42px;height:42px;border-radius:8px;background:#EFEFF1;overflow:hidden;display:flex;align-items:center;justify-content:center}.logo img{width:100%;height:100%;object-fit:contain}
@media(max-width:600px){.line{flex-direction:column;border-bottom:0}.row{border-bottom:.5px solid #E5E5E7}.row+.row{border-left:0;padding-left:0}.th,.tr{grid-template-columns:1fr 68px 72px 78px;font-size:12px}}
</style>
</head>
<body>
<div class="wrap">
<div class="title">${_esc(plano.nome)}</div>
${_header(plano)}
${await _stages(c)}
<div class="section">Consolidação</div>
${_table(c)}
<div class="card summary">
<div class="sumrow"><span>Total investimento</span><span class="blue">${_money.format(total)}</span></div>
<div class="sumrow"><span>Custo / hectare</span><strong>${_money.format(custoHa)} / ha</strong></div>
<div class="sumrow"><span>Custo em sacas</span><strong>${custoSc == null ? '—' : '${_num.format(custoSc)} sc / ha'}</strong></div>
${plano.dataVencimento == null ? '' : '<div class="sumrow"><span>Vencimento</span><strong>${_date.format(plano.dataVencimento!)}</strong></div>'}
</div>
<div class="card footer"><div class="logo">${logoData == null ? 'Logo' : '<img src="$logoData">'}</div><div><div class="lbl">Consultor</div><div class="val">${_esc(plano.consultorNome ?? '—')}</div></div></div>
</div>
</body>
</html>
''';
  }

  String _header(plano) => '''
<div class="card">
<div class="line">
<div class="row"><span class="lbl">Produtor</span><span class="val">${_esc(plano.produtorNomeLivre ?? plano.clienteNome ?? '—')}</span></div>
<div class="row"><span class="lbl">Fazenda</span><span class="val">${_esc(plano.fazendaNomeLivre ?? plano.fazendaNome ?? '—')}</span></div>
<div class="row"><span class="lbl">Área (ha)</span><span class="val">${_num.format(plano.areaHaTotal)}</span></div>
</div>
<div class="line">
<div class="row"><span class="lbl">Cidade / UF</span><span class="val">${_esc(plano.cidadeUf ?? '—')}</span></div>
<div class="row"><span class="lbl">Safra / Talhão</span><span class="val">${_esc(plano.safra)}</span></div>
</div>
</div>
''';

  Future<String> _stages(ConsolidacaoEntity c) async {
    final buffer = StringBuffer();
    for (final estadio in c.plano.estadios) {
      final image = await _imageDataUri(estadio.imageLocalPath);
      buffer.write('<div class="stage-label">${_esc(estadio.label)}</div>');
      buffer.write('<div class="stage"><div class="circle">');
      buffer.write(image == null ? _esc(estadio.codigo) : '<img src="$image">');
      buffer.write('</div><div class="op">');
      if (estadio.produtos.isEmpty) {
        buffer.write('<div class="prod2">Nenhum produto</div>');
      } else {
        for (final produto in estadio.produtos) {
          final unit = produto.doseUnidade.split('/').first;
          buffer.write(
              '<div class="prod"><div class="prod1"><span class="dot"></span><span class="pname">${_esc(produto.produtoNome)}</span><span class="ptotal">${_num.format(produto.totalFinal)} $unit</span></div><div class="prod2">${_num.format(produto.dose)} ${_esc(produto.doseUnidade)} · ${_num.format(produto.areaHa)} ha</div></div>');
        }
      }
      buffer.write(
          '</div><div class="cats"><div class="cat">D</div><div class="cat">I</div><div class="cat">N</div><div class="cat">H</div><div class="cat">C</div></div></div>');
    }
    return buffer.toString();
  }

  String _table(ConsolidacaoEntity c) {
    final buffer = StringBuffer(
        '<div class="table"><div class="th"><span>Produto</span><span class="right">Qtd.</span><span class="right">R\$ Unit.</span><span class="right">R\$ Total</span></div>');
    for (final item in c.itens) {
      buffer.write(
          '<div class="tr"><span class="bold">${_esc(item.produtoNome)}</span><span class="right">${_num.format(item.quantidadeTotal)}<br>${_esc(item.unidade)}</span><span class="right">${item.precoUnitario == null ? '—' : _money.format(item.precoUnitario)}</span><span class="right bold">${item.custoTotal == null ? '—' : _money.format(item.custoTotal)}</span></div>');
    }
    buffer.write('</div>');
    return buffer.toString();
  }

  Future<String?> _imageDataUri(String? path) async {
    if (path == null || path.isEmpty) return null;
    final file = File(path);
    if (!await file.exists()) return null;
    final ext = path.toLowerCase().endsWith('.png') ? 'png' : 'jpeg';
    return 'data:image/$ext;base64,${base64Encode(await file.readAsBytes())}';
  }

  String _esc(Object? value) => '$value'
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
}
