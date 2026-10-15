import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/referencia_tecnica_entity.dart';

part 'references_provider.g.dart';

// ── Referências por categoria + estádio ───────────────────────────────────────

@riverpod
Future<List<ReferenciaTecnicaEntity>> referenciasByEstadio(
  ReferenciasByEstadioRef ref, {
  required String categoria,
  required String estadio,
}) async {
  await ref.read(referencesRepoProvider).seedIfEmpty();
  return ref.read(referencesRepoProvider).getByEstadio(categoria, estadio);
}

// ── Todas referências de uma categoria ────────────────────────────────────────

@riverpod
Future<List<ReferenciaTecnicaEntity>> referenciasByCategoria(
  ReferenciasByCategoriaRef ref,
  String categoria,
) async {
  await ref.read(referencesRepoProvider).seedIfEmpty();
  return ref.read(referencesRepoProvider).getByCategoria(categoria);
}

// ── CESB ──────────────────────────────────────────────────────────────────────

@riverpod
Future<List<ReferenciaTecnicaEntity>> cesbReferencias(
  CesbReferenciasRef ref, {
  String? estadio,
}) async {
  await ref.read(referencesRepoProvider).seedIfEmpty();
  return ref.read(referencesRepoProvider).getCesb(estadio: estadio);
}
