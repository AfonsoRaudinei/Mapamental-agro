# Arquitetura Flutter em Escala Enterprise

> Manual de engenharia sobre gerenciamento de estado, modularização e testes de alta performance.

- **Target:** Mid/Senior Devs & Architects
- **Framework:** Flutter 3.x
- **Padrão:** Hybrid Multimodule Monorepo

---

## 1. A Genialidade Mecânica do Paradigma Reativo

Fluxo conceitual:

```text
state -> f() -> UI
```

- **State:** o estado da aplicação em um dado momento.
- **f():** método `build` da árvore de widgets.
- **UI:** layout renderizado na tela.

Princípios:

- **Sem cascata:** Flutter não atualiza o estado imperativamente. Ele constrói a interface passivamente com base no estado atual.
- **Imutabilidade:** widgets são configurações imutáveis. Mudar o estado significa instanciar uma nova árvore.
- **Performance Skia:** instanciar milhares de objetos em Dart é rápido e barato.

---

## 2. A Eliminação do Gargalo de Comunicação

### Abordagem Reativa Clássica

- App conversa com código nativo por uma ponte JavaScript.
- UI baseada em widgets nativos OEM.
- Comunicação atravessa bridge.
- Performance sofre com latência da ponte em animações complexas.

### Abordagem Flutter

- Dart compilado AOT.
- Comunicação direta, sem ponte JavaScript.
- UI renderizada pelo próprio motor Skia.
- Comunicação com serviços via Platform Channels.
- Performance alvo: 60 a 120 FPS nativos consistentes.

---

## 3. O Desafio da Escala: Quando `setState` Falha

### Antipadrão: Monolito Frágil

Misturar lógica de negócio na camada de UI cria:

- testes isolados difíceis;
- reconstruções desnecessárias em cascata;
- acoplamento alto;
- baixa previsibilidade.

### Tipologia de Estado

| Tipo de estado | Exemplo | Ferramenta sugerida |
|---|---|---|
| Estado efêmero/local | Animações, aba atual, texto em input | `setState` nativo |
| Estado da aplicação/global | Sessões de usuário, carrinho de compras, dados de API | BLoC / Cubit |

---

## 4. A Resposta: Arquitetura Híbrida

A arquitetura híbrida combina:

### Arquitetura em Camadas

Separação horizontal por papel técnico:

```text
UI
Lógica
Dados
```

Vantagem: padronização técnica rigorosa.

### Arquitetura Orientada a Features

Separação vertical por domínio:

```text
login
carrinho
pagamento
```

Vantagem: equipes trabalham isoladamente, com menos conflito.

### Modelo híbrido

```text
Feature A   Feature B   Feature C
UI Layer    UI Layer    UI Layer
Business    Business    Business
Data        Data        Data
```

O aplicativo é dividido verticalmente por features. Dentro de cada feature, os dados são organizados horizontalmente em camadas estritas.

---

## 5. O Stack de 4 Camadas

```text
Presentation Layer
Business Logic Layer
Domain Layer
Data Layer
```

### Presentation Layer

- Widgets Flutter.
- Reage passivamente a mudanças de estado.
- Desenha pixels na tela.

### Business Logic Layer

- BLoCs e Cubits.
- Gerencia estado reativo de uma feature específica.
- Injeta dependências.

### Domain Layer

- Repositórios baseados em domínio.
- Centraliza regras de negócio.
- Orquestra múltiplos clientes.

### Data Layer

- Clientes de API.
- Bancos locais.
- Transforma dados brutos sem conhecer a interface.

---

## 6. Empacotamento: Multimodule Monorepo

### Erro Monolítico

```text
lib/
├── screens/
├── models/
└── utils/
```

Problema: pastas genéricas agrupam por tipo técnico e escondem acoplamento entre domínios.

### Padrão Enterprise

```text
app_root/
├── lib/
│   └── features/
│       ├── home/
│       └── login/
└── packages/
    ├── api_client/
    └── user_repository/
```

Insight: mover domínio e dados para `packages/` força limites rígidos. A UI só contorna regras porque pacotes são bibliotecas independentes, impedindo importações circulares.

---

## 7. A Mecânica do Padrão BLoC

Fluxo:

```text
UI -> Event -> BLoC Core -> Request -> Repository/Data
Repository/Data -> Response -> BLoC Core -> State -> UI
```

