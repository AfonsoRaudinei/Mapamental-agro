import 'package:drift/drift.dart';

import '../../features/plans/domain/talhao_safra/programa_operacional_ids_codec.dart';
import 'app_database.dart';

/// v21: persiste vínculos talhão↔programa em [TalhoesSafra.programaOperacionalIds].
///
/// Retorna quantas linhas de talhoes_safra receberam lista não vazia.
Future<int> migrateProgramaOperacionalIdsV21(AppDatabase database) async {
  final talhoesSafra = await database.customSelect(
    'SELECT uid, plano_id, talhao_id FROM talhoes_safra WHERE deleted_at IS NULL',
    readsFrom: {database.talhoesSafra},
  ).get();

  var populados = 0;
  for (final row in talhoesSafra) {
    final uid = row.read<String>('uid');
    final planoId = row.read<String>('plano_id');
    final talhaoId = row.read<String>('talhao_id');

    final programas = await database.customSelect(
      '''
      SELECT uid FROM programas_operacionais
      WHERE plano_id = ? AND talhao_id = ? AND deleted_at IS NULL
      ORDER BY ordem ASC, created_at ASC
      ''',
      variables: [
        Variable.withString(planoId),
        Variable.withString(talhaoId),
      ],
      readsFrom: {database.programasOperacionais},
    ).get();

    final ids = programas.map((p) => p.read<String>('uid')).toList();
    final encoded = encodeProgramaOperacionalIds(ids);
    await database.customUpdate(
      'UPDATE talhoes_safra SET programa_operacional_ids = ?, updated_at = ? '
      'WHERE uid = ?',
      variables: [
        Variable.withString(encoded),
        Variable.withDateTime(DateTime.now()),
        Variable.withString(uid),
      ],
      updates: {database.talhoesSafra},
    );
    if (ids.isNotEmpty) populados++;
  }
  return populados;
}
