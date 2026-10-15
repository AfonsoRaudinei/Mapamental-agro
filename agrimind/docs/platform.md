# AgriMind — Platform IDs

Fonte única de IDs de plataforma. Outros docs devem **referenciar este arquivo**, não duplicar valores.

## App

| Campo | Valor |
|-------|-------|
| Nome | AgriMind |
| Bundle / Application ID | `com.cultivamind.agrimind` |
| Idioma | PT-BR |
| Plataforma primária | iOS |

## Apple (release)

| Campo | Valor |
|-------|-------|
| Team ID | `BA2BU25B78` |
| Entitlements | `ios/Runner/Runner.entitlements` (Sign in with Apple) |
| Versão | `pubspec.yaml` → `MARKETING.BUILD_NUMBER` (ex.: `1.0.0+122`) |

## Supabase (auth)

| Campo | Valor |
|-------|-------|
| Project ref | `wugqcowsujyrspkbupxq` |
| URL | `https://wugqcowsujyrspkbupxq.supabase.co` |
| Schema/migrations | `agrimind/supabase/` (fonte única — não usar `/supabase` na raiz do repo) |
| Config no código | `lib/core/config/supabase_config.dart` |
| Chave pública | `--dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>` (nunca commitar) |

Providers habilitados: email/senha, Google, Apple.

## Android

| Campo | Valor |
|-------|-------|
| Application ID | `com.cultivamind.agrimind` |
| Gradle | `android/app/build.gradle.kts` |
| Keystore (release) | `android/app/upload-keystore.jks` + `android/key.properties` (gerar via `tool/create_android_keystore.sh`) |

## Legal (lojas)

| Página | URL produção | Fonte estática |
|--------|--------------|----------------|
| Privacidade | `https://cultivamind.com/privacidade` | `docs/legal/privacidade.html` |
| Termos | `https://cultivamind.com/termos` | `docs/legal/termos.html` |

Override opcional no build: `--dart-define=PRIVACY_POLICY_URL=...` e `TERMS_URL=...`.

## Segredos — nunca commitar

- `SUPABASE_PUBLISHABLE_KEY` / service role keys
- `android/key.properties` e `*.jks` / `*.keystore`
- Senhas de usuários de teste
- Provisioning profiles (`.mobileprovision`)
- Chaves privadas Apple (`.p8`, `.p12`)

## Comandos com dart-define

```bash
cd agrimind
flutter run --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
flutter build ipa --release --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
sh tool/create_android_keystore.sh
flutter build appbundle --release --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
```
