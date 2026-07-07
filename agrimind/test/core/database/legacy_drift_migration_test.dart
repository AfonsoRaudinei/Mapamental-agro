import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/core/database/legacy_drift_migration.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('migra relações para Drift e registra conclusão', () async {
    final now = DateTime.utc(2026, 6, 20);
    final batch = LegacyMigrationBatch(
      clientes: [
        ClientesCompanion.insert(
          uid: 'cliente-1',
          userId: const Value('user-1'),
          nome: 'Cliente Teste',
          createdAt: now,
          updatedAt: now,
        ),
      ],
      fazendas: [
        FazendasCompanion.insert(
          uid: 'fazenda-1',
          userId: const Value('user-1'),
          clienteId: 'cliente-1',
          nome: 'Fazenda Teste',
          areaHa: 150,
          cultura: 'Soja',
          safra: '2026/27',
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );

    final report = await LegacyDriftMigration(database).migrate(batch);

    expect(report.alreadyCompleted, isFalse);
    expect(report.migratedRecords, 2);
    expect(await database.select(database.clientes).get(), hasLength(1));
    expect(await database.select(database.fazendas).get(), hasLength(1));
    expect(
      await database.hasCompletedMigration(legacyDriftMigrationKey),
      isTrue,
    );
  });

  test('não executa novamente uma migração concluída', () async {
    const batch = LegacyMigrationBatch();
    final migrator = LegacyDriftMigration(database);

    await migrator.migrate(batch);
    final secondReport = await migrator.migrate(batch);

    expect(secondReport.alreadyCompleted, isTrue);
    expect(secondReport.migratedRecords, 0);
  });

  test('foreign key impede fazenda sem cliente', () async {
    final now = DateTime.utc(2026, 6, 20);

    expect(
      database.into(database.fazendas).insert(
            FazendasCompanion.insert(
              uid: 'fazenda-orfa',
              clienteId: 'cliente-inexistente',
              nome: 'Inválida',
              areaHa: 1,
              cultura: 'Soja',
              safra: '2026/27',
              createdAt: now,
              updatedAt: now,
            ),
          ),
      throwsA(isA<SqliteException>()),
    );
  });
}
