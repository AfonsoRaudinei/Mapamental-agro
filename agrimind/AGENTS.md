# AgriMind — Agent Guide

App Flutter de planejamento agrícola (Mapa Mental Agro).

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
| Modo escuro | `.agents/dark-mode-designer.md` |
| Referências | `.agents/references-prompt.md` |
| **Codex: Circular fungicidas** | `.agents/codex-integrar-circular-fungicidas.md` |
| **Codex: Build IPA** | `.agents/codex-build-ipa-135.md` |
| **Codex: Fix IPA v135 Mac** | `.agents/codex-fix-ipa-135-mac.md` |

## Integração

Guia para mesclar código local: `docs/INTEGRACAO.md`

## Tema padrão

Dark Black (`AppTheme.darkBlack`) — ver agente designer.

## Banco de dados

SQLite local (`lib/core/database/app_database.dart`):
- `clients`, `plans`, `stages`, `products`
