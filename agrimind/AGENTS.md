# AgriMind — Agent Guide

App Flutter de planejamento agrícola (Mapa Mental Agro).

## Workflow (obrigatório)

**Correções de UI e features → MacBook (Alberto).** Nuvem só se extremamente expresso.

Ver `.agents/macbook-first-workflow.md`.

## Comandos

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

## Agentes

| Agente | Arquivo |
|--------|---------|
| **MacBook first** | `.agents/macbook-first-workflow.md` |
| Modo escuro | `.agents/dark-mode-designer.md` |

## Aplicar correções lab no Mac

`docs/MACBOOK-APLICAR-CORRECOES.md` — widgets base + grep/replace nas telas locais.

## Integração

Guia para mesclar código local: `docs/INTEGRACAO.md`

## Tema padrão

Dark Black (`AppTheme.darkBlack`) — ver agente designer.

## Banco de dados

SQLite local (`lib/core/database/app_database.dart`):
- `clients`, `plans`, `stages`, `products`

## Widgets dark (repo)

| Widget | Uso |
|--------|-----|
| `DarkSurfaceCard` | Cards genéricos |
| `LabTemplateCard` | Modelos de Laboratório |
| `DarkAppBar` | AppBar com voltar |
| `PrimaryBackLink` | "Voltar para plantio" |
| `DarkDropdownField` | Unidades padrão |
