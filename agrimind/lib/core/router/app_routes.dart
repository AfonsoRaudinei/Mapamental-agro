/// Constantes de rotas do AgriMind (go_router).
class AppRoutes {
  AppRoutes._();

  // ── AUTH ──────────────────────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String recover = '/auth/recover';

  // ── PLANS ─────────────────────────────────────────────────────────────────
  static const String plans = '/plans';
  static const String planNew = '/plans/new';
  static const String planCanvas = '/plans/:id';
  static const String consolidacao = '/plans/:id/consolidacao';

  // ── CLIENTS ───────────────────────────────────────────────────────────────
  static const String clients = '/clients';
  static const String clientDetail = '/clients/:id';
  static const String clientForm = '/clients/new';
  static const String clientEdit = '/clients/:id/edit';
  static const String farmForm = '/clients/:clienteId/farms/new';
  static const String farmEdit = '/clients/:clienteId/farms/:farmId/edit';
  static const String talhaoForm =
      '/clients/:clienteId/farms/:farmId/talhoes/new';

  // ── CATALOG ───────────────────────────────────────────────────────────────
  static const String catalog = '/catalog';
  static const String produtoForm = '/catalog/new';
  static const String produtoEdit = '/catalog/:id/edit';

  // ── REFERENCES ────────────────────────────────────────────────────────────
  static const String references = '/references';
  static const String circularFungicidas = '/references/circular-fungicidas';
  static const String categoriaDetail = '/references/:categoria';
  static const String cesbDetail = '/references/cesb';

  // ── SETTINGS ──────────────────────────────────────────────────────────────
  static const String settings = '/settings';
  static const String profileEdit = '/settings/profile';
  static const String appearance = '/settings/appearance';
  static const String dataPage = '/settings/data';
  static const String feedback = '/settings/feedback';
  static const String privacy = '/settings/privacy';
  static const String terms = '/settings/terms';
  static const String about = '/settings/about';

  // ── HELPERS ───────────────────────────────────────────────────────────────
  static String planCanvasPath(String id) => '/plans/$id';
  static String consolidacaoPath(String id) => '/plans/$id/consolidacao';
  static String clientDetailPath(String id) => '/clients/$id';
  static String clientEditPath(String id) => '/clients/$id/edit';
  static String farmFormPath(String clienteId) =>
      '/clients/$clienteId/farms/new';
  static String farmEditPath(String clienteId, String farmId) =>
      '/clients/$clienteId/farms/$farmId/edit';
  static String talhaoFormPath(String clienteId, String farmId) =>
      '/clients/$clienteId/farms/$farmId/talhoes/new';
  static String produtoEditPath(String id) => '/catalog/$id/edit';
  static String categoriaDetailPath(String categoria) =>
      '/references/$categoria';
}
