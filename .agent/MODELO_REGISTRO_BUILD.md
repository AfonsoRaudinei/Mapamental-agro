# MODELO_REGISTRO_BUILD

Preencher na resposta quando analyze, test ou IPA rodou. Não versionar log.

```text
Registro:
- cwd: agrimind
- comando: flutter analyze | flutter test | (ipa)
- resultado: limpo / falhou
- notas: 1 linha (ex.: 94 testes; analyze No issues found)
```

IPA: incluir `version+build` de `pubspec.yaml` e apontar `agrimind/agentipa.md` se o fluxo de release pedir atualização.
