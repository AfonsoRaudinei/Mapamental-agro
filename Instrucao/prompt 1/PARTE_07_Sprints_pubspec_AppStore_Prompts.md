# 🌱 AgriMind — PARTE 07
## Sprints · pubspec.yaml · Checklist App Store · Prompts de Geração

---

## 🚀 Sequência de Sprints

### Sprint 0 — Fundação (3-4 dias)
```
□ flutter create agrimind --org com.seudominio
□ pubspec.yaml completo (todas dependências)
□ Firebase: projeto + Auth + Firestore configurados
□ core/constants: AppColors, AppTypography, AppSpacing
□ core/theme: AppTheme light + dark + ThemeProvider
□ core/router: go_router skeleton com todas as rotas
□ core/database: IsarService singleton + collections registradas
□ core/di: providers.dart com cadeia completa
□ flutter analyze → zero warnings críticos
□ flutter test → passa
```

### Sprint 1 — Auth (4-5 dias)
```
□ SplashPage: logo animado + redirect automático
□ OnboardingPage: PageView 3 slides
□ LoginPage: email/senha + Apple + Google Sign-In
□ RegisterPage: campos + validações inline
□ RecoverPasswordPage: reset Firebase
□ AuthProvider: estado de sessão reativo
□ AuthRepository + AuthRemoteDatasource
□ Redirect guard no go_router
□ Testes: AuthBloc cenário feliz + erro + edge cases
```

### Sprint 2 — Shell + Navegação (2 dias)
```
□ AppShell: CupertinoTabScaffold com 5 tabs
□ Tab bar customizado (blur, iOS style)
□ AppBarCustom reutilizável
□ BottomSheetHandle widget
□ EmptyStateWidget
□ ErrorStateWidget
□ LoadingSkeleton
□ ConfirmationDialog
```

### Sprint 3 — Clients (3-4 dias)
```
□ Isar: ClienteModel + FazendaModel + TalhaoModel schemas
□ ClientsLocalDatasource: CRUD completo
□ ClientsRepository + usecases
□ ClientsListPage: lista + busca + swipe actions
□ ClientDetailPage: fazendas expandidas
□ ClientFormPage: criar/editar cliente
□ FarmFormPage: criar/editar fazenda + talhões
□ ClientsProvider: Riverpod notifiers
```

### Sprint 4 — Catalog (2-3 dias)
```
□ Isar: ProdutoCatalogoModel schema
□ Seed inicial: ~30 produtos principais
□ CatalogLocalDatasource: CRUD + search
□ CatalogListPage: lista filtrada por categoria
□ ProdutoFormPage: criar/editar
□ ProdutoSearchDropdown: busca live com Isar
□ CatalogProvider
```

### Sprint 5 — References (2 dias)
```
□ Isar: ReferenciaTecnicaModel schema
□ Seed: STAGE_REF completo (do HTML)
□ Seed CESB: dados do PDF correlação
□ ReferencesHomePage: hub 5 categorias
□ CategoriaDetailPage: lista por estádio com chips
□ CesbDetailPage: dicas por faixa de estádio
□ ReferencesProvider
```

### Sprint 6 — Plans Canvas (7-10 dias) ⭐ Feature central
```
□ Isar: PlanoModel + EstadioModel + ProdutoAplicacaoModel
□ PlansRepository + todos os usecases
□ PlansListPage: lista + busca
□ PlanCreatePage: seleciona cliente/fazenda/cultura/safra
□ PlanCanvasPage: canvas principal
□ EstadioBlock: Zona A + Zona B + Zona C
□ ProdutoAplicacaoRow: dose × área = total (inline editável)
□ AreaSelectorWidget: fazenda | talhão | custom
□ TotalOverrideModal: override manual + motivo
□ CategoriaIconStrip: 5 ícones com opacidade dinâmica
□ CategoriaBottomSheet: DraggableScrollableSheet
□ ReferenciaItemTile: item + [+ Usar no plano]
□ CesbTipCard: card especial CESB
□ ProdutoPanelSheet: edição completa do produto
□ ProdutoSearchDropdown integrado ao panel
□ CalcularTotalUseCase: dose × area + override logic
□ UnitConverter: normalização de unidades mistas
□ PlanoProvider + ProdutoAplicacaoProvider
□ Testes: cálculo dose × area, override, unidade mista
```

