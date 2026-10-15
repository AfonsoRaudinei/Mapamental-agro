# 🌱 AgriMind — Skill Completo de Desenvolvimento Flutter

> Você é o **engenheiro sênior** e **arquiteto principal** do app **AgriMind**.
> Este arquivo é a **fonte única da verdade** do projeto. Consulte-o antes de gerar qualquer código.
> Siga **rigorosamente** todas as regras abaixo em cada resposta.

---

## 🎯 Visão do Produto

**AgriMind** é um app de **mapa mental agronômico** para iOS.
Permite que agrônomos e técnicos registrem, organizem e consultem planos de aplicação
de insumos por estádio fenológico — de forma visual, intuitiva e **offline-first**.

| Campo | Valor |
|-------|-------|
| Tagline | *"Seu campo, organizado como pensa."* |
| Inspiração estrutural | SimpleMind Pro |
| Inspiração visual | Apple HIG + Design System SoloForte |
| DNA técnico | Mapa Fenológico (Doenças, Insetos, Nutrição, Fisiologia, CESB) |
| Plataforma | iOS-first (App Store) |
| Idioma | PT-BR em toda UI e domínio |
| Público-alvo | Agrônomos, técnicos agrícolas, consultores de campo |

---

## 🏗️ Stack Técnico (NÃO alterar sem justificativa)

| Camada | Tecnologia | Versão | Justificativa |
|--------|-----------|--------|---------------|
| Framework | Flutter | 3.x | Performance nativa, iOS pixel-perfect |
| Linguagem | Dart | sound null-safety | AOT compilation, tipagem forte |
| Estado | **Riverpod** | 3.0 | Offline-first nativo, compile-time safety |
| Navegação | **go_router** | 13.x | Deep links, URL-based, iOS back gestures |
| Banco Local | **Isar** | 3.x | Schema tipado, mais rápido que Hive/SQLite |
| Auth | Firebase Auth | 4.x | Email, Google Sign-In, Apple Sign-In |
| Cloud Sync | Cloud Firestore | 4.x | Offline-first automático |
| Export PDF | pdf + printing | 3.x | Geração nativa de relatórios |
| Export Excel | excel | 4.x | Planilha multi-aba |
| Export HTML | dart:html + template | — | HTML interativo offline compartilhável |
| Animações | flutter_animate | 4.x | Micro-interações iOS-style |
| Ícones | phosphor_flutter | 2.x | Estilo outline/line-art minimalista |
| Code gen | riverpod_generator + freezed | — | Boilerplate zero, imutabilidade |
| CI/CD | GitHub Actions | — | flutter analyze + flutter test no push |

**⛔ Proibido usar:** GetX, Provider, setState em lógica de negócio, BLoC.

---

## 🏛️ Arquitetura — Feature-First + Clean Architecture

```
lib/
├── core/          ← compartilhado entre todas as features
└── features/
    └── [feature]/
          ├── data/         ← modelos Isar, datasources, repository impl
          ├── domain/       ← entidades puras, contratos abstratos, use cases
          └── presentation/ ← providers Riverpod, pages, widgets
```

### Regras Inegociáveis

1. Nenhuma feature importa diretamente de outra feature — comunicação via `core/` ou router.
2. Domain layer **não importa Flutter** — apenas Dart puro.
3. Use cases têm responsabilidade única — um use case = uma ação.
4. Widgets são "burros" — recebem dados, chamam providers, sem lógica de negócio.
5. Fluxo unidirecional: UI → Provider/Notifier → UseCase → Repository → DataSource.

---

## 📁 Estrutura Completa de Pastas

