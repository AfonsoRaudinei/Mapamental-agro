# 🌱 AgriMind — PARTE 05
## Auth · Clientes · Catálogo · Configurações

---

## 🔐 Feature: Auth

### Fluxo completo

```
App start
  └── SplashPage (2s — verifica sessão Firebase)
        ├── sessão ativa → /plans (home)
        └── sem sessão → OnboardingPage
                            └── LoginPage
                                  ├── Login com email/senha → /plans
                                  ├── Apple Sign-In → /plans
                                  ├── Google Sign-In → /plans
                                  ├── [Criar conta] → RegisterPage → /plans
                                  └── [Esqueci senha] → RecoverPasswordPage
```

### Telas

#### SplashPage
```
- Logo animado (flutter_animate: fadeIn + scale)
- Verificação Firebase Auth (currentUser)
- Redirect automático após 2s
- Sem botões — fully automatic
```

#### OnboardingPage
```
- PageView com 3 slides
- Slide 1: "Seu planejamento de campo em um só lugar"
- Slide 2: "Estádios fenológicos com referência técnica"
- Slide 3: "Consolide e exporte o pedido em segundos"
- Indicadores de página (dots)
- Botão "Começar" no último slide → LoginPage
- Botão "Pular" (ghost) em todos → LoginPage
```

#### LoginPage
```
Campos:
  - E-mail (keyboard: emailAddress, autocorrect: off)
  - Senha (obscureText, toggle eye icon)

Ações:
  - [Entrar] → primário
  - [Esqueci minha senha] → ghost → RecoverPasswordPage
  - Divider "ou"
  - [🍎 Continuar com Apple] → Apple Sign-In
  - [G  Continuar com Google] → Google Sign-In
  - [Criar conta] → RegisterPage

Estados:
  - idle / loading (disable campos + spinner no botão)
  - error (shake animation + mensagem embaixo do campo)
```

#### RegisterPage
```
Campos:
  - Nome completo (obrigatório)
  - E-mail (obrigatório)
  - Telefone (opcional, máscara: (00) 00000-0000)
  - Empresa (opcional)
  - Senha (mínimo 8 chars)
  - Confirmar senha

Validações inline (ao sair do campo):
  - email: formato válido
  - senha: mínimo 8, ao menos 1 número
  - confirmação: igual à senha

Sucesso → cria conta Firebase → /plans
```

#### RecoverPasswordPage
```
Campo: E-mail
Ação: [Enviar link de recuperação]
Sucesso: banner "Link enviado para seu e-mail" + voltar ao login
```

---

## 👥 Feature: Clients (Clientes + Fazendas + Talhões)

### ClientsListPage

```
┌─────────────────────────────────┐
│ Clientes                [+]     │
│ 🔍 [Buscar cliente...]          │
│ ─────────────────────────────  │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ J  João Silva               │ │
│ │    2 fazendas · Soja        │ │
│ │                      [›]    │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ M  Maria Souza              │ │
│ │    1 fazenda · Milho        │ │
│ │                      [›]    │ │
│ └─────────────────────────────┘ │
└─────────────────────────────────┘
  ↑ FAB [+] abre ClientFormPage
  ↑ Swipe left → [Editar] [Excluir]
  ↑ Avatar = inicial do nome com cor gerada
```

### ClientDetailPage

```
┌─────────────────────────────────┐
│ ← João Silva            [✏️]    │
│ ─────────────────────────────  │
│ 📱 (11) 99999-9999              │
│ 📧 joao@email.com               │
│ 🏙 Sorriso, MT                  │
│ ─────────────────────────────  │
│ FAZENDAS                  [+]   │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 🌾 Fazenda Boa Vista        │ │
│ │    80 ha · Soja · 2025/26   │ │
│ │    3 talhões                │ │
│ │                     [›]     │ │
│ └─────────────────────────────┘ │
└─────────────────────────────────┘
```

### ClientFormPage / FarmFormPage

```
Formulário compacto com dropdowns:
  - Cultura: [Soja ▼] (dropdown)
  - UF: [MT ▼] (dropdown, 27 estados)
  - Área (ha): campo numérico, máx 7 dígitos

Talhões na FarmFormPage:
  - Lista de talhões com nome + área
  - [+ Adicionar talhão] → inline form simples
  - Swipe para remover
```

---

## 📦 Feature: Catalog (Banco de Produtos)

### CatalogListPage

```
┌─────────────────────────────────┐
│ Catálogo                  [+]   │
│                                 │
│ [Todos ▼] [Fungicida] [Insetic] │
│  ← segmented control scroll →   │
│                                 │
│ 🔍 [Buscar produto...]          │
│                                 │
│ ● Fox Xpro           Fungicida  │
│   Trifloxistrobina + Protiocon. │
│   0,3–0,6 L/ha    R$ 45,00/L   │
│ ─────────────────────────────  │
│ ● Engeo Pleno        Inseticida │
│   Tiametoxam + Lambda-cialotrina│
│   100–200 mL/ha  R$ 38,00/L    │
│                                 │
└─────────────────────────────────┘
  ↑ Swipe left → [Editar] [Desativar]
  ↑ Produtos desativados ficam ocultos
    (toggle "Mostrar inativos" em Settings)
```

