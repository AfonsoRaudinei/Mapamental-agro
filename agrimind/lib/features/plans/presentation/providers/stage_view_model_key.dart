/// Chave do provider de estádio no canvas (plano + estádio).
class StageViewModelKey {
  const StageViewModelKey({required this.planoId, required this.stageId});

  final String planoId;
  final String stageId;

  @override
  bool operator ==(Object other) {
    return other is StageViewModelKey &&
        other.planoId == planoId &&
        other.stageId == stageId;
  }

  @override
  int get hashCode => Object.hash(planoId, stageId);
}