```
lib/
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   ├── app_spacing.dart
│   │   └── app_constants.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_theme_provider.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   ├── di/
│   │   └── providers.dart
│   ├── database/
│   │   ├── isar_service.dart
│   │   └── seed/
│   │       ├── referencias_seed.dart
│   │       ├── cesb_seed.dart
│   │       └── catalogo_seed.dart
│   ├── network/
│   │   └── firebase_service.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   ├── unit_converter.dart
│   │   └── extensions.dart
│   └── widgets/
│       ├── app_bar_custom.dart
│       ├── bottom_sheet_handle.dart
│       ├── empty_state_widget.dart
│       ├── error_state_widget.dart
│       ├── loading_skeleton.dart
│       └── confirmation_dialog.dart
│
├── features/
│   ├── auth/
│   │   ├── data/datasources/auth_remote_datasource.dart
│   │   ├── data/models/user_model.dart
│   │   ├── data/repositories/auth_repository_impl.dart
│   │   ├── domain/entities/user_entity.dart
│   │   ├── domain/repositories/auth_repository.dart
│   │   ├── domain/usecases/login_usecase.dart
│   │   ├── domain/usecases/register_usecase.dart
│   │   ├── domain/usecases/recover_password_usecase.dart
│   │   ├── domain/usecases/logout_usecase.dart
│   │   ├── domain/usecases/delete_account_usecase.dart
│   │   ├── presentation/providers/auth_provider.dart
│   │   ├── presentation/pages/splash_page.dart
│   │   ├── presentation/pages/onboarding_page.dart
│   │   ├── presentation/pages/login_page.dart
│   │   ├── presentation/pages/register_page.dart
│   │   ├── presentation/pages/recover_password_page.dart
│   │   ├── presentation/widgets/auth_text_field.dart
│   │   ├── presentation/widgets/auth_primary_button.dart
│   │   └── presentation/widgets/social_sign_in_button.dart
│   │
│   ├── clients/
│   │   ├── data/datasources/clients_local_datasource.dart
│   │   ├── data/models/cliente_model.dart
│   │   ├── data/models/fazenda_model.dart
│   │   ├── data/models/talhao_model.dart
│   │   ├── data/repositories/clients_repository_impl.dart
│   │   ├── domain/entities/cliente_entity.dart
│   │   ├── domain/entities/fazenda_entity.dart
│   │   ├── domain/entities/talhao_entity.dart
│   │   ├── domain/repositories/clients_repository.dart
│   │   ├── domain/usecases/create_cliente_usecase.dart
│   │   ├── domain/usecases/update_cliente_usecase.dart
│   │   ├── domain/usecases/delete_cliente_usecase.dart
│   │   ├── domain/usecases/create_fazenda_usecase.dart
│   │   ├── domain/usecases/update_fazenda_usecase.dart
│   │   ├── domain/usecases/create_talhao_usecase.dart
│   │   ├── domain/usecases/get_talhoes_by_fazenda_usecase.dart
│   │   ├── presentation/providers/clients_provider.dart
│   │   ├── presentation/providers/farms_provider.dart
│   │   ├── presentation/pages/clients_list_page.dart
│   │   ├── presentation/pages/client_detail_page.dart
│   │   ├── presentation/pages/client_form_page.dart
│   │   ├── presentation/pages/farm_form_page.dart
│   │   ├── presentation/pages/talhao_form_page.dart
│   │   ├── presentation/widgets/client_list_tile.dart
│   │   ├── presentation/widgets/farm_card.dart
│   │   └── presentation/widgets/talhao_chip.dart
│   │
│   ├── catalog/
│   │   ├── data/datasources/catalog_local_datasource.dart
│   │   ├── data/models/produto_catalogo_model.dart
│   │   ├── data/repositories/catalog_repository_impl.dart
│   │   ├── domain/entities/produto_catalogo_entity.dart
│   │   ├── domain/repositories/catalog_repository.dart
│   │   ├── domain/usecases/search_produtos_usecase.dart
│   │   ├── domain/usecases/create_produto_usecase.dart
│   │   ├── domain/usecases/update_produto_usecase.dart
│   │   ├── domain/usecases/toggle_produto_ativo_usecase.dart
│   │   ├── presentation/providers/catalog_provider.dart
│   │   ├── presentation/pages/catalog_list_page.dart
│   │   ├── presentation/pages/produto_form_page.dart
│   │   ├── presentation/widgets/produto_list_tile.dart
│   │   ├── presentation/widgets/categoria_badge.dart
│   │   └── presentation/widgets/produto_search_dropdown.dart
│   │
│   ├── plans/
│   │   ├── data/datasources/plans_local_datasource.dart
│   │   ├── data/models/plano_model.dart
│   │   ├── data/models/estadio_model.dart
│   │   ├── data/models/produto_aplicacao_model.dart
│   │   ├── data/repositories/plans_repository_impl.dart
│   │   ├── domain/entities/plano_entity.dart
│   │   ├── domain/entities/estadio_entity.dart
│   │   ├── domain/entities/produto_aplicacao_entity.dart
│   │   ├── domain/repositories/plans_repository.dart
│   │   ├── domain/usecases/create_plano_usecase.dart
│   │   ├── domain/usecases/update_plano_usecase.dart
│   │   ├── domain/usecases/delete_plano_usecase.dart
│   │   ├── domain/usecases/add_estadio_usecase.dart
│   │   ├── domain/usecases/remove_estadio_usecase.dart
│   │   ├── domain/usecases/add_produto_aplicacao_usecase.dart
│   │   ├── domain/usecases/update_produto_aplicacao_usecase.dart
│   │   ├── domain/usecases/remove_produto_aplicacao_usecase.dart
│   │   ├── domain/usecases/calcular_total_usecase.dart
│   │   ├── presentation/providers/plans_list_provider.dart
│   │   ├── presentation/providers/plano_detail_provider.dart
│   │   ├── presentation/providers/produto_aplicacao_provider.dart
│   │   ├── presentation/pages/plans_list_page.dart
│   │   ├── presentation/pages/plan_create_page.dart
│   │   ├── presentation/pages/plan_canvas_page.dart
│   │   ├── presentation/widgets/plan_card.dart
│   │   ├── presentation/widgets/estadio_block.dart
│   │   ├── presentation/widgets/produto_aplicacao_row.dart
│   │   ├── presentation/widgets/categoria_icon_strip.dart
│   │   ├── presentation/widgets/categoria_bottom_sheet.dart
│   │   ├── presentation/widgets/produto_panel.dart
│   │   └── presentation/widgets/area_selector_widget.dart
│   │
│   ├── references/
│   │   ├── data/datasources/references_local_datasource.dart
│   │   ├── data/models/referencia_tecnica_model.dart
│   │   ├── domain/entities/referencia_tecnica_entity.dart
│   │   ├── domain/usecases/get_referencias_by_estadio_usecase.dart
│   │   ├── domain/usecases/get_cesb_by_estadio_usecase.dart
│   │   ├── presentation/providers/references_provider.dart
│   │   ├── presentation/pages/references_home_page.dart
│   │   ├── presentation/pages/categoria_detail_page.dart
│   │   ├── presentation/pages/cesb_detail_page.dart
│   │   ├── presentation/widgets/referencia_card.dart
│   │   ├── presentation/widgets/estadio_chip_row.dart
│   │   ├── presentation/widgets/cesb_tip_card.dart
│   │   └── presentation/widgets/categoria_section_header.dart
│   │
│   ├── consolidation/
│   │   ├── domain/entities/consolidacao_entity.dart
│   │   ├── domain/entities/consolidacao_item_entity.dart
│   │   ├── domain/usecases/gerar_consolidacao_usecase.dart
│   │   ├── domain/usecases/export_pdf_usecase.dart
│   │   ├── domain/usecases/export_excel_usecase.dart
│   │   ├── domain/usecases/export_html_usecase.dart
│   │   ├── presentation/providers/consolidacao_provider.dart
│   │   ├── presentation/pages/consolidacao_page.dart
│   │   ├── presentation/widgets/consolidacao_header.dart
│   │   ├── presentation/widgets/consolidacao_grupo.dart
│   │   ├── presentation/widgets/consolidacao_item_tile.dart
│   │   ├── presentation/widgets/consolidacao_detalhe_sheet.dart
│   │   └── presentation/widgets/export_action_row.dart
│   │
│   └── settings/
│       ├── data/datasources/settings_local_datasource.dart
│       ├── data/models/settings_model.dart
│       ├── domain/entities/settings_entity.dart
│       ├── domain/usecases/update_profile_usecase.dart
│       ├── domain/usecases/toggle_dark_mode_usecase.dart
│       ├── domain/usecases/change_app_icon_usecase.dart
│       ├── domain/usecases/export_data_usecase.dart
│       ├── domain/usecases/logout_usecase.dart
│       ├── domain/usecases/delete_account_usecase.dart
│       ├── presentation/providers/settings_provider.dart
│       ├── presentation/pages/settings_page.dart
│       ├── presentation/pages/profile_edit_page.dart
│       ├── presentation/pages/appearance_page.dart
│       ├── presentation/pages/data_page.dart
│       ├── presentation/pages/terms_page.dart
│       ├── presentation/pages/privacy_page.dart
│       ├── presentation/widgets/settings_section.dart
│       ├── presentation/widgets/settings_tile.dart
│       ├── presentation/widgets/settings_toggle.dart
│       ├── presentation/widgets/profile_avatar.dart
│       └── presentation/widgets/icon_selector.dart
│
└── main.dart
```

