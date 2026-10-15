import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/di/providers.dart';
import '../widgets/categoria_bottom_sheet.dart';
import '../widgets/referencia_display_mapper.dart';

part 'estadio_referencias_content_provider.g.dart';

/// Mapa categoria → há referências técnicas para o estádio informado.
@riverpod
Future<Map<CategoriaReferencia, bool>> estadioReferenciasContentMap(
  EstadioReferenciasContentMapRef ref,
  String estadioCodigo,
) async {
  await ref.read(referencesRepoProvider).seedIfEmpty();
  final repo = ref.read(referencesRepoProvider);
  final map = <CategoriaReferencia, bool>{};

  for (final categoria in CategoriaReferencia.values) {
    if (categoria == CategoriaReferencia.cesb) {
      final items = await repo.getCesb(estadio: estadioCodigo);
      map[categoria] = items.isNotEmpty;
    } else {
      final items = await repo.getByEstadio(categoria.name, estadioCodigo);
      map[categoria] = items.isNotEmpty;
    }
  }

  return map;
}

/// Itens de referência formatados para exibição no bottom sheet.
@riverpod
Future<List<ReferenciaDisplayItem>> referenciasDisplayByCategoria(
  ReferenciasDisplayByCategoriaRef ref, {
  required CategoriaReferencia categoria,
  required String estadioCodigo,
}) async {
  await ref.read(referencesRepoProvider).seedIfEmpty();
  final repo = ref.read(referencesRepoProvider);

  final entities = categoria == CategoriaReferencia.cesb
      ? await repo.getCesb(estadio: estadioCodigo)
      : await repo.getByEstadio(categoria.name, estadioCodigo);

  return entities.map(ReferenciaDisplayMapper.fromEntity).toList();
}
