import '../entities/semente_talhao_entity.dart';

/// Cultivar(es) vinculada(s) ao talhão via FK em [SementeTalhaoEntity.talhaoId].
class ResolverCultivarTalhaoPlanoUseCase {
  const ResolverCultivarTalhaoPlanoUseCase();

  /// Retorna cultivares distintas para o talhão no plano.
  List<String> call({
    required String talhaoId,
    required List<SementeTalhaoEntity> sementes,
  }) {
    final nomes = <String>{};
    for (final s in sementes) {
      if (s.talhaoId != talhaoId) continue;
      final c = s.cultivar.trim();
      if (c.isNotEmpty) nomes.add(c);
    }
    final list = nomes.toList();
    list.sort();
    return list;
  }

  /// Mantém a cultivar salva se ainda existir no talhão; senão usa a primeira opção.
  String escolherCultivar({
    required String talhaoId,
    required List<SementeTalhaoEntity> sementes,
    required String? cultivarSalva,
  }) {
    final opcoes = call(talhaoId: talhaoId, sementes: sementes);
    if (opcoes.isEmpty) return cultivarSalva?.trim() ?? '';
    final salva = cultivarSalva?.trim() ?? '';
    if (salva.isNotEmpty && opcoes.contains(salva)) return salva;
    return opcoes.first;
  }

  String? cultivarPrincipal({
    required String talhaoId,
    required List<SementeTalhaoEntity> sementes,
  }) {
    final list = call(talhaoId: talhaoId, sementes: sementes);
    return list.isEmpty ? null : list.first;
  }
}
