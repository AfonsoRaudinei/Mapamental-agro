# Arquitetura Híbrida e Escala em Flutter

> Playbook definitivo para estruturação, gerenciamento de estado e testabilidade de aplicações complexas.

---

## 1. O Custo Invisível do Código Não Estruturado

### Entropia em Escala

Código sem fronteiras claras gera:

- dependências circulares;
- efeitos colaterais invisíveis;
- lógica duplicada;
- componentes acoplados;
- testes frágeis;
- alta dificuldade de manutenção.

### Disciplina Estrutural

A solução é uma malha arquitetural rígida com:

- módulos de UI;
- navegação;
- controle de estado;
- camada de apresentação;
- business logic layer;
- data access layer;
- serviços de API;
- serviços de banco;
- state management.

À medida que aplicações crescem, a ausência de fronteiras estritas transforma complexidade em instabilidade.

---

## 2. Projeto Arquitetônico Digital em Quatro Etapas

```text
Fundação -> Estrutura -> Encanamento -> Inspeção
```

### Fase 1 - Fundação

Engine C++ e Dart.

### Fase 2 - Estrutura

Arquitetura em camadas.

### Fase 3 - Encanamento

BLoC e fluxo unidirecional.

### Fase 4 - Inspeção

Testes e cobertura.

Desenvolver aplicações escaláveis exige mais do que empilhar widgets. Exige planta baixa rigorosa.

---

## 3. A Fundação: Como o Flutter Elimina a Ponte

Ao compilar para código de máquina nativo via AOT e assumir o controle da renderização via Skia, o Flutter contorna limitações de performance comuns em sistemas cross-platform tradicionais.

Conceito:

```text
Source Code -> C++/Skia Engine -> Native UI Screens
```

O ganho central é reduzir a dependência de bridges interpretadas para desenhar interface.

---

## 4. Matriz de Diagnóstico: Motores de Renderização

| Critério | Nativo | WebView | Reactive Views | Flutter |
|---|---:|---:|---:|---:|
| Acesso à API do OS | Total | Via bridge | Via bridge | Via Platform Channels |
| Performance | Máxima | Baixa | Média | Nativa/alta |
| Necessidade de bridge | Não | Sim | Sim | Não |
| Reuso de código | Mínimo | Alto | Alto | Alto |

---

## 5. Paradigma Declarativo: Moldando Pixels a partir de Dados

Fórmula conceitual:

```text
UI = f(state)
```

- O layout na tela é resultado do estado da aplicação.
- Os métodos `build` transformam estado em widgets.
- A UI é reconstruída quando dados mudam.

### Frameworks imperativos

A interface é manipulada diretamente. O desenvolvedor descreve passos para alterar a UI, aumentando risco de dessincronização.

### Frameworks declarativos

A interface descreve o estado final. O framework reconstrói a árvore quando os dados mudam.

---

## 6. Estrutura de Sustentação: Arquitetura de 4 Camadas

```text
Presentation Layer
Business Logic Layer
Domain Layer
Data Layer
```

### Presentation

Widgets, telas e UI.

### Business Logic

BLoCs e Cubits. Gerenciamento de estado.

### Domain

Repositórios e regras de domínio isoladas.

### Data

Clientes API externos, bancos de dados e código técnico.

Regra: limites lógicos estritos impedem que detalhes de infraestrutura contaminem regras de negócio ou UI.

---

## 7. Modularização Orientada a Features

Estrutura em cidade de código:

```text
app/lib
├── feature_login
├── feature_device_control
└── feature_settings

app/packages
├── repository_1..n
└── client_1..n
```

Dividir a aplicação em pacotes independentes garante:

- limites claros;
- compilações isoladas;
- código compartilhável;
- menor acoplamento.

---

## 8. Encanamento do Sistema: Fluxo Unidirecional de Dados

Fluxo:

```text
UI Layer --Eventos--> Data/Domain Layer
Data/Domain Layer --Estados--> UI Layer
```

