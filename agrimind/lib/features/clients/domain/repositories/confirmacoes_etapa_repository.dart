import '../talhao_etapas/confirmacao_etapa.dart';

/// Confirmações manuais de aplicações do cronograma, por talhão.
abstract class ConfirmacoesEtapaRepository {
  Future<List<ConfirmacaoEtapa>> listar(String talhaoId);

  /// Grava (ou substitui) a confirmação da etapa.
  Future<void> salvar(ConfirmacaoEtapa confirmacao);

  /// Desfaz a confirmação (a etapa volta a pendente).
  Future<void> remover(String talhaoId, String chaveEtapa);
}
