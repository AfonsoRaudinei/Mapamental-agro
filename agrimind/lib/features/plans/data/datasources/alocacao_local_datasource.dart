import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/entities/alocacao_talhao_entity.dart';
import '../../domain/entities/escopo_alocacao_entity.dart';
import '../../domain/entities/tipo_escopo_alocacao.dart';

class AlocacaoLocalDatasource {
  AlocacaoLocalDatasource(this._database, {String? userId})
      : _scope = LocalUserScope(userId);

  final AppDatabase _database;
  final LocalUserScope _scope;
  final _uuid = const Uuid();

  Future<void> salvarRateio({
    required EscopoAlocacaoEntity escopo,
    required List<AlocacaoTalhaoEntity> lancamentos,
  }) async {
    final userId = _scope.userId;
    await _database.transaction(() async {
      await _database.into(_database.escoposAlocacao).insert(
            EscoposAlocacaoCompanion.insert(
              uid: escopo.id,
              userId: Value(userId),
              produtoAplicacaoId: escopo.produtoAplicacaoId,
              tipo: escopo.tipo.toStorage(),
              talhoesIdsJson: jsonEncode(escopo.talhoesIds),
              quantidadeTotal: escopo.quantidadeTotal,
              dataCriacao: escopo.dataCriacao,
            ),
          );

      for (final row in lancamentos) {
        await _database.into(_database.alocacoesTalhao).insert(
              AlocacoesTalhaoCompanion.insert(
                uid: row.id.isEmpty ? _uuid.v4() : row.id,
                userId: Value(userId),
                produtoAplicacaoId: row.produtoAplicacaoId,
                talhaoId: row.talhaoId,
                quantidadeAlocada: row.quantidadeAlocada,
                origemEscopoId: row.origemEscopoId,
                dataLancamento: row.dataLancamento,
                foiAjustadoManualmente: Value(row.foiAjustadoManualmente),
              ),
            );
      }
    });
  }

  Future<List<AlocacaoTalhaoEntity>> listarPorProdutoAplicacao(
    String produtoAplicacaoId,
  ) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.alocacoesTalhao)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.produtoAplicacaoId.equals(produtoAplicacaoId) &
                t.deletedAt.isNull(),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.dataLancamento)]))
        .get();
    return rows.map(_alocacaoToEntity).toList();
  }

  Future<List<AlocacaoTalhaoEntity>> listarPorTalhao(String talhaoId) async {
    final userId = _scope.userId;
    final rows = await (_database.select(_database.alocacoesTalhao)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.talhaoId.equals(talhaoId) &
                t.deletedAt.isNull(),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.dataLancamento)]))
        .get();
    return rows.map(_alocacaoToEntity).toList();
  }

  AlocacaoTalhaoEntity _alocacaoToEntity(AlocacoesTalhaoData row) =>
      AlocacaoTalhaoEntity(
        id: row.uid,
        produtoAplicacaoId: row.produtoAplicacaoId,
        talhaoId: row.talhaoId,
        quantidadeAlocada: row.quantidadeAlocada,
        origemEscopoId: row.origemEscopoId,
        dataLancamento: row.dataLancamento,
        foiAjustadoManualmente: row.foiAjustadoManualmente,
      );
}
