import 'dart:convert';

/// Persistência de IDs em [TalhoesSafra.programaOperacionalIds] (JSON array).
const String kProgramaOperacionalIdsVazio = '[]';

List<String> decodeProgramaOperacionalIds(String? raw) {
  if (raw == null || raw.trim().isEmpty) return const [];
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded
        .map((e) => e.toString())
        .where((id) => id.isNotEmpty)
        .toList(growable: false);
  } catch (_) {
    return const [];
  }
}

String encodeProgramaOperacionalIds(List<String> ids) {
  final unicos = <String>{};
  for (final id in ids) {
    if (id.isNotEmpty) unicos.add(id);
  }
  return jsonEncode(unicos.toList());
}

List<String> mesclarProgramaOperacionalIds(
  List<String> existentes,
  List<String> novos,
) {
  return {...existentes, ...novos}.where((id) => id.isNotEmpty).toList();
}
