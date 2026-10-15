import '../entities/plano_entity.dart';
import '../repositories/plans_repository.dart';

/// Plano não consolidado mais recente vinculado à fazenda.
class ResolverPlanoAtivoFazendaUseCase {
  const ResolverPlanoAtivoFazendaUseCase(this._plansRepository);

  final PlansRepository _plansRepository;

  Future<PlanoEntity?> call(String fazendaId) async {
    final planos = await _plansRepository.getAll();
    final candidatos = planos
        .where((p) => p.fazendaId == fazendaId && p.status != 'consolidado')
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return candidatos.isEmpty ? null : candidatos.first;
  }
}
