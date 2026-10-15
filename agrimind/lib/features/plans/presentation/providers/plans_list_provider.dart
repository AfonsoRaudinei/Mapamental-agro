import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/plano_entity.dart';
import '../../../../core/di/providers.dart';

part 'plans_list_provider.g.dart';

/// Provider da lista de planos do usuário.
@riverpod
class PlansListNotifier extends _$PlansListNotifier {
  @override
  FutureOr<List<PlanoEntity>> build() async {
    return ref.read(plansRepoProvider).getAll();
  }

  /// Invalida e recarrega a lista.
  Future<void> refresh() async => ref.invalidateSelf();
}