### Sprint 7 — Consolidação + Export (4-5 dias)
```
□ GerarConsolidacaoUseCase: agrupamento + soma + normalização
□ ConsolidacaoPage: layout com grupos por categoria
□ ConsolidacaoItemTile: produto + total + custo
□ ConsolidacaoDetalheSheet: breakdown por estádio
□ ExportPdfUseCase: PDF profissional multi-página
□ ExportExcelUseCase: 3 abas
□ ExportHtmlUseCase: HTML interativo offline
□ ExportActionRow: 4 botões (PDF/Excel/HTML/Share)
□ Share Sheet nativo iOS
□ Testes: consolidação com unidades mistas, sem preço, com override
```

### Sprint 8 — Settings (2-3 dias)
```
□ SettingsPage: estrutura completa com sections
□ ProfileEditPage: edição de perfil
□ AppearancePage: darkMode toggle + app icon selector
□ DataPage: exportar/importar dados JSON
□ DarkModeProvider: persist no Isar
□ AppIconUseCase: iOS alternate icons
□ Logout + Delete Account com re-auth
□ WebView: Terms + Privacy
□ Feedback: mailto link
□ Rate App: StoreKit
```

### Sprint 9 — Polimento Final (3-4 dias)
```
□ flutter_animate: micro-interações em todos os elementos
□ Skeleton loaders em todas as listas
□ Empty states criativos por feature
□ Error states com retry automático
□ Performance audit (Flutter DevTools)
□ Rebuild audit: Consumer → ConsumerWidget, const everywhere
□ flutter analyze → zero warnings
□ flutter test → cobertura > 80% na domain layer
□ Testes de widget nas telas principais
□ TestFlight: build + distribuição interna
□ Accessibility: semântica + contraste mínimo AAA
```

---

## 📦 pubspec.yaml Completo

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

  # State management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.3

  # Navigation
  go_router: ^13.0.0

  # Database local
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  path_provider: ^2.1.2

  # Firebase
  firebase_core: ^2.27.0
  firebase_auth: ^4.17.0
  cloud_firestore: ^4.15.0
  google_sign_in: ^6.2.1
  sign_in_with_apple: ^6.1.0

  # Export
  pdf: ^3.10.8
  printing: ^5.12.0
  excel: ^4.0.0
  share_plus: ^9.0.0

  # UI & Animações
  flutter_animate: ^4.5.0
  phosphor_flutter: ^2.1.0
  cached_network_image: ^3.3.1
  image_picker: ^1.0.7
  webview_flutter: ^4.7.0

  # Utils
  intl: ^0.19.0
  uuid: ^4.3.3
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  url_launcher: ^6.3.0

  # iOS específico
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

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/
  fonts:
    - family: SFPro
      fonts:
        - asset: assets/fonts/SF-Pro-Text-Regular.otf
        - asset: assets/fonts/SF-Pro-Text-Medium.otf
          weight: 500
        - asset: assets/fonts/SF-Pro-Text-Semibold.otf
          weight: 600
        - asset: assets/fonts/SF-Pro-Text-Bold.otf
          weight: 700
```

---

## ✅ Checklist App Store (iOS)

### Antes de submeter
```
□ Bundle ID: com.seudominio.agrimind
□ Display Name: AgriMind
□ Versão: 1.0.0 (build 1)
□ Minimum iOS: 16.0
□ Orientação: Portrait only

□ Ícones gerados (flutter_launcher_icons):
    - 1024×1024 (App Store)
    - todos os tamanhos iOS automáticos

□ LaunchScreen.storyboard configurado
    (splash nativo antes do Flutter iniciar)

□ Info.plist — Permissões:
    - NSCameraUsageDescription (fotos nos produtos)
    - NSPhotoLibraryUsageDescription
    - NSPhotoLibraryAddUsageDescription

□ PrivacyInfo.xcprivacy (obrigatório 2024+):
    - NSPrivacyAccessedAPITypes
    - NSPrivacyCollectedDataTypes
    - NSPrivacyTrackingDomains

□ Alternate app icons configurados (Principal + Clássico)

□ Entitlements:
    - com.apple.developer.applesignin
    - Push notifications (se notificações)