Regra de ouro: o fluxo de dados é estritamente unidirecional. A UI emite eventos e reage a estados. Ela nunca altera banco de dados diretamente.

---

## 8. BLoC vs Cubit: Matriz de Decisão

### Cubit

- Leve e direto.
- Usa funções chamadas diretamente pela UI.
- Emite novos estados.
- Menos boilerplate.
- Ideal para lógica simples.

Exemplo conceitual:

```dart
context.read<ThemeCubit>().toggleTheme();
```

### BLoC

- Robusto e complexo.
- Reage a eventos enfileirados em stream contínuo.
- Rastreabilidade completa.
- Manipulação avançada com debounce/throttle.
- Ideal para APIs e paginação.

Exemplo conceitual:

```dart
context.read<SearchBloc>().add(QueryChanged(text));
```

---

## 9. A Espinha Dorsal: Injeção de Dependências

Cadeia:

```text
ApiClient -> UserRepository -> UserBloc
```

- `ApiClient`: instância global ou cliente base.
- `UserRepository`: injetado via `RepositoryProvider`.
- `UserBloc`: injetado via `BlocProvider`.

Exemplo:

```dart
BlocProvider(
  create: (context) => UserBloc(
    userRepository: context.read<UserRepository>(),
  ),
)
```

Insight: constructor injection deixa as dependências explícitas. O repositório acessa dados, mas não conhece a UI. Zero variáveis globais ocultas. Mais testável.

---

## 10. Playbook de Quality Assurance

Pirâmide:

```text
Testes de Integração
Testes de Widget
Testes de Unidade
```

### Testes de Unidade

- Alvo: BLoCs, repositórios, services.
- Lógica de negócio isolada.
- Execução determinística em milissegundos.

### Testes de Widget

- Alvo: componentes visuais da árvore de UI.
- Interação simulada com `pumpAndSettle`.
- Roda em memória sem simulador.

### Testes de Integração

- Alvo: app completo em dispositivo real.
- Foco em fluxos E2E e comunicação com APIs reais.

---

## 11. O Mecanismo de Mocking

### Antipadrão

Teste não isolado usando banco real:

- gera latência;
- cria flakiness;
- quebra regra de isolamento da unidade.

### Padrão de Isolamento

Substituir clientes reais por objetos simulados com entradas e saídas instantâneas e pré-definidas.

### Três passos

1. **Setup:** configurar estado esperado do objeto simulado.
2. **Act:** fornecer o mock ao código sob teste.
3. **Assert:** verificar se o comportamento esperado foi chamado.

---

## 12. Testando a Máquina de Estado com `bloc_test`

Fluxo:

```text
1. Build -> 2. Act -> 3. Expect
```

### Build

Instanciar o BLoC com dependências mockadas.

```dart
build: () => AuthBloc(mockRepo)
```

### Act

Disparar eventos simulando a ação do usuário.

```dart
act: (bloc) => bloc.add(LoginRequested())
```

### Expect

Verificar a sequência exata dos estados emitidos.

```dart
expect: () => [
  AuthLoading(),
  AuthSuccess(),
]
```

Insight: como o BLoC mapeia evento para estado de forma pura, prever o array exato de estados garante confiança na lógica antes da UI existir.

---

## 13. Síntese: Fluxo Enterprise Completo

Fluxo de autenticação:

```text
UI Widget
  -> LoginSubmitted event
  -> AuthBloc
  -> AuthRepository
  -> ApiClient
  -> HTTP Request
  -> AuthSuccess
  -> BlocBuilder redesenha UI
```

Responsabilidades:

- **UI:** emite evento e renderiza estado.
- **AuthBloc:** orquestra a lógica.
- **AuthRepository:** formata requests e dados.
- **ApiClient:** executa chamada HTTP.
- **BlocBuilder:** reage ao retorno.

---

## 14. Frase central

> Escalabilidade não é um acidente. É uma escolha de design.

A combinação de arquitetura híbrida, rigidez do padrão BLoC e separação via monorepos cria sistemas de baixa fricção.

### Resultado esperado

- **Testabilidade:** lógica isolada com cobertura por mocks e unit tests.
- **Modularidade:** equipes paralelas trabalhando em packages distintos sem conflito.
- **Manutenibilidade:** efeitos colaterais previsíveis; todo evento tem estado garantido.
