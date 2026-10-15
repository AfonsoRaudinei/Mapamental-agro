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
cd agrimind
grep "^version" pubspec.yaml
sh tool/build_ipa.sh
```

`build_ipa.sh` lê a chave em `../sup.rtf`, valida analyze/test, preflight de signing e copia o IPA para `../ipa/Agrimind_vBUILD.ipa`. Não use placeholder no lugar da chave.

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