□ Firebase GoogleService-Info.plist incluído
```

### Screenshots e metadados
```
□ Screenshots iPhone 6.9" (iPhone 16 Pro Max): 5 telas
□ Screenshots iPhone 6.5" (iPhone 11 Pro Max): 5 telas
□ Screenshots iPhone 5.5" (iPhone 8 Plus): 5 telas
□ Título PT-BR: "AgriMind — Manejo Fenológico"
□ Subtítulo: "Seu planejamento de campo"
□ Descrição completa (4000 chars max)
□ Keywords: agronomia, soja, manejo, fenologia, agronomo...
□ Suporte URL: link para FAQ/site
□ Política de privacidade: URL pública obrigatória
□ Categoria: Productivity / Business
□ Preço: Free (ou Paid — definir modelo)
□ App Review Notes: credenciais de teste
```

### TestFlight
```
□ Build enviado via Xcode ou fastlane
□ Grupo de testadores internos adicionados
□ Feedback coletado e bugs corrigidos
□ Build final: incrementar build number
```

---

## 📝 Prompts de Geração — Sequência Oficial

Cada prompt é independente e autocontido — inclui todo o contexto necessário.

```
PROMPT 01 — Setup & Foundation
  Setup Flutter, pubspec.yaml, Firebase, AppColors,
  AppTypography, AppSpacing, AppTheme light/dark,
  IsarService, go_router skeleton, main.dart

PROMPT 02 — Auth Feature
  SplashPage, OnboardingPage, LoginPage, RegisterPage,
  RecoverPasswordPage, AuthProvider, AuthRepository,
  Firebase Auth (email + Apple + Google), guard de rotas

PROMPT 03 — AppShell + Widgets Globais
  CupertinoTabScaffold 5 tabs, AppBarCustom,
  BottomSheetHandle, EmptyStateWidget, ErrorStateWidget,
  LoadingSkeleton, ConfirmationDialog

PROMPT 04 — Clients Feature
  ClienteModel/FazendaModel/TalhaoModel Isar,
  ClientsListPage, ClientDetailPage, ClientFormPage,
  FarmFormPage, TalhaoFormPage, ClientsProvider

PROMPT 05 — Catalog Feature
  ProdutoCatalogoModel Isar, seed inicial 30+ produtos,
  CatalogListPage, ProdutoFormPage,
  ProdutoSearchDropdown (busca live), CatalogProvider

PROMPT 06 — References Feature + Seed
  ReferenciaTecnicaModel Isar, seed STAGE_REF completo,
  seed CESB do PDF, ReferencesHomePage,
  CategoriaDetailPage, CesbDetailPage, ReferencesProvider

PROMPT 07 — Plans Feature: Modelo + CRUD
  PlanoModel/EstadioModel/ProdutoAplicacaoModel Isar,
  PlansRepository, todos os usecases,
  PlansListPage, PlanCreatePage, PlansProvider

PROMPT 08 — Plans Canvas: Estádio + Produtos
  PlanCanvasPage, EstadioBlock (Zona A + B + C),
  ProdutoAplicacaoRow (inline edit área),
  AreaSelectorWidget, TotalOverrideModal,
  CalcularTotalUseCase, UnitConverter

PROMPT 09 — Plans Canvas: Ícones + Bottom Sheets
  CategoriaIconStrip (5 ícones, opacidade dinâmica),
  CategoriaBottomSheet (DraggableScrollableSheet),
  ReferenciaItemTile + [+ Usar no plano] flow,
  CesbTipCard, ProdutoPanelSheet completo

PROMPT 10 — Consolidação + Export
  GerarConsolidacaoUseCase, ConsolidacaoPage,
  ConsolidacaoDetalheSheet, ExportPdfUseCase,
  ExportExcelUseCase, ExportHtmlUseCase (interativo),
  ExportActionRow, Share Sheet

PROMPT 11 — Settings Feature
  SettingsPage completo, ProfileEditPage,
  DarkModeProvider (persist Isar), AppIconUseCase,
  Logout + DeleteAccount, WebView Terms/Privacy

PROMPT 12 — Polimento: Animações + Performance
  flutter_animate em todos os elementos,
  skeleton loaders, empty states criativos,
  flutter analyze clean, performance audit
```

---

## 📊 Resumo do Projeto

| Item | Valor |
|------|-------|
| Total de features | 8 |
| Total de telas | ~25 |
| Total de sprints | 9 |
| Total de prompts | 12 |
| Stack principal | Flutter + Riverpod + Isar + Firebase |
| Plataforma | iOS-first (App Store) |
| Padrão visual | Apple HIG + Design System SoloForte |
| Exportações | PDF + Excel + HTML interativo |
| Offline-first | ✅ Isar local + Firebase sync |
| Categorias ícones | 5 (Doenças + Insetos + Nutrição + Fisiologia + CESB) |

---

*Planejamento completo. Pronto para iniciar o PROMPT 01.*