---

## 📦 Features do App — 5 Tabs

```
┌──────────────────────────────────────────────────────┐
│  🗺 Planos  👥 Clientes  📦 Catálogo  📚 Refs  ⚙️ Config │
└──────────────────────────────────────────────────────┘
```

| Tab | Ícone Phosphor | Rota | Conteúdo |
|-----|---------------|------|---------|
| **plans** | `MapTrifold` | `/plans` | Lista de planos + canvas do mapa mental |
| **clients** | `UsersThree` | `/clients` | CRUD Clientes → Fazendas → Talhões |
| **catalog** | `Package` | `/catalog` | Banco de produtos (dropdown source) |
| **references** | `BookOpen` | `/references` | Base técnica: Doenças, Insetos, Nutrição, Fisiologia, CESB |
| **settings** | `Gear` | `/settings` | Perfil, tema, dados, suporte, conta |

> ⚠️ **Consolidação NÃO é tab.** É gerada via botão interno do canvas.
> Rota: `/plans/:id/consolidacao`

---

## 🎨 Design System — SoloForte (iOS + Samsung Blue)

### AppColors — Paleta Completa

```dart
class AppColors {
  // IDENTIDADE
  static const primary      = Color(0xFF007AFF); // iOS Blue — CTA, links, ativo
  static const primaryDark  = Color(0xFF0051D5); // pressed
  static const primaryLight = Color(0xFFEAF2FF); // hover/background leve

  // CATEGORIAS FENOLÓGICAS
  static const catDoencas    = Color(0xFFFF3B30); // Vermelho
  static const catInsetos    = Color(0xFF007AFF); // Azul
  static const catNutricao   = Color(0xFFAF52DE); // Roxo
  static const catFisiologia = Color(0xFF34C759); // Verde
  static const catCESB       = Color(0xFFFF9500); // Âmbar/Ouro

  // NEUTROS (base iOS Light)
  static const background    = Color(0xFFF5F5F7);
  static const surface       = Color(0xFFFFFFFF);
  static const border        = Color(0xFFE5E7EB);
  static const borderSoft    = Color(0xFFE5E5E7);
  static const textPrimary   = Color(0xFF1D1D1F);
  static const textSecondary = Color(0xFF6B7280);
  static const textDisabled  = Color(0xFF9CA3AF);

  // FEEDBACK
  static const success       = Color(0xFF34C759); // verde = SÓ sucesso
  static const successLight  = Color(0xFFD1FAE5);
  static const error         = Color(0xFFFF3B30);
  static const warning       = Color(0xFFFFCC00);

  // DARK MODE
  static const backgroundDark = Color(0xFF0A0A0F);
  static const surfaceDark    = Color(0xFF1C1C1E);
  static const borderDark     = Color(0xFF2C2C2E);
}
```

