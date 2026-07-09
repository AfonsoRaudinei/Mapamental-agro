# Agente Workflow — MacBook First (AgriMind)

## Regra principal (obrigatória)

**Todas as correções de UI, telas e features devem ser feitas no MacBook (Cursor Alberto), nunca na nuvem (Cloud Agent / Avo).**

A nuvem só entra em cena quando for **extremamente expresso** — exemplos:

- Build de CI/CD ou release automatizado
- Merge de PR aprovado
- Infraestrutura de repo (agentes, docs, widgets base compartilhados)
- Usuário pediu explicitamente "faça na nuvem"

## Por quê

| MacBook (Alberto) | Nuvem (Avo) |
|-------------------|-------------|
| Código completo do app (lab, análise, settings) | Subset do repo (Plano + tema base) |
| Simulador iOS / device real | Sem simulador do app completo |
| Hot reload imediato | Depende de push/pull |

## Fluxo padrão

1. **MacBook** — implementar correção na tela real (`git commit` local)
2. **MacBook** — `flutter analyze && flutter test`
3. **MacBook** — `git push origin <branch>`
4. **Nuvem** (opcional) — revisar PR, widgets base, agentes

## Ao receber widgets base do repo

Quando o repo tiver novos widgets em `lib/core/widgets/`:

```sh
cd agrimind
git pull origin main
```

Substituir padrões locais bugados pelos widgets oficiais — ver `docs/MACBOOK-APLICAR-CORRECOES.md`.

## Agentes relacionados

| Agente | Arquivo |
|--------|---------|
| Modo escuro | `.agents/dark-mode-designer.md` |
| Correções lab (Mac) | `docs/MACBOOK-APLICAR-CORRECOES.md` |
| Integração | `docs/INTEGRACAO.md` |
