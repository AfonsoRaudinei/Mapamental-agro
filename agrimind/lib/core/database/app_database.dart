import 'package:agrimind/core/database/alocacao_v9_migration.dart';
import 'package:agrimind/core/database/cronograma_soja_table_migration.dart';
import 'package:agrimind/core/database/estadio_operacional_v18_migration.dart';
import 'package:agrimind/core/database/estadios_table_migration.dart';
import 'package:agrimind/core/database/instancia_roteiro_v20_migration.dart';
import 'package:agrimind/core/database/programa_operacional_ids_v21_migration.dart';
import 'package:agrimind/core/database/talhoes_safra_table_migration.dart';
import 'package:agrimind/core/database/talhoes_safra_v19_migration.dart';
import 'package:agrimind/core/database/estadio_v8_migration.dart';
import 'package:agrimind/core/database/plan_schema_v11_migration.dart';
import 'package:agrimind/core/database/plan_schema_v8_migration.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class LocalUsers extends Table {
  TextColumn get uid => text()();
  TextColumn get nome => text()();
  TextColumn get email => text()();
  TextColumn get telefone => text().nullable()();
  TextColumn get empresa => text().nullable()();
  TextColumn get craRegistro => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  BoolColumn get darkMode => boolean().withDefault(const Constant(false))();
  TextColumn get appIconKey =>
      text().withDefault(const Constant('principal'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class Clientes extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get nome => text()();
  TextColumn get cpfCnpj => text().nullable()();
  TextColumn get telefone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get cidade => text().nullable()();
  TextColumn get uf => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class Fazendas extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get clienteId =>
      text().references(Clientes, #uid, onDelete: KeyAction.cascade)();
  TextColumn get nome => text()();
  RealColumn get areaHa => real()();
  TextColumn get cultura => text()();
  TextColumn get safra => text()();
  TextColumn get municipio => text().nullable()();
  TextColumn get uf => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class Talhoes extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get fazendaId =>
      text().references(Fazendas, #uid, onDelete: KeyAction.cascade)();
  TextColumn get nome => text()();
  RealColumn get areaHa => real()();
  TextColumn get observacao => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

/// Parâmetros do cronograma agrícola (soja) por talhão / linha de planejamento.
class CronogramasSojaTalhao extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get talhaoId =>
      text().references(Talhoes, #uid, onDelete: KeyAction.cascade)();
  TextColumn get cultura => text()();
  TextColumn get materialCultivar => text().withDefault(const Constant(''))();
  DateTimeColumn get dataPlantio => dateTime()();
  IntColumn get diasEmergencia => integer().withDefault(const Constant(5))();
  IntColumn get daePosEmergente => integer().withDefault(const Constant(25))();
  IntColumn get diasRecuperacaoPosEmergente =>
      integer().withDefault(const Constant(5))();
  IntColumn get intervaloFungicidaDias =>
      integer().withDefault(const Constant(15))();
  IntColumn get totalAplicacoesFungicida =>
      integer().withDefault(const Constant(4))();
  IntColumn get daeMaturacaoCiclo =>
      integer().withDefault(const Constant(110))();
  IntColumn get diasAntesR8Dessecante =>
      integer().withDefault(const Constant(12))();
  IntColumn get diasAntecipacaoColheitaReal =>
      integer().withDefault(const Constant(5))();
  IntColumn get diasDessecacaoPrePlantio =>
      integer().withDefault(const Constant(15))();
  TextColumn get grupoRegulagemId =>
      text().withDefault(const Constant(''))();
  BoolColumn get plantioDefinido =>
      boolean().withDefault(const Constant(true))();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

/// SSOT do planejamento por talhão na safra (plano ativo).
class TalhoesSafra extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get planoId =>
      text().references(Planos, #uid, onDelete: KeyAction.cascade)();
  TextColumn get talhaoId =>
      text().references(Talhoes, #uid, onDelete: KeyAction.cascade)();
  TextColumn get cultura => text()();
  TextColumn get materialCultivar => text().withDefault(const Constant(''))();
  DateTimeColumn get dataPlantio => dateTime()();
  IntColumn get diasEmergencia => integer().withDefault(const Constant(5))();
  IntColumn get daePosEmergente => integer().withDefault(const Constant(25))();
  IntColumn get diasRecuperacaoPosEmergente =>
      integer().withDefault(const Constant(5))();
  IntColumn get intervaloFungicidaDias =>
      integer().withDefault(const Constant(15))();
  IntColumn get totalAplicacoesFungicida =>
      integer().withDefault(const Constant(4))();
  IntColumn get daeMaturacaoCiclo =>
      integer().withDefault(const Constant(110))();
  IntColumn get diasAntesR8Dessecante =>
      integer().withDefault(const Constant(12))();
  IntColumn get diasAntecipacaoColheitaReal =>
      integer().withDefault(const Constant(5))();
  IntColumn get diasDessecacaoPrePlantio =>
      integer().withDefault(const Constant(15))();
  TextColumn get grupoRegulagemId =>
      text().withDefault(const Constant(''))();
  BoolColumn get plantioDefinido =>
      boolean().withDefault(const Constant(false))();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
  /// JSON array de [ProgramasOperacionais.uid] vinculados a este talhão na safra.
  TextColumn get programaOperacionalIds =>
      text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

/// Programa operacional persistido (pai + aplicações de fungicida por talhão).
class ProgramasOperacionais extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get planoId =>
      text().references(Planos, #uid, onDelete: KeyAction.cascade)();
  TextColumn get talhaoId =>
      text().references(Talhoes, #uid, onDelete: KeyAction.cascade)();
  TextColumn get programaPaiId => text().nullable()();
  TextColumn get tipo => text()();
  TextColumn get regraCalculo => text()();
  TextColumn get estadioId => text().nullable().references(
        Estadios,
        #uid,
        onDelete: KeyAction.setNull,
      )();
  IntColumn get aplicacaoIndice => integer().nullable()();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
  BoolColumn get incluirAdubacao =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class CatalogoProdutos extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get nomeComercial => text()();
  TextColumn get ingredienteAtivo => text().nullable()();
  TextColumn get categoria => text()();
  TextColumn get unidadePadrao => text()();
  RealColumn get doseMin => real().nullable()();
  RealColumn get doseMax => real().nullable()();
  RealColumn get precoUnitario => real().nullable()();
  TextColumn get fabricante => text().nullable()();
  TextColumn get observacoes => text().nullable()();
  TextColumn get culturas => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  BoolColumn get isSeed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class ReferenciasTecnicas extends Table {
  TextColumn get uid => text()();
  TextColumn get categoria => text()();
  TextColumn get estadio => text()();
  TextColumn get titulo => text()();
  TextColumn get descricao => text().nullable()();
  TextColumn get focoManejo => text().nullable()();
  TextColumn get praticas => text().nullable()();
  TextColumn get padrao => text().nullable()();
  TextColumn get destaque => text().nullable()();
  TextColumn get fonte => text().nullable()();
  TextColumn get safraReferencia => text().nullable()();
  DateTimeColumn get dataReferencia => dateTime().nullable()();
  TextColumn get resultado => text().nullable()();
  TextColumn get local => text().nullable()();
  TextColumn get tipoFonte => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class Planos extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get clienteId => text().nullable().references(Clientes, #uid)();
  TextColumn get fazendaId => text().nullable().references(Fazendas, #uid)();
  TextColumn get nome => text()();
  TextColumn get produtorNomeLivre => text().nullable()();
  TextColumn get fazendaNomeLivre => text().nullable()();
  TextColumn get cidadeUf => text().nullable()();
  TextColumn get consultorNome => text().nullable()();
  BoolColumn get consultorExibirNome =>
      boolean().withDefault(const Constant(true))();
  TextColumn get logoLocalPath => text().nullable()();
  RealColumn get precoGraoSc60 => real().nullable()();
  DateTimeColumn get dataVencimento => dateTime().nullable()();
  TextColumn get cultivarNome => text().nullable()();
  TextColumn get cultivarObtentora => text().nullable()();
  TextColumn get cultivarGrupoMaturacao => text().nullable()();
  RealColumn get cultivarPopulacao => real().nullable()();
  TextColumn get cultivarPopulacaoUnidade =>
      text().withDefault(const Constant('plantas/ha'))();
  TextColumn get cultivarObservacoes => text().nullable()();
  TextColumn get cultura => text()();
  TextColumn get safra => text()();
  RealColumn get areaHaTotal => real()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class Estadios extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get planoId =>
      text().references(Planos, #uid, onDelete: KeyAction.cascade)();
  TextColumn get codigo => text()();
  TextColumn get tipo => text().withDefault(const Constant('fenologico'))();
  TextColumn get label => text()();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
  DateTimeColumn get dataAplicacao => dateTime().nullable()();
  TextColumn get imageLocalPath => text().nullable()();
  TextColumn get observacao => text().nullable()();
  TextColumn get tipoOperacional => text().nullable()();
  TextColumn get operacionalConfig => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class ProdutosAplicacao extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get estadioId =>
      text().references(Estadios, #uid, onDelete: KeyAction.cascade)();
  TextColumn get catalogoProdutoId =>
      text().nullable().references(CatalogoProdutos, #uid)();
  TextColumn get produtoNome => text()();
  TextColumn get produtoCategoria => text()();
  RealColumn get dose => real()();
  TextColumn get doseUnidade => text()();
  RealColumn get areaHa => real()();
  TextColumn get talhaoRef => text().nullable()();
  RealColumn get totalOverride => real().nullable()();
  TextColumn get overrideMotivo => text().nullable()();
  RealColumn get precoUnitario => real().nullable()();
  TextColumn get observacao => text().nullable()();
  DateTimeColumn get dataPrevista => dateTime().nullable()();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class SementesTalhao extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get planoId =>
      text().references(Planos, #uid, onDelete: KeyAction.cascade)();
  TextColumn get estadioId =>
      text().references(Estadios, #uid, onDelete: KeyAction.cascade)();
  TextColumn get talhaoId =>
      text().nullable().references(Talhoes, #uid, onDelete: KeyAction.cascade)();
  TextColumn get cultivar => text()();
  RealColumn get populacaoSementesPorHa => real()();
  IntColumn get sementesPorEmbalagem => integer()();
  RealColumn get espacamentoPlantioCm => real()();
  IntColumn get embalagensManual => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class LocalMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class EscoposAlocacao extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get produtoAplicacaoId =>
      text().references(ProdutosAplicacao, #uid, onDelete: KeyAction.cascade)();
  TextColumn get tipo => text()();
  TextColumn get talhoesIdsJson => text()();
  RealColumn get quantidadeTotal => real()();
  DateTimeColumn get dataCriacao => dateTime()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

class AlocacoesTalhao extends Table {
  TextColumn get uid => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get produtoAplicacaoId =>
      text().references(ProdutosAplicacao, #uid, onDelete: KeyAction.cascade)();
  TextColumn get talhaoId =>
      text().references(Talhoes, #uid, onDelete: KeyAction.cascade)();
  RealColumn get quantidadeAlocada => real()();
  TextColumn get origemEscopoId =>
      text().references(EscoposAlocacao, #uid, onDelete: KeyAction.cascade)();
  DateTimeColumn get dataLancamento => dateTime()();
  BoolColumn get foiAjustadoManualmente =>
      boolean().withDefault(const Constant(false))();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}

@DriftDatabase(
  tables: [
    LocalUsers,
    Clientes,
    Fazendas,
    Talhoes,
    CatalogoProdutos,
    ReferenciasTecnicas,
    Planos,
    Estadios,
    ProdutosAplicacao,
    EscoposAlocacao,
    AlocacoesTalhao,
    SementesTalhao,
    CronogramasSojaTalhao,
    TalhoesSafra,
    ProgramasOperacionais,
    LocalMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'agrimind'));

  @override
  int get schemaVersion => 22;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(planos, planos.produtorNomeLivre);
            await migrator.addColumn(planos, planos.fazendaNomeLivre);
            await migrator.addColumn(planos, planos.cidadeUf);
            await migrator.addColumn(planos, planos.consultorNome);
            await migrator.addColumn(planos, planos.logoLocalPath);
            await migrator.addColumn(planos, planos.precoGraoSc60);
            await migrator.addColumn(planos, planos.dataVencimento);
            await migrator.addColumn(estadios, estadios.imageLocalPath);
          }
          if (from < 3) {
            await migrateEstadioV8ToV7(this);
          }
          if (from < 4) {
            await migrator.addColumn(planos, planos.consultorExibirNome);
          }
          if (from < 5) {
            await migrator.addColumn(
                referenciasTecnicas, referenciasTecnicas.fonte);
            await migrator.addColumn(
              referenciasTecnicas,
              referenciasTecnicas.safraReferencia,
            );
            await migrator.addColumn(
              referenciasTecnicas,
              referenciasTecnicas.dataReferencia,
            );
            await migrator.addColumn(
              referenciasTecnicas,
              referenciasTecnicas.resultado,
            );
            await migrator.addColumn(
                referenciasTecnicas, referenciasTecnicas.local);
            await migrator.addColumn(
              referenciasTecnicas,
              referenciasTecnicas.tipoFonte,
            );
          }
          if (from < 6) {
            await customStatement(
              "UPDATE catalogo_produtos SET categoria = 'Adjuvante TA' "
              "WHERE categoria = 'Adjuvante'",
            );
          }
          if (from < 7) {
            await migrator.addColumn(
              catalogoProdutos,
              catalogoProdutos.culturas,
            );
          }
          if (from < 8) {
            await migrator.addColumn(estadios, estadios.tipo);
            await migrator.addColumn(planos, planos.cultivarNome);
            await migrator.addColumn(planos, planos.cultivarObtentora);
            await migrator.addColumn(planos, planos.cultivarGrupoMaturacao);
            await migrator.addColumn(planos, planos.cultivarPopulacao);
            await migrator.addColumn(planos, planos.cultivarPopulacaoUnidade);
            await migrator.addColumn(planos, planos.cultivarObservacoes);
            await migratePlanSchemaV8(this);
          }
          if (from < 9) {
            await migrateAlocacaoV9(this);
          }
          if (from < 10) {
            await migrator.createTable(sementesTalhao);
          }
          if (from < 11) {
            await migratePlanSchemaV11(this);
          }
          if (from < 12) {
            await migrator.createTable(cronogramasSojaTalhao);
          }
          if (from < 13) {
            await addCronogramaSojaColumnIfMissing(
              this,
              migrator,
              'dae_maturacao_ciclo',
              () => migrator.addColumn(
                cronogramasSojaTalhao,
                cronogramasSojaTalhao.daeMaturacaoCiclo,
              ),
            );
            if (!await cronogramaSojaTalhaoHasColumn(
              this,
              'dias_antecipacao_dessecacao_colheita',
            )) {
              await customStatement(
                'ALTER TABLE cronogramas_soja_talhao '
                'ADD COLUMN dias_antecipacao_dessecacao_colheita '
                'INTEGER NOT NULL DEFAULT 5',
              );
            }
          }
          if (from < 14) {
            await migrator.createTable(programasOperacionais);
          }
          if (from < 15) {
            await addCronogramaSojaColumnIfMissing(
              this,
              migrator,
              'dias_dessecacao_pre_plantio',
              () => migrator.addColumn(
                cronogramasSojaTalhao,
                cronogramasSojaTalhao.diasDessecacaoPrePlantio,
              ),
            );
          }
          if (from < 16) {
            await addCronogramaSojaColumnIfMissing(
              this,
              migrator,
              'grupo_regulagem_id',
              () => migrator.addColumn(
                cronogramasSojaTalhao,
                cronogramasSojaTalhao.grupoRegulagemId,
              ),
            );
            await addCronogramaSojaColumnIfMissing(
              this,
              migrator,
              'plantio_definido',
              () => migrator.addColumn(
                cronogramasSojaTalhao,
                cronogramasSojaTalhao.plantioDefinido,
              ),
            );
            await customStatement(
              "UPDATE cronogramas_soja_talhao "
              "SET grupo_regulagem_id = uid "
              "WHERE grupo_regulagem_id IS NULL OR grupo_regulagem_id = ''",
            );
          }
          if (from < 17) {
            await addCronogramaSojaColumnIfMissing(
              this,
              migrator,
              'dias_antes_r8_dessecante',
              () => migrator.addColumn(
                cronogramasSojaTalhao,
                cronogramasSojaTalhao.diasAntesR8Dessecante,
              ),
            );
            await addCronogramaSojaColumnIfMissing(
              this,
              migrator,
              'dias_antecipacao_colheita_real',
              () => migrator.addColumn(
                cronogramasSojaTalhao,
                cronogramasSojaTalhao.diasAntecipacaoColheitaReal,
              ),
            );
            if (await cronogramaSojaTalhaoHasColumn(
              this,
              'dias_antecipacao_dessecacao_colheita',
            )) {
              await customStatement(
                'UPDATE cronogramas_soja_talhao '
                'SET dias_antecipacao_colheita_real = dias_antecipacao_dessecacao_colheita '
                'WHERE dias_antecipacao_colheita_real IS NULL '
                'OR dias_antecipacao_colheita_real = 0',
              );
            }
            await customStatement(
              'UPDATE cronogramas_soja_talhao '
              'SET dias_antes_r8_dessecante = 12 '
              'WHERE dias_antes_r8_dessecante IS NULL OR dias_antes_r8_dessecante = 0',
            );
          }
          if (from < 18) {
            await addEstadiosColumnIfMissing(
              this,
              migrator,
              'tipo_operacional',
              () => migrator.addColumn(estadios, estadios.tipoOperacional),
            );
            await addEstadiosColumnIfMissing(
              this,
              migrator,
              'operacional_config',
              () => migrator.addColumn(estadios, estadios.operacionalConfig),
            );
            await migrateEstadioOperacionalV18(this);
          }
          if (from < 19) {
            final talhoesSafraTable = await customSelect(
              "SELECT name FROM sqlite_master "
              "WHERE type = 'table' AND name = 'talhoes_safra'",
            ).get();
            if (talhoesSafraTable.isEmpty) {
              await migrator.createTable(talhoesSafra);
            }
            await migrateTalhoesSafraV19(this);
          }
          if (from < 20) {
            await migrateInstanciaRoteiroV20(this);
          }
          if (from < 21) {
            await addTalhoesSafraColumnIfMissing(
              this,
              migrator,
              'programa_operacional_ids',
              () => migrator.addColumn(
                talhoesSafra,
                talhoesSafra.programaOperacionalIds,
              ),
            );
            await migrateProgramaOperacionalIdsV21(this);
          }
          if (from < 22) {
            final cols = await customSelect(
              'PRAGMA table_info(sementes_talhao)',
            ).get();
            final jaTem =
                cols.any((r) => r.read<String>('name') == 'embalagens_manual');
            if (!jaTem) {
              await migrator.addColumn(
                sementesTalhao,
                sementesTalhao.embalagensManual,
              );
            }
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<bool> hasCompletedMigration(String key) async {
    final row = await (select(localMetadata)
          ..where((table) => table.key.equals(key)))
        .getSingleOrNull();
    return row?.value == 'completed';
  }

  Future<void> markMigrationCompleted(String key) {
    return into(localMetadata).insertOnConflictUpdate(
      LocalMetadataCompanion.insert(
        key: key,
        value: 'completed',
        updatedAt: DateTime.now(),
      ),
    );
  }
}
