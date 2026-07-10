# Agente Flutter/Dart

Este arquivo define as regras obrigatorias para qualquer alteracao neste projeto Flutter.

## Objetivo

- Seguir boas praticas de Flutter/Dart.
- Manter o codigo previsivel, testavel e facil de manter.
- Alterar somente o que foi pedido.

## Regras obrigatorias

1. Antes de alterar qualquer coisa, entenda o pedido e confirme o escopo.
2. Se a solicitacao for ambigua, pare e pergunte antes de editar.
3. Nao altere arquivos, logica ou comportamento fora do que foi pedido.
4. Se for necessario mexer em algo fora do escopo para concluir o pedido, pare e reporte o motivo antes de seguir.
5. Preserve o estilo e a arquitetura ja existentes no projeto.
6. Priorize mudancas pequenas, localizadas e rastreaveis.
7. Nao faça refatoracoes amplas sem pedido explicito.

## Padrao de desenvolvimento

- Use arquitetura limpa feature-first:
  - `presentation` — UI, widgets, providers Riverpod e paginas.
  - `domain` — entidades puras, contratos de repository e use cases.
  - `data` — datasources (Drift/Supabase), DTOs e implementacoes de repository.
- Estado e fluxo ficam em `presentation/providers`; regra de negocio em `domain/usecases`.
- Mantenha a regra de dependencia apontando para o centro.
- Mantenha UI burra: widget nao deve concentrar regra de negocio.
- Use fluxo unidirecional de dados sempre que possivel:
  - evento ou acao do usuario -> estado -> renderizacao da UI.
- Use `const` quando possivel.
- Evite reconstrucoes desnecessarias.
- Prefira componentes pequenos e reutilizaveis.

## Estado e dados

- Use o mecanismo de estado ja adotado no projeto.
- Se o projeto nao tiver padrao definido, escolha a menor solucao que mantenha simplicidade e rastreabilidade.
- Nao misture acesso a API, banco ou cache diretamente na UI.
- Repositories devem esconder a origem do dado.

## Qualidade

- Sempre valide o resultado com checagem ou teste quando o contexto permitir.
- Priorize testes de unidade para regra de negocio.
- Use testes de widget para comportamento visual.
- Use testes de integracao apenas quando o fluxo exigir.

## Fluxo de trabalho obrigatorio

1. Ler o pedido.
2. Identificar arquivos afetados.
3. Alterar somente o necessario.
4. Validar a mudanca.
5. Reportar exatamente o que foi feito.

## Checklist de conclusao

Ao finalizar, sempre informar um checklist com um destes estados para cada item:

- `[x]` concluido
- `[ ]` nao concluido

Modelo minimo de saida:

```text
Checklist:
- [x] Item 1
- [ ] Item 2
```

## Regra de parada

Se surgir qualquer necessidade fora do pedido original:

- pare imediatamente;
- nao faca alteracoes adicionais;
- reporte o que foi encontrado;
- aguarde confirmacao antes de continuar.

## Fluxos de UX / Responsabilidades de tela

Posicionamento: **Simples. Poderoso. Teu.** — ver `Instrucao/🍎 APPLE — - cópia.md` e `agent.md` (secao UX Flows).

- O usuario nunca deve se perguntar "pra onde vou agora?" — um toque, um proposito por tela.
- Menos etapas vencem formularios intermediarios. Nao reintroduzir fluxos inline quando o bottom sheet ja resolve.

### Canvas / ProdutoPanel

Aberto direto em **"+ Adicionar produto"** ou ao tocar num produto existente.

Campos permitidos:
- Nome do produto
- Dose + unidade
- Area de aplicacao (fazenda / personalizado)
- Total calculado (+ ajuste manual)
- Observacao (opcional)

**Fora do ProdutoPanel:**
- Preco unitario → somente na aba Consolidação
- Data prevista de aplicacao → nao usada no planejamento (agro nao permite cravar data nesta aba)

Ao editar, preservar `precoUnitario` e `dataPrevista` ja persistidos — nao apagar no save do painel.

### Aba Consolidação

Camada financeira do mesmo plano:
- Precos unitarios por produto consolidado (linha flat alinhada ao cabecalho da tabela)
- Parametros financeiros do plano: valor do grao (R$/sc 60 kg) e data de vencimento

Linhas da tabela devem seguir o grid do cabecalho (`Produto | Qtd. | R$ Unit. | R$ Total`) — sem expand/collapse que quebre colunas.

### Referencias tecnicas

Dois livros no header do estádio:
- livro padrão (outline) → Doenças, Insetos, Nutrição, Fisiologia
- livro dourado (fill) → Circular técnica + Campeões CESB (trilha monetizável)

Selecionar referencia abre o `ProdutoPanel` com nome pre-preenchido — mesmos campos agronomicos apenas.
