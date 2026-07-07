# 🌱 AgriMind — PARTE 04
## Canvas do Mapa Mental · Bloco do Estádio · Ícones de Categoria

---

## 🗺️ Canvas — Visão Geral

O canvas é uma lista vertical scrollável (não rotacionável como o SimpleMind).
Cada **estádio** é um bloco horizontal composto de 3 zonas:

```
┌─────────────────────────────────────────────────────────┐
│ ESTÁDIO R1 — Início do Florescimento                    │
├───────────┬───────────────────────────────┬─────────────┤
│  ZONA A   │          ZONA B               │   ZONA C    │
│           │                               │             │
│  [R1]    │  Fox Xpro                     │  🔴 38×38  │
│  círculo  │  0,4 L/ha × [80] ha = 32,0 L │  🔵 38×38  │
│  72×72   │  ─────────────────────────    │  🟣 38×38  │
│           │  Engeo Pleno                  │  🟢 38×38  │
│   [+]    │  150mL/ha × [80] ha = 12,0 L  │  🏆 38×38  │
│   btn    │  ─────────────────────────    │             │
│           │  [+ Produto do catálogo...]   │             │
└───────────┴───────────────────────────────┴─────────────┘
```

**ZONA A:** Identificador do estádio + botão adicionar produto
**ZONA B:** Card de produtos (lista scrollável verticalmente)
**ZONA C:** 5 ícones de categoria (sempre visíveis, clicáveis)

---

## 🎨 Anatomia Visual do Bloco de Estádio

### Zona A — Identificador

```dart
// EstadioIdentifierWidget
Column(
  children: [
    // Círculo do código
    GestureDetector(
      onTap: () => _onCircleTap(), // foto futura (v2)
      child: Container(
        width: 72, height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.background,
          border: Border.all(color: AppColors.borderSoft, width: 1.5),
        ),
        child: Center(
          child: Text(estadio.codigo,  // "R1"
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700)),
        ),
      ),
    ),
    SizedBox(height: 4),
    // Label editável inline
    Text(estadio.codigo,
      style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
    SizedBox(height: 12),
    // Botão + adicionar produto
    _AddProductButton(onTap: () => _openProdutoPanel()),
  ],
)
```

### Zona B — Card de Produtos

```dart
// ProdutoAplicacaoCard
Container(
  constraints: BoxConstraints(minWidth: 200, maxWidth: 280),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.95),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.borderSoft),
    boxShadow: [AppShadows.sm],
  ),
  child: Column(
    children: [
      // Lista de produtos
      ...estadio.produtos.map((p) => ProdutoAplicacaoRow(produto: p)),
      // Empty state
      if (estadio.produtos.isEmpty) _EmptyProductsHint(),
      // Campo adicionar
      _AddProductInlineField(onAdd: (nome) => ...),
    ],
  ),
)
```

### Produto Row — Anatomia Completa

```
┌──────────────────────────────────────────────────┐
│ ● Fox Xpro                            [✏️]  [🗑] │
│   0,4 L/ha  ×  [  80,0 ] ha  =  32,0 L          │
│                   ↑ editável field               │
│                   (toca para editar área)         │
└──────────────────────────────────────────────────┘

Se totalOverride:
┌──────────────────────────────────────────────────┐
│ ● Fox Xpro                     ⚠️  [✏️]  [🗑]   │
│   0,4 L/ha  ×  80 ha  →  [  28,0 ] L  (manual)  │
│   Motivo: "Estoque limitado"                     │
└──────────────────────────────────────────────────┘
```

```dart
class ProdutoAplicacaoRow extends StatelessWidget {
  // Layout: Row com 3 partes
  // 1. Dot colorido (cor da categoria) + nome
  // 2. Dose × Área = Total (todos editáveis inline)
  // 3. Ações: editar (abre panel completo) | deletar

  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _openProdutoPanel(context),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _CategoryDot(categoria: produto.categoria),
            SizedBox(width: 6),
            Expanded(child: Text(produto.produtoNome,
              style: AppTypography.body.copyWith(fontWeight: FontWeight.w600))),
            _EditIcon(), _DeleteIcon(),
          ]),
          SizedBox(height: 4),
          Row(children: [
            Text('${produto.dose} ${produto.doseUnidade}',
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
            Text(' × ', style: AppTypography.caption),
            // Campo área inline — editável
            _AreaInlineField(
              value: produto.areaHa,
              onChanged: (v) => ref.read(...).updateArea(produto.uid, v),
            ),
            Text(' ha = ', style: AppTypography.caption),
            // Total calculado (ou override com ⚠️)
            _TotalDisplay(produto: produto),
          ]),
        ],
      ),
    ),
  );
}
```

