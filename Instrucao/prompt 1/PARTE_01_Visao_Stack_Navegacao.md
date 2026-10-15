# 🌱 AgriMind — PARTE 01
## Visão do Produto · Stack Técnico · Navegação

> Mapa Mental Agronômico | Flutter/Dart | iOS-First | 2026

---

## 🎯 Visão do Produto

**AgriMind** é um app de mapa mental agronômico — um espaço vivo onde o agrônomo ou técnico registra, organiza e consulta seu planejamento de aplicações por estádio fenológico, de forma visual, intuitiva e offline-first.

**Tagline:** *"Seu campo, organizado como pensa."*

| | |
|--|--|
| Inspiração estrutural | SimpleMind Pro |
| Inspiração visual | Apple HIG + Design System SoloForte |
| DNA técnico | Mapa Fenológico (Doenças, Insetos, Nutrição, Fisiologia, CESB) |
| Público-alvo | Agrônomos, técnicos agrícolas, consultores |
| Plataforma | iOS-first (App Store) |
| Idioma | PT-BR |

---

## 🏗️ Stack Técnico Definitivo

| Camada | Tecnologia | Versão | Justificativa |
|--------|-----------|--------|---------------|
| Framework | Flutter | 3.x | Performance nativa, iOS pixel-perfect |
| Linguagem | Dart | sound null-safety | AOT compilation, tipagem forte |
| Estado | **Riverpod** | 3.0 | Offline-first nativo, compile-time safety, menos boilerplate |
| Navegação | **go_router** | 13.x | Deep links, URL-based, iOS back gestures |
| Banco Local | **Isar** | 3.x | Schema tipado, mais rápido que Hive/SQLite, ideal para grafos |
| Auth | Firebase Auth | 4.x | Email, Google Sign-In, Apple Sign-In |
| Sync Cloud | Cloud Firestore | 4.x | Offline-first automático, sync em background |
| Export PDF | pdf + printing | 3.x | Geração nativa de relatórios |
| Export Excel | excel | 4.x | Planilha multi-aba |
| Export HTML | dart:html + template | — | HTML interativo dinâmico (compartilhável) |
| Animações | flutter_animate | 4.x | Micro-interações iOS-style |
| Ícones | phosphor_flutter | 2.x | Estilo outline/line-art minimalista |
| Code gen | riverpod_generator + freezed | — | Boilerplate zero, imutabilidade garantida |
| CI/CD | GitHub Actions | — | flutter analyze + flutter test no push |

---

## 📱 Navegação — Bottom Tab Bar

### Decisão: `CupertinoTabScaffold` customizado

**Descartados:**
- `NavigationDrawer` → esconde contexto, quebra fluidez iOS
- `Material NavigationBar` → ripple effect, indicadores quadrados
- `NavigationRail` → padrão tablet, inadequado mobile-first
- `Top Tabs` → conflita com gestos de swipe iOS

### 5 Tabs Definitivas

```
┌──────────────────────────────────────────────────────┐
│  🗺 Planos  👥 Clientes  📦 Catálogo  📚 Refs  ⚙️ Config │
└──────────────────────────────────────────────────────┘
```

| Tab | Ícone Phosphor | Conteúdo |
|-----|---------------|---------|
| **Planos** | `MapTrifold` | Lista de planos + canvas do mapa mental |
| **Clientes** | `UsersThree` | CRUD Clientes → Fazendas → Talhões |
| **Catálogo** | `Package` | Banco de produtos (dropdown source) |
| **Referências** | `BookOpen` | Base técnica CESB + Doenças/Insetos/Nutrição/Fisiologia |
| **Config** | `Gear` | Perfil, aparência, dados, suporte, conta |

> ⚠️ **Consolidação NÃO é tab fixa.** É gerada a partir de um Plano (botão interno). Resultado: fluxo mais coerente, menos tabs desnecessárias.

### Estilo da Tab Bar
```
Fundo:    branco fosco com blur (frostedGlass)
Ativo:    #007AFF
Inativo:  #8E8E93
Ícones:   outline 24px, stroke 1.8px
Altura:   83px (incluindo safe area)
Borda:    0.5px #E5E5E7 no topo
```

### Implementação Flutter
```dart
CupertinoTabScaffold(
  tabBar: CupertinoTabBar(
    activeColor: AppColors.primary,        // #007AFF
    inactiveColor: AppColors.textSecondary, // #8E8E93
    backgroundColor: Colors.white.withOpacity(0.92),
    items: const [
      BottomNavigationBarItem(icon: PhosphorIcon(PhosphorIcons.mapTrifold)),
      BottomNavigationBarItem(icon: PhosphorIcon(PhosphorIcons.usersThree)),
      BottomNavigationBarItem(icon: PhosphorIcon(PhosphorIcons.package)),
      BottomNavigationBarItem(icon: PhosphorIcon(PhosphorIcons.bookOpen)),
      BottomNavigationBarItem(icon: PhosphorIcon(PhosphorIcons.gear)),
    ],
  ),
  tabBuilder: (context, index) => ...,
)
```

---

## 🎨 Design System — Tokens Completos

### Paleta de Cores
```dart
class AppColors {
  // Identidade
  static const primary      = Color(0xFF007AFF); // iOS Blue
  static const primaryDark  = Color(0xFF0051D5);
  static const primaryLight = Color(0xFFEAF2FF);

  // Categorias fenológicas (ícones do estádio)
  static const catDoencas    = Color(0xFFFF3B30); // Vermelho
  static const catInsetos    = Color(0xFF007AFF); // Azul
  static const catNutricao   = Color(0xFFAF52DE); // Roxo
  static const catFisiologia = Color(0xFF34C759); // Verde
  static const catCESB       = Color(0xFFFF9500); // Âmbar/Ouro

  // Neutros (Light)
  static const background    = Color(0xFFF5F5F7);
  static const surface       = Color(0xFFFFFFFF);
  static const border        = Color(0xFFE5E7EB);
  static const borderSoft    = Color(0xFFE5E5E7);
  static const textPrimary   = Color(0xFF1D1D1F);
  static const textSecondary = Color(0xFF6B7280);
  static const textDisabled  = Color(0xFF9CA3AF);

  // Semânticas
  static const success       = Color(0xFF34C759);
  static const error         = Color(0xFFFF3B30);
  static const warning       = Color(0xFFFFCC00);

  // Dark Mode
  static const backgroundDark = Color(0xFF0A0A0F);
  static const surfaceDark    = Color(0xFF1C1C1E);
  static const borderDark     = Color(0xFF2C2C2E);
}
```

### Tipografia (SF Pro hierarchy)
```dart
// H1  — 28px Bold      — Título de página
// H2  — 22px SemiBold  — Seções
// H3  — 18px SemiBold  — Cards
// Body— 16px Regular   — Conteúdo
// Cap — 13px Regular   — Metadados
// Lbl — 11px Medium    — Badges/chips
```

### Espaçamento (8px grid)
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

### Componentes base
```
Botão primário:   #007AFF bg, branco, radius 12px, height 48px min
Botão secundário: #F5F5F7 bg, #1D1D1F text
Botão ghost:      transparente, #007AFF text
Card padrão:      branco, border 1px #E5E7EB, radius 12-16px, shadow leve
Card premium:     gradiente #007AFF → #0051D5, texto branco
Touch target:     44×44px mínimo (HIG)
Input número:     máximo 7 dígitos
```

---

*Próxima parte → PARTE 02: Modelo de Dados & Entidades*
