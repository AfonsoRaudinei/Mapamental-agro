import 'dart:convert';

List<String> decodeCulturas(String? raw) {
  if (raw == null || raw.trim().isEmpty) return const [];
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded
        .whereType<String>()
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  } catch (_) {
    return const [];
  }
}

String? encodeCulturas(List<String> culturas) {
  final trimmed =
      culturas.map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
  if (trimmed.isEmpty) return null;
  return jsonEncode(trimmed);
}
