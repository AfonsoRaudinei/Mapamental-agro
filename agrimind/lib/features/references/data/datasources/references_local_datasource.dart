import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/referencia_tecnica_entity.dart';
import 'references_cesb_seed.dart';
import 'references_disease_seed.dart';
import 'references_insect_seed.dart';
import 'references_nutrition_seed.dart';
import 'references_physiology_seed.dart';

/// Datasource local Drift para Referências Técnicas.
/// Inclui seed com dados agronômicos por categoria/estádio.
class ReferencesLocalDatasource {
  ReferencesLocalDatasource(this._database);

  final AppDatabase _database;

  ReferenciaTecnicaEntity _toEntity(ReferenciasTecnica m) =>
      ReferenciaTecnicaEntity(
        id: m.uid,
        categoria: m.categoria,
        estadio: m.estadio,
        titulo: m.titulo,
        descricao: m.descricao,
        focoManejo: m.focoManejo,
        praticas: m.praticas,
        padrao: m.padrao,
        destaque: m.destaque,
        fonte: m.fonte,
        safraReferencia: m.safraReferencia,
        dataReferencia: m.dataReferencia,
        resultado: m.resultado,
        local: m.local,
        tipoFonte: m.tipoFonte,
      );

  // ── Queries ────────────────────────────────────────────────────────────────

  Future<List<ReferenciaTecnicaEntity>> getByCategoria(
    String categoria,
  ) async {
    final models = await (_database.select(_database.referenciasTecnicas)
          ..where((row) => row.categoria.equals(categoria)))
        .get();
    return models.map(_toEntity).toList();
  }

  Future<List<ReferenciaTecnicaEntity>> getByEstadio(
    String categoria,
    String estadio,
  ) async {
    final models = await (_database.select(_database.referenciasTecnicas)
          ..where(
            (row) =>
                row.categoria.equals(categoria) & row.estadio.equals(estadio),
          ))
        .get();
    return models.map(_toEntity).toList();
  }

  Future<List<ReferenciaTecnicaEntity>> getCesb({String? estadio}) async {
    final query = _database.select(_database.referenciasTecnicas)
      ..where((row) => row.categoria.equals('cesb'));
    if (estadio != null) {
      query.where((row) => row.estadio.equals(estadio));
    }
    final models = await query.get();
    return models.map(_toEntity).toList();
  }

  // ── Seed Técnico (referências agronômicas) ─────────────────────────────────

  static const _diseaseReferencesMigrationKey = 'references_doencas_v4';
  static const _insectReferencesMigrationKey = 'references_insetos_v3';
  static const _nutritionReferencesMigrationKey = 'references_nutricao_v3';
  static const _physiologyReferencesMigrationKey = 'references_fisiologia_v3';
  static const _cesbReferencesMigrationKey = 'references_cesb_v4';

  Future<void> seedIfEmpty() async {
    final count = await _database.referenciasTecnicas.count().getSingle();
    if (count == 0) {
      final seed = _buildSeed();
      await _database.batch(
        (batch) => batch.insertAll(_database.referenciasTecnicas, seed),
      );
    }

    if (!await _database
        .hasCompletedMigration(_diseaseReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('doencas')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            buildDiseaseReferences(),
          ),
        );
        await _database.markMigrationCompleted(_diseaseReferencesMigrationKey);
      });
    }

    if (!await _database.hasCompletedMigration(_insectReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('insetos')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            buildInsectReferences(),
          ),
        );
        await _database.markMigrationCompleted(_insectReferencesMigrationKey);
      });
    }

    if (!await _database
        .hasCompletedMigration(_nutritionReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('nutricao')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            buildNutritionReferences(),
          ),
        );
        await _database
            .markMigrationCompleted(_nutritionReferencesMigrationKey);
      });
    }

    if (!await _database
        .hasCompletedMigration(_physiologyReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('fisiologia')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            buildPhysiologyReferences(),
          ),
        );
        await _database
            .markMigrationCompleted(_physiologyReferencesMigrationKey);
      });
    }

    if (!await _database.hasCompletedMigration(_cesbReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('cesb')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            buildCesbReferences(),
          ),
        );
        await _database.markMigrationCompleted(_cesbReferencesMigrationKey);
      });
    }
  }

  List<ReferenciasTecnicasCompanion> _buildSeed() {
    final items = <ReferenciasTecnicasCompanion>[];

    items.addAll(buildDiseaseReferences());

    items.addAll(buildInsectReferences());

    items.addAll(buildNutritionReferences());

    items.addAll(buildPhysiologyReferences());

    items.addAll(buildCesbReferences());

    return items;
  }
}
