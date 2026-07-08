# AgriMind — Correções Lab no MacBook

Aplicar correções de modo black em templates de laboratório e botão voltar.

## Quando usar

- Bugs visuais em Modelos de Lab, Novo Template, Sellar, Análise de Solo
- Botão "Voltar para plantio" ilegível
- Cards pretos (#000) ou dropdowns com contraste ruim

## Pré-requisito

```sh
git pull origin main
cd agrimind && flutter pub get
```

## Passos

1. Leia `docs/MACBOOK-APLICAR-CORRECOES.md`
2. Leia `.agents/dark-mode-designer.md`
3. Grep + substituir widgets locais pelos oficiais:
   - `PrimaryBackLink` → "Voltar para plantio"
   - `DarkAppBar` → AppBars de lab
   - `LabTemplateCard` → lista de templates
   - `DarkDropdownField` → unidades padrão
4. Validar:

```sh
flutter analyze
flutter test
```

5. Commit no Mac:

```sh
git add lib/
git commit -m "fix(ui): corrige modo black em templates de lab"
git push
```

## Critérios

| Check | Esperado |
|-------|----------|
| Cards lab | `#1E1E1E`, não `#000` |
| Voltar plantio | `AppColors.primary` |
| Dropdowns | texto legível sobre `#2D2D2D` |
| AppBar back | chevron azul, toque ≥ 48px |

## Workflow

Correções de UI são **sempre no MacBook** — ver `.agents/macbook-first-workflow.md`.
