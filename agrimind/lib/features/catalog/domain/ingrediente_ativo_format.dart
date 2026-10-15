/// Formato de múltiplos ingredientes ativos no catálogo (ex.: "A + B").
final RegExp _ingredienteAtivoSeparator = RegExp(r'\s+\+\s+');

List<String> parseIngredientesAtivos(String? raw) {
  if (raw == null || raw.trim().isEmpty) {
    return const [];
  }
  return raw
      .split(_ingredienteAtivoSeparator)
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
}

String? joinIngredientesAtivos(List<String> parts) {
  final trimmed =
      parts.map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  if (trimmed.isEmpty) return null;
  return trimmed.join(' + ');
}
