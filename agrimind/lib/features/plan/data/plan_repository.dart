import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/plan_models.dart';

final planRepositoryProvider = Provider<PlanRepository>((ref) {
  return PlanRepository(ref.watch(databaseProvider));
});

class PlanRepository {
  PlanRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<ClientModel>> getClients() => _db.getClients();

  Future<PlanState> loadPlan(String clientId) async {
    var plan = await _db.getPlanForClient(clientId);
    if (plan == null) {
      plan = PlanModel(id: _uuid.v4(), clientId: clientId);
      await _db.upsertPlan(plan);
    }
    final stages = await _db.getStages(plan.id);
    final productsByStage = <String, List<ProductModel>>{};
    for (final stage in stages) {
      productsByStage[stage.id] = await _db.getProducts(stage.id);
    }
    return PlanState(
      plan: plan,
      stages: stages,
      productsByStage: productsByStage,
    );
  }

  Future<void> updateStageName(StageModel stage, String name) async {
    await _db.upsertStage(stage.copyWith(name: name));
  }

  Future<StageModel> addStage(String planId, String code, String name) async {
    final existing = await _db.getStages(planId);
    final stage = StageModel(
      id: _uuid.v4(),
      planId: planId,
      code: code,
      name: name,
      sortOrder: existing.length,
    );
    await _db.upsertStage(stage);
    return stage;
  }

  Future<void> removeStage(String stageId) => _db.deleteStage(stageId);

  Future<ProductModel> addProduct(String stageId, String name) async {
    final product = ProductModel(id: _uuid.v4(), stageId: stageId, name: name);
    await _db.upsertProduct(product);
    return product;
  }

  Future<void> removeProduct(String productId) => _db.deleteProduct(productId);
}

class PlanState {
  const PlanState({
    required this.plan,
    required this.stages,
    required this.productsByStage,
  });

  final PlanModel plan;
  final List<StageModel> stages;
  final Map<String, List<ProductModel>> productsByStage;

  PlanState copyWith({
    List<StageModel>? stages,
    Map<String, List<ProductModel>>? productsByStage,
  }) =>
      PlanState(
        plan: plan,
        stages: stages ?? this.stages,
        productsByStage: productsByStage ?? this.productsByStage,
      );
}

final selectedClientProvider = StateProvider<ClientModel?>((ref) => null);

final planStateProvider =
    AsyncNotifierProvider<PlanNotifier, PlanState>(PlanNotifier.new);

class PlanNotifier extends AsyncNotifier<PlanState> {
  @override
  Future<PlanState> build() async {
    final client = ref.watch(selectedClientProvider);
    if (client == null) {
      final clients = await ref.read(planRepositoryProvider).getClients();
      if (clients.isEmpty) {
        throw StateError('Nenhum cliente cadastrado');
      }
      ref.read(selectedClientProvider.notifier).state = clients.first;
      return ref.read(planRepositoryProvider).loadPlan(clients.first.id);
    }
    return ref.read(planRepositoryProvider).loadPlan(client.id);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(selectedClientProvider);
      if (client == null) throw StateError('Cliente não selecionado');
      return ref.read(planRepositoryProvider).loadPlan(client.id);
    });
  }

  Future<void> renameStage(StageModel stage, String name) async {
    await ref.read(planRepositoryProvider).updateStageName(stage, name);
    await refresh();
  }

  Future<void> addStage(String code, String name) async {
    final current = state.value;
    if (current == null) return;
    await ref
        .read(planRepositoryProvider)
        .addStage(current.plan.id, code, name);
    await refresh();
  }

  Future<void> removeStage(String stageId) async {
    await ref.read(planRepositoryProvider).removeStage(stageId);
    await refresh();
  }

  Future<void> addProduct(String stageId, String name) async {
    await ref.read(planRepositoryProvider).addProduct(stageId, name);
    await refresh();
  }

  void toggleExpanded(String stageId) {
    final current = state.value;
    if (current == null) return;
    final stages = current.stages
        .map(
          (s) => s.id == stageId ? s.copyWith(isExpanded: !s.isExpanded) : s,
        )
        .toList();
    state = AsyncData(current.copyWith(stages: stages));
  }
}
