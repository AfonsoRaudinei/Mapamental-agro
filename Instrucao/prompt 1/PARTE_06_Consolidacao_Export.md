# 🌱 AgriMind — PARTE 06
## Consolidação · Export PDF · Export Excel · Export HTML Dinâmico

---

## 📊 Feature: Consolidação

### Como é gerada

A consolidação **não é uma tela de cadastro** — é gerada automaticamente a partir de um Plano existente. O técnico toca em **[Consolidar]** dentro do canvas do plano.

```dart
// GerarConsolidacaoUseCase
class GerarConsolidacaoUseCase {
  ConsolidacaoEntity call(PlanoEntity plano) {
    // 1. Agrupa todos os ProdutoAplicacao por produtoNome
    // 2. Soma os totais (respeitando override)
    // 3. Normaliza unidades mistas (mL → L, g → kg)
    // 4. Calcula custo se precoUnitario disponível
    // 5. Ordena por categoria (Fungicida → Inseticida → Herbicida...)
    // 6. Retorna ConsolidacaoEntity com breakdown por estádio
  }
}
```

### ConsolidacaoPage — Layout

```
┌───────────────────────────────────────┐
│ ← Consolidação                  [📤]  │
│                                       │
│ Fazenda Boa Vista                     │
│ João Silva · Soja · 80 ha · 2025/26   │
│ Gerado em: 05/06/2026 às 14:32        │
│                                       │
│ ─── FUNGICIDAS ───────────────────    │
│                                       │
│ Fox Xpro                   [›]        │
│ 96,0 L           R$ 45,00  R$4.320   │
│                                       │
│ Elatus                     [›]        │
│ 48,0 L           R$ 62,00  R$2.976   │
│                                       │
│ ─── INSETICIDAS ──────────────────    │
│                                       │
│ Engeo Pleno                [›]        │
│ 12,0 L           R$ 38,00  R$ 456    │
│                                       │
│ ─── BIOESTIMULANTES ──────────────    │
│                                       │
│ Stimulate                  [›]        │
│ 4,0 L  ⚠️         R$ 22,00  R$  88   │
│ ↑ unidade mista detectada            │
│                                       │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   │
│ TOTAL GERAL              R$ 7.840    │
│ 4 produtos · 3 categorias             │
│                                       │
│ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐  │
│ │ PDF  │ │Excel │ │ HTML │ │Share │  │
│ └──────┘ └──────┘ └──────┘ └──────┘  │
└───────────────────────────────────────┘
```

### ConsolidacaoDetalhSheet — ao tocar em um produto

```
Fox Xpro — Total: 96,0 L
R$ 45,00/L · Custo: R$ 4.320,00
─────────────────────────────────
Estádio  │ Dose      │ Área  │ Total
─────────┼───────────┼───────┼───────
VE       │ 0,4 L/ha  │ 80 ha │ 32,0 L
V3       │ 0,4 L/ha  │ 80 ha │ 32,0 L
R1       │ 0,4 L/ha  │ 80 ha │ 32,0 L
─────────────────────────────────
TOTAL                          96,0 L
```

---

## 📄 Export: PDF

### Layout do PDF gerado

```
╔══════════════════════════════════════════════════╗
║  [LOGO]    PEDIDO DE PRODUTOS                    ║
║            AgriMind · Gerado em 05/06/2026       ║
╠══════════════════════════════════════════════════╣
║  PRODUTOR: João Silva                            ║
║  FAZENDA:  Boa Vista · Sorriso, MT               ║
║  ÁREA:     80 ha · CULTURA: Soja · 2025/26       ║
╠══════════════════════════════════════════════════╣
║  PRODUTO          QTD     PREÇO    TOTAL         ║
║  ─────────────────────────────────────────────   ║
║  FUNGICIDAS                                      ║
║  Fox Xpro         96,0 L  R$45,00  R$ 4.320,00  ║
║    VE: 0,4L/ha×80ha=32L | V3: 32L | R1: 32L     ║
║  Elatus            48,0 L  R$62,00  R$ 2.976,00  ║
║    R1: 48L                                       ║
║  ─────────────────────────────────────────────   ║
║  INSETICIDAS                                     ║
║  Engeo Pleno       12,0 L  R$38,00  R$   456,00  ║
║  ─────────────────────────────────────────────   ║
║                    TOTAL GERAL  R$  7.752,00     ║
╠══════════════════════════════════════════════════╣
║  Técnico responsável: ___________________        ║
║  Assinatura: _______________ Data: ______        ║
╚══════════════════════════════════════════════════╝
```

