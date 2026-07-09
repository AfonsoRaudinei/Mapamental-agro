import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import '../widgets/app_shell.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/recover_password_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/plans/presentation/pages/plans_list_page.dart';
import '../../features/plans/presentation/pages/plan_create_page.dart';
import '../../features/plans/presentation/pages/plan_canvas_page.dart';
import '../../features/clients/presentation/pages/clients_list_page.dart';
import '../../features/clients/presentation/pages/client_detail_page.dart';
import '../../features/clients/presentation/pages/client_form_page.dart';
import '../../features/clients/presentation/pages/farm_form_page.dart';
import '../../features/clients/presentation/pages/talhao_form_page.dart';
import '../../features/catalog/presentation/pages/catalog_list_page.dart';
import '../../features/catalog/presentation/pages/produto_form_page.dart';
import '../../features/references/presentation/pages/circular_fungicidas_page.dart';
import '../../features/references/presentation/pages/references_home_page.dart';
import '../../features/references/presentation/pages/categoria_detail_page.dart';
import '../../features/references/presentation/pages/cesb_detail_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/profile_edit_page.dart';
import '../../features/settings/presentation/pages/appearance_page.dart';
import '../../features/settings/presentation/pages/settings_data_page.dart';
import '../../features/settings/presentation/pages/feedback_page.dart';
import '../../features/settings/presentation/pages/legal_page.dart';
import '../../features/settings/presentation/pages/about_page.dart';
import '../../features/consolidation/presentation/pages/consolidacao_page.dart';
import '../../features/auth/domain/entities/user_entity.dart';

String? authRedirect({
  required AsyncValue<UserEntity?> auth,
  required String location,
}) {
  if (auth.isLoading) {
    // Login e cadastro também usam AsyncLoading. Mantê-los na rota atual evita
    // que uma operação em andamento seja confundida com restauração da sessão.
    if (location.startsWith('/auth')) return null;
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final isLoggedIn = auth.valueOrNull != null;
  final isPublic = location == AppRoutes.splash ||
      location == AppRoutes.onboarding ||
      location.startsWith('/auth');

  if (!isLoggedIn && !isPublic) return AppRoutes.login;
  if (isLoggedIn &&
      (location == AppRoutes.splash ||
          location == AppRoutes.onboarding ||
          location.startsWith('/auth'))) {
    return AppRoutes.plans;
  }
  return null;
}

/// Provider do GoRouter com guard de autenticação (Sprint 1).
final appRouterProvider = Provider<GoRouter>((ref) {
  final authRefresh = _AuthRouterRefresh();
  ref.onDispose(authRefresh.dispose);
  ref.listen(authNotifierProvider, (_, __) => authRefresh.refresh());

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    refreshListenable: authRefresh,

    // ── Guard de autenticação ─────────────────────────────────────────────
    redirect: (context, state) {
      final authAsync = ref.read(authNotifierProvider);
      final loc = state.matchedLocation;

      return authRedirect(auth: authAsync, location: loc);
    },

    routes: [
      // ── AUTH (sem shell / sem tab bar) ────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth',
        redirect: (_, __) => AppRoutes.login,
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'recover',
            builder: (context, state) => const RecoverPasswordPage(),
          ),
        ],
      ),

      // ── SHELL — 5 tabs ────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          // ── Tab: Planos ───────────────────────────────────────────────────
          GoRoute(
            path: AppRoutes.plans,
            builder: (context, state) => const PlansListPage(),
          ),
          GoRoute(
            path: AppRoutes.planNew,
            builder: (context, state) => const PlanCreatePage(),
          ),
          GoRoute(
            path: '/plans/:id',
            builder: (context, state) => PlanCanvasPage(
              planoId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: '/plans/:id/consolidacao',
            builder: (context, state) => ConsolidacaoPage(
              planoId: state.pathParameters['id']!,
            ),
          ),

          // ── Tab: Clientes ─────────────────────────────────────────────────
          GoRoute(
            path: AppRoutes.clients,
            builder: (context, state) => const ClientsListPage(),
          ),
          GoRoute(
            path: '/clients/new',
            builder: (context, state) => const ClientFormPage(),
          ),
          GoRoute(
            path: '/clients/:id',
            builder: (context, state) => ClientDetailPage(
              clienteId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: '/clients/:id/edit',
            builder: (context, state) => ClientFormPage(
              clienteId: state.pathParameters['id'],
            ),
          ),
          GoRoute(
            path: '/clients/:clienteId/farms/new',
            builder: (context, state) => FarmFormPage(
              clienteId: state.pathParameters['clienteId']!,
            ),
          ),
          GoRoute(
            path: '/clients/:clienteId/farms/:farmId/edit',
            builder: (context, state) => FarmFormPage(
              clienteId: state.pathParameters['clienteId']!,
              fazendaId: state.pathParameters['farmId'],
            ),
          ),
          GoRoute(
            path: '/clients/:clienteId/farms/:farmId/talhoes/new',
            builder: (context, state) => TalhaoFormPage(
              fazendaId: state.pathParameters['farmId']!,
            ),
          ),

          // ── Tab: Catálogo ─────────────────────────────────────────────────
          GoRoute(
            path: AppRoutes.catalog,
            builder: (context, state) => const CatalogListPage(),
          ),
          GoRoute(
            path: '/catalog/new',
            builder: (context, state) => const ProdutoFormPage(),
          ),
          GoRoute(
            path: '/catalog/:id/edit',
            builder: (context, state) => ProdutoFormPage(
              produtoId: state.pathParameters['id'],
            ),
          ),

          // ── Tab: Referências ──────────────────────────────────────────────
          GoRoute(
            path: AppRoutes.references,
            builder: (context, state) => const ReferencesHomePage(),
          ),
          GoRoute(
            path: '/references/cesb',
            builder: (context, state) => const CesbDetailPage(),
          ),
          GoRoute(
            path: AppRoutes.circularFungicidas,
            builder: (context, state) => const CircularFungicidasPage(),
          ),
          GoRoute(
            path: '/references/:categoria',
            builder: (context, state) => CategoriaDetailPage(
              categoriaKey: state.pathParameters['categoria']!,
            ),
          ),

          // ── Tab: Configurações ────────────────────────────────────────────
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/settings/profile',
            builder: (context, state) => const ProfileEditPage(),
          ),
          GoRoute(
            path: '/settings/appearance',
            builder: (context, state) => const AppearancePage(),
          ),
          GoRoute(
            path: AppRoutes.dataPage,
            builder: (context, state) => const SettingsDataPage(),
          ),
          GoRoute(
            path: AppRoutes.feedback,
            builder: (context, state) => const FeedbackPage(),
          ),
          GoRoute(
            path: AppRoutes.privacy,
            builder: (context, state) =>
                const LegalPage(document: LegalDocument.privacy),
          ),
          GoRoute(
            path: AppRoutes.terms,
            builder: (context, state) =>
                const LegalPage(document: LegalDocument.terms),
          ),
          GoRoute(
            path: AppRoutes.about,
            builder: (context, state) => const AboutPage(),
          ),
        ],
      ),
    ],
  );

  return router;
});

class _AuthRouterRefresh extends ChangeNotifier {
  void refresh() => notifyListeners();
}
