# flutter-check

Valida o estado do projeto AgriMind: análise estática + testes.

## Passos

```bash
flutter pub get
flutter analyze
flutter test
```

## Critérios de aprovação

- `flutter analyze` → `No issues found`
- `flutter test` → todos os testes passando (zero falhas)

## Checklist de saída

- [ ] `flutter pub get` sem erros
- [ ] `flutter analyze` limpo
- [ ] `flutter test` 100% verde
