# Smoke test — Fase 2 (2026-07-01)

Build: `1.0.0+129` · Emuladores: iPhone 17 (iOS 26.2), Medium Phone API 36 (Android 16)

## Automatizado

| Check | iOS | Android | Resultado |
|-------|-----|---------|-----------|
| `flutter analyze` (0 errors, 0 warnings) | ✓ | ✓ | OK |
| `flutter test` (58 testes) | ✓ | ✓ | OK |
| Build compilável | `flutter build ios --simulator` | `flutter build apk --debug` | OK |

## Manual (`.agents/qa-mobile.md`)

Requer `--dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>` e conta de teste.

| # | Fluxo | iOS sim | Android emu | Notas |
|---|-------|---------|-------------|-------|
| 1 | Splash → login/sessão | ⏳ | ⏳ | Executar com chave Supabase |
| 2 | Login email/senha | ⏳ | ⏳ | |
| 3 | Cadastro → `/plans` | ⏳ | ⏳ | |
| 4 | Recuperar senha | ⏳ | ⏳ | |
| 5 | 5 tabs (planos, clientes, catálogo, refs, settings) | ⏳ | ⏳ | |
| 6 | Logout → rotas protegidas | ⏳ | ⏳ | |
| 7 | Modo avião | ⏳ | ⏳ | |
| 8 | Logout / excluir conta | ⏳ | ⏳ | |

Comando sugerido (dois terminais):

```bash
cd agrimind
flutter run -d "iPhone 17" --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
flutter run -d emulator-5554 --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
```

Marcar ✓/✗ após execução manual e anotar falhas conforme `.agents/qa-mobile.md`.
