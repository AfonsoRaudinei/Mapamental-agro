import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/plano_entity.dart';
import '../../../../core/di/providers.dart';

part 'plano_detail_provider.g.dart';

/// Provider do detalhe de um Plano (inclui estádios + produtos).
/// Family: recebe o planoId como parâmetro.
@riverpod
Future<PlanoEntity> planoDetail(
  PlanoDetailRef ref,
  String planoId,
) async {
  final plano = await ref.read(plansRepoProvider).getById(planoId);
  if (plano == null) throw StateError('Plano $planoId não encontrado.');
  return plano;
}
