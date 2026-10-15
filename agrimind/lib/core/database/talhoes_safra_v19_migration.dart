import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';

const _uuid = Uuid();

/// v19: [TalhoesSafra] como SSOT; copia dados legados de cronogramas_soja_talhao.
Future<void> migrateTalhoesSafraV19(AppDatabase database) async {
  final planos = await database.customSelect(
    "SELECT uid, fazenda_id FROM planos "
    "WHERE deleted_at IS NULL AND fazenda_id IS NOT NULL",
    readsFrom: {database.planos},
  ).get();

  for (final plano in planos) {
    final planoId = plano.read<String>('uid');
    final fazendaId = plano.read<String>('fazenda_id');
    final talhoes = await database.customSelect(
      'SELECT uid FROM talhoes WHERE fazenda_id = ? AND deleted_at IS NULL',
      variables: [Variable.withString(fazendaId)],
      readsFrom: {database.talhoes},
    ).get();

    for (final t in talhoes) {
      final talhaoId = t.read<String>('uid');
      final existe = await database.customSelect(
        'SELECT uid FROM talhoes_safra WHERE plano_id = ? AND talhao_id = ? '
        'AND deleted_at IS NULL LIMIT 1',
        variables: [
          Variable.withString(planoId),
          Variable.withString(talhaoId),
        ],
        readsFrom: {database.talhoesSafra},
      ).getSingleOrNull();
      if (existe != null) continue;

      final legado = await database.customSelect(
        'SELECT * FROM cronogramas_soja_talhao WHERE talhao_id = ? '
        'AND deleted_at IS NULL ORDER BY updated_at DESC LIMIT 1',
        variables: [Variable.withString(talhaoId)],
        readsFrom: {database.cronogramasSojaTalhao},
      ).getSingleOrNull();

      final now = DateTime.now().toIso8601String();
      final id = legado?.read<String>('uid') ?? _uuid.v4();
      final cultura = legado?.read<String>('cultura') ?? 'Soja';
      final cultivar = legado?.read<String>('material_cultivar') ?? '';
      final dataPlantio =
          legado?.read<String>('data_plantio') ?? now;
      final plantioDefinido =
          (legado?.readNullable<int>('plantio_definido') ?? 0) == 1 ? 1 : 0;

      await database.customInsert(
        'INSERT INTO talhoes_safra ('
        'uid, plano_id, talhao_id, cultura, material_cultivar, data_plantio, '
        'dias_emergencia, dae_pos_emergente, dias_recuperacao_pos_emergente, '
        'intervalo_fungicida_dias, total_aplicacoes_fungicida, '
        'dae_maturacao_ciclo, dias_antes_r8_dessecante, '
        'dias_antecipacao_colheita_real, dias_dessecacao_pre_plantio, '
        'grupo_regulagem_id, plantio_definido, ordem, created_at, updated_at, '
        'sync_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        variables: [
          Variable.withString(id),
          Variable.withString(planoId),
          Variable.withString(talhaoId),
          Variable.withString(cultura),
          Variable.withString(cultivar),
          Variable.withString(dataPlantio),
          Variable.withInt(legado?.read<int>('dias_emergencia') ?? 5),
          Variable.withInt(legado?.read<int>('dae_pos_emergente') ?? 25),
          Variable.withInt(
            legado?.read<int>('dias_recuperacao_pos_emergente') ?? 5,
          ),
          Variable.withInt(legado?.read<int>('intervalo_fungicida_dias') ?? 15),
          Variable.withInt(
            legado?.read<int>('total_aplicacoes_fungicida') ?? 4,
          ),
          Variable.withInt(legado?.read<int>('dae_maturacao_ciclo') ?? 110),
          Variable.withInt(legado?.read<int>('dias_antes_r8_dessecante') ?? 12),
          Variable.withInt(
            legado?.read<int>('dias_antecipacao_colheita_real') ?? 5,
          ),
          Variable.withInt(
            legado?.read<int>('dias_dessecacao_pre_plantio') ?? 15,
          ),
          Variable.withString(
            legado?.read<String>('grupo_regulagem_id') ?? id,
          ),
          Variable.withInt(plantioDefinido),
          Variable.withInt(legado?.read<int>('ordem') ?? 0),
          Variable.withString(
            legado?.read<String>('created_at') ?? now,
          ),
          Variable.withString(now),
          Variable.withString('pending'),
        ],
      );
    }
  }
}
