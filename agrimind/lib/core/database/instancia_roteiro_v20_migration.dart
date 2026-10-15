import 'package:drift/drift.dart';

import 'app_database.dart';

/// v20: estádios criados pelo sync legado (cronograma → canvas) passam a
/// [instanciaRoteiro=1] + `talhaoId` na observação, alinhados ao programa.
///
/// Retorna quantos registros foram reclassificados (para diagnóstico).
Future<int> migrateInstanciaRoteiroV20(AppDatabase database) async {
  final candidatos = await database.customSelect(
    '''
    SELECT e.uid AS estadio_id, p.talhao_id AS talhao_id, e.observacao AS observacao
    FROM estadios e
    INNER JOIN programas_operacionais p ON p.estadio_id = e.uid
    WHERE e.deleted_at IS NULL
      AND p.deleted_at IS NULL
      AND e.tipo = 'operacional'
      AND (e.observacao IS NULL OR e.observacao NOT LIKE '%instanciaRoteiro=1%')
    ''',
    readsFrom: {database.estadios, database.programasOperacionais},
  ).get();

  var atualizados = 0;
  for (final row in candidatos) {
    final estadioId = row.read<String>('estadio_id');
    final talhaoId = row.read<String>('talhao_id');
    final obs = row.read<String?>('observacao') ?? '';
    final novaObs = _observacaoInstanciaMigrada(obs, talhaoId);
    if (novaObs == obs) continue;
    await database.customUpdate(
      'UPDATE estadios SET observacao = ?, updated_at = ? WHERE uid = ?',
      variables: [
        Variable.withString(novaObs),
        Variable.withDateTime(DateTime.now()),
        Variable.withString(estadioId),
      ],
      updates: {database.estadios},
    );
    atualizados++;
  }

  final templatesSemMarca = await database.customSelect(
    '''
    SELECT e.uid
    FROM estadios e
    LEFT JOIN programas_operacionais p ON p.estadio_id = e.uid AND p.deleted_at IS NULL
    WHERE e.deleted_at IS NULL
      AND e.tipo = 'operacional'
      AND p.uid IS NULL
      AND (e.observacao IS NULL OR e.observacao NOT LIKE '%roteiroTemplate=1%')
      AND (e.observacao IS NULL OR e.observacao NOT LIKE '%talhaoId=%')
    ''',
    readsFrom: {database.estadios, database.programasOperacionais},
  ).get();

  for (final row in templatesSemMarca) {
    final estadioId = row.read<String>('uid');
    await database.customUpdate(
      "UPDATE estadios SET observacao = 'roteiroTemplate=1', updated_at = ? "
      'WHERE uid = ?',
      variables: [
        Variable.withDateTime(DateTime.now()),
        Variable.withString(estadioId),
      ],
      updates: {database.estadios},
    );
    atualizados++;
  }

  return atualizados;
}

String _observacaoInstanciaMigrada(String obs, String talhaoId) {
  if (obs.contains('instanciaRoteiro=1') && obs.contains('talhaoId=$talhaoId')) {
    return obs;
  }
  final parts = <String>[];
  if (obs.isNotEmpty && !obs.contains('roteiroTemplate=1')) {
    parts.add(obs);
  }
  if (!obs.contains('talhaoId=$talhaoId')) {
    parts.add('talhaoId=$talhaoId');
  }
  if (!obs.contains('instanciaRoteiro=1')) {
    parts.add('instanciaRoteiro=1');
  }
  if (!obs.contains('origemMigracao=cronogramaLegado')) {
    parts.add('origemMigracao=cronogramaLegado');
  }
  return parts.join(';');
}
