import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../models/stage_view_model.dart';
import '../models/stage_view_model_mapper.dart';
import 'plano_detail_provider.dart';
import 'stage_view_model_key.dart';

/// ViewModel de um estádio derivado do plano (fonte: [planoDetailProvider]).
final stageProvider =
    Provider.autoDispose.family<StageViewModel, StageViewModelKey>((ref, key) {
  final estadio = ref.watch(
    planoDetailProvider(key.planoId).select(_selectEstadio(key.stageId)),
  );
  if (estadio == null) {
    throw StateError('Estádio ${key.stageId} não encontrado no plano.');
  }
  return StageViewModelMapper.fromEntity(estadio);
});

EstadioEntity? Function(AsyncValue<PlanoEntity> async) _selectEstadio(
  String stageId,
) {
  return (async) {
    return async.when(
      data: (plano) {
        for (final estadio in plano.estadios) {
          if (estadio.id == stageId) return estadio;
        }
        return null;
      },
      loading: () => null,
      error: (_, __) => null,
    );
  };
}