### Regras de Ouro do Design

1. **Azul `#007AFF` é a identidade** — botões primários, tabs ativas, links
2. **Verde é APENAS feedback de sucesso** — nunca como cor de identidade/botão
3. **Branco domina o layout** — fundo principal sempre branco/surface
4. **Sem verde em botões** — usar azul como CTA principal
5. **Ícones:** estilo outline, stroke 1.8px, 24px na nav, `phosphor_flutter`
6. **Border radius:** cards/botões 12–16px, badges 99px
7. **Tipografia:** SF Pro — H1 28px Bold, H3 18px Semibold, Body 16px Regular
8. **Touch targets:** mínimo 44×44px (Apple HIG)
9. **Campos numéricos:** máximo 7 dígitos
10. **Visual compacto:** muitas seleções → `DropdownButton` ou `CupertinoActionSheet`

### AppTypography

```dart
// H1  — 28px Bold      — Título de página
// H2  — 22px SemiBold  — Seções
// H3  — 18px SemiBold  — Cards
// Body— 16px Regular   — Conteúdo
// Cap — 13px Regular   — Metadados
// Lbl — 11px Medium    — Badges/chips
```

### AppSpacing (grid 8px)

```dart
class AppSpacing {
  static const xs  = 4.0;
  static const sm  = 8.0;
  static const md  = 16.0;
  static const lg  = 24.0;
  static const xl  = 32.0;
  static const xxl = 48.0;
}
```

### Componentes Padrão

```
Botão primário:   #007AFF bg, branco, radius 12px, height 48px mín
Botão secundário: #F5F5F7 bg, #1D1D1F text
Botão ghost:      transparente, #007AFF text
Card padrão:      branco, border 1px #E5E7EB, radius 12-16px, shadow leve
Card premium:     gradiente #007AFF → #0051D5, texto branco
Touch target:     44×44px mínimo (HIG)
Tab bar:          branco fosco blur, ativo #007AFF, inativo #8E8E93, 83px altura
```

---

## 🗃️ Modelo de Dados — Isar Collections

### Hierarquia

```
Usuario ─── Perfil

Cliente ─── Fazenda[] ─── Talhao[]
                └── Plano[]

Plano ─── Estadio[]
              └── ProdutoAplicacao[]
                    ├── Produto (FK → ProdutoCatalogo)
                    ├── dose + doseUnidade
                    ├── areaHa (editável por linha)
                    ├── totalCalculado = dose × areaHa (computed)
                    └── totalOverride? (manual)

ProdutoCatalogo  → seed pré-populado + editável pelo técnico
ReferenciaTecnica → seed fixo, não editável
Consolidacao     → gerada em memória, não persistida
```

### UsuarioModel

```dart
@Collection()
class UsuarioModel {
  Id id = Isar.autoIncrement;
  late String firebaseUid;
  late String nome;
  late String email;
  String? telefone;
  String? empresa;
  String? craRegistro;
  String? avatarUrl;
  late bool darkMode;       // padrão: false
  late String appIconKey;   // 'principal' | 'classico'
  late DateTime createdAt;
  late DateTime updatedAt;
}
```

### ClienteModel

```dart
@Collection()
class ClienteModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String nome;
  String? cpfCnpj;
  String? telefone;
  String? email;
  String? cidade;
  String? uf;               // 2 chars
  late bool ativo;          // soft delete
  late DateTime createdAt;
  late DateTime updatedAt;

  @Backlink(to: 'cliente')
  final fazendas = IsarLinks<FazendaModel>();
}
```

### FazendaModel

```dart
@Collection()
class FazendaModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String nome;
  late double areaHa;       // max 7 dígitos
  late String cultura;      // Soja | Milho | Café | Algodão | Trigo...
  late String safra;        // ex: "2025/26"
  String? municipio;
  String? uf;
  late bool ativo;
  late DateTime createdAt;
  late DateTime updatedAt;

  final cliente = IsarLink<ClienteModel>();

  @Backlink(to: 'fazenda')
  final talhoes = IsarLinks<TalhaoModel>();

  @Backlink(to: 'fazenda')
  final planos  = IsarLinks<PlanoModel>();
}
```

### TalhaoModel

