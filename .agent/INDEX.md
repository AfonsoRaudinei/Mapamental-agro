# `.agent/` — Regulagem de prompt (Cultiva Mind / AgriMind)

Pacote de execução. Não é documentação de produto. Objetivo: **menos contexto, menos ferramenta, mesmo resultado**.

## Quando usar

- Prompt longo de implementação (código de referência, tabelas de props, checklist).
- Pedido do tipo “execute este prompt”, “implemente conforme”, “siga o contrato”.
- Risco de feature duplicada, path inventado ou leitura excessiva.

## Ordem de leitura (máximo 2 arquivos antes de editar)

1. Este `INDEX.md` (já está aberto).
2. [`CONTRATO_REGULAGEM.md`](CONTRATO_REGULAGEM.md) — protocolo de execução.
3. [`AGENT_REGRAS.md`](AGENT_REGRAS.md) — só se o contrato não cobrir o caso.
4. Templates na **resposta**, não no disco:
   - [`MODELO_CHECKLIST.md`](MODELO_CHECKLIST.md)
   - [`MODELO_REGISTRO_BUILD.md`](MODELO_REGISTRO_BUILD.md)

Não leia `agrimind/AGENTS.md`, `agent.md`, `agente.md` e 3 skills de uma vez. Escolha **uma** skill de domínio.

## Skill Cursor

`.cursor/skills/prompt-performance/SKILL.md` — dispara o contrato.

Papel Codex/Claude: `agrimind/.agents/prompt-performance.md`.

## Mapa rápido de paths

| O prompt pede | No repo real |
|---------------|--------------|
| `features/plano_soja/` | `agrimind/lib/features/plans/` |
| `plano_soja_page.dart` | `plan_canvas_page.dart` + `plan_canvas_widgets.dart` |
| tokens / cores | `agrimind/lib/core/constants/app_colors.dart` |
| widget genérico | `agrimind/lib/core/widgets/` |
