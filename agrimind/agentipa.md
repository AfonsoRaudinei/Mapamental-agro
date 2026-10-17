# AgriMind IPA Agent

## Propósito

Este arquivo governa a geração de IPA e guarda o histórico de cada release.

Regras centrais:

- Nunca gerar IPA sem embutir `SUPABASE_PUBLISHABLE_KEY` via `--dart-define`.
- Nunca commitar chaves, perfis de provisionamento ou credenciais privadas.
- Nunca gerar IPA com build number menor ou igual ao último registrado abaixo.
- Sempre atualizar este arquivo após cada IPA concluída com sucesso.
- Sempre registrar o que entrou no build (notas), não só o número.

## Fonte de verdade

- Versão e build number: `pubspec.yaml`
- Chaves de release: `docs/platform.md`
- Fluxo oficial de IPA: `.agents/release-mobile.md`
- Leitura obrigatória: `/Users/raudineisilvapereira/dev/Cultiva Mind/sup.rtf`

## Próximo build

O número válido é sempre `último build registrado + 1`.

Último registrado: **276** (2026-10-17) → próximo: **277**

Nunca reutilize um número anterior.

## Retenção de IPAs no disco

- Pastas oficiais: `ipa/` (raiz do repo) e `agrimind/build/ios/ipa/`.
- Em cada pasta deve existir **somente** `Agrimind_v<último build>.ipa` (ex.: `Agrimind_v154.ipa`).
- Não guardar `ExportOptions.plist` em `ipa/` — usar `agrimind/ios/ExportOptions.plist`.
- Releases antigas permanecem registradas **só** na tabela deste arquivo (não manter `.ipa` velhos no Mac).

## Política de build

Antes de cada IPA:

1. Confirmar `version` em `pubspec.yaml` igual ao próximo build.
2. Validar `flutter analyze` (sem issues).
3. Validar `flutter test` (100% verde).
4. Confirmar `SUPABASE_PUBLISHABLE_KEY` no comando de build (lida de `sup.rtf`).
5. Confirmar que o novo build number é maior que o último registrado aqui.

Se qualquer uma dessas condições falhar, a IPA não deve ser gerada.

## Protocolo do agente (obrigatório)

Quando a usuária pedir IPA ou entrega de release:

1. **Executar no terminal** — não apenas documentar:
   ```bash
   cd agrimind && sh tool/build_ipa.sh
   ```
   Se o script não ler a chave sozinho, passar `SUPABASE_PUBLISHABLE_KEY` da chave publicável em `sup.rtf` e usar `ios/ExportOptions.plist`.
2. **Nunca** usar placeholder (`<sua chave do sup.rtf>`) em `SUPABASE_PUBLISHABLE_KEY`.
3. **Entregar artefatos** — confirmar:
   - `agrimind/build/ios/ipa/Agrimind_vBUILD.ipa`
   - `ipa/Agrimind_vBUILD.ipa`
   - **Retenção:** manter **apenas** o IPA do build atual nessas pastas (histórico fica na tabela abaixo, não em arquivos antigos). O `tool/build_ipa.sh` remove `Agrimind_v*.ipa` anteriores automaticamente.
4. **Registrar** — nova linha na tabela com data, build, caminho, commit e notas do que foi entregue.
5. **Upload** — só com pedido explícito (Transporter / App Store Connect).
6. **Commit/push/main** — só com pedido explícito da usuária.

Se o archive falhar com `No Accounts` ou perfil sem certificado:

```bash
cd agrimind && sh tool/fix_ios_signing.sh
```

Depois de ajustar conta/assinatura no Xcode, rodar o build de novo.

### Erro `Failed host lookup: pub.dev`

Não é Supabase nem Postgres. O Mac não resolveu `pub.dev` (rede/DNS). Corrija Wi‑Fi/VPN/DNS e rode `flutter pub get`.

## Migrações Drift — erros reais no TestFlight (não repetir)

Antes de **cada IPA**, revisar `app_database.dart` `onUpgrade` e garantir as regras abaixo. Testes em `test/core/database/*migration*`.

### 1. `Could not find a matching SQL type for Object?`

| Campo | Valor |
|-------|--------|
| **Onde** | Startup (`DatabaseService.initialize` → `onUpgrade` v19) |
| **Builds afetados** | 158 (e anteriores com v19) |
| **Causa** | `QueryRow.read<Object?>('plantio_definido')` em `talhoes_safra_v19_migration.dart` — Drift não mapeia `Object?` |
| **Correção** | Usar `readNullable<int>`, `read<bool>`, etc. Nunca `read<Object?>` em `customSelect` |
| **IPA que corrigiu** | 159 |

### 2. `SqliteException(1): duplicate column name: tipo_operacional`

