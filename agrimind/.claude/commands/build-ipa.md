# build-ipa

Gera o IPA de release do AgriMind para App Store.

## Protocolo obrigatório (release-mobile)

1. **Verificar versão** — confirmar `version` em `pubspec.yaml` e IDs em `docs/platform.md`.
2. **Análise limpa** — `flutter analyze` deve retornar `No issues found`.
3. **Testes passando** — `flutter test` deve passar 100%.
4. **Arquivos validados** — confirmar `ios/Runner/Runner.entitlements` (Sign in with Apple), dart-define `SUPABASE_PUBLISHABLE_KEY` e provisioning profile.
5. **Build do IPA** — `flutter build ipa --release`.
6. **Renomear** — copiar `build/ios/ipa/agrimind.ipa` → `build/ios/ipa/Agrimind_vBUILD.ipa`.
7. **Inspeção** — verificar assinatura, bundle version, entitlements e perfil de provisionamento.
8. **Não fazer upload** — somente subir se a usuária pedir explicitamente.

## Passos

```bash
# 1. Verificar versão
grep "^version" pubspec.yaml

# 2. Análise
flutter analyze

# 3. Testes
flutter test

# 4. Build IPA
flutter build ipa --release --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>

# 5. Renomear (substitua BUILD pelo número do build)
BUILD=$(grep "^version" pubspec.yaml | grep -o '+[0-9]*' | tr -d '+')
cp build/ios/ipa/agrimind.ipa "build/ios/ipa/Agrimind_v${BUILD}.ipa"
```

## Checklist de saída

- [ ] Versão e build number confirmados
- [ ] `flutter analyze` sem issues
- [ ] `flutter test` todos passando
- [ ] IPA gerado em `build/ios/ipa/`
- [ ] IPA renomeado para `Agrimind_vBUILD.ipa`
- [ ] Assinatura e entitlements verificados
- [ ] Upload NÃO realizado (aguardando confirmação)

## Notas

- IDs de plataforma: `docs/platform.md`
- Nunca commitar credenciais, chaves privadas ou perfis de provisionamento.
- Para upload usar Apple Transporter ou `xcrun altool`.
