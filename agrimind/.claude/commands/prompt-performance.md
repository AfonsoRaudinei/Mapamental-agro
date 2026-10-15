# prompt-performance

Espelha `.cursor/skills/prompt-performance/` e o pacote `.agent/` na raiz do workspace.

## Passos

1. Ler `../../../.agent/INDEX.md` e `../../../.agent/CONTRATO_REGULAGEM.md`.
2. Classificar o prompt e carregar **uma** skill/comando de domínio.
3. Grep o path real em `lib/` antes de criar pasta.
4. Implementar só o contrato; respeitar fora de escopo.
5. `cd agrimind` → `dart format` nos tocados → `flutter analyze` → `flutter test`.
6. Responder com os modelos em `../../../.agent/MODELO_CHECKLIST.md` e `../../../.agent/MODELO_REGISTRO_BUILD.md`.
