---
name: agrimind-build-ipa
description: >-
  Gera IPA de release do AgriMind para App Store. Use para build iOS, TestFlight
  prep ou quando o usuário pedir build-ipa ou release mobile.
---

# AgriMind — Build IPA

Espelha `agrimind/.claude/commands/build-ipa.md`. IDs: `agrimind/docs/platform.md`.

## Protocolo

1. Confirmar versão em `pubspec.yaml`.
2. `flutter analyze` limpo + `flutter test` verde.
3. Validar entitlements Apple + dart-define Supabase.
4. `flutter build ipa --release`.
5. Renomear IPA.
6. Inspecionar assinatura — **não fazer upload** sem pedido explícito.

## Comandos

```bash
cd agrimind
grep "^version" pubspec.yaml
flutter analyze && flutter test
flutter build ipa --release --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>
BUILD=$(grep "^version" pubspec.yaml | grep -o '+[0-9]*' | tr -d '+')
cp build/ios/ipa/agrimind.ipa "build/ios/ipa/Agrimind_v${BUILD}.ipa"
```

## Checklist de saída

- [ ] Versão confirmada
- [ ] Analyze + test verdes
- [ ] Entitlements e dart-define OK
- [ ] IPA gerado e renomeado
- [ ] Upload NÃO realizado

Consulte também `agrimind/.agents/release-mobile.md`.