| Campo | Valor |
|-------|--------|
| **Onde** | Startup, bloco `from < 18` |
| **Builds afetados** | 159 (usuários com coluna já criada e `user_version` ainda &lt; 18, ex. crash no meio da migração) |
| **Causa** | `migrator.addColumn` em `estadios` sem checar `PRAGMA table_info` |
| **Correção** | `addEstadiosColumnIfMissing` (`estadios_table_migration.dart`) para `tipo_operacional` e `operacional_config` |
| **IPA que corrigiu** | 160 |

### 3. `duplicate column` em outras tabelas (padrão v157)

| Campo | Valor |
|-------|--------|
| **Exemplo histórico** | `dae_maturacao_ciclo` em `cronogramas_soja_talhao` (v12→v13) |
| **Correção** | `addCronogramaSojaColumnIfMissing` — espelhar para qualquer `addColumn` em upgrade longo |

### Checklist obrigatório antes de IPA (migrações)

1. Todo `migrator.addColumn` em `onUpgrade` deve ser **idempotente** (`PRAGMA table_info` ou helper `*ColumnIfMissing`).
2. Todo `migrator.createTable` em upgrade deve checar `sqlite_master` se a tabela pode já existir com schema atual (ex. v19 `talhoes_safra`).
3. Em migrações com `customSelect`, **proibir** `read<Object?>` — tipos Drift: `int`, `String`, `bool`, `DateTime`, `double`.
4. Rodar `flutter test test/core/database/` após mudar `schemaVersion` ou qualquer `*_migration.dart`.
5. Smoke mental: usuário em `user_version` antigo (ex. 17) abrindo app com `schemaVersion` atual (21) num único `onUpgrade`.

Helpers no código:

- `cronograma_soja_table_migration.dart` — `cronogramas_soja_talhao`
- `talhoes_safra_table_migration.dart` — `talhoes_safra` / v21 `programa_operacional_ids`
- `estadios_table_migration.dart` — `estadios` / v18 operacional

## Qualidade do artefato

Antes de marcar a IPA como concluída:

- Analyze e testes verdes no código que entra no build.
- Excel/PDF/HTML gerados no app devem abrir no Mac sem diálogo de reparo.
- Planilha: só abas úteis, sem Sheet1 vazia, sem dados de rascunho/status.
- Bundle version no archive igual ao build registrado.

## Registro de releases

Atualize esta seção após cada IPA bem-sucedida.

