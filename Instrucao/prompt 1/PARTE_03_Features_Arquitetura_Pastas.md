# 🌱 AgriMind — PARTE 03
## Estrutura de Features · Arquitetura de Pastas

---

## 🏛️ Princípio Arquitetural

```
Feature-First + Clean Architecture por camada interna

lib/
 ├── core/          ← compartilhado entre todas as features
 └── features/      ← cada feature é um módulo independente
       └── [feature]/
             ├── data/        ← modelos, datasources, repository impl
             ├── domain/      ← entidades, contratos, use cases
             └── presentation/← providers, pages, widgets
```

**Regra de ouro:** nenhuma feature importa diretamente de outra feature. Comunicação via `core/` ou via router.

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
│   │   └── app_constants.dart       # strings fixas, limites
│   │
│   ├── theme/
│   │   ├── app_theme.dart           # ThemeData light + dark
│   │   └── app_theme_provider.dart  # Riverpod: darkMode toggle
│   │
│   ├── router/
│   │   ├── app_router.dart          # go_router config
│   │   └── app_routes.dart          # constantes de rotas
│   │
│   ├── di/
│   │   └── providers.dart           # injeção de dependências global
│   │
│   ├── database/
│   │   ├── isar_service.dart        # singleton Isar
│   │   └── seed/
│   │       ├── referencias_seed.dart    # STAGE_REF do HTML
│   │       ├── cesb_seed.dart           # dados do PDF CESB
│   │       └── catalogo_seed.dart       # produtos pré-populados
│   │
│   ├── network/
│   │   └── firebase_service.dart
│   │
│   ├── utils/
│   │   ├── validators.dart          # email, CPF, senha
│   │   ├── formatters.dart          # moeda, área, dose
│   │   ├── unit_converter.dart      # mL→L, g→kg (consolidação)
│   │   └── extensions.dart          # String/DateTime extensions
│   │
│   └── widgets/                     # widgets verdadeiramente globais
│       ├── app_bar_custom.dart
│       ├── bottom_sheet_handle.dart
│       ├── empty_state_widget.dart
│       ├── error_state_widget.dart
│       ├── loading_skeleton.dart
│       └── confirmation_dialog.dart
│
├── features/
│   │
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart    # contrato abstrato
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── register_usecase.dart
│   │   │       ├── recover_password_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── delete_account_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       ├── pages/
│   │       │   ├── splash_page.dart
│   │       │   ├── onboarding_page.dart
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   └── recover_password_page.dart
│   │       └── widgets/
│   │           ├── auth_text_field.dart
│   │           ├── auth_primary_button.dart
│   │           └── social_sign_in_button.dart
│   │
│   ├── clients/                     # 👥 Clientes + Fazendas + Talhões
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── clients_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── cliente_model.dart
│   │   │   │   ├── fazenda_model.dart
│   │   │   │   └── talhao_model.dart
│   │   │   └── repositories/
│   │   │       └── clients_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── cliente_entity.dart
│   │   │   │   ├── fazenda_entity.dart
│   │   │   │   └── talhao_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── clients_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_cliente_usecase.dart
│   │   │       ├── update_cliente_usecase.dart
│   │   │       ├── delete_cliente_usecase.dart
│   │   │       ├── create_fazenda_usecase.dart
│   │   │       ├── update_fazenda_usecase.dart
│   │   │       ├── create_talhao_usecase.dart
│   │   │       └── get_talhoes_by_fazenda_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── clients_provider.dart
│   │       │   └── farms_provider.dart
│   │       ├── pages/
│   │       │   ├── clients_list_page.dart      # lista c/ busca
│   │       │   ├── client_detail_page.dart     # fazendas do cliente
│   │       │   ├── client_form_page.dart       # criar/editar cliente
│   │       │   ├── farm_form_page.dart         # criar/editar fazenda
│   │       │   └── talhao_form_page.dart       # criar/editar talhão
│   │       └── widgets/
│   │           ├── client_list_tile.dart
│   │           ├── farm_card.dart
│   │           └── talhao_chip.dart
│   │
│   ├── catalog/                     # 📦 Banco de Produtos
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── catalog_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── produto_catalogo_model.dart
│   │   │   └── repositories/
│   │   │       └── catalog_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── produto_catalogo_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── catalog_repository.dart
│   │   │   └── usecases/
│   │   │       ├── search_produtos_usecase.dart
│   │   │       ├── create_produto_usecase.dart
│   │   │       ├── update_produto_usecase.dart
│   │   │       └── toggle_produto_ativo_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── catalog_provider.dart
│   │       ├── pages/
│   │       │   ├── catalog_list_page.dart      # lista + busca
│   │       │   └── produto_form_page.dart      # criar/editar
│   │       └── widgets/
│   │           ├── produto_list_tile.dart
│   │           ├── categoria_badge.dart
│   │           └── produto_search_dropdown.dart # ⭐ dropdown com busca live
│   │
│   ├── plans/                       # 🗺️ Planos + Mapa Mental (feature central)
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── plans_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── plano_model.dart
│   │   │   │   ├── estadio_model.dart
│   │   │   │   └── produto_aplicacao_model.dart
│   │   │   └── repositories/
│   │   │       └── plans_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── plano_entity.dart
│   │   │   │   ├── estadio_entity.dart
│   │   │   │   └── produto_aplicacao_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── plans_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_plano_usecase.dart
│   │   │       ├── update_plano_usecase.dart
│   │   │       ├── delete_plano_usecase.dart
│   │   │       ├── add_estadio_usecase.dart
│   │   │       ├── remove_estadio_usecase.dart
│   │   │       ├── add_produto_aplicacao_usecase.dart
│   │   │       ├── update_produto_aplicacao_usecase.dart
│   │   │       ├── remove_produto_aplicacao_usecase.dart
│   │   │       └── calcular_total_usecase.dart  # dose × area + override
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── plans_list_provider.dart
│   │       │   ├── plano_detail_provider.dart
│   │       │   └── produto_aplicacao_provider.dart
│   │       ├── pages/
│   │       │   ├── plans_list_page.dart         # lista de planos
│   │       │   ├── plan_create_page.dart        # seleciona cliente/fazenda
│   │       │   └── plan_canvas_page.dart        # ⭐ CANVAS DO MAPA MENTAL
│   │       └── widgets/
│   │           ├── plan_card.dart               # card na lista
│   │           ├── estadio_block.dart           # bloco do estádio no canvas
│   │           ├── produto_aplicacao_row.dart   # linha: nome | dose | area | total
│   │           ├── categoria_icon_strip.dart    # 5 ícones verticais
│   │           ├── categoria_bottom_sheet.dart  # bottom sheet das refs
│   │           ├── produto_panel.dart           # bottom sheet edição produto
│   │           └── area_selector_widget.dart    # fazenda inteira | talhão | custom
│   │
│   ├── references/                  # 📚 Base Técnica
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── references_local_datasource.dart
│   │   │   └── models/
│   │   │       └── referencia_tecnica_model.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── referencia_tecnica_entity.dart
│   │   │   └── usecases/
│   │   │       ├── get_referencias_by_estadio_usecase.dart
│   │   │       └── get_cesb_by_estadio_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── references_provider.dart
│   │       ├── pages/
│   │       │   ├── references_home_page.dart    # hub com 5 categorias
│   │       │   ├── categoria_detail_page.dart   # lista por estádio
│   │       │   └── cesb_detail_page.dart        # dicas CESB por estádio
│   │       └── widgets/
│   │           ├── referencia_card.dart
│   │           ├── estadio_chip_row.dart        # scroll horizontal de chips
│   │           ├── cesb_tip_card.dart           # card especial CESB
│   │           └── categoria_section_header.dart
│   │
│   ├── consolidation/               # 📊 Pedido / Consolidação
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── consolidacao_entity.dart
│   │   │   │   └── consolidacao_item_entity.dart
│   │   │   └── usecases/
│   │   │       ├── gerar_consolidacao_usecase.dart
│   │   │       ├── export_pdf_usecase.dart
│   │   │       ├── export_excel_usecase.dart
│   │   │       └── export_html_usecase.dart     # HTML interativo dinâmico
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── consolidacao_provider.dart
│   │       ├── pages/
│   │       │   └── consolidacao_page.dart
│   │       └── widgets/
│   │           ├── consolidacao_header.dart
│   │           ├── consolidacao_grupo.dart      # agrupado por categoria
│   │           ├── consolidacao_item_tile.dart  # produto + total + custo
│   │           ├── consolidacao_detalhe_sheet.dart # breakdown por estádio
│   │           └── export_action_row.dart       # botões PDF/Excel/HTML/Share
│   │
│   └── settings/                    # ⚙️ Configurações
│       ├── data/
│       │   ├── datasources/
│       │   │   └── settings_local_datasource.dart
│       │   └── models/
│       │       └── settings_model.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── settings_entity.dart
│       │   └── usecases/
│       │       ├── update_profile_usecase.dart
│       │       ├── toggle_dark_mode_usecase.dart
│       │       ├── change_app_icon_usecase.dart
│       │       ├── export_data_usecase.dart
│       │       ├── logout_usecase.dart
│       │       └── delete_account_usecase.dart
│       └── presentation/
│           ├── providers/
│           │   └── settings_provider.dart
│           ├── pages/
│           │   ├── settings_page.dart           # página raiz
│           │   ├── profile_edit_page.dart
│           │   ├── appearance_page.dart
│           │   ├── data_page.dart               # export/import backup
│           │   ├── terms_page.dart              # WebView
│           │   └── privacy_page.dart            # WebView
│           └── widgets/
│               ├── settings_section.dart        # grupo com header
│               ├── settings_tile.dart           # linha clicável
│               ├── settings_toggle.dart         # linha com switch
│               ├── profile_avatar.dart
│               └── icon_selector.dart           # Principal / Clássico
│
└── main.dart
```

---

## 🔌 Injeção de Dependências (core/di/providers.dart)

```dart
// Cadeia de dependências Riverpod

