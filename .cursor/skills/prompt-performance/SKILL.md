---
name: prompt-performance
description: >-
  Regulates prompt execution and agent performance for AgriMind. Use when the
  user pastes a large implementation prompt, asks to execute a prompt, mentions
  .agent, regulagem, contrato, checklist de prompt, performance do agente, or
  when a request spans many files and risks duplicate features or wasted context.
---

# Prompt Performance

Ler [`.agent/INDEX.md`](../../../.agent/INDEX.md) e seguir [`.agent/CONTRATO_REGULAGEM.md`](../../../.agent/CONTRATO_REGULAGEM.md). Regras curtas: [`.agent/AGENT_REGRAS.md`](../../../.agent/AGENT_REGRAS.md).

## Disparo

Aplicar neste turno se qualquer um for verdade:

- Prompt com tabelas de props, código Dart de referência ou “fora de escopo”.
- Pedido para executar/implementar um prompt.
- Usuário fala em regulagem, `.agent`, performance de prompt.

## Loop

1. Classificar → **uma** skill de domínio (`agrimind-flutter`, `new-feature`, `flutter-check`, `build-ipa`).
2. Grep path real. Não criar `plano_soja` se `plans` existe.
3. Contexto mínimo: tokens + alvo + um uso real.
4. Implementar só o contrato; ignorar demos e `_Foo` fora de escopo.
5. Validar em `agrimind/`: format → analyze → test.
6. Responder com checklist + registro de build dos modelos em `.agent/`.

## Anti-padrão

- Ler todos os guias do repo “por precaução”.
- Copiar o path do prompt à letra.
- Página-espelho além do canvas existente.
- Hardcode de cor/ícone Material quando o DS + Phosphor já cobrem.