---

## 🎯 Zona C — 5 Ícones de Categoria

### Layout

```dart
// CategoriaIconStrip
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: CategoriaReferencia.values.map((cat) =>
    Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: CategoriaIconButton(
        categoria: cat,
        estadio: estadio.codigo,
        hasContent: _hasContent(cat, estadio.codigo),
        onTap: () => _openCategoriaBottomSheet(cat, estadio.codigo),
      ),
    ),
  ).toList(),
)
```

### Botão Individual

```dart
class CategoriaIconButton extends StatelessWidget {
  final CategoriaReferencia categoria;
  final bool hasContent;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return Opacity(
      opacity: hasContent ? 1.0 : 0.4,   // sem conteúdo → 40%
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: Color(categoria.cor),
            borderRadius: BorderRadius.circular(10),
            boxShadow: hasContent ? [AppShadows.catIcon] : [],
          ),
          child: Center(
            child: PhosphorIcon(
              categoria.icone,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
```

### Enum completo das categorias

```dart
enum CategoriaReferencia {
  doencas(
    label: 'Doenças',
    cor: 0xFFFF3B30,
    icone: PhosphorIconsRegular.virus,
    subtitle: 'Fungos, bactérias, vírus',
  ),
  insetos(
    label: 'Insetos',
    cor: 0xFF007AFF,
    icone: PhosphorIconsRegular.bug,
    subtitle: 'Pragas e níveis de ação',
  ),
  nutricao(
    label: 'Nutrição',
    cor: 0xFFAF52DE,
    icone: PhosphorIconsRegular.leaf,
    subtitle: 'N, P, K, S e micronutrientes',
  ),
  fisiologia(
    label: 'Fisiologia',
    cor: 0xFF34C759,
    icone: PhosphorIconsRegular.dna,
    subtitle: 'Bioestimulantes e hormônios',
  ),
  cesb(
    label: 'Campeões',
    cor: 0xFFFF9500,
    icone: PhosphorIconsRegular.trophy,
    subtitle: 'Dicas CESB por estádio',
  );

  const CategoriaReferencia({
    required this.label,
    required this.cor,
    required this.icone,
    required this.subtitle,
  });

  final String label;
  final int cor;
  final IconData icone;
  final String subtitle;
}
```

---

## 📋 Bottom Sheet de Categoria

Ao tocar em qualquer ícone → abre `DraggableScrollableSheet` estilo iOS.

### Estrutura do Bottom Sheet

```
┌──────────────────────────────────┐
│            ▬▬▬ (handle)          │
│                                  │
│  🔴  DOENÇAS — Estádio R1        │
│  ─────────────────────────────  │
│                                  │
│  ● Ferrugem Asiática             │
│    [+ Usar no plano]             │
│                                  │
│  ● Oídio (Erysiphe)              │
│    [+ Usar no plano]             │
│                                  │
│  ● Antracnose (Colletotrichum)   │
│    [+ Usar no plano]             │
│                                  │
└──────────────────────────────────┘
  ↑ 40% da tela por padrão
  ↑ drag para expandir até 85%
```

### Para CESB — Bottom Sheet especial

```
┌──────────────────────────────────┐
│            ▬▬▬                   │
│                                  │
│  🏆  CAMPEÕES CESB — R1-R2       │
│  "Fixação de Flores"             │
│  ─────────────────────────────  │
│                                  │
│  O que fazem os campeões:        │
│  • Foco em reduzir abortamento   │
│  • Aplicações de Cálcio + Boro   │
│  • Reguladores de crescimento    │
│  • 1ª aplicação de fungicida     │
│    preventivo (Mancha-alvo,      │
│    Ferrugem)                     │
│                                  │
│  ─────────────────────────────  │
│  🥇 Destaque: Agro Mallon        │
│     135,49 sc/ha                 │
│                                  │
└──────────────────────────────────┘
```

### Implementação

