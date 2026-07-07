# AgriMind Agent Guide

## Product

AgriMind is a PT-BR, iOS-first Flutter application for agronomic planning.
Preserve its offline-first behavior: Supabase owns authentication and Drift
owns local application data until cloud sync is fully validated.

## Architecture

- Keep feature-first Clean Architecture: `data`, `domain`, `presentation`.
- Domain code must not import Flutter, Supabase, or Drift.
- UI calls Riverpod providers; providers call use cases and repositories.
- Use `go_router` for navigation and typed entities for layer boundaries.
- Do not add GetX, Provider, BLoC, or business logic in widgets.

## Required Checks

Run from this directory:

```sh
flutter pub get
flutter analyze
flutter test
```

Use `build_runner --delete-conflicting-outputs` only after checking generated
files are expected to change.

## Platform Rules

Platform IDs (bundle, team, Supabase ref): see `docs/platform.md`.

- Never commit credentials, private keys, provisioning profiles, or test-user
  passwords.
- Before an IPA, require clean analysis/tests and verify version/build number.

## Workflows

| Workflow | Claude Code | Cursor Skill |
|----------|-------------|--------------|
| Validação | `.claude/commands/flutter-check.md` | `.cursor/skills/agrimind-flutter-check/` |
| Nova feature | `.claude/commands/new-feature.md` | `.cursor/skills/agrimind-new-feature/` |
| Build IPA | `.claude/commands/build-ipa.md` | `.cursor/skills/agrimind-build-ipa/` |
| Listagem lojas | — | [`docs/store-listing.md`](docs/store-listing.md) |

## Role checklists

See `.agents/` for role-specific guides:

- `flutter-architect.md` — structure and migrations
- `supabase-auth.md` — Supabase Auth providers
- `qa-mobile.md` — smoke test order
- `release-mobile.md` — IPA and signing

Also read `agent.md` (visual) and `agente.md` (change discipline, PT-BR).
