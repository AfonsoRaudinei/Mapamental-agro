# O Projeto de Precisão: Engenharia Flutter de Alta Performance

> Padrões enterprise, arquitetura limpa e ecossistemas escaláveis.

---

## 1. O Paradoxo da Escala: Do Caos à Engenharia de Precisão

### Problema

- Código acoplado.
- Interfaces sobrecarregadas.
- Rebuilds desnecessários causando jank.
- Regras de negócio misturadas com widgets.

### Solução: Máquina Perfeita

Componentes estruturais:

- Fundação: Clean Architecture.
- Motor: gestão de estado reativa.
- Aerodinâmica: renderização Impeller.
- Linha de montagem: CI/CD.

---

## 2. Fundação: Clean Architecture no Flutter

Camadas:

### Presentation Layer

- UI, widgets e controllers.
- BLoC/Riverpod.
- Regra: extremamente burra, apenas reage ao estado.

### Domain Layer

- Entities e use cases.
- Coração puro em Dart.
- Zero dependência do Flutter.

### Data Layer

- APIs, Hive/SQLite, repositories e models.
- Regra: busca e transforma dados brutos em objetos.

Insight: a regra de dependência aponta sempre para o centro. A UI nunca conhece a origem do dado.

---

## 3. Escudo Protetor: Padrão Repository

Fluxo:

```text
GetUserDataUseCase -> abstract class UserRepository
UserRepository -> RemoteDataSource / LocalDataSource
```

O Repository atua como tradutor. Se a fonte de dados migrar de REST para GraphQL, a camada de UI e domínio permanecem intactas.

---

## 4. Trilha Unidirecional: UDF

Fluxo:

```text
Ação do usuário -> Evento -> Gestor de Estado -> Novo Estado -> UI reconstruída
```

Regra: a UI se reconstrói baseada puramente no estado.

Cuidado: contornar essa trilha, por exemplo com UI alterando banco diretamente, quebra previsibilidade e impossibilita auditoria do código.

---

## 5. Motor: Filosofia Declarativa

```text
UI = f(state)
```

- **UI:** layout renderizado.
- **f:** métodos `build` dos widgets.
- **state:** estado atual da aplicação.

No Flutter, a tela não é modificada diretamente. O estado muda e o framework redesenha a UI de forma otimizada.

---

## 6. Grande Batalha de Estados: O que usar em 2026?

| Critério | Riverpod 3.0 | BLoC 9.0 |
|---|---|---|
| Paradigma | Caching reativo e data binding | Eventos baseados em streams |
| Segurança | Compile-time safety excepcional | `context.mounted` automático robusto |
| Auditoria | Boa via observers | Padrão ouro com rastreamento rígido |
| Offline first | Nativo e automático | Via pacote `hydrated_bloc` |
| Boilerplate | Baixo via code generation | Alto, focado em rigor estrutural |

Resumo:

- **Riverpod:** startups modernas e ciclo rápido.
- **BLoC:** projetos enterprise fortemente auditados.

---

## 7. Anatomia do BLoC 9.0

Fluxo interno:

```text
Event -> EventTransformer -> EventHandler -> State
```

Regra de ouro enterprise: a UI nunca executa lógica. Ela apenas dispara gatilhos. O BLoC age como uma caixa preta auditável.

---

## 8. Aerodinâmica: Renderização e Impeller

### Gargalo Skia

- Compilação de shaders em tempo de execução.
- Jank e atraso de 100-300ms na primeira animação.

### Via expressa: Impeller

- Compilação Ahead-of-Time.
- Shaders pré-compilados no build time.
- Operações complexas caem de aproximadamente 450ms para 11ms, conforme apresentado no PDF.

Nota do material: Flutter 3.29+ unificou threads de UI e Raster, entregando 60+ FPS de forma determinística.

---

## 9. Blindagem de Performance: Funil do `const`

O uso de `const` reduz reconstruções inúteis.

Princípios:

- Flutter destrói e recria widgets agressivamente.
- Widgets `const` são alocados em tempo de compilação.
- Se o pai sofre rebuild, objeto `const` pode ser ignorado.
- Para dados grandes, trocar `ListView` padrão por `ListView.builder` permite lazy loading.

---

## 10. Controle de Qualidade: Pirâmide de Testes

```text
Testes de Integração
Testes de Widget
Testes Unitários
```

### Testes Unitários

- Foco: domínio, use cases e classes puras.
- Velocidade: milissegundos.
- Volume: alto.

### Testes de Widget

- Foco: componentes de UI com mocks.
- Usa `WidgetTester` para simular interações.

### Testes de Integração

- Foco: fluxos completos em emuladores reais.
- Custo alto e manutenção mais lenta.

Regra de ouro: busque 100% de cobertura na base de domínio antes de escalar a pirâmide.

---

## 11. Isolamento Total: Testes de Widget e Mocks

### Mocks

Substituem dependências imprevisíveis por simulações exatas.

Exemplo conceitual:

```dart
when(() => mockRepo.login()).thenAnswer((_) async => User());
```

### WidgetTester

Operações comuns:

```dart
pumpWidget();
enterText();
tap();
expect(find.byType(CircularProgressIndicator), findsOneWidget);
```

Objetivo: validar a matemática da UI sem achismos.

---

## 12. Linha de Montagem: CI/CD com GitHub Actions

Fluxo:

```text
Pull Request -> Crash Test -> Build -> Deploy Automatizado
```

Etapas:

- gatilho intercepta código na direção da branch `main`;
- isolamento cria contêiner imaculado;
- porta de qualidade impede merge se validações falharem.

---

## 13. Anatomia do Workflow YAML

Pipeline típico:

1. Checkout do código: `actions/checkout@v4`.
2. Setup do motor Flutter: `subosito/flutter-action@v2`.
3. Instalação de pacotes: `flutter pub get`.
4. Auditoria e linting: `flutter analyze`.
5. Validação: `flutter test`.
6. Empacotamento: `flutter build apk --release`.

Saída: artefato gerado e armazenado de forma rastreável.

---

## 14. Ultimate Flutter Pipeline

Sequência do ecossistema simbiótico:

1. Usuário toca na UI.
2. Evento é disparado no BLoC.
3. Use case é acionado no domínio.
4. Repository busca dados na Data Layer.
5. Impeller renderiza a 60 FPS o novo estado.
6. Cobertura blindada por testes unitários e mocks.
7. GitHub Actions valida o código e orquestra deploy contínuo.

---

## 15. Padrão Ouro Enterprise: Checklist de Implementação

- **Arquitetura:** o domínio sobrevive se você remover o Flutter do projeto amanhã?
- **Estado:** o gerenciamento possui fluxo unidirecional rígido e separação clara da UI?
- **Performance:** o widget tree maximiza `const` e evita listagens gulosas?
- **Cobertura:** a pirâmide de testes cobre 100% da lógica crítica antes de tocar na interface?
- **Automação:** uma falha nos testes bloqueia deploy quebrado via CI/CD?

Frase final: desenvolvimento sênior não é apenas escrever código que funciona; é projetar sistemas que não quebram ao escalar.
