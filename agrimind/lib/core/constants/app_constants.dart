/// Constantes globais do app AgriMind.
class AppConstants {
  AppConstants._();

  // ── PUBLICAÇÃO / SUPORTE ──────────────────────────────────────────────────
  static const String appName = 'AgriMind';
  static const String appVersion = '1.0.0';
  static const String supportEmail = 'suporte@cultivamind.com';
  static const String privacyPolicyUrl = 'https://cultivamind.com/privacidade';
  static const String termsUrl = 'https://cultivamind.com/termos';

  // ── LIMITES DE ENTRADA ────────────────────────────────────────────────────
  /// Máximo de dígitos em campos numéricos (Apple HIG)
  static const int maxDigitosNumerico = 7;

  /// Touch target mínimo (Apple HIG)
  static const double minTouchTarget = 44.0;

  // ── ANIMAÇÕES ─────────────────────────────────────────────────────────────
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 250);
  static const Duration animSlow = Duration(milliseconds: 400);

  // ── ESTÁDIOS FENOLÓGICOS ──────────────────────────────────────────────────
  static const List<String> estadiosCodigos = [
    'Operacional',
    'VE',
    'VC',
    'V1',
    'V2',
    'V3',
    'V4',
    'V5',
    'V6',
    'V7',
    'R1',
    'R2',
    'R3',
    'R4',
    'R5.1',
    'R5.3',
    'R5.5',
    'R6',
    'R7',
    'R8',
  ];

  static const Map<String, String> estadioLabels = {
    'Operacional': 'Operacional',
    'VE': 'VE — Emergência',
    'VC': 'VC — Cotilédone',
    'V1': 'V1 — 1º Nó',
    'V2': 'V2 — 2º Nó',
    'V3': 'V3 — 3º Nó',
    'V4': 'V4 — 4º Nó',
    'V5': 'V5 — 5º Nó',
    'V6': 'V6 — 6º Nó',
    'V7': 'V7 — 7º Nó',
    'R1': 'R1 — Início do Florescimento',
    'R2': 'R2 — Florescimento Pleno',
    'R3': 'R3 — Início de Vagem',
    'R4': 'R4 — Vagem Cheia',
    'R5.1': 'R5.1 — Início do Enchimento',
    'R5.3': 'R5.3 — Enchimento Médio',
    'R5.5': 'R5.5 — Enchimento Avançado',
    'R6': 'R6 — Grão Cheio',
    'R7': 'R7 — Início da Maturação',
    'R8': 'R8 — Maturação Plena',
  };

  // ── CULTURAS ──────────────────────────────────────────────────────────────
  static const List<String> culturas = [
    'Soja',
    'Milho',
    'Café',
    'Algodão',
    'Trigo',
    'Cana-de-açúcar',
    'Arroz',
    'Feijão',
    'Sorgo',
    'Girassol',
  ];

  // ── CATEGORIAS DE PRODUTOS ────────────────────────────────────────────────
  static const List<String> categoriasProduto = [
    'Fungicida',
    'Inseticida',
    'Herbicida',
    'Fertilizante',
    'Bioestimulante',
    'Adjuvante',
  ];

  // ── UNIDADES DE DOSE ──────────────────────────────────────────────────────
  static const List<String> unidadesDose = [
    'L/ha',
    'mL/ha',
    'kg/ha',
    'g/ha',
    'unid/ha',
  ];

  // ── STATUS DE PLANO ───────────────────────────────────────────────────────
  static const String statusRascunho = 'rascunho';
  static const String statusAtivo = 'ativo';
  static const String statusConsolidado = 'consolidado';

  // ── APP ICONS ─────────────────────────────────────────────────────────────
  static const String iconPrincipal = 'principal';
  static const String iconClassico = 'classico';

  // ── ESTADOS BRASILEIROS (UF) ──────────────────────────────────────────────
  static const List<String> estadosBrasileiros = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
  ];

  static const Map<String, String> estadosNomes = {
    'AC': 'Acre',
    'AL': 'Alagoas',
    'AP': 'Amapá',
    'AM': 'Amazonas',
    'BA': 'Bahia',
    'CE': 'Ceará',
    'DF': 'Distrito Federal',
    'ES': 'Espírito Santo',
    'GO': 'Goiás',
    'MA': 'Maranhão',
    'MT': 'Mato Grosso',
    'MS': 'Mato Grosso do Sul',
    'MG': 'Minas Gerais',
    'PA': 'Pará',
    'PB': 'Paraíba',
    'PR': 'Paraná',
    'PE': 'Pernambuco',
    'PI': 'Piauí',
    'RJ': 'Rio de Janeiro',
    'RN': 'Rio Grande do Norte',
    'RS': 'Rio Grande do Sul',
    'RO': 'Rondônia',
    'RR': 'Roraima',
    'SC': 'Santa Catarina',
    'SP': 'São Paulo',
    'SE': 'Sergipe',
    'TO': 'Tocantins',
  };
}
