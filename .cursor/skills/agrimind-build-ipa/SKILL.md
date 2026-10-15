---
name: agrimind-build-ipa
description: >-
  Gera IPA de release do AgriMind para App Store. Use para build iOS, TestFlight
  prep ou quando o usuário pedir build-ipa ou release mobile.
---

# AgriMind — Build IPA

Espelha `agrimind/.claude/commands/build-ipa.md` e `agrimind/agentipa.md`. IDs: `agrimind/docs/platform.md`.

## Protocolo do agente

1. **Sempre rodar no terminal** (não só instruir a usuária):
   ```bash
   cd agrimind && sh tool/build_ipa.sh
   ```
2. Confirmar versão em `pubspec.yaml` e ledger em `agentipa.md`.
3. Após IPA OK: atualizar tabela em `agentipa.md`; integrar branch em `main` quando a entrega pedir release completo (commit/push só se a usuária pedir).
4. **Não fazer upload** sem pedido explícito.

O script `tool/build_ipa.sh` já executa: leitura de chave em `sup.rtf` → `flutter analyze` → `flutter test` → `tool/preflight_ios_signing.sh` → `flutter build ipa` com `ios/ExportOptions.plist` → cópia para `../ipa/Agrimind_vBUILD.ipa`.

## Checklist de saída

- [ ] Comando executado no terminal pelo agente
- [ ] Analyze + test verdes
- [ ] IPA em `build/ios/ipa/` e `ipa/`
- [ ] `agentipa.md` atualizado
- [ ] Upload NÃO realizado

Consulte também `agrimind/.agents/release-mobile.md`.
