import 'package:agrimind/core/constants/app_constants.dart';
import 'package:agrimind/core/database/app_database.dart';
import 'package:drift/drift.dart';

/// Migra dados do estádio fenológico V8 (removido) para V7.
Future<void> migrateEstadioV8ToV7(AppDatabase database) async {
  await (database.update(database.referenciasTecnicas)
        ..where((row) => row.estadio.equals('V8')))
      .write(const ReferenciasTecnicasCompanion(estadio: Value('V7')));

  final v8Stages = await (database.select(database.estadios)
        ..where((row) => row.codigo.equals('V8') & row.deletedAt.isNull()))
      .get();

  if (v8Stages.isEmpty) return;

  final now = DateTime.now();
  final v7Order = AppConstants.estadiosCodigos.indexOf('V7');

  for (final v8 in v8Stages) {
    final v7 = await (database.select(database.estadios)
          ..where(
            (row) =>
                row.planoId.equals(v8.planoId) &
                row.codigo.equals('V7') &
                row.deletedAt.isNull(),
          ))
        .getSingleOrNull();

    if (v7 != null) {
      await (database.update(database.produtosAplicacao)
            ..where(
              (row) => row.estadioId.equals(v8.uid) & row.deletedAt.isNull(),
            ))
          .write(
        ProdutosAplicacaoCompanion(
          estadioId: Value(v7.uid),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
      await (database.update(database.estadios)
            ..where((row) => row.uid.equals(v8.uid)))
          .write(
        EstadiosCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
    } else {
      await (database.update(database.estadios)
            ..where((row) => row.uid.equals(v8.uid)))
          .write(
        EstadiosCompanion(
          codigo: const Value('V7'),
          label: const Value('V7 — 7º Nó'),
          ordem: Value(v7Order >= 0 ? v7Order : v8.ordem),
          updatedAt: Value(now),
          syncState: const Value('pending'),
        ),
      );
    }
  }
}