### Implementação

```dart
class ExportPdfUseCase {
  Future<File> call(ConsolidacaoEntity consolidacao) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (ctx) => _buildHeader(consolidacao),
        footer: (ctx) => _buildFooter(ctx),
        build: (ctx) => [
          _buildInfoSection(consolidacao),
          pw.SizedBox(height: 16),
          ..._buildGruposPorCategoria(consolidacao),
          _buildTotalSection(consolidacao),
          _buildAssinaturaSection(),
        ],
      ),
    );
    // Salva no diretório temporário
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/pedido_${consolidacao.plano.nome}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
```

---

## 📊 Export: Excel

### Estrutura multi-aba

```
Aba 1: RESUMO
─────────────────────────────────────────────
Produto        | Categoria   | Total  | Custo
Fox Xpro       | Fungicida   | 96,0 L | R$4.320
Elatus         | Fungicida   | 48,0 L | R$2.976
Engeo Pleno    | Inseticida  | 12,0 L | R$ 456
─────────────────────────────────────────────
TOTAL GERAL                          R$7.752

Aba 2: DETALHAMENTO POR ESTÁDIO
─────────────────────────────────────────────────────────────
Estádio | Produto    | Dose   | Unidade | Área  | Total
VE      | Fox Xpro   | 0,4    | L/ha    | 80 ha | 32,0 L
V3      | Fox Xpro   | 0,4    | L/ha    | 80 ha | 32,0 L
R1      | Fox Xpro   | 0,4    | L/ha    | 80 ha | 32,0 L
R1      | Elatus     | 0,2    | L/ha    | 80 ha | 16,0 L
R2      | Elatus     | 0,2    | L/ha    | 80 ha | 16,0 L
...

Aba 3: INFO
Fazenda, cliente, área, cultura, safra, data de geração
```

```dart
class ExportExcelUseCase {
  Future<File> call(ConsolidacaoEntity consolidacao) async {
    final excel = Excel.createExcel();

    // Aba Resumo
    final resumo = excel['Resumo'];
    _buildResumoSheet(resumo, consolidacao);

    // Aba Detalhamento
    final detalhe = excel['Detalhamento por Estádio'];
    _buildDetalheSheet(detalhe, consolidacao);

    // Aba Info
    final info = excel['Informações'];
    _buildInfoSheet(info, consolidacao);

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/pedido_${consolidacao.plano.nome}.xlsx');
    await file.writeAsBytes(excel.encode()!);
    return file;
  }
}
```

---

## 🌐 Export: HTML Dinâmico Interativo

### Conceito

O HTML gerado é **uma cópia navegável do plano** — sem edição, somente leitura.
Funciona offline no browser do smartphone do produtor.
Compartilhado via WhatsApp, e-mail, AirDrop.

### O que o produtor vê no browser

