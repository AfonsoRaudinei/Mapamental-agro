# Cultiva Mind — Cursor Agent Guide

Workspace do app **AgriMind** (`agrimind/`).

## Onde está cada coisa

| Ferramenta | Configuração |
|------------|--------------|
| **Cursor Rules** | `.cursor/rules/agrimind-flutter.mdc` |
| **Cursor Skills** | `.cursor/skills/` — `agrimind-flutter`, check, new-feature, build-ipa, `prompt-performance` |
| **Codex** | `agrimind/AGENTS.md` + `agrimind/.agents/` |
| **Claude Code** | `agrimind/.claude/commands/` |
| **Regulagem de prompt** | [`.agent/`](.agent/INDEX.md) + skill `prompt-performance` |
| **IDs de plataforma** | `agrimind/docs/platform.md` |

## Workflows espelhados

| Workflow | Claude | Cursor Skill |
|----------|--------|--------------|
| Validação | `flutter-check` | `agrimind-flutter-check` |
| Nova feature | `new-feature` | `agrimind-new-feature` |
| Build IPA | `build-ipa` | `agrimind-build-ipa` |
| Prompt / performance | `prompt-performance` | `prompt-performance` |

## Comandos padrão

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

## Preview

Simulador iOS via terminal ou F5 (`.vscode/launch.json`).

## Posicionamento e UX

- Ideologia: **Simples. Poderoso. Teu.** — [`Instrucao/ideologia.md`](Instrucao/ideologia.md) (fonte canônica; espelho em [`Instrucao/🍎 APPLE — - cópia.md`](Instrucao/🍎 APPLE — - cópia.md))
- Responsabilidades de tela (ProdutoPanel, Consolidação, preços): [`agrimind/agent.md`](agrimind/agent.md) → seção **UX Flows / Screen Responsibilities**
- **Cronograma agrícola** → só módulo **Clientes** (`agrimind/agent.md` + `agrimind/agente.md`). Não criar rotas/UI em Planos sem autorização explícita.
- **Disciplina de escopo:** seguir o pedido; não inventar features — [`agrimind/agente.md`](agrimind/agente.md) → **Autorização do produto**.
