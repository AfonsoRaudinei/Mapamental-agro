import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../data/datasources/alocacao_local_datasource.dart';
import '../../data/repositories/alocacao_repository_impl.dart';
import '../../domain/repositories/alocacao_repository.dart';
import '../../domain/usecases/calcular_total_produto_talhao_usecase.dart';
import '../../domain/usecases/ratear_produto_por_talhao_usecase.dart';

final alocacaoDatasourceProvider = Provider<AlocacaoLocalDatasource>(
  (ref) => AlocacaoLocalDatasource(ref.read(databaseProvider)),
);

final alocacaoRepoProvider = Provider<AlocacaoRepository>(
  (ref) => AlocacaoRepositoryImpl(ref.read(alocacaoDatasourceProvider)),
);

final ratearProdutoPorTalhaoUseCaseProvider =
    Provider<RatearProdutoPorTalhaoUseCase>(
  (ref) => const RatearProdutoPorTalhaoUseCase(),
);

final calcularTotalProdutoTalhaoUseCaseProvider =
    Provider<CalcularTotalProdutoTalhaoUseCase>(
  (ref) => const CalcularTotalProdutoTalhaoUseCase(),
);
