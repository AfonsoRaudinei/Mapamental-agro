import 'package:agrimind/core/database/estadio_v8_migration.dart';
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
  TextColumn get label => text()();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
  DateTimeColumn get dataAplicacao => dateTime().nullable()();
  TextColumn get imageLocalPath => text().nullable()();
  TextColumn get observacao => text().nullable()();
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

class LocalMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
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
    LocalMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'agrimind'));

  @override
  int get schemaVersion => 4;

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