```
╔══════════════════════════════════════╗
║  🌿 AgriMind                         ║
║  Fazenda Boa Vista · João Silva      ║
║  Soja · 80 ha · Safra 2025/26        ║
╠══════════════════════════════════════╣
║  PLANO DE APLICAÇÃO                  ║
║  Gerado em: 05/06/2026               ║
╠══════════════════════════════════════╣
║  ESTÁDIO VE — Emergência             ║
║  ┌─────────────────────┬──────────┐  ║
║  │ Nenhum produto      │ 🔴 🔵    │  ║
║  │                     │ 🟣 🟢 🏆 │  ║
║  └─────────────────────┴──────────┘  ║
║                                      ║
║  ESTÁDIO R1 — Início Florescimento   ║
║  ┌─────────────────────┬──────────┐  ║
║  │ Fox Xpro            │ 🔴 🔵    │  ║
║  │ 0,4 L/ha×80ha=32L   │ 🟣 🟢 🏆 │  ║
║  │ ─────────────────   │          │  ║
║  │ Engeo Pleno          │          │  ║
║  │ 150mL/ha×80ha=12L   │          │  ║
║  └─────────────────────┴──────────┘  ║
║   [tap ícone → expande referência]   ║
╚══════════════════════════════════════╝
```

### Interatividade do HTML

| Ação | Comportamento |
|------|--------------|
| Tap ícone 🔴 | Expande accordion com lista de doenças do estádio |
| Tap ícone 🏆 | Expande dica CESB do estádio |
| Tap produto | Expande detalhes (dose, área, total, observação) |
| Scroll | Vertical suave |
| Offline | 100% funcional sem internet |

### Estrutura do HTML gerado

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Plano — Fazenda Boa Vista</title>
  <style>
    /* Design System embutido inline */
    :root {
      --blue: #007AFF; --red: #FF3B30;
      --purple: #AF52DE; --green: #34C759;
      --amber: #FF9500;
      --bg: #F5F5F7; --surface: #FFFFFF;
      --text: #1D1D1F; --secondary: #6B7280;
      --border: #E5E7EB; --radius: 12px;
      --font: -apple-system, BlinkMacSystemFont, "SF Pro Text", sans-serif;
    }
    /* ... todos os estilos inline ... */
  </style>
</head>
<body>
  <header class="topbar">
    <span class="app-name">🌿 AgriMind</span>
    <span class="badge-readonly">Somente leitura</span>
  </header>

  <div class="plan-info">
    <h1>Fazenda Boa Vista</h1>
    <p>João Silva · Soja · 80 ha · Safra 2025/26</p>
  </div>

  <!-- Gerado dinamicamente para cada estádio -->
  <div class="estadio-block" data-codigo="R1">
    <div class="estadio-header">
      <span class="estadio-badge">R1</span>
      <span class="estadio-label">Início do Florescimento</span>
    </div>
    <div class="estadio-layout">
      <!-- Produtos -->
      <div class="produtos-card">
        <div class="produto-row" data-id="prod_1">
          <span class="produto-nome">Fox Xpro</span>
          <span class="produto-calc">0,4 L/ha × 80 ha = <strong>32,0 L</strong></span>
        </div>
        <!-- detalhes expandíveis -->
        <div class="produto-detail" id="detail_prod_1">
          <p>Observação: —</p>
          <p>Data prevista: —</p>
        </div>
      </div>

      <!-- Ícones de categoria -->
      <div class="cat-strip">
        <button class="cat-btn" data-cat="doencas" data-estadio="R1"
                style="background:#FF3B30" title="Doenças">🦠</button>
        <button class="cat-btn" data-cat="insetos" data-estadio="R1"
                style="background:#007AFF" title="Insetos">🐛</button>
        <button class="cat-btn" data-cat="nutricao" data-estadio="R1"
                style="background:#AF52DE" title="Nutrição">🍃</button>
        <button class="cat-btn" data-cat="fisiologia" data-estadio="R1"
                style="background:#34C759" title="Fisiologia">🧬</button>
        <button class="cat-btn cat-btn--empty" data-cat="cesb" data-estadio="R1"
                style="background:#FF9500;opacity:0.4" title="CESB">🏆</button>
      </div>
    </div>

    <!-- Acordeões de referência (ocultos por padrão) -->
    <div class="ref-accordion" id="ref_R1_doencas">
      <div class="ref-header" style="color:#FF3B30">🔴 Doenças — R1</div>
      <ul>
        <li>Ferrugem Asiática (Phakopsora pachyrhizi)</li>
        <li>Oídio (Erysiphe diffusa)</li>
        <li>Antracnose (Colletotrichum truncatum)</li>
      </ul>
    </div>
    <!-- ... outros acordeões ... -->
  </div>

  <!-- Dados JSON embutidos para o JS -->
  <script type="application/json" id="plano-data">
    { /* JSON completo do plano + referências */ }
  </script>

  <script>
    // JS minificado inline — sem dependências externas
    // Gerencia: toggle acordeões, expand produto-detail
    // Zero fetch, zero CDN — 100% offline
    (function() {
      'use strict';
      // Ícones categoria → toggle accordion
      document.querySelectorAll('.cat-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const cat = btn.dataset.cat;
          const estadio = btn.dataset.estadio;
          const acc = document.getElementById(`ref_${estadio}_${cat}`);
          if (!acc) return;
          const isOpen = acc.classList.toggle('open');
          btn.classList.toggle('active', isOpen);
        });
      });
      // Produto → expand detalhes
      document.querySelectorAll('.produto-row').forEach(row => {
        row.addEventListener('click', () => {
          const detail = document.getElementById(
            'detail_' + row.dataset.id);
          detail?.classList.toggle('open');
        });
      });
    })();
  </script>
