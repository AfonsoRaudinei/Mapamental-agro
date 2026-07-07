---
name: agrimind-flutter-check
description: >-
  Valida o AgriMind com flutter pub get, analyze e test. Use quando o usuário
  pedir flutter-check, validação, CI local, ou antes de commit/release.
---

# AgriMind — Flutter Check

Espelha `agrimind/.claude/commands/flutter-check.md`.

## Passos

```bash
cd agrimind
flutter pub get
flutter analyze
flutter test
```

## Critérios de aprovação

- `flutter analyze` → `No issues found`
- `flutter test` → zero falhas

## Checklist de saída

- [ ] `flutter pub get` sem erros
- [ ] `flutter analyze` limpo
- [ ] `flutter test` 100% verde
