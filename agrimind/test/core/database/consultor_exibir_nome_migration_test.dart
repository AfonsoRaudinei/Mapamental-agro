import 'package:agrimind/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('schema v4 adiciona consultorExibirNome com default true', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final now = DateTime.utc(2026, 6, 29);
    await database.into(database.planos).insert(
          PlanosCompanion.insert(
            uid: 'plano-1',
            nome: 'Plano teste',
            cultura: 'Soja',
            safra: '2026/27',
            areaHaTotal: 100,
            status: 'rascunho',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final row = await (database.select(database.planos)
          ..where((p) => p.uid.equals('plano-1')))
        .getSingle();

    expect(row.consultorExibirNome, isTrue);
  });
}
