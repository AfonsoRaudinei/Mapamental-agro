# AgriMind — Listagem nas lojas (PT-BR)

Fonte de IDs: [`platform.md`](platform.md) · Legal: [`legal/README.md`](legal/README.md)

**Posicionamento:** Simples. Poderoso. Teu. · iOS-first · consultores e técnicos agronômicos.

---

## Pré-requisitos (ambas as lojas)

- [ ] URLs legais no ar: `https://cultivamind.com/privacidade` e `/termos`
- [ ] Smoke test manual concluído (`.agents/qa-mobile.md`)
- [ ] `flutter analyze` / `flutter test` verdes
- [ ] Conta de suporte ativa: `suporte@cultivamind.com`
- [ ] Screenshots capturados (roteiro abaixo)

---

## App Store Connect (iOS)

### Metadados principais

| Campo | Valor |
|-------|-------|
| **Nome** | AgriMind |
| **Subtítulo** (30) | Planejamento por estádio |
| **Bundle ID** | `com.cultivamind.agrimind` |
| **SKU** | `agrimind-ios` (sugestão) |
| **Idioma primário** | Português (Brasil) |
| **Categoria primária** | Negócios |
| **Categoria secundária** | Produtividade |
| **URL de suporte** | `mailto:suporte@cultivamind.com` ou página de suporte no site |
| **URL de marketing** | `https://cultivamind.com` |
| **Política de privacidade** | `https://cultivamind.com/privacidade` |
| **Classificação etária** | 4+ (ver questionário abaixo) |
| **Direitos de exportação** | Usa criptografia padrão — `ITSAppUsesNonExemptEncryption = false` |

### Texto promocional (170 caracteres)

```
Planeje aplicações por estádio fenológico, consolide custos e exporte relatórios. Offline-first, feito para o consultor no campo.
```

### Descrição (App Store)

```
AgriMind é o mapa mental agronômico para consultores e técnicos que precisam transformar planejamento em ação — estádio por estádio.

Simples. Poderoso. Teu.

PLANEJE NO CAMPO
• Crie planos por cultura e safra com canvas fenológico visual
• Adicione produtos por estádio (dose, área, preço)
• Consulte referências técnicas integradas (doenças, insetos, nutrição, CESB)

ORGANIZE SEU TRABALHO
• Cadastre clientes, fazendas e talhões
• Mantenha catálogo de produtos com busca rápida
• Trabalhe offline: seus dados ficam no aparelho

CONSOLIDE E COMPARTILHE
• Consolidação de investimento por hectare e sacas
• Exportação HTML do mapa fenológico
• Backup JSON dos dados locais

CONTA E PRIVACIDADE
• Login com e-mail, Apple ou Google
• Exclusão de conta em Configurações
• Política de privacidade e termos dentro do app

AgriMind é ferramenta de apoio ao planejamento. Decisões técnicas permanecem sob responsabilidade do profissional.

Suporte: suporte@cultivamind.com
```

### Palavras-chave (100 caracteres, separadas por vírgula)

```
agronomia,soja,planejamento,fenologia,consultor,defensivos,fazenda,catálogo,offline,relatório
```

### O que há de novo (1.0.0)

```
Lançamento inicial do AgriMind: planejamento por estádio fenológico, clientes, catálogo, referências técnicas, consolidação e exportação — com trabalho offline e conta segura.
```

### Screenshots iOS (obrigatório)

Capturar em **iPhone 6,7"** (1290 × 2796 px) — simulador iPhone 17 Pro Max ou frame equivalente.

| # | Tela | Legenda sugerida (overlay opcional) |
|---|------|-------------------------------------|
| 1 | Login ou lista de planos | Planejamento agronômico por estádio |
| 2 | Canvas fenológico com produtos | Monte o plano visualmente |
| 3 | Painel de produto / bottom sheet | Dose, área e preço em segundos |
| 4 | Consolidação / custos | Consolide investimento por hectare |
| 5 | Clientes + fazenda | Clientes, fazendas e talhões |
| 6 | Catálogo de produtos | Catálogo sempre à mão |
| 7 | Referências (CESB ou categoria) | Referências técnicas por estádio |
| 8 | Configurações (modo escuro opcional) | Simples. Poderoso. Teu. |