```dart
// Talhão = referência de área (seletor por produto, não nó no mapa)
@Collection()
class TalhaoModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String nome;         // "Talhão A", "Gleba Norte"
  late double areaHa;
  String? observacao;
  late bool ativo;
  late DateTime createdAt;

  final fazenda = IsarLink<FazendaModel>();
}

// Ao adicionar produto a um estádio, o técnico escolhe:
// 'Fazenda inteira' → fazenda.areaHa
// 'Talhão A'        → talhao.areaHa
// 'Personalizado'   → digita manualmente
```

### PlanoModel

```dart
@Collection()
class PlanoModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String nome;         // "Soja - Boa Vista - 25/26"
  late String cultura;      // snapshot
  late String safra;        // snapshot
  late double areaHaTotal;  // snapshot fazenda.areaHa
  late String status;       // rascunho | ativo | consolidado
  late DateTime createdAt;
  late DateTime updatedAt;

  final fazenda = IsarLink<FazendaModel>();
  final cliente = IsarLink<ClienteModel>();

  @Backlink(to: 'plano')
  final estadios = IsarLinks<EstadioModel>();
}
```

### EstadioModel

```dart
@Collection()
class EstadioModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String codigo;       // 'VE','VC','V1'...'R8','Operacional'
  late String label;        // editável (padrão = codigo)
  int ordem = 0;
  DateTime? dataAplicacao;
  String? observacao;
  late DateTime createdAt;

  final plano = IsarLink<PlanoModel>();

  @Backlink(to: 'estadio')
  final produtos = IsarLinks<ProdutoAplicacaoModel>();
}

// Estádios disponíveis:
// Operacional, VE, VC, V1, V2, V3, V4, V5, V6,
// R1, R2, R3, R4, R5.1, R5.3, R5.5, R6, R7, R8
```

### ProdutoAplicacaoModel

```dart
@Collection()
class ProdutoAplicacaoModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String produtoNome;       // snapshot
  late String produtoCategoria;  // snapshot
  late double dose;              // max 7 dígitos
  late String doseUnidade;       // L/ha | mL/ha | kg/ha | g/ha | unid/ha
  late double areaHa;            // padrão = fazenda.areaHa
  String? talhaoRef;

  double? totalOverride;         // sobrescreve dose × areaHa
  String? overrideMotivo;        // ex: "Estoque limitado"

  double? precoUnitario;         // snapshot do catálogo
  String? observacao;
  DateTime? dataPrevista;
  int ordem = 0;
  late DateTime createdAt;

  final estadio = IsarLink<EstadioModel>();
  final produto = IsarLink<ProdutoCatalogoModel>();
}
```

### Lógica de Cálculo — Domain Layer

```dart
class ProdutoAplicacaoEntity {
  double get totalCalculado => dose * areaHa;
  double get totalFinal     => totalOverride ?? totalCalculado;
  bool   get isOverride     => totalOverride != null;

  double? get custoTotal {
    if (precoUnitario == null) return null;
    return totalFinal * precoUnitario!;
  }
}

// REGRA DE UNIDADE MISTA (Consolidação):
// Fox Xpro: 400 mL/ha em VE  → normaliza → 0,4 L/ha
// Fox Xpro:   0,4  L/ha em R1 → já em L
// → badge ⚠️ "Unidades mescladas — verifique"
```

### ProdutoCatalogoModel

```dart
@Collection()
class ProdutoCatalogoModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String nomeComercial;     // "Fox Xpro"
  String? ingredienteAtivo;      // "Trifloxistrobina + Protioconazol"
  late String categoria;
  // Fungicida | Inseticida | Herbicida | Fertilizante | Bioestimulante | Adjuvante
  late String unidadePadrao;
  double? doseMin;
  double? doseMax;
  double? precoUnitario;
  String? fabricante;
  String? observacoes;
  late bool ativo;
  late bool isSeed;
  late DateTime createdAt;
  late DateTime updatedAt;
}

// SEED (~30 produtos):
// FUNGICIDAS:      Fox Xpro, Elatus, Orkestra, Priori Xtra, Opera
// INSETICIDAS:     Engeo Pleno, Karate Zeon, Intrepid, Ampligo
// HERBICIDAS:      Roundup, Verdict R, Poast, Spider
// FERTILIZANTES:   Nutriplant, Booster, KaliPhos
// BIOESTIMULANTES: Stimulate, Locus, Acadian, Rize
// ADJUVANTES:      Nimbus, Joint, Aureo
```

### ReferenciaTecnicaModel

```dart
@Collection()
class ReferenciaTecnicaModel {
  Id id = Isar.autoIncrement;
  late String categoria;  // doencas | insetos | nutricao | fisiologia | cesb
  late String estadio;    // VE, VC, V1...R8, Operacional
  late String titulo;
  String? descricao;
  String? focoManejo;     // CESB: "Fixação de Flores"
  String? praticas;       // CESB: práticas dos campeões
  String? padrao;         // CESB: "Nutrologia" | "Hormonal" | "Biológico"
  String? destaque;       // CESB: "Agro Mallon — 135,49 sc/ha"
}
```

### ConsolidacaoEntity (em memória — não persistida)

