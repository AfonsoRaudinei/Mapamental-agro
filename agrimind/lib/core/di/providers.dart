import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../database/database_service.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/clients/data/datasources/clients_local_datasource.dart';
import '../../features/clients/data/datasources/confirmacoes_etapa_local_datasource.dart';
import '../../features/clients/data/repositories/clients_repository_impl.dart';
import '../../features/clients/domain/repositories/confirmacoes_etapa_repository.dart';
import '../../features/clients/domain/repositories/clients_repository.dart';
import '../../features/catalog/data/datasources/catalog_local_datasource.dart';
import '../../features/catalog/data/repositories/catalog_repository_impl.dart';
import '../../features/catalog/domain/repositories/catalog_repository.dart';
import '../../features/references/data/datasources/references_local_datasource.dart';
import '../../features/references/data/repositories/references_repository_impl.dart';
import '../../features/references/domain/repositories/references_repository.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/plans/data/datasources/plans_local_datasource.dart';
import '../../features/plans/data/repositories/plans_repository_impl.dart';
import '../../features/plans/domain/repositories/plans_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATABASE
// ─────────────────────────────────────────────────────────────────────────────

/// Banco SQLite ativo via Drift.
final databaseProvider = Provider<AppDatabase>(
  (ref) => DatabaseService.instance,
);

// ─────────────────────────────────────────────────────────────────────────────
// SPRINT 1 — AUTH
// ─────────────────────────────────────────────────────────────────────────────

final authDatasourceProvider = Provider<AuthRemoteDatasource>(
  (ref) => AuthRemoteDatasource(),
);

final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authDatasourceProvider)),
);

// ─────────────────────────────────────────────────────────────────────────────
// SPRINT 3 — CLIENTES
// ─────────────────────────────────────────────────────────────────────────────

final clientsDatasourceProvider = Provider<ClientsLocalDatasource>(
  (ref) => ClientsLocalDatasource(ref.read(databaseProvider)),
);

final clientsRepoProvider = Provider<ClientsRepository>(
  (ref) => ClientsRepositoryImpl(ref.read(clientsDatasourceProvider)),
);

final confirmacoesEtapaRepoProvider = Provider<ConfirmacoesEtapaRepository>(
  (ref) => ConfirmacoesEtapaLocalDatasource(ref.read(databaseProvider)),
);

// ─────────────────────────────────────────────────────────────────────────────
// SPRINT 4 — CATÁLOGO
// ─────────────────────────────────────────────────────────────────────────────

final catalogDatasourceProvider = Provider<CatalogLocalDatasource>(
  (ref) => CatalogLocalDatasource(ref.read(databaseProvider)),
);

final catalogRepoProvider = Provider<CatalogRepository>(
  (ref) => CatalogRepositoryImpl(ref.read(catalogDatasourceProvider)),
);

// ─────────────────────────────────────────────────────────────────────────────
// SPRINT 5 — REFERÊNCIAS
// ─────────────────────────────────────────────────────────────────────────────

final referencesDatasourceProvider = Provider<ReferencesLocalDatasource>(
  (ref) => ReferencesLocalDatasource(ref.read(databaseProvider)),
);

final referencesRepoProvider = Provider<ReferencesRepository>(
  (ref) => ReferencesRepositoryImpl(ref.read(referencesDatasourceProvider)),
);

// ─────────────────────────────────────────────────────────────────────────────
// SPRINT 8 — CONFIGURAÇÕES
// ─────────────────────────────────────────────────────────────────────────────

final settingsDatasourceProvider = Provider<SettingsLocalDatasource>(
  (ref) => SettingsLocalDatasource(ref.read(databaseProvider)),
);

final settingsRepoProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepositoryImpl(ref.read(settingsDatasourceProvider)),
);

// SPRINT 6 - PLANOS
final plansDatasourceProvider = Provider<PlansLocalDatasource>(
  (ref) => PlansLocalDatasource(ref.read(databaseProvider)),
);

final plansRepoProvider = Provider<PlansRepository>(
  (ref) => PlansRepositoryImpl(ref.read(plansDatasourceProvider)),
);
