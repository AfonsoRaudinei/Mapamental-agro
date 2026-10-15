import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/cliente_entity.dart';
import '../../domain/entities/fazenda_entity.dart';
import '../../domain/entities/talhao_entity.dart';

part 'clients_provider.g.dart';

// ── Lista de Clientes ─────────────────────────────────────────────────────────

@riverpod
class ClientsNotifier extends _$ClientsNotifier {
  @override
  FutureOr<List<ClienteEntity>> build() =>
      ref.read(clientsRepoProvider).getAll();

  Future<void> createCliente(ClienteEntity c) async {
    await ref.read(clientsRepoProvider).create(c);
    ref.invalidateSelf();
  }

  Future<void> updateCliente(ClienteEntity c) async {
    await ref.read(clientsRepoProvider).update(c);
    ref.invalidateSelf();
  }

  Future<void> deleteCliente(String id) async {
    await ref.read(clientsRepoProvider).delete(id);
    ref.invalidateSelf();
  }
}

// ── Detalhe do Cliente (com fazendas) ─────────────────────────────────────────

@riverpod
Future<ClienteEntity?> clienteDetail(ClienteDetailRef ref, String clienteId) =>
    ref.read(clientsRepoProvider).getById(clienteId);

// ── Fazendas de um Cliente ────────────────────────────────────────────────────

@riverpod
class FazendasNotifier extends _$FazendasNotifier {
  @override
  FutureOr<List<FazendaEntity>> build(String clienteId) =>
      ref.read(clientsRepoProvider).getFazendas(clienteId);

  Future<void> createFazenda(FazendaEntity f) async {
    await ref.read(clientsRepoProvider).createFazenda(f);
    ref.invalidateSelf();
  }

  Future<void> updateFazenda(FazendaEntity f) async {
    await ref.read(clientsRepoProvider).updateFazenda(f);
    ref.invalidateSelf();
  }

  Future<void> deleteFazenda(String id) async {
    await ref.read(clientsRepoProvider).deleteFazenda(id);
    ref.invalidateSelf();
  }
}

// ── Talhões de uma Fazenda ────────────────────────────────────────────────────

@riverpod
class TalhoesNotifier extends _$TalhoesNotifier {
  @override
  FutureOr<List<TalhaoEntity>> build(String fazendaId) =>
      ref.read(clientsRepoProvider).getTalhoes(fazendaId);

  Future<TalhaoEntity> createTalhao(TalhaoEntity t) async {
    final created = await ref.read(clientsRepoProvider).createTalhao(t);
    ref.invalidateSelf();
    return created;
  }

  Future<void> updateTalhao(TalhaoEntity t) async {
    await ref.read(clientsRepoProvider).updateTalhao(t);
    ref.invalidateSelf();
  }

  Future<void> deleteTalhao(String id) async {
    await ref.read(clientsRepoProvider).deleteTalhao(id);
    ref.invalidateSelf();
  }
}