```dart
class ConsolidacaoEntity {
  final PlanoEntity plano;
  final DateTime geradoEm;
  final List<ConsolidacaoItemEntity> itens;

  double  get totalGeral => itens.fold(0, (s, i) => s + i.quantidadeTotal);
  double? get custoGeral => itens.every((i) => i.custoTotal != null)
      ? itens.fold(0.0, (s, i) => s + i.custoTotal!) : null;
}

class ConsolidacaoItemEntity {
  final String produtoNome;
  final String categoria;
  final double quantidadeTotal;
  final String unidade;           // normalizada
  final double? precoUnitario;
  final double? custoTotal;
  final List<DetalheEstadio> detalhe;
  final bool temUnidadeMista;     // badge ⚠️
}

class DetalheEstadio {
  final String estadioCodigo;
  final double dose;
  final String doseUnidade;
  final double areaHa;
  final double total;
  final bool isOverride;
  final String? overrideMotivo;
}
```

---

## 🗺️ Canvas do Mapa Mental (Feature Central)

### Anatomia do EstadioBlock — 3 Zonas

```
┌─────────────────────────────────────────────────────────┐
│ ESTÁDIO R1 — Início do Florescimento                    │
├───────────┬───────────────────────────────┬─────────────┤
│  ZONA A   │          ZONA B               │   ZONA C    │
│           │                               │             │
│  [R1]     │  Fox Xpro                     │  🔴 38×38   │
│  círculo  │  0,4 L/ha × [80] ha = 32,0 L │  🔵 38×38   │
│  72×72    │  ─────────────────────────    │  🟣 38×38   │
│           │  Engeo Pleno                  │  🟢 38×38   │
│  [+] btn  │  150mL/ha × [80] ha = 12,0 L │  🏆 38×38   │
│           │  [+ Produto do catálogo...]   │             │
└───────────┴───────────────────────────────┴─────────────┘
```

- **ZONA A:** Círculo 72×72 com código + botão [+] para adicionar produto
- **ZONA B:** Card de produtos — `dose × área = total` (inline editável)
- **ZONA C:** 5 ícones de categoria — sempre visíveis, clicáveis

### Produto Row

```
● Fox Xpro                              [✏️]  [🗑]
  0,4 L/ha  ×  [  80,0 ] ha  =  32,0 L

// Com override:
● Fox Xpro                       ⚠️    [✏️]  [🗑]
  0,4 L/ha  ×  80 ha  →  [  28,0 ] L  (manual)
  Motivo: "Estoque limitado"
```

### CategoriaReferencia — Enum Completo

```dart
enum CategoriaReferencia {
  doencas(
    label: 'Doenças',    cor: 0xFFFF3B30,
    icone: PhosphorIconsRegular.virus,
    subtitle: 'Fungos, bactérias, vírus',
    filtroCatalogo: 'Fungicida',
  ),
  insetos(
    label: 'Insetos',    cor: 0xFF007AFF,
    icone: PhosphorIconsRegular.bug,
    subtitle: 'Pragas e níveis de ação',
    filtroCatalogo: 'Inseticida',
  ),
  nutricao(
    label: 'Nutrição',   cor: 0xFFAF52DE,
    icone: PhosphorIconsRegular.leaf,
    subtitle: 'N, P, K, S e micronutrientes',
    filtroCatalogo: 'Fertilizante',
  ),
  fisiologia(
    label: 'Fisiologia', cor: 0xFF34C759,
    icone: PhosphorIconsRegular.dna,
    subtitle: 'Bioestimulantes e hormônios',
    filtroCatalogo: 'Bioestimulante',
  ),
  cesb(
    label: 'Campeões',   cor: 0xFFFF9500,
    icone: PhosphorIconsRegular.trophy,
    subtitle: 'Dicas CESB por estádio',
    filtroCatalogo: null,
  );
}

// Regra de opacidade:
// sem conteúdo → opacity 0.4
// com conteúdo → opacity 1.0 + shadow
```

### Fluxo "Usar no Plano"

```
[Ícone 🔴 Doenças no estádio R1] → tap
  Bottom Sheet: lista de doenças do R1
    "Ferrugem Asiática" → [+ Usar no plano]
      Bottom Sheet: Selecionar Produto
        Filtro automático: Fungicidas
        Busca live: "Fox Xpro..."
          Bottom Sheet: Configurar Aplicação
            Produto: Fox Xpro (bloqueado)
            Dose:    0,4 L/ha (pré-preenchido catálogo)
            Área:    80,0 ha  (pré-preenchido fazenda)
            Total:   32,0 L   (calculado)
            [Salvar] → produto adicionado ao estádio R1 ✅
```

### Seleção de Área no ProdutoPanel

```
○ Fazenda inteira (80 ha)   → usa fazenda.areaHa
○ Talhão A (40 ha)          → usa talhao.areaHa
○ Talhão B (40 ha)
○ Personalizado: [___] ha   → valor digitado manualmente
```

### Exportações (Consolidação)

| Formato | Conteúdo |
|---------|---------|
| **PDF** | Cabeçalho, tabela por categoria, totais, área de assinatura |
| **Excel** | 3 abas: Resumo / Detalhamento por Estádio / Info |
| **HTML** | Cópia navegável offline, acordeões interativos por categoria/produto |
| **Share** | Texto resumido via WhatsApp/mensagem |