| Data | Build | IPA | Commit | Status | Notas |
|------|-------|-----|--------|--------|-------|
| 2026-10-17 | 276 | `build/ios/ipa/Agrimind_v276.ipa` | `8990d63`* | concluída | Nuvem: stepper acompanha scroll + toque no nó rola até a etapa; talhão mostra claramente posição na safra; tiles de etapa e tabela refinados; 157 testes |
| 2026-10-17 | 275 | `build/ios/ipa/Agrimind_v275.ipa` | `e32773b`* | concluída | Nuvem: `TalhaoTimelineStepper` (fases fixas na ficha do talhão); auditoria (picker plantio, anti-flicker, `talhaoRef`, rótulo sem plano); refinamentos `EtapaTalhao`/`ProductTile`; 154 testes |
| 2026-10-16 | 274 | `build/ios/ipa/Agrimind_v274.ipa` | `c6c55ed`* | concluída | Nuvem: cronograma em sanfona (blocos); produtos do plano por etapa na ficha do talhão (`EtapaTalhao` + `ProductTile`); fungicida título “N Fungicida” e limpeza dessecação; remoção `features/plan` legado; 151 testes |
| 2026-10-07 | 272 | `build/ios/ipa/Agrimind_v272.ipa` | `1a93340`* | concluída | Fungicida: 1ª/2ª aplicação no próprio card (sem sub-card OP); migração ao abrir plano; cronograma plano ativo = grupos + plantio na ficha do talhão; testes widget cronograma; 148 testes |
| 2026-10-07 | 271 | `build/ios/ipa/Agrimind_v271.ipa` | *(working tree)* | concluída | Card OP: dropdown só dessecação pré-plantio + adubação (sem plantio no plano); estádio fenológico: dropdown aplicações + aplicação extra; sheet Adicionar unificado; 144 testes |
| 2026-10-07 | 161 | `build/ios/ipa/Agrimind_v161.ipa` | *(working tree)* | concluída | Cronograma só módulo Clientes (sem rota/card em Planos); operacional: tipo via dropdown no título do card (sem action sheet); 144 testes |
| 2026-10-06 | 160 | `build/ios/ipa/Agrimind_v160.ipa` | `8a24f84`* | concluída | Hotfix v18 `tipo_operacional`/`operacional_config` idempotente; v19 `createTable` só se ausente; seção migrações Drift em `agentipa.md`; 144 testes |
| 2026-10-05 | 159 | `build/ios/ipa/Agrimind_v159.ipa` | `8a24f84`* | concluída | Hotfix startup TestFlight: migration v19 sem `read<Object?>` em `plantio_definido`; `addColumn` idempotente `programa_operacional_ids` (v21); 143 testes |
| 2026-10-05 | 158 | `build/ios/ipa/Agrimind_v158.ipa` | `8a24f84` | concluída (rebuild) | Plano=template / talhão=instância / cronograma=carimbo; `programa_operacional_ids` Drift v21; modo avulso explícito sem plano; selo visual instância no canvas; migration v20 instância roteiro; 142 testes |
| 2026-10-05 | 157 | `build/ios/ipa/Agrimind_v157.ipa` | `8a24f84` | concluída | Hotfix migration Drift: `addColumn` idempotente em `cronogramas_soja_talhao` (evita duplicate `dae_maturacao_ciclo` ao subir v12→v13); 128 testes |
| 2026-10-05 | 155 | `build/ios/ipa/Agrimind_v155.ipa` | `8a24f84` | concluída | Operacional por talhão: cronograma soja (pré-plantio, plantio, pós-emergente, pré-colheita, fungicidas recorrentes) sync canvas + ProgramaOperacional; DAE maturação do catálogo Semente (editável); Drift v15; 128 testes |
| 2026-10-04 | 154 | `build/ios/ipa/Agrimind_v154.ipa` | `8a24f84` | concluída | Card Sementes = AccordionStageCard (badge SEM, layout V5); removido botão X (só swipe + confirmação); expandido sem resumo duplicado (hideSubtitleWhenExpanded); analyze + 117 testes |
| 2026-10-04 | 153 | `build/ios/ipa/Agrimind_v153.ipa` | `8a24f84` | concluída | Sementes: dose por ha (sem/ha) no Excel; removido total de sementes (UI + export); embalagens mantidas; canvas plano (hierarquia, card único sementes, Excel audit); analyze + 117 testes |
| 2026-10-04 | 152 | `build/ios/ipa/Agrimind_v152.ipa` | `8a24f84` | concluída | Refs: scroll acima da tab, Circular com contraste AA (chips/texto/tiles), hub títulos primários; ideologia canônica `Instrucao/ideologia.md` (Simples. Poderoso. Teu.); analyze limpo |
| 2026-10-04 | 151 | `build/ios/ipa/Agrimind_v151.ipa` | `8a24f84` | concluída | Ícone do app (`assets/icon.png` → launcher iOS/Android); livros ref (cinza/dourado) ao lado do badge V5 no header do estádio (visível fechado); produto sem sheet “Onde aplicar?” + exclusão de talhões no painel |
| 2026-10-04 | 150 | `build/ios/ipa/Agrimind_v150.ipa` | `8a24f84` | concluída | Card Sementes: resumo fechado (cultivar · total sementes · embalagens); sanfona/chevron; teclado dismiss; adicionar outra semente; retenção IPA única |
| 2026-10-04 | 149 | `build/ios/ipa/Agrimind_v149.ipa` | `8a24f84` | concluída | Plano Soja: menu Adicionar (Estádio/Operacional/Sementes); Sementes na lista única com calculadora; removida seção SEMENTES fixa e card Cultivar; Drift v11 |
| 2026-09-30 | 148 | `build/ios/ipa/Agrimind_v148.ipa` | `8a24f84` | concluída | Plano: confirmação em remoções; canvas sem rodapé consultor; estádio com swipe + confirmação e resumo fechado (produto · dose); cards de estágio/alocação e seção Sementes (v10); regulagem agentes |
| 2026-09-30 | 147 | `build/ios/ipa/Agrimind_v147.ipa` | `e9abcb3` | concluída | Catálogo: culturas por produto; linha Nortox Proteção (74) + Nutrição 2025/26 (48); múltiplos ingredientes ativos; categorias Micros sólidos e Adjuvante TA |
| 2026-09-29 | 146 | `build/ios/ipa/Agrimind_v146.ipa` | `e9abcb3` | concluída | Excel visual compacto (2 colunas); só Aplicações + Resumo; sem Sheet1/Status; estilos válidos no Mac |
| 2026-09-29 | 145 | `build/ios/ipa/Agrimind_v145.ipa` | `e9abcb3` | concluída | Excel por estádio; cabeçalho de identificação; locale pt_BR |
| 2026-07-23 | 143 | `build/ios/ipa/Agrimind_v143.ipa` | `7278a8e` | concluída | — |
| 2026-07-20 | 142 | `build/ios/ipa/Agrimind_v142.ipa` | `55ea9c5` | concluída | — |
| 2026-07-13 | 141 | `build/ios/ipa/Agrimind_v141.ipa` | `9996317` | concluída | — |

## Checklist obrigatório pós-IPA

Marque só depois do build **160** terminar com sucesso.

- [x] `flutter analyze` aprovado (apenas `info`, sem erros)
- [x] `flutter test` aprovado (144 testes)
- [x] checklist de migrações Drift (seção acima) revisado
- [x] `SUPABASE_PUBLISHABLE_KEY` embutida no build
- [x] build number **160** confirmado no archive (`pubspec.yaml` `1.0.0+160`)
- [x] IPA gerada e copiada para `build/ios/ipa/` e `ipa/`
- [x] este arquivo atualizado com notas do hotfix