</body>
</html>
```

### ExportHtmlUseCase

```dart
class ExportHtmlUseCase {
  String call(ConsolidacaoEntity consolidacao, List<ReferenciaTecnicaEntity> refs) {
    final buffer = StringBuffer();

    // 1. Header HTML + CSS embutido completo
    buffer.write(_htmlHeader(consolidacao.plano));

    // 2. Info do plano
    buffer.write(_planInfoSection(consolidacao));

    // 3. Para cada estádio
    for (final estadio in consolidacao.plano.estadios) {
      buffer.write(_estadioBlock(estadio, refs));
    }

    // 4. Consolidação resumida no final
    buffer.write(_consolidacaoSection(consolidacao));

    // 5. JSON embutido + JS inline
    buffer.write(_scriptSection(consolidacao, refs));

    buffer.write('</body></html>');
    return buffer.toString();
  }

  // Salva como arquivo .html e compartilha via Share Sheet
  Future<void> shareAsFile(String html, String nomeArquivo) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$nomeArquivo.html');
    await file.writeAsString(html);
    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'text/html')],
      subject: 'Plano AgriMind — $nomeArquivo',
    );
  }
}
```

---

## 📤 Share Sheet — Fluxo de Exportação

```dart
// ExportActionRow — 4 botões na consolidação
Row(
  children: [
    ExportButton(
      icon: PhosphorIconsRegular.filePdf,
      label: 'PDF',
      onTap: () async {
        final file = await ref.read(exportPdfProvider(planoId).future);
        await Printing.sharePdf(bytes: file.readAsBytesSync(),
            filename: 'pedido.pdf');
      },
    ),
    ExportButton(
      icon: PhosphorIconsRegular.microsoftExcelLogo,
      label: 'Excel',
      onTap: () async {
        final file = await ref.read(exportExcelProvider(planoId).future);
        await Share.shareXFiles([XFile(file.path)]);
      },
    ),
    ExportButton(
      icon: PhosphorIconsRegular.globeSimple,
      label: 'HTML',
      onTap: () async {
        await ref.read(exportHtmlProvider(planoId).future);
        // HTML já compartilhado via Share Sheet dentro do use case
      },
    ),
    ExportButton(
      icon: PhosphorIconsRegular.shareNetwork,
      label: 'Share',
      onTap: () async {
        // Share texto resumido via WhatsApp/mensagem
        final texto = _gerarTextoResumo(consolidacao);
        await Share.share(texto);
      },
    ),
  ],
)
```

---

*Próxima parte → PARTE 07: Sprints · pubspec.yaml · Checklist App Store*
