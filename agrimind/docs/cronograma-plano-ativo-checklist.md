# Cronograma + plano ativo — checklist de conclusão

Escopo: **Clientes** com fazenda vinculada a plano ativo. Modo avulso (sem plano) permanece como calculadora.

## Produto / UX

- [x] Cronograma agrícola só em **Clientes** (sem rota/UI duplicada em Planos)
- [x] Com plano ativo: tela de cronograma usa **grupos** (accordion), não lista “um accordion por talhão”
- [x] **Multi-talhão no grupo** via seletor de talhões (mesmo conjunto de parâmetros fenológicos)
- [x] **Plantio** fora da regulagem em grupo — na **ficha do talhão** (toque no talhão na fazenda)
- [x] Texto de orientação na regulagem: plantio na ficha da fazenda
- [x] **Aplicar datas ao plano** só considera talhões com `plantioDefinido`
- [x] Cards do **canvas (Planos)** mantêm escolha de talhões para aplicação (comportamento atual)

## Fungicida no canvas (roteiro-mãe)

- [x] Sem sub-card OP extra ao escolher fungicida (recorrente)
- [x] Card vira **1ª / 2ª aplicação…** no próprio estádio (ordem no plano)
- [x] Migração ao abrir o plano: remove sub-cards legados e renumera
- [x] Instâncias por talhão (Clientes) alinhadas ao modelo sem sub-cards no template

## Sincronização técnica

- [ ] Persistência modo avulso sem `planoId` (hoje exige plano no Drift; avulso em memória/sessão — avaliar se necessário)
- [x] Sync grupo/ficha com plano: instanciar roteiro + `SincronizarTalhaoSafraPlanoUseCase`
- [x] Testes de widget: fluxo plano ativo (`test/features/clients/cronograma_plano_ativo_flow_test.dart`)
- [ ] Validar em dispositivo: 2 talhões, 1 grupo, plantio só em 1 → sync parcial

## Modo avulso (sem plano)

- [x] Banner e título “Cronograma avulso”
- [x] Plantio **dentro** do grupo (comportamento anterior preservado)
- [x] Sem sync automática para plano inexistente

## Documentação / release

- [x] `agent.md` aponta este checklist
- [ ] IPA / TestFlight (somente quando você pedir build)

## Como validar manualmente (5 min)

1. Fazenda com **plano ativo** → **Cronograma Agrícola** → accordion **Grupo**, talhões marcados, **sem** campo de data de plantio no grupo.
2. Voltar à fazenda → tocar **talhão** → definir **data de plantio** → **Aplicar datas ao plano**.
3. **Planos** → escolher fungicida em V7 → só **1ª aplicação** (badge V7), sem card OP duplicado.
4. Fazenda **sem** plano → cronograma avulso com plantio no grupo (como antes).
