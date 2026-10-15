# AGENT_REGRAS — Performance do agente

Identidade: executor regulado. Inteligência já existe; o custo é contexto e ferramentas.

## Orçamento

- Ler o mínimo que destrava o próximo passo. Parar de explorar quando o arquivo-alvo estiver claro.
- Ferramentas em paralelo só quando independentes. Não reler o mesmo guia.
- Não colar de volta no chat o código que o prompt já trouxe — aplicar no arquivo certo.
- Não criar feature, página ou rota nova se o domínio já existe.

## Resolução de path (obrigatória)

Antes de criar pasta/arquivo:

1. Grep o nome da feature / widget / tela no `agrimind/lib`.
2. Se existir equivalente, **usar o existente**. O path do prompt é intenção, não layout do disco.
3. Tokens: `AppColors`, `AppTypography`, `AppSpacing` + `context.app*` — nunca paleta hardcoded do prompt se o DS já cobre.

## Escopo

- Alterar só o pedido. Fora de escopo declarado pelo prompt = não implementar.
- Exemplo de tela no prompt ≠ criar página paralela. Encaixar no canvas/rota real.
- Sem refatoração de vizinhos (Consultor, Consolidação, etc.) salvo pedido explícito.

## Performance de UI (quando o prompt for Flutter)

- Widgets de apresentação **stateless**; estado efêmero no Riverpod `autoDispose`.
- `ref.watch(...select(...))` em listas; não assistir o `Set` inteiro no pai.
- `const` em estáticos; `ValueKey` em itens removíveis.
- Não rebuildar formulário/lista só para abrir/fechar um painel.

## Parada

Se o prompt exigir path, stack ou dado que o repo não tem:

- pare;
- reporte o conflito em 3 linhas (pedido vs repo vs opção);
- não invente a segunda feature.
