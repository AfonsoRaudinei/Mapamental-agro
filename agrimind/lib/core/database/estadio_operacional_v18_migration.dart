import 'package:drift/drift.dart';

import 'app_database.dart';
import '../../features/plans/domain/talhao_safra/mapear_tipo_operacional_label.dart';
import '../../features/plans/domain/talhao_safra/tipo_operacional.dart';

/// v18: tipo operacional fechado + JSON de parâmetros no estádio.
Future<void> migrateEstadioOperacionalV18(AppDatabase database) async {
  final rows = await database.customSelect(
    "SELECT uid, label, tipo_operacional, operacional_config "
    "FROM estadios WHERE deleted_at IS NULL AND codigo = 'Operacional'",
    readsFrom: {database.estadios},
  ).get();

  for (final row in rows) {
    final uid = row.read<String>('uid');
    final label = row.read<String>('label');
    final tipoAtual = row.readNullable<String>('tipo_operacional');

    if (tipoAtual != null && tipoAtual.isNotEmpty) continue;

    final mapeamento = mapearLabelOperacionalParaTipo(label);
    switch (mapeamento) {
      case TipoOperacionalMapeado(:final tipo, :final incluirAdubacao):
        final novoLabel = labelOperacionalParaCard(
          tipo,
          incluirAdubacao: incluirAdubacao,
        );
        final configJson = incluirAdubacao
            ? '{"incluirAdubacao":true}'
            : null;
        if (configJson != null) {
          await database.customUpdate(
            'UPDATE estadios SET tipo_operacional = ?, label = ?, '
            'operacional_config = ? WHERE uid = ?',
            variables: [
              Variable.withString(tipo.name),
              Variable.withString(novoLabel),
              Variable.withString(configJson),
              Variable.withString(uid),
            ],
          );
        } else {
          await database.customUpdate(
            'UPDATE estadios SET tipo_operacional = ?, label = ? WHERE uid = ?',
            variables: [
              Variable.withString(tipo.name),
              Variable.withString(novoLabel),
              Variable.withString(uid),
            ],
          );
        }
      case TipoOperacionalIndefinido():
        await database.customUpdate(
          'UPDATE estadios SET tipo_operacional = ? WHERE uid = ?',
          variables: [
            Variable.withString(TipoOperacional.indefinido.name),
            Variable.withString(uid),
          ],
        );
    }
  }
}
