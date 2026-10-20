import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/repositories/confirmacoes_etapa_repository.dart';
import '../../domain/talhao_etapas/confirmacao_etapa.dart';

/// Confirmações de aplicação no SQLite local.
///
/// Tabela própria, criada sob demanda (`IF NOT EXISTS`), para não depender
/// de nova geração do schema Drift.
class ConfirmacoesEtapaLocalDatasource implements ConfirmacoesEtapaRepository {
  ConfirmacoesEtapaLocalDatasource(this._database, {String? userId})
      : _scope = LocalUserScope(userId);

  final AppDatabase _database;
  final LocalUserScope _scope;
  Future<void>? _tabela;

  Future<void> _garantirTabela() => _tabela ??= _database.customStatement('''
    CREATE TABLE IF NOT EXISTS confirmacoes_etapa_talhao (
      user_id TEXT NOT NULL,
      talhao_id TEXT NOT NULL,
      chave_etapa TEXT NOT NULL,
      data_real TEXT NOT NULL,
      produtos_json TEXT NOT NULL,
      confirmada_em TEXT NOT NULL,
      PRIMARY KEY (user_id, talhao_id, chave_etapa)
    )
  ''');

  @override
  Future<List<ConfirmacaoEtapa>> listar(String talhaoId) async {
    await _garantirTabela();
    final rows = await _database.customSelect(
      'SELECT chave_etapa, data_real, produtos_json, confirmada_em '
      'FROM confirmacoes_etapa_talhao WHERE user_id = ? AND talhao_id = ?',
      variables: [
        Variable.withString(_scope.userId),
        Variable.withString(talhaoId),
      ],
    ).get();
    return [
      for (final r in rows)
        ConfirmacaoEtapa(
          talhaoId: talhaoId,
          chaveEtapa: r.read<String>('chave_etapa'),
          dataReal: DateTime.parse(r.read<String>('data_real')),
          produtos: _decodeProdutos(r.read<String>('produtos_json')),
          confirmadaEm: DateTime.parse(r.read<String>('confirmada_em')),
        ),
    ];
  }

  @override
  Future<void> salvar(ConfirmacaoEtapa c) async {
    await _garantirTabela();
    await _database.customStatement(
      'INSERT OR REPLACE INTO confirmacoes_etapa_talhao '
      '(user_id, talhao_id, chave_etapa, data_real, produtos_json, '
      'confirmada_em) VALUES (?, ?, ?, ?, ?, ?)',
      [
        _scope.userId,
        c.talhaoId,
        c.chaveEtapa,
        c.dataReal.toIso8601String(),
        _encodeProdutos(c.produtos),
        c.confirmadaEm.toIso8601String(),
      ],
    );
  }

  @override
  Future<void> remover(String talhaoId, String chaveEtapa) async {
    await _garantirTabela();
    await _database.customStatement(
      'DELETE FROM confirmacoes_etapa_talhao '
      'WHERE user_id = ? AND talhao_id = ? AND chave_etapa = ?',
      [_scope.userId, talhaoId, chaveEtapa],
    );
  }

  static String _encodeProdutos(List<ProdutoConfirmado> produtos) => jsonEncode([
        for (final p in produtos)
          {
            'id': p.produtoId,
            'nome': p.nome,
            'dose': p.dosePorHa,
            'unidade': p.unidade,
            'total': p.total,
          },
      ]);

  static List<ProdutoConfirmado> _decodeProdutos(String json) {
    final lista = jsonDecode(json) as List<dynamic>;
    return [
      for (final item in lista.cast<Map<String, dynamic>>())
        ProdutoConfirmado(
          produtoId: item['id'] as String,
          nome: item['nome'] as String,
          dosePorHa: (item['dose'] as num).toDouble(),
          unidade: item['unidade'] as String,
          total: (item['total'] as num).toDouble(),
        ),
    ];
  }
}