Regra inegociável: interações descem como eventos; atualizações sobem como estados. Alterar esse ciclo cria dependências invisíveis e falhas de concorrência.

---

## 9. BLoC: Isolando a Lógica de Negócios

BLoC age como cérebro isolado da aplicação:

```text
UI -> Events -> BLoC -> States -> UI
BLoC -> Data -> BLoC
```

Características:

- entradas e saídas estritas via streams/sinks;
- zero ramificações de plataforma;
- dependências 100% injetáveis;
- transformações puras e previsíveis.

---

## 10. Cubit vs BLoC

### Cubit

Uso ideal: fluxos lineares onde chamada direta de método é suficiente.

```text
Function called -> emit -> onChange -> State emitted
```

Vantagens:

- simples;
- rápido;
- menor boilerplate.

### BLoC

Uso ideal: fluxos complexos com necessidade de auditoria, transição e controle de concorrência.

```text
Event -> EventTransformer -> EventHandler -> emit -> State
```

Vantagens:

- rastreabilidade;
- controle avançado;
- adequado para debounce, switchMap e workflows assíncronos.

---

## 11. Arquitetura em Ação: Raio-X de uma Funcionalidade

Exemplo de fluxo de uma feature de dispositivo:

1. Usuário dispara `DeviceCommandEvent`.
2. `DeviceBloc` mapeia evento e orquestra lógica.
3. Repositório recebe chamada de atualização.
4. Repositório traduz regra de domínio.
5. `ApiClient` envia mutação GraphQL.
6. API retorna sucesso.
7. Repositório retorna modelo atualizado.
8. `DeviceBloc` emite `DeviceCommandSuccessState`.

Resultado: qualquer funcionalidade complexa vira uma sequência previsível de eventos e reações.

---

## 12. Inspeção de Segurança e Testabilidade

Uma arquitetura limpa é a única maneira sustentável de alcançar alta cobertura de código.

Sem testabilidade estrutural nativa, sistemas quebram silenciosamente em produção conforme escalam.

Conceitos visuais do PDF:

- CI/CD pipeline como laser scan.
- Arquitetura modular testável.
- Seção fundida gera alerta de teste quebrado.

---

## 13. Espectro de Testes do Flutter

```text
Integration Tests
Widget Tests
Unit Tests
```

### Unit Tests

- Foco: lógica isolada, BLoCs e repositórios.
- Velocidade: ultra-rápida.
- Isolamento: total via mocks.
- Custo de manutenção: baixo.

### Widget Tests

- Foco: renderização e fluxos de injeção na UI.
- Velocidade: média.
- Isolamento: parcial sem emulador.
- Custo de manutenção: médio.

### Integration Tests

- Foco: comportamento do usuário e rotas críticas.
- Velocidade: lenta.
- Isolamento: nenhum; workflow real.
- Custo de manutenção: alto.

---

## 14. Anatomia de um Mock

Mocks permitem testar unidades rigorosamente isoladas, trocando uma dependência real sem que o código principal perceba.

Fluxo:

```text
Mock Database -> Código em Teste -> API Real/Nuvem
```

Objetivo: controlar o trilho. A dependência é trocada por uma simulação previsível.

---

## 15. Sound Null Safety

Dart exige que variáveis sejam não nulas por padrão. Essa restrição em tempo de compilação atua como uma viga estrutural que elimina classes inteiras de falhas em runtime.

Efeito prático:

- menos exceções de null;
- mais segurança de tipo;
- alertas no editor antes da execução.

---

## 16. Playbook do Arquiteto-Chefe de Software

Checklist do quadro final:

1. **Isole fronteiras:** separe apresentação, estrutura entre UI e lógica de negócio.
2. **Imponha fluxo unidirecional:** interações despacham eventos; dados sobem como estados. Nunca inverta a gravidade.
3. **Lidere pelo isolamento:** projete entidades para que qualquer serviço externo possa ser mockado. Código não testável é código mal arquitetado.

Frase final: escala não é sobre volume de código escrito, mas sobre regras restritas que a equipe se recusa a quebrar.
