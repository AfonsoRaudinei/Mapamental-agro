import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/cultura_label.dart';
import '../../domain/culturas_codec.dart';
import 'catalog_nortox_records.dart';

const _nortoxMigrationKey = 'catalog_nortox_2025';

List<CatalogoProdutosCompanion> buildNortoxCatalogSeed(
  DateTime now,
  Uuid uuid,
) {
  return catalogNortoxRecords.map((item) {
    final culturas = parseCulturasTexto(item['culturas']);
    return CatalogoProdutosCompanion.insert(
      uid: uuid.v4(),
      nomeComercial: item['nome']!,
      ingredienteAtivo: Value(item['ia']),
      categoria: item['cat']!,
      unidadePadrao: item['unid']!,
      fabricante: const Value('Nortox'),
      observacoes: Value('Concentração: ${item['conc']}'),
      culturas: Value(encodeCulturas(culturas)),
      ativo: const Value(true),
      isSeed: const Value(true),
      createdAt: now,
      updatedAt: now,
    );
  }).toList();
}

Future<void> ensureNortoxCatalogSeed(AppDatabase database) async {
  if (await database.hasCompletedMigration(_nortoxMigrationKey)) return;

  final now = DateTime.now();
  const uuid = Uuid();
  final companions = buildNortoxCatalogSeed(now, uuid);

  final existing = await database.select(database.catalogoProdutos).get();
  final nomes = existing.map((e) => e.nomeComercial.toLowerCase()).toSet();

  final novos =
      companions.where((c) => !nomes.contains(c.nomeComercial.value.toLowerCase()));

  if (novos.isNotEmpty) {
    await database.batch(
      (batch) => batch.insertAll(database.catalogoProdutos, novos.toList()),
    );
  }

  await database.markMigrationCompleted(_nortoxMigrationKey);
}
