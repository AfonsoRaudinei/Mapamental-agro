/// Normaliza nome de cultura para exibição e armazenamento.
String normalizeCulturaLabel(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return trimmed;

  final lower = trimmed.toLowerCase();
  const fixes = <String, String>{
    'cana-de-açúcar': 'Cana-de-açúcar',
    'cana': 'Cana-de-açúcar',
    'cana-de-acucar': 'Cana-de-açúcar',
    'soja ogm': 'Soja OGM',
    'milho ogm': 'Milho OGM',
    'algodão ogm': 'Algodão OGM',
    'feijão-caupi': 'Feijão-caupi',
    'batata-doce': 'Batata-doce',
    'batata yacon': 'Batata yacon',
    'mandioquinha-salsa': 'Mandioquinha-salsa',
    'grão-de-bico': 'Grão-de-bico',
    'noz-pecã': 'Noz-pecã',
    'castanha-do-pará': 'Castanha-do-pará',
    'arroz irrigado': 'Arroz irrigado',
    'pastagens': 'Pastagem',
    'pastagem': 'Pastagem',
    'feijões': 'Feijão',
    'feijão': 'Feijão',
  };
  if (fixes.containsKey(lower)) return fixes[lower]!;

  return trimmed
      .split(RegExp(r'(\s+|-)'))
      .map((part) {
        if (part == '-' || part.trim().isEmpty) return part;
        final p = part.toLowerCase();
        if (p.length == 1) return p;
        return p[0].toUpperCase() + p.substring(1);
      })
      .join();
}

List<String> parseCulturasTexto(String? texto) {
  if (texto == null || texto.trim().isEmpty) return const [];
  final out = <String>{};

  for (final segment in texto.split(';')) {
    var part = segment.trim();
    final colon = part.indexOf(':');
    if (colon >= 0) {
      part = part.substring(colon + 1).trim();
    }
    final amplo = RegExp(r'amplo espectro[^\(]*\(([^)]+)\)', caseSensitive: false)
        .firstMatch(part);
    if (amplo != null) {
      part = amplo.group(1)!;
    } else {
      part = part.replaceAll(RegExp(r'\([^)]*\)'), ' ');
    }
    for (final raw in part.split(',')) {
      final cleaned = raw.trim();
      if (cleaned.isEmpty) continue;
      if (cleaned.toLowerCase().startsWith('entre')) continue;
      if (cleaned.toLowerCase().contains('manejo')) continue;
      final n = normalizeCulturaLabel(cleaned);
      if (n.isNotEmpty) out.add(n);
    }
  }
  return out.toList();
}
