# CONTRATO_REGULAGEM — Como executar um prompt

Contrato curto. Violar qualquer cláusula custa tokens e produz código no lugar errado.

## 1. Classificar (10 s, sem ferramenta)

| Tipo | Skill única | Não ler |
|------|-------------|---------|
| Widget/UI no app | `agrimind-flutter` | new-feature, build-ipa |
| Feature nova (domínio + data + rota) | `agrimind-new-feature` | build-ipa |
| Validar | `agrimind-flutter-check` | o resto |
| IPA | `agrimind-build-ipa` | new-feature |

Prompt colado com código de referência = **implementação**, não redesenho de arquitetura.

## 2. Extrair o contrato do prompt

Anotar só isto (mental ou no rascunho da resposta):

- Objetivo em 1 frase
- Arquivos pedidos vs arquivos reais (grep)
- Fora de escopo
- Checklist de qualidade do próprio prompt

Descartar: tutoriais, código duplicado se o arquivo-alvo já existe, “justificativa pedagógica”.

## 3. Contexto mínimo

Ordem máxima:

1. Tokens + arquivo que vai mudar.
2. 1 vizinho de uso real (quem instancia o widget).
3. Teste semelhante, se for escrever teste.

Protótipo HTML: `Grep` da classe/seção, não `Read` do arquivo inteiro.

## 4. Executar em fatias

1. Criar/ajustar os widgets/providers pedidos.
2. Encaixar no uso real (não montar página-demo).
3. Testes do contrato (feliz, vazio, N itens, ação destrutiva isolada).
4. `dart format` nos tocados → `flutter analyze` → `flutter test` (código Dart).

Não rodar a suíte antes de o código compilar. Não `build_runner` se nada gerado mudou.

## 5. Entrega

- Resposta: o que entrou, onde, desvio de path (se houve).
- Checklist no formato de [`MODELO_CHECKLIST.md`](MODELO_CHECKLIST.md).
- Se rodou analyze/test/ipa: bloco [`MODELO_REGISTRO_BUILD.md`](MODELO_REGISTRO_BUILD.md) na resposta — **não gravar arquivo** salvo o usuário pedir.

## Cláusulas anti-desperdício

- Não reler `AGENTS.md` + `agent.md` + `agente.md` no mesmo turno se a skill de domínio já aponta as regras.
- Não lançar subagente para achar um arquivo; `Glob`/`Grep` bastam.
- Não implementar `_Foo` que o prompt marcou fora de escopo.
- Código de referência do prompt: adaptar a tokens/ícones do repo; não copiar `Color(0xFF…)` nem `Icons.*` se o projeto usa Phosphor + `AppColors`.