**Dica:** use modo claro nos 4 primeiros e um frame escuro no último para mostrar dark mode.

Comando para captura no simulador:

```bash
xcrun simctl io booted screenshot ~/Desktop/agrimind-01-plans.png
```

### Classificação etária (Apple — questionário)

Respostas esperadas para **4+**:

| Tópico | Resposta |
|--------|----------|
| Cartoon / violência / sexual / drogas / jogos de azar | Nenhum |
| Conteúdo gerado pelo usuário | Não (dados profissionais privados, sem feed público) |
| Acesso web irrestrito | Não (apenas links legais/suporte iniciados pelo usuário) |
| Made for Kids | Não |

### Privacidade do app (App Store Connect)

Alinhar com `PrivacyInfo.xcprivacy` e [`legal/privacidade.html`](legal/privacidade.html):

| Tipo de dado | Coletado | Vinculado ao usuário | Rastreamento | Finalidade |
|--------------|----------|----------------------|--------------|------------|
| E-mail | Sim | Sim | Não | Funcionalidade do app |
| Nome | Sim | Sim | Não | Funcionalidade do app |
| Identificadores (ID conta) | Sim | Sim | Não | Funcionalidade do app |
| Fotos (opcional, estádios) | Sim | Sim | Não | Funcionalidade do app |
| Dados de contato do cliente (CPF/CNPJ, tel.) | Sim | Sim | Não | Funcionalidade do app |
| Outros dados do usuário (planos, produtos) | Sim | Sim | Não | Funcionalidade do app |

- **Rastreamento:** Não
- **Coleta opcional:** Fotos da galeria/câmera (image_picker)
- **Exclusão:** Sim — Configurações > Excluir conta

---

## Google Play Console (Android)

### Metadados principais

| Campo | Valor |
|-------|-------|
| **Título** (30) | AgriMind |
| **Descrição curta** (80) | Planejamento agronômico por estádio fenológico. Offline-first. |
| **Package** | `com.cultivamind.agrimind` |
| **Categoria** | Negócios |
| **Tags** | Agronomia, Produtividade, Planejamento |
| **E-mail de contato** | suporte@cultivamind.com |
| **Política de privacidade** | `https://cultivamind.com/privacidade` |

### Descrição completa

(Reutilizar a descrição da App Store acima — Play aceita texto longo equivalente.)

### Feature graphic

- **Tamanho:** 1024 × 500 px
- **Conteúdo:** logo AgriMind + tagline “Simples. Poderoso. Teu.” + ícone folha / canvas fenológico estilizado
- Fundo claro ou preto (`backgroundDark`), sem texto ilegível em miniatura

### Screenshots Android

Mínimo **2**, recomendado **8** — telas 1080 × 1920 ou superior (mesmo roteiro iOS).

Dispositivo de referência: Pixel / API 36 emulator.

### Classificação de conteúdo (IARC)

| Pergunta | Resposta |
|----------|----------|
| Violência, sexualidade, linguagem, substâncias | Não |
| Compartilhamento de localização | Não |
| Compras digitais | Não |
| Interação entre usuários | Não |
| Dados pessoais sensíveis | Dados profissionais inseridos pelo usuário (não sensíveis IARC) |

Resultado esperado: **Livre** / Everyone / PEGI 3 equivalente.

### Formulário Data Safety

| Declaração | Valor |
|------------|-------|
| Coleta de dados | Sim |
| Compartilha com terceiros | Sim — **apenas** Supabase (autenticação), processador |
| Criptografia em trânsito | Sim (HTTPS) |
| Usuário pode solicitar exclusão | Sim (in-app) |
| Dados vendidos | Não |
| Rastreamento / ads | Não |

**Tipos de dados (detalhe):**

| Categoria Play | Campos | Obrigatório | Finalidade |
|----------------|--------|-------------|------------|
| Informações pessoais | Nome, e-mail | Sim (conta) | Funcionalidade |
| Informações pessoais | Outros (empresa, registro prof.) | Opcional | Funcionalidade |
| Fotos e vídeos | Fotos | Opcional | Funcionalidade |
| Arquivos e docs | Outros (backup JSON export) | Opcional | Funcionalidade do app / exportação iniciada pelo usuário |
| Identificadores | ID de usuário | Sim | Funcionalidade |
| App activity | Outros (planos criados) | Sim | Funcionalidade — armazenado localmente |