### ProdutoFormPage

```
Nome comercial (obrigatório)
Ingrediente ativo (opcional)
Categoria: [Fungicida ▼] (dropdown)
Unidade padrão: [L/ha ▼]
Dose mínima: [___] (opcional)
Dose máxima: [___] (opcional)
Preço unitário: R$ [___] (opcional)
Fabricante: (opcional)
Observações: (texto livre)
```

### ProdutoSearchDropdown (widget reutilizável)

```dart
// Usado em ProdutoPanel no canvas
// Busca em tempo real no Isar

class ProdutoSearchDropdown extends ConsumerStatefulWidget {
  final Function(ProdutoCatalogoEntity) onSelected;
  final String? categoriaFilter; // filtra automaticamente

  // Exibe: nome + categoria badge + dose padrão
  // "Fox Xpro  [Fungicida]  0,4 L/ha"
  // Último item: [+ Cadastrar "Nome digitado"]
  //   → abre ProdutoFormPage inline
}
```

---

## 📚 Feature: References

### ReferencesHomePage

```
┌─────────────────────────────────┐
│ Referências Técnicas            │
│                                 │
│ ┌──────────┐ ┌──────────┐       │
│ │ 🔴       │ │ 🔵       │       │
│ │ Doenças  │ │ Insetos  │       │
│ └──────────┘ └──────────┘       │
│ ┌──────────┐ ┌──────────┐       │
│ │ 🟣       │ │ 🟢       │       │
│ │ Nutrição │ │Fisiologia│       │
│ └──────────┘ └──────────┘       │
│ ┌──────────────────────────┐    │
│ │ 🏆  Campeões CESB        │    │
│ │     Correlação por estádio│   │
│ └──────────────────────────┘    │
└─────────────────────────────────┘
```

### CategoriaDetailPage

```
← Doenças

── Estádios ─────────────────────
[VE] [VC] [V1] [V2] [V3] ... [R8]
 ↑ scroll horizontal, ativo selecionado

── R1 ───────────────────────────
● Ferrugem Asiática (Phakopsora)
● Oídio
● Antracnose (Colletotrichum)

── R2 ───────────────────────────
● Ferrugem Asiática
● Antracnose
● Esclerotinia
```

### CesbDetailPage

```
← Campeões CESB

── Pré-plantio / VE ─────────────
🏆 Construção de Perfil e Arranque

Práticas dos campeões:
• Correção profunda de solo
• Adubação de sistema
• Bioestimulantes no tratamento
  de sementes (Auxina/Citocinina/
  Giberelina)
• Inoculação robusta
  (Bradyrhizobium + Azospirillum)

── V3 - V6 ──────────────────────
🏆 Estruturação e Ramificação
...

── Destaque Safra 2024/25 ───────
🥇 Agro Mallon — 135,49 sc/ha
   "Nutrologia vegetal conforme
    curva de absorção"
```

---

## ⚙️ Feature: Settings (Configurações)

### SettingsPage — Estrutura completa

```
┌─────────────────────────────────┐
│ ← Configurações                 │
│                                 │
│ PERFIL                          │
│ ┌─────────────────────────────┐ │
│ │  [S]  Nome não definido     │ │
│ │       E-mail não definido   │ │
│ └─────────────────────────────┘ │
│ Telefone          Não informado │
│ Empresa           Não informada │
│ CRA/Registro      Não informado │
│                                 │
│ APARÊNCIA                       │
│ Modo escuro              [  ●] │
│                                 │
│ Ícone do aplicativo             │
│ [✓ Principal] [🌿 Clássico]     │
│                                 │
│ DADOS                           │
│ Exportar dados                  │
│ Importar backup                 │
│ Sincronização cloud      [●  ] │
│ Última sync: hoje 14:32         │
│                                 │
│ SUPORTE                         │
│ Termos de uso              [›]  │
│ Política de privacidade    [›]  │
│ Enviar feedback            [›]  │
│ Avaliar o app              [›]  │
│ Versão 1.0.0 (build 1)          │
│                                 │
│ CONTA                           │
│ Sair do aplicativo              │
│ Excluir conta        [vermelho] │
└─────────────────────────────────┘
```

### Tiles reutilizáveis

```dart
// SettingsTile — linha simples clicável
SettingsTile(
  leading: PhosphorIcon(PhosphorIconsRegular.user),
  title: 'Telefone',
  subtitle: usuario.telefone ?? 'Não informado',
  onTap: () => context.push('/settings/profile'),
)

// SettingsToggle — linha com switch
SettingsToggle(
  title: 'Modo escuro',
  value: ref.watch(darkModeProvider),
  onChanged: (v) => ref.read(darkModeProvider.notifier).toggle(),
)

// SettingsSection — grupo com header
SettingsSection(
  title: 'APARÊNCIA',
  children: [...],
)
```

### ProfileEditPage

```
Nome completo *
[João da Silva           ]

Telefone
[(11) 99999-9999         ]

Empresa
[Agro Consulting         ]

CRA / Registro Técnico
[CREA-MT 000000          ]

[Salvar alterações]
```

---

*Próxima parte → PARTE 06: Consolidação · Exportação PDF/Excel/HTML Dinâmico*
