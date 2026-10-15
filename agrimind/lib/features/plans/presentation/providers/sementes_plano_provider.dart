import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/semente_talhao_entity.dart';

part 'sementes_plano_provider.g.dart';

@riverpod
class SementesPlanoNotifier extends _$SementesPlanoNotifier {
  @override
  FutureOr<List<SementeTalhaoEntity>> build(String planoId) async {
    return ref.read(plansRepoProvider).getSementesByPlano(planoId);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
