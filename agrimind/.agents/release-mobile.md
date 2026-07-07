# Mobile Release

IDs e versão: ver `docs/platform.md`.

- Confirm `pubspec.yaml` version before building.
- Validate Supabase dart-define, Apple entitlements, and signing before archive.
- Build App Store IPA only after analysis, tests, and device smoke tests pass.
- Inspect IPA signing, bundle version, entitlements, and provisioning profile.
- Do not upload unless the user explicitly requests upload.

## Pré-build

```bash
cd agrimind
grep "^version" pubspec.yaml
flutter analyze    # No issues found
flutter test       # 100% green
```

## Build e renomear

```bash
cd agrimind
flutter build ipa --release --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
BUILD=$(grep "^version" pubspec.yaml | grep -o '+[0-9]*' | tr -d '+')
cp build/ios/ipa/agrimind.ipa "build/ios/ipa/Agrimind_v${BUILD}.ipa"
```

## Checklist iOS

- [ ] `ios/Runner/Runner.entitlements` — Sign in with Apple
- [ ] `ios/Runner/PrivacyInfo.xcprivacy` no bundle
- [ ] Bundle ID = `com.cultivamind.agrimind`
- [ ] `SUPABASE_PUBLISHABLE_KEY` passada no build
- [ ] IPA assinado e renomeado
- [ ] Metadados + screenshots: `docs/store-listing.md`
- [ ] TestFlight interno → externo → App Review

## TestFlight → produção

1. Upload IPA (Transporter / Xcode)
2. Internal testing — equipe + smoke `.agents/qa-mobile.md`
3. External testing — grupo beta + **What to Test** em PT-BR
4. Submit for Review com conta demo nas notas
5. Phased release recomendado (7 dias)

Detalhes completos: [`docs/store-listing.md`](../docs/store-listing.md)
