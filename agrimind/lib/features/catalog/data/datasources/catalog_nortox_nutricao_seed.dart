import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/cultura_label.dart';
import '../../domain/culturas_codec.dart';
import 'catalog_nortox_nutricao_records.dart';

const _nortoxNutricaoMigrationKey = 'catalog_nortox_nutricao_2025';

List<String> _culturasDoItem(Map<String, String> item) {
  final fromText = parseCulturasTexto(item['culturas']);
  if (fromText.isNotEmpty) return fromText;

  final nome = item['nome']!.toLowerCase();
  final sec = item['sec']!.toLowerCase();
  if (nome.contains('cana') || nome.contains('bioativador cana')) {
    return parseCulturasTexto('Cana-de-açúcar');
  }
  if (nome.contains('cotton') || nome.contains('algodão')) {
    return parseCulturasTexto('Algodão');
  }
  if (nome.contains('leg') || sec.contains('biobase leg')) {
    return parseCulturasTexto('Soja, Feijão');
  }
  if (nome.contains('gram')) {
    return parseCulturasTexto('Milho, Sorgo, Trigo, Triticale');
  }
  if (sec.contains('inoculante') || nome.contains('bradyrhizobium')) {
    return parseCulturasTexto('Soja, Feijão');
  }
  return const [];
}

String _observacoes(Map<String, String> item) {
  final sec = item['sec']!;
  final conc = item['conc']!;
  return 'Linha Nutrição Nortox · $sec · $conc';
}

List<CatalogoProdutosCompanion> buildNortoxNutricaoCatalogSeed(
  DateTime now,
  Uuid uuid,
) {
  return catalogNortoxNutricaoRecords.map((item) {
    final culturas = _culturasDoItem(item);
    return CatalogoProdutosCompanion.insert(
      uid: uuid.v4(),
      nomeComercial: item['nome']!,
      ingredienteAtivo: Value(item['ia']),
      categoria: item['cat']!,
      unidadePadrao:
          item['cat'] == 'Micros sólidos' ? 'kg/ha' : item['unid']!,
      fabricante: const Value('Nortox'),
      observacoes: Value(_observacoes(item)),
      culturas: Value(encodeCulturas(culturas)),
      ativo: const Value(true),
      isSeed: const Value(true),
      createdAt: now,
      updatedAt: now,
    );
  }).toList();
}

Future<void> ensureNortoxNutricaoCatalogSeed(AppDatabase database) async {
  if (await database.hasCompletedMigration(_nortoxNutricaoMigrationKey)) {
    return;
  }

  final now = DateTime.now();
  const uuid = Uuid();
  final companions = buildNortoxNutricaoCatalogSeed(now, uuid);

  final existing = await database.select(database.catalogoProdutos).get();
  final nomes = existing.map((e) => e.nomeComercial.toLowerCase()).toSet();

  final novos = companions.where(
    (c) => !nomes.contains(c.nomeComercial.value.toLowerCase()),
  );

  if (novos.isNotEmpty) {
    await database.batch(
      (batch) => batch.insertAll(database.catalogoProdutos, novos.toList()),
    );
  }

  await database.markMigrationCompleted(_nortoxNutricaoMigrationKey);
}
