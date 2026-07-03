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

## Integração

Guia para mesclar código local: `docs/INTEGRACAO.md`

## Tema padrão

Dark Black (`AppTheme.darkBlack`) — ver agente designer.

## Banco de dados

SQLite local (`lib/core/database/app_database.dart`):
- `clients`, `plans`, `stages`, `products`
