# Agente Designer — Modo Escuro & Black (AgriMind)

## Princípio central

O **modo escuro black** é o tema **padrão** ao iniciar o app. Nunca usar cards brancos sobre fundo escuro.

> **Workflow:** correções de UI são feitas no **MacBook** — ver `.agents/macbook-first-workflow.md`.

## Paleta oficial (Dark Black)

| Token | Hex | Uso |
|-------|-----|-----|
| `background` | `#0A0A0A` | Scaffold, fundo principal |
| `surface` | `#141414` | AppBar, bottom nav |
| `surfaceContainer` | `#1E1E1E` | Cards, sheets |
| `surfaceElevated` | `#2D2D2D` | Inputs, áreas internas |
| `border` | `#3D3D3D` | Bordas, dividers |
| `primary` | `#3B82F6` | Ações, tab ativa, links, **botões voltar** |
| `onSurface` | `#FFFFFF` | Texto principal |
| `onSurfaceMuted` | `#9CA3AF` | Texto secundário |
| `onSurfaceDim` | `#6B7280` | Placeholders |

## Regras de componentes

### Cards
- Usar **`DarkSurfaceCard`** (`lib/core/widgets/dark_surface_card.dart`) — **não** `Card` M3.
- M3 `Card` com `ColorScheme` incompleto renderiza superfície clara/branca.
- Cor: `AppColors.surfaceContainer` (#1E1E1E), borda `#3D3D3D`.
- ❌ **Nunca** `Colors.black` ou `#000000` em cards — usar `surfaceContainer`.

### Templates de Laboratório
- Lista: **`LabTemplateCard`** (`lib/core/widgets/lab_template_card.dart`).
- Formulário (Novo Template / editar lab): fundo `background`, cards `DarkSurfaceCard`.
- Toggles: `Switch` com tema de `theme_dark_black.dart` (track azul quando ativo).
- Unidades padrão: **`DarkDropdownField`** — texto `primary`, menu `surfaceElevated`.
- AppBar: **`DarkAppBar`** — chevron voltar em `primary`, área de toque ≥ 48px.

### Botão voltar / links de navegação
- Links inline (ex.: "Voltar para plantio"): **`PrimaryBackLink`**.
- Cor: `AppColors.primary` (#3B82F6) — **nunca** azul escuro ou `onSurfaceMuted` sobre `background`.
- Área de toque mínima: 48×48 px.

### Inputs
- `fillColor`: `surfaceElevated` (#2D2D2D).
- Label **acima** do campo, nunca sobreposto.
- Texto do input = `onSurface`; hint = `onSurfaceDim`.

### Bottom Navigation
- Fundo `surface`, ícone ativo `primary`, inativo `onSurfaceMuted`.

### FAB / CTAs
- Pill shape, `primary` background, texto branco.

## Anti-patterns (corrigir na tela Plano e Lab)

1. ❌ Card branco em fundo preto → ✅ Card `#1E1E1E`
2. ❌ Card preto puro (#000) → ✅ `surfaceContainer` (#1E1E1E)
3. ❌ Label "Nome do estádio" sobre input → ✅ Column com label + SizedBox(8) + TextField
4. ❌ Texto "Nenhum produto" sobre título → ✅ Row com Expanded no título, subtitle em linha separada
5. ❌ Controller compartilhado entre estádios → ✅ Um controller por `stage.id`
6. ❌ Tema light como default → ✅ `AppTheme.darkBlack` no primeiro launch
7. ❌ "Voltar para plantio" escuro no black → ✅ `PrimaryBackLink`
8. ❌ Dropdown com texto ilegível → ✅ `DarkDropdownField`
9. ❌ Chevron AppBar fino/cinza → ✅ `DarkAppBar`

## Contraste WCAG 2.1 AA

- Texto principal sobre card: ≥ 7:1 ✅
- Texto secundário sobre card: ≥ 4.5:1 ✅
- Primary button / links: ≥ 4.5:1 ✅
- "Voltar para plantio" sobre `#0A0A0A`: primary #3B82F6 ✅

## Widgets oficiais (usar no MacBook)

| Widget | Arquivo | Uso |
|--------|---------|-----|
| `DarkSurfaceCard` | `dark_surface_card.dart` | Cards genéricos |
| `LabTemplateCard` | `lab_template_card.dart` | Lista Modelos de Lab |
| `DarkAppBar` | `dark_app_bar.dart` | AppBar com voltar |
| `PrimaryBackLink` | `primary_back_link.dart` | "Voltar para plantio" |
| `DarkDropdownField` | `dark_dropdown_field.dart` | Unidades padrão |

Guia de aplicação no Mac: `docs/MACBOOK-APLICAR-CORRECOES.md`

## Referência de implementação

- `lib/core/theme/theme_dark_black.dart`
- `lib/core/theme/app_theme.dart` — bridge IDs legados SoloForte
- `lib/core/theme/theme_provider.dart` (default: dark)
- `lib/core/database/data_importer.dart` — import JSON + migração prefs
- `docs/INTEGRACAO.md` — guia de merge com código local