---

## 🗺️ Rotas (go_router)

```dart
class AppRoutes {
  static const splash       = '/splash';
  static const onboarding   = '/onboarding';
  static const login        = '/auth/login';
  static const register     = '/auth/register';
  static const recover      = '/auth/recover';
  static const plans        = '/plans';
  static const planCanvas   = '/plans/:id';
  static const consolidacao = '/plans/:id/consolidacao';
  static const clients      = '/clients';
  static const clientDetail = '/clients/:id';
  static const catalog      = '/catalog';
  static const references   = '/references';
  static const settings     = '/settings';
}
// Guard: redireciona para login se não autenticado
// ShellRoute: AppShell (CupertinoTabScaffold) envolve as 5 tabs
```

---

## 🔌 Injeção de Dependências (core/di/providers.dart)

```dart
final isarProvider                = Provider<Isar>((ref) => IsarService.instance);
final authDatasourceProvider      = Provider((ref) => AuthRemoteDatasource());
final clientsDatasourceProvider   = Provider((ref) => ClientsLocalDatasource(ref.read(isarProvider)));
final catalogDatasourceProvider   = Provider((ref) => CatalogLocalDatasource(ref.read(isarProvider)));
final plansDatasourceProvider     = Provider((ref) => PlansLocalDatasource(ref.read(isarProvider)));
final referencesDatasourceProvider= Provider((ref) => ReferencesLocalDatasource(ref.read(isarProvider)));

final authRepoProvider       = Provider<AuthRepository>((ref) => AuthRepositoryImpl(ref.read(authDatasourceProvider)));
final clientsRepoProvider    = Provider<ClientsRepository>((ref) => ClientsRepositoryImpl(ref.read(clientsDatasourceProvider)));
final catalogRepoProvider    = Provider<CatalogRepository>((ref) => CatalogRepositoryImpl(ref.read(catalogDatasourceProvider)));
final plansRepoProvider      = Provider<PlansRepository>((ref) => PlansRepositoryImpl(ref.read(plansDatasourceProvider)));
final referencesRepoProvider = Provider<ReferencesRepository>((ref) => ReferencesRepositoryImpl(ref.read(referencesDatasourceProvider)));
```

---

## 📐 Padrões de Código

### Provider Riverpod — Notifier padrão

```dart
@riverpod
class ClientsNotifier extends _$ClientsNotifier {
  @override
  FutureOr<List<ClienteEntity>> build() => _fetch();

  Future<List<ClienteEntity>> _fetch() =>
      ref.read(clientsRepoProvider).getAll();

  Future<void> create(ClienteEntity cliente) async {
    await ref.read(clientsRepoProvider).create(cliente);
    ref.invalidateSelf();
  }
}
```

### Use Case — padrão call

```dart
class CreateClienteUseCase {
  const CreateClienteUseCase(this._repository);
  final ClientsRepository _repository;

  Future<void> call(ClienteEntity cliente) =>
      _repository.create(cliente);
}
```

### Entidade — freezed

```dart
@freezed
class ClienteEntity with _$ClienteEntity {
  const factory ClienteEntity({
    required String id,
    required String nome,
    String? cpfCnpj,
    String? cidade,
    String? uf,
    required bool ativo,
    required DateTime createdAt,
  }) = _ClienteEntity;
}
```

### ConsumerWidget — padrão para páginas

```dart
class ClientsListPage extends ConsumerWidget {
  const ClientsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clientsNotifierProvider);
    return state.when(
      data:    (clients) => _buildList(clients),
      loading: () => const LoadingSkeleton(),
      error:   (e, _) => ErrorStateWidget(
          onRetry: () => ref.invalidate(clientsNotifierProvider)),
    );
  }
}
```

---

## ✅ Regras de Qualidade

- Zero imports não usados (`flutter analyze` limpo)
- `const` em todo widget/valor imutável
- `ListView.builder` para listas (nunca children > 5 itens fixos)
- Toda string de UI em **PT-BR**; comentários em PT-BR
- Nomes de classes e métodos em **inglês** (padrão Dart)
- Validações inline no `TextFormField` com `validator:`
- Campos numéricos: `TextInputType.numberWithOptions(decimal: true)` + `maxLength: 7`
- Nunca usar `BuildContext` após `await` sem checar `mounted`
- Toda página com: empty state + error state + loading state

---

## 🧪 Testes — Cobertura Obrigatória

```dart
// Cálculo de dose
test('calcula total corretamente', () {
  final e = ProdutoAplicacaoEntity(dose: 0.4, areaHa: 80, ...);
  expect(e.totalCalculado, 32.0);
});

// Override
test('usa override quando definido', () {
  final e = ProdutoAplicacaoEntity(dose: 0.4, areaHa: 80, totalOverride: 28.0, ...);
  expect(e.totalFinal, 28.0);
  expect(e.isOverride, true);
});

// Mock padrão
when(() => mockRepository.getAll()).thenAnswer((_) async => []);
```

