import '../../domain/entities/alocacao_talhao_entity.dart';
import '../../domain/entities/escopo_alocacao_entity.dart';
import '../../domain/repositories/alocacao_repository.dart';
import '../datasources/alocacao_local_datasource.dart';

class AlocacaoRepositoryImpl implements AlocacaoRepository {
  AlocacaoRepositoryImpl(this._datasource);

  final AlocacaoLocalDatasource _datasource;

  @override
  Future<void> salvarRateio({
    required EscopoAlocacaoEntity escopo,
    required List<AlocacaoTalhaoEntity> lancamentos,
  }) =>
      _datasource.salvarRateio(escopo: escopo, lancamentos: lancamentos);

  @override
  Future<List<AlocacaoTalhaoEntity>> listarPorProdutoAplicacao(
    String produtoAplicacaoId,
  ) =>
      _datasource.listarPorProdutoAplicacao(produtoAplicacaoId);

  @override
  Future<List<AlocacaoTalhaoEntity>> listarPorTalhao(String talhaoId) =>
      _datasource.listarPorTalhao(talhaoId);
}
