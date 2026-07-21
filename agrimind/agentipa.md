# AgriMind IPA Agent

## Propósito

Este agente registra e governa o fluxo de IPA do AgriMind.

Regras centrais:

- Nunca gerar IPA sem embutir `SUPABASE_PUBLISHABLE_KEY` via `--dart-define`.
- Nunca commitar chaves, perfis de provisionamento ou credenciais privadas.
- Nunca gerar IPA com build number menor ou igual ao último IPA registrado.
- Sempre atualizar este arquivo após cada IPA concluída com sucesso.

## Fonte de verdade

- Versão e build number: `pubspec.yaml`
- Chaves de release: `docs/platform.md`
- Fluxo oficial de IPA: `.agents/release-mobile.md`

## Política de build

Antes de cada IPA:

1. Validar `flutter analyze`.
2. Validar `flutter test`.
3. Confirmar `SUPABASE_PUBLISHABLE_KEY` no comando de build.
4. Confirmar que o novo build number é maior que o último registrado neste arquivo.

Se qualquer uma dessas condições falhar, a IPA não deve ser gerada.

## Registro de releases

Atualize esta seção após cada IPA bem-sucedida.

| Data | Build | IPA | Commit | Status |
|------|-------|-----|--------|--------|
| 2026-07-20 | 142 | `build/ios/ipa/Agrimind_v142.ipa` | `55ea9c5` | concluída |
| 2026-07-13 | 141 | `build/ios/ipa/Agrimind_v141.ipa` | `9996317` | concluída |

## Checklist obrigatório pós-IPA

- [ ] `flutter analyze` aprovado
- [ ] `flutter test` aprovado
- [ ] `SUPABASE_PUBLISHABLE_KEY` embutida no build
- [ ] build number maior que o último registrado
- [ ] IPA gerada e validada no caminho final
- [ ] este arquivo atualizado com a nova release

## Observação operacional

Se houver dúvida sobre qual é o próximo build, o número válido é sempre:

- `último build registrado + 1`

Nunca reutilize um número anterior.