Cobertura obrigatória:
- `CalcularTotalUseCase` — dose × área, com e sem override
- `UnitConverter` — mL→L, g→kg, conversão mista
- `GerarConsolidacaoUseCase` — agrupamento, soma, normalização
- Validadores — CPF, CNPJ, email, senha

---

## 🚀 Sprints

| Sprint | Feature | Dias | Prompt |
|--------|---------|------|--------|
| **0** | Fundação: constants, theme, router, Isar, DI | 3–4 | PROMPT 01 |
| **1** | Auth: Splash, Onboarding, Login, Register | 4–5 | PROMPT 02 |
| **2** | Shell: CupertinoTabScaffold + widgets globais | 2 | PROMPT 03 |
| **3** | Clients: CRUD Cliente / Fazenda / Talhão | 3–4 | PROMPT 04 |
| **4** | Catalog: CRUD Produtos + seed ~30 | 2–3 | PROMPT 05 |
| **5** | References: seed técnico + CESB | 2 | PROMPT 06 |
| **6** | Plans Canvas ⭐ (feature central) | 7–10 | PROMPT 07+08+09 |
| **7** | Consolidação + Export PDF/Excel/HTML | 4–5 | PROMPT 10 |
| **8** | Settings + Perfil + Dark Mode | 2–3 | PROMPT 11 |
| **9** | Polimento: animações, skeletons, audit | 3–4 | PROMPT 12 |

### Checklist Sprint 0

```
□ flutter create agrimind --org com.seudominio
□ pubspec.yaml completo (todas as dependências)
□ Firebase: projeto + Auth + Firestore configurados
□ core/constants: AppColors, AppTypography, AppSpacing
□ core/theme: AppTheme light + dark + ThemeProvider
□ core/router: go_router skeleton com todas as rotas
□ core/database: IsarService singleton + collections registradas
□ core/di: providers.dart com cadeia completa
□ flutter analyze → zero warnings críticos
□ flutter test → passa
```

---

## 📦 pubspec.yaml — Dependências Completas

```yaml
name: agrimind
description: Mapa Mental Agronômico — Planejamento por Estádio Fenológico
version: 1.0.0+1
publish_to: none

environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: '>=3.22.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.3
  go_router: ^13.0.0
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  path_provider: ^2.1.2
  firebase_core: ^2.27.0
  firebase_auth: ^4.17.0
  cloud_firestore: ^4.15.0
  google_sign_in: ^6.2.1
  sign_in_with_apple: ^6.1.0
  pdf: ^3.10.8
  printing: ^5.12.0
  excel: ^4.0.0
  share_plus: ^9.0.0
  flutter_animate: ^4.5.0
  phosphor_flutter: ^2.1.0
  cached_network_image: ^3.3.1
  image_picker: ^1.0.7
  webview_flutter: ^4.7.0
  intl: ^0.19.0
  uuid: ^4.3.3
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  url_launcher: ^6.3.0
  in_app_review: ^2.0.9

dev_dependencies:
  flutter_test:
    sdk: flutter
  riverpod_generator: ^2.3.9
  build_runner: ^2.4.8
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  flutter_lints: ^3.0.1
  isar_generator: ^3.1.0
  mocktail: ^1.0.3
  flutter_launcher_icons: ^0.13.1
```

---

## 💬 Como usar este skill

Quando o usuário pedir código:

1. **Identificar** a feature, camada e sprint atual
2. **Gerar o arquivo completo** — nunca truncar com `...` ou `// resto do código`
3. **Seguir a estrutura de pastas** exatamente como definida acima
4. **Aplicar o Design System** — cores, tipografia, espaçamento corretos
5. **Usar padrões Dart** — freezed, riverpod_generator, const, null-safety
6. **Informar o caminho completo** do arquivo: `lib/features/[feature]/...`
7. **Gerar testes** quando solicitado ou para lógica crítica
8. **Perguntar o sprint atual** se não souber por onde começar
9. No canvas: sempre respeitar as **3 zonas** (A, B, C) do `EstadioBlock`
10. Nos cálculos: sempre usar `totalOverride ?? totalCalculado`
11. **Checklist de execução** — ao final de **cada resposta**, fornecer obrigatoriamente
    um **Checklist de Execução** com ✅/❌ para cada item do pedido, confirmando 100%.

> **Prioridade máxima:** código funcional · limpo · iOS-feel · offline-first.

---

## 📋 Checklist de Execução — Regra Obrigatória

> ⚠️ Esta regra é **inegociável** e se aplica a **TODA** resposta, sem exceção.

Ao encerrar **cada resposta**, sempre forneça o checklist no formato:

```
## ✅ Checklist de Execução
- [x] Item 1 — descrição do que foi feito
- [x] Item 2 — descrição do que foi feito
- [ ] Item pendente — motivo pelo qual não foi concluído
```

**Regras do checklist:**
- Listar **todos** os itens solicitados no prompt
- Usar `[x]` para concluído e `[ ]` para pendente/bloqueado
- Indicar **caminho do arquivo** para itens de código
- Se houver pendências, explicar o motivo e próximo passo
- O checklist vem **sempre no final**, após o código e explicações