```dart
class CategoriaBottomSheet extends ConsumerWidget {
  final CategoriaReferencia categoria;
  final String estadio;

  Widget build(BuildContext context, WidgetRef ref) {
    final refs = ref.watch(referenciasByEstadioProvider(
      (categoria: categoria, estadio: estadio)
    ));

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            BottomSheetHandle(),
            _CategoriaHeader(categoria: categoria, estadio: estadio),
            Expanded(
              child: refs.when(
                data: (items) => items.isEmpty
                    ? _EmptyContent(categoria: categoria)
                    : ListView.builder(
                        controller: controller,
                        itemCount: items.length,
                        itemBuilder: (_, i) => categoria == CategoriaReferencia.cesb
                            ? CesbTipCard(item: items[i])
                            : ReferenciaItemTile(
                                item: items[i],
                                onUsarNoPlano: () => _addToPlano(items[i]),
                              ),
                      ),
                loading: () => LoadingSkeleton(),
                error: (e, _) => ErrorState(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToPlano(ReferenciaTecnicaEntity ref) {
    // Fecha o bottom sheet da referência
    // Abre o bottom sheet de seleção de produto do catálogo
    // Filtra por categoria correspondente (doencas → Fungicida)
    // Produto selecionado → adicionado ao estadio atual
  }
}
```

### Fluxo "Usar no plano" — passo a passo

```
[Doenças R1] → "Ferrugem Asiática" → [+ Usar no plano]
      ↓
Bottom Sheet: "Selecionar Produto"
  Filtro automático: Fungicidas
  Busca: [  Fox Xpro...  ] 🔍
  Lista: Fox Xpro | Elatus | Orkestra...
      ↓
Seleciona "Fox Xpro"
      ↓
Bottom Sheet: "Configurar Aplicação"
  Produto: Fox Xpro       (bloqueado)
  Dose: [0,4] L/ha        (pré-preenchido do catálogo)
  Área: [80,0] ha         (pré-preenchido da fazenda)
  Total: 32,0 L           (calculado)
  [Salvar]
      ↓
Produto adicionado ao estádio R1 ✅
```

---

## 📱 Bottom Sheet de Edição de Produto (Panel completo)

Abre ao tocar no ícone de editar ✏️ ou tap na row do produto.

```
┌──────────────────────────────────┐
│  ▬▬▬                             │
│                                  │
│  Fox Xpro              [Excluir] │
│  ─────────────────────────────  │
│                                  │
│  Produto                         │
│  [Fox Xpro              ▼] 🔍   │
│  (dropdown com busca live)       │
│                                  │
│  Dose                            │
│  [0,4    ] [L/ha ▼]             │
│                                  │
│  Área de Aplicação               │
│  ○ Fazenda inteira (80 ha)       │
│  ○ Talhão A (40 ha)              │
│  ○ Talhão B (40 ha)              │
│  ○ Personalizado: [___] ha       │
│                                  │
│  Total Calculado                 │
│  32,0 L        [Override manual] │
│                                  │
│  (se override ativo:)            │
│  Total: [28,0] L  ⚠️             │
│  Motivo: [________________]      │
│                                  │
│  Preço unitário (opcional)       │
│  R$ [45,00] / L                  │
│  Custo: R$ 1.440,00              │
│                                  │
│  Data prevista                   │
│  [Selecionar data]               │
│                                  │
│  Observação                      │
│  [________________________]      │
│                                  │
│  [Cancelar]          [Salvar]    │
└──────────────────────────────────┘
```

---

## 🔄 Fluxo Completo do Canvas

```
PlansListPage
  └── tap em plano → PlanCanvasPage
        ├── Header: nome do plano | cliente | fazenda | area | cultura
        ├── FAB: [+ Estádio]
        └── Lista vertical de EstadioBlock
              ├── EstadioBlock VE
              │    ├── ZonaA: círculo VE + botão +
              │    ├── ZonaB: card produtos (vazio inicialmente)
              │    └── ZonaC: 5 ícones (doenças 40%, insetos 40%...)
              │                        ↑ sem seed para VE → opacidade baixa
              │
              ├── EstadioBlock R1
              │    ├── ZonaA: círculo R1
              │    ├── ZonaB: Fox Xpro 0,4L/ha × 80ha = 32L
              │    │          Engeo Pleno 150mL/ha × 80ha = 12L
              │    └── ZonaC: 🔴 (100%) 🔵 (100%) 🟣 (100%) 🟢 (100%) 🏆 (40%)
              │                ↑ todos têm conteúdo em R1 exceto CESB agrupa R1-R2
              │
              └── [Botão Consolidar] → ConsolidacaoPage
```

---

*Próxima parte → PARTE 05: Auth · Clientes · Catálogo · Configurações*
