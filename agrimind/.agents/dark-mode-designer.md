# Agente Designer — Modo Escuro & Black (AgriMind)

## Princípio central

O **modo escuro black** é o tema **padrão** ao iniciar o app. Nunca usar cards brancos sobre fundo escuro.

## Paleta oficial (Dark Black)

| Token | Hex | Uso |
|-------|-----|-----|
| `background` | `#0A0A0A` | Scaffold, fundo principal |
| `surface` | `#141414` | AppBar, bottom nav |
| `surfaceContainer` | `#1E1E1E` | Cards, sheets |
| `surfaceElevated` | `#2D2D2D` | Inputs, áreas internas |
| `border` | `#3D3D3D` | Bordas, dividers |
| `primary` | `#3B82F6` | Ações, tab ativa, links |
| `onSurface` | `#FFFFFF` | Texto principal |
| `onSurfaceMuted` | `#9CA3AF` | Texto secundário |
| `onSurfaceDim` | `#6B7280` | Placeholders |

## Regras de componentes

### Cards
- Sempre `surfaceContainer` (#1E1E1E), nunca branco.
- Borda sutil `border` 1px, radius 16.
- Sem elevação Material (elevation: 0).

### Inputs
- `fillColor`: `surfaceElevated` (#2D2D2D).
- Label **acima** do campo, nunca sobreposto.
- Texto do input = `onSurface`; hint = `onSurfaceDim`.

### Bottom Navigation
- Fundo `surface`, ícone ativo `primary`, inativo `onSurfaceMuted`.

### FAB / CTAs
- Pill shape, `primary` background, texto branco.

## Anti-patterns (corrigir na tela Plano)

1. ❌ Card branco em fundo preto → ✅ Card `#1E1E1E`
2. ❌ Label "Nome do estádio" sobre input → ✅ Column com label + SizedBox(8) + TextField
3. ❌ Texto "Nenhum produto" sobre título → ✅ Row com Expanded no título, subtitle em linha separada
4. ❌ Controller compartilhado entre estádios → ✅ Um controller por `stage.id`
5. ❌ Tema light como default → ✅ `AppTheme.darkBlack` no primeiro launch

## Contraste WCAG 2.1 AA

- Texto principal sobre card: ≥ 7:1 ✅
- Texto secundário sobre card: ≥ 4.5:1 ✅
- Primary button: ≥ 4.5:1 ✅

## Referência de implementação

- `lib/core/theme/theme_dark_black.dart`
- `lib/core/theme/app_theme.dart` — bridge IDs legados SoloForte
- `lib/core/theme/theme_provider.dart` (default: dark)
- `lib/core/database/data_importer.dart` — import JSON + migração prefs
- `docs/INTEGRACAO.md` — guia de merge com código local