// Database
final isarProvider = Provider<Isar>((ref) => IsarService.instance);

// Datasources
final authDatasourceProvider = Provider((ref) => AuthRemoteDatasource());
final clientsDatasourceProvider = Provider((ref) =>
    ClientsLocalDatasource(ref.read(isarProvider)));
final catalogDatasourceProvider = Provider((ref) =>
    CatalogLocalDatasource(ref.read(isarProvider)));
final plansDatasourceProvider = Provider((ref) =>
    PlansLocalDatasource(ref.read(isarProvider)));

// Repositories
final authRepoProvider = Provider<AuthRepository>((ref) =>
    AuthRepositoryImpl(ref.read(authDatasourceProvider)));
final clientsRepoProvider = Provider<ClientsRepository>((ref) =>
    ClientsRepositoryImpl(ref.read(clientsDatasourceProvider)));
final catalogRepoProvider = Provider<CatalogRepository>((ref) =>
    CatalogRepositoryImpl(ref.read(catalogDatasourceProvider)));
final plansRepoProvider = Provider<PlansRepository>((ref) =>
    PlansRepositoryImpl(ref.read(plansDatasourceProvider)));
```

---

## 🗺️ Rotas (core/router/app_router.dart)

```dart
final appRouter = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) {
    final isAuth = ref.read(authProvider).isAuthenticated;
    if (!isAuth && !state.uri.toString().startsWith('/auth')) {
      return '/auth/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/splash',         builder: (_, __) => const SplashPage()),
    GoRoute(path: '/onboarding',     builder: (_, __) => const OnboardingPage()),
    GoRoute(
      path: '/auth',
      routes: [
        GoRoute(path: 'login',       builder: (_, __) => const LoginPage()),
        GoRoute(path: 'register',    builder: (_, __) => const RegisterPage()),
        GoRoute(path: 'recover',     builder: (_, __) => const RecoverPasswordPage()),
      ],
    ),
    ShellRoute(
      builder: (_, __, child) => AppShell(child: child), // tab scaffold
      routes: [
        GoRoute(path: '/plans',      builder: (_, __) => const PlansListPage()),
        GoRoute(path: '/plans/:id',  builder: (_, s)  => PlanCanvasPage(id: s.pathParameters['id']!)),
        GoRoute(path: '/plans/:id/consolidacao', builder: (_, s) => ConsolidacaoPage(planoId: s.pathParameters['id']!)),
        GoRoute(path: '/clients',    builder: (_, __) => const ClientsListPage()),
        GoRoute(path: '/clients/:id', builder: (_, s) => ClientDetailPage(id: s.pathParameters['id']!)),
        GoRoute(path: '/catalog',    builder: (_, __) => const CatalogListPage()),
        GoRoute(path: '/references', builder: (_, __) => const ReferencesHomePage()),
        GoRoute(path: '/settings',   builder: (_, __) => const SettingsPage()),
      ],
    ),
  ],
);
```

---

*Próxima parte → PARTE 04: Canvas do Mapa Mental · Estádio · Ícones de Categoria*