**Armazenamento:** dados operacionais primariamente **no dispositivo**; auth na nuvem (Supabase).

---

## Roteiro TestFlight → Produção (iOS-first)

Ver também [`.agents/release-mobile.md`](../.agents/release-mobile.md).

### Fase A — Build de release

```bash
cd agrimind
grep "^version" pubspec.yaml          # ex.: 1.0.0+129
flutter analyze && flutter test
SUPABASE_PUBLISHABLE_KEY=<chave> sh tool/build_ipa.sh
```

### Fase B — App Store Connect (primeira vez)

1. **Apps** → **+** → New App → iOS → AgriMind · `com.cultivamind.agrimind`
2. Preencher metadados deste documento (PT-BR)
3. Upload screenshots + ícone 1024 (já em `Assets.xcassets`)
4. **App Privacy** + **Age Rating** conforme tabelas acima
5. **Pricing:** Free (ou preço desejado)

### Fase C — TestFlight interno

1. Upload IPA via **Transporter** ou Xcode Organizer
2. Aguardar processamento (~5–30 min)
3. **TestFlight → Internal Testing** → adicionar equipe (até 100)
4. Validar checklist `.agents/qa-mobile.md` em device real
5. Corrigir bugs → incrementar build (`+130`) → novo upload

### Fase D — TestFlight beta externa

1. **External Testing** → criar grupo “Beta Consultores”
2. Preencher **What to Test** (PT-BR):

```
Teste criação de plano, adição de produtos no canvas, consolidação, exportação HTML, login Apple/Google e exclusão de conta. Reporte bugs para suporte@cultivamind.com com versão exibida em Configurações > Sobre.
```

3. **Beta App Review** (1ª vez externa) — usa mesma privacidade/idade
4. Convidar consultores via link público ou e-mail
5. Mínimo **1–2 semanas** de beta estável antes de produção

### Fase E — Submissão App Review (produção)

Checklist final:

- [ ] URLs legais respondendo HTTP 200
- [ ] Conta demo para revisor (e-mail/senha **ou** instruções Apple Sign-In)
- [ ] Notas para revisor:

```
AgriMind exige login. Conta de teste:
E-mail: <demo@...>
Senha: <senha>

Fluxo: login → Planos → criar plano → canvas → Configurações.
Exclusão de conta: Configurações > Conta > Excluir conta.
Sign in with Apple e Google disponíveis na tela de login.
```

- [ ] **Submit for Review** → Release manual ou phased (recomendado phased 7 dias)

### Fase F — Android (após iOS estável)

1. `sh tool/create_android_keystore.sh` (se ainda não feito)
2. `flutter build appbundle --release --dart-define=SUPABASE_PUBLISHABLE_KEY=<chave>`
3. Play Console → **Produção** → upload AAB
4. Reutilizar textos e screenshots deste doc
5. Data Safety + classificação IARC
6. **Internal testing** → **Closed testing** → **Production** (staged rollout 10% → 100%)

---

## Conta demo para revisores (criar antes da submissão)

| Campo | Valor sugerido |
|-------|----------------|
| E-mail | `review+cultivamind@...` (alias seu domínio) |
| Senha | forte, rotacionável |
| Dados | 1 cliente, 1 plano soja com 2 estádios preenchidos |

Documentar apenas nas **Notas do revisor** — nunca commitar no repositório.

---

## Checklist final Fase 3

| Item | App Store | Play Console |
|------|-----------|--------------|
| Nome + descrição PT-BR | ☐ | ☐ |
| Screenshots (8 telas) | ☐ | ☐ |
| Feature graphic | N/A | ☐ |
| Classificação etária | ☐ | ☐ |
| Privacidade / Data Safety | ☐ | ☐ |
| URL privacidade live | ☐ | ☐ |
| Conta demo revisor | ☐ | ☐ |
| TestFlight interno | ☐ | — |
| TestFlight externo | ☐ | — |
| Produção iOS | ☐ | — |
| Produção Android | — | ☐ |
