import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/culturas_codec.dart';
import '../../domain/dae_maturacao_cultivar.dart';

const _cultivaresSojaMigrationKey = 'catalog_cultivares_soja_2026';

/// Cultivares de referência (CESB / uso no cronograma). DAE = dias plantio → colheita.
final List<Map<String, Object>> catalogCultivaresSojaRecords = [
  {'nome': 'Olimpo', 'dae': 110, 'fab': 'Brasmax'},
  {'nome': 'Brasmax Olimpo IPRO', 'dae': 110, 'fab': 'Brasmax'},
  {'nome': 'Cruzada', 'dae': 118, 'fab': '—'},
  {'nome': 'NS 6906 IPRO', 'dae': 115, 'fab': 'Nidera'},
  {'nome': 'BMX Potência RR', 'dae': 112, 'fab': 'Brasmax'},
  {'nome': 'TMG 2381 IPRO', 'dae': 108, 'fab': 'TMG'},
];

List<CatalogoProdutosCompanion> buildCultivaresSojaCatalogSeed(
  DateTime now,
  Uuid uuid,
) {
  return catalogCultivaresSojaRecords.map((item) {
    final dae = item['dae'] as int;
    return CatalogoProdutosCompanion.insert(
      uid: uuid.v4(),
      nomeComercial: item['nome'] as String,
      categoria: kCategoriaSementeCatalogo,
      unidadePadrao: 'ciclo',
      fabricante: Value(item['fab'] as String?),
      observacoes: Value(observacoesDaeMaturacao(dae)),
      culturas: Value(encodeCulturas(const ['Soja'])),
      ativo: const Value(true),
      isSeed: const Value(true),
      createdAt: now,
      updatedAt: now,
    );
  }).toList();
}

Future<void> ensureCultivaresSojaCatalogSeed(AppDatabase database) async {
  if (await database.hasCompletedMigration(_cultivaresSojaMigrationKey)) {
    return;
  }

  final now = DateTime.now();
  const uuid = Uuid();
  final companions = buildCultivaresSojaCatalogSeed(now, uuid);

  final existing = await database.select(database.catalogoProdutos).get();
  final nomes = existing.map((e) => e.nomeComercial.toLowerCase()).toSet();

  final novos = companions
      .where((c) => !nomes.contains(c.nomeComercial.value.toLowerCase()));

  if (novos.isNotEmpty) {
    await database.batch(
      (batch) => batch.insertAll(database.catalogoProdutos, novos.toList()),
    );
  }

  await database.markMigrationCompleted(_cultivaresSojaMigrationKey);
}
