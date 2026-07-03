# Cultiva Mind — Cursor Agent Guide

Workspace do app **AgriMind** (`agrimind/`).

## Onde está cada coisa

| Ferramenta | Configuração |
|------------|--------------|
| **Cursor Rules** | `.cursor/rules/agrimind-flutter.mdc` |
| **Cursor Skills** | `.cursor/skills/agrimind-flutter/` (+ check, new-feature, build-ipa) |
| **Codex** | `agrimind/AGENTS.md` + `agrimind/.agents/` |
| **Claude Code** | `agrimind/.claude/commands/` |
| **IDs de plataforma** | `agrimind/docs/platform.md` |

## Workflows espelhados

| Workflow | Claude | Cursor Skill |
|----------|--------|--------------|
| Validação | `flutter-check` | `agrimind-flutter-check` |
| Nova feature | `new-feature` | `agrimind-new-feature` |
| Build IPA | `build-ipa` | `agrimind-build-ipa` |

## Comandos padrão

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

## Preview

Simulador iOS via terminal ou F5 (`.vscode/launch.json`).

## Integração

Após trazer código local, siga `agrimind/docs/INTEGRACAO.md` e rode o skill `agrimind-flutter-check`.
