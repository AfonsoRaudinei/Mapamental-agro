# Agente Prompt — Referências AgriMind

## Objetivo

Guiar a implementação das referências técnicas na aba **Refs**, seguindo o design dark black (`.agents/dark-mode-designer.md`).

## Estrutura da feature

```
lib/features/references/
  domain/reference_models.dart   — ReferenceKind, ReferenceStageEntry, FungicidaRecommendation
  data/                          — dados estáticos por tipo (circular_fungicidas_data.dart, …)
  presentation/
    references_screen.dart       — grid 2×2 + cards featured
    circular_fungicidas_screen.dart
    widgets/
      golden_book_icon.dart      — ícone livro dourado reutilizável
      reference_grid_card.dart
      reference_featured_card.dart
```

## Tipos de referência (roadmap)

| ReferenceKind | Status | Ícone | Cor |
|---------------|--------|-------|-----|
| `doencas` | Em breve | coronavirus | vermelho |
| `insetos` | Em breve | pest_control | azul |
| `nutricao` | Em breve | eco | roxo |
| `fisiologia` | Em breve | biotech | verde |
| `circularFungicidas` | **Ativo** | menu_book (dourado) | gold |
| `campeoesCesb` | Em breve | diamond | gold + borda |

## Circular fungicidas (implementado)

- Card featured com `GoldenBookIcon` (livro dourado — distinto do ícone branco no Plano).
- Dados: Embrapa CT-219 + Fundação MS 2024/25.
- Modelo: `estadio → doenca → fungicida_recomendado → fonte`.
- Tela detalhe: seções expansíveis por estádio (VE–R8).

## Próximas referências (preparar terreno)

1. **Insetos** — criar `insetos_data.dart` com pragas e níveis de ação por estádio.
2. **Nutrientes** — N, P, K, S e micronutrientes por fase fenológica.
3. **Hormônios / Fisiologia** — bioestimulantes e reguladores.
4. **Campeões CESB** — dicas dos produtores recordistas (card com borda dourada).

Para cada nova referência:
1. Adicionar dados em `data/<tipo>_data.dart`.
2. Setar `ReferenceKind.isAvailable => true`.
3. Criar tela de detalhe em `presentation/<tipo>_screen.dart`.
4. Registrar navegação em `references_screen.dart`.

## Regras visuais

- Cards: `DarkSurfaceCard` (#1E1E1E), nunca `Card` M3 branco.
- Ícone livro dourado: `AppColors.gold` (#D4AF37) sobre `AppColors.goldSurface`.
- Título da aba: **Referências** (headline no body, sem search bar).
- Bottom nav: label **Refs**, ícone `Icons.menu_book_outlined`.

## Fontes de dados

- `uploads/estadio_doenca_fungicida_53d9.md` — correlação estádio → doença → fungicida
- `uploads/estadio_doenca_fungicida_completo_6b7a.md` — matriz completa rankeada
