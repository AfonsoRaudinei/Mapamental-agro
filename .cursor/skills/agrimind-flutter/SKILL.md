---
name: agrimind-flutter
description: >-
  Desenvolve, valida e publica o AgriMind (Flutter/Dart, Clean Architecture,
  Riverpod, Drift, Supabase). Use para features Flutter, bugs mobile, auth
  Supabase, canvas fenológico, consolidação/export ou quando o usuário mencionar
  AgriMind, agrimind ou planejamento agronômico.
---

# AgriMind Flutter

## Contexto

- App: `agrimind/`
- IDs: `agrimind/docs/platform.md`
- Docs: `AGENTS.md`, `agent.md`, `agente.md`, `.agents/`

## Skills especializadas

| Tarefa | Skill |
|--------|-------|
| Validação | `agrimind-flutter-check` |
| Nova feature | `agrimind-new-feature` |
| Build IPA | `agrimind-build-ipa` |

## Papéis (`.agents/`)

- `flutter-architect.md` — estrutura e migrations
- `supabase-auth.md` — auth Supabase
- `qa-mobile.md` — smoke test ordenado
- `release-mobile.md` — IPA e assinatura

## Preview local

```bash
cd agrimind
flutter run -d "iPhone 17" --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
```

No Cursor: extensões Dart + Flutter, F5 via `.vscode/launch.json`.
