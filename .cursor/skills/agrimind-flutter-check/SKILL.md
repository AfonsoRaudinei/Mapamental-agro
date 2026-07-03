# AgriMind Flutter Check

Validação padrão antes de commit/PR.

## Quando usar

- Após integrar código local
- Após alterar tela Plano, tema ou banco
- Antes de build IPA

## Passos

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

## Critérios de aprovação

| Check | Esperado |
|-------|----------|
| `flutter analyze` | 0 issues |
| `flutter test` | 100% passando |
| Tema default | `AppTheme.darkBlack` |
| Cards Plano | `AppColors.surfaceContainer`, não branco |
| DB persistência | testes em `test/database_persistence_test.dart` |

## Integração

Se veio de código local, consulte `docs/INTEGRACAO.md` antes de rodar os checks.
