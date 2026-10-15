import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/entities/settings_entity.dart';

class SettingsLocalDatasource {
  SettingsLocalDatasource(this._database, {String? userId})
      : _scope = LocalUserScope(userId);

  final AppDatabase _database;
  final LocalUserScope _scope;

  Future<SettingsEntity?> getSettings({String? uid}) async {
    final resolvedUid = uid ?? _scope.optionalUserId;
    if (resolvedUid != null) {
      final row = await (_database.select(_database.localUsers)
            ..where((row) => row.uid.equals(resolvedUid)))
          .getSingleOrNull();
      return row == null ? null : _toEntity(row);
    }
    return null;
  }

  /// Cria o perfil local a partir da sessão autenticada quando ainda não existe.
  Future<SettingsEntity> ensureProfile({
    required String uid,
    required String nome,
    required String email,
    String? avatarUrl,
  }) async {
    final existing = await getSettings(uid: uid);
    if (existing != null) return existing;

    final now = DateTime.now();
    return updateProfile(
      SettingsEntity(
        uid: uid,
        nome: nome,
        email: email,
        avatarUrl: avatarUrl,
        darkMode: false,
        appIconKey: 'principal',
        updatedAt: now,
      ),
    );
  }

  Future<SettingsEntity> updateProfile(SettingsEntity settings) async {
    final existing = await (_database.select(_database.localUsers)
          ..where((row) => row.uid.equals(settings.uid)))
        .getSingleOrNull();
    final now = DateTime.now();
    await _database.into(_database.localUsers).insertOnConflictUpdate(
          LocalUsersCompanion.insert(
            uid: settings.uid,
            nome: settings.nome,
            email: settings.email,
            telefone: Value(settings.telefone),
            empresa: Value(settings.empresa),
            craRegistro: Value(settings.craRegistro),
            avatarUrl: Value(settings.avatarUrl),
            darkMode: Value(settings.darkMode),
            appIconKey: Value(settings.appIconKey),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
    return settings.copyWith(updatedAt: now);
  }

  Future<void> setDarkMode(bool value) async {
    final current = await getSettings();
    if (current == null) return;
    await (_database.update(_database.localUsers)
          ..where((row) => row.uid.equals(current.uid)))
        .write(
      LocalUsersCompanion(
        darkMode: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setAppIcon(String iconKey) async {
    final current = await getSettings();
    if (current == null) return;
    await (_database.update(_database.localUsers)
          ..where((row) => row.uid.equals(current.uid)))
        .write(
      LocalUsersCompanion(
        appIconKey: Value(iconKey),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<Map<String, dynamic>> exportAllData() async {
    final userId = _scope.userId;
    final localUsers = await (_database.select(_database.localUsers)
          ..where((row) => row.uid.equals(userId)))
        .get();
    final clientes = await (_database.select(_database.clientes)
          ..where((row) => row.userId.equals(userId)))
        .get();
    final fazendas = await (_database.select(_database.fazendas)
          ..where((row) => row.userId.equals(userId)))
        .get();
    final talhoes = await (_database.select(_database.talhoes)
          ..where((row) => row.userId.equals(userId)))
        .get();
    final catalogoProdutos = await (_database.select(_database.catalogoProdutos)
          ..where(
            (row) => row.isSeed.equals(true) | row.userId.equals(userId),
          ))
        .get();
    final planos = await (_database.select(_database.planos)
          ..where((row) => row.userId.equals(userId)))
        .get();
    final estadios = await (_database.select(_database.estadios)
          ..where((row) => row.userId.equals(userId)))
        .get();
    final produtosAplicacao =
        await (_database.select(_database.produtosAplicacao)
              ..where((row) => row.userId.equals(userId)))
            .get();

    return {
      'schema': 'agrimind.settings-export.v1',
      'exportedAt': DateTime.now().toIso8601String(),
      'userId': userId,
      'localUsers': localUsers.map((row) => row.toJson()).toList(),
      'clientes': clientes.map((row) => row.toJson()).toList(),
      'fazendas': fazendas.map((row) => row.toJson()).toList(),
      'talhoes': talhoes.map((row) => row.toJson()).toList(),
      'catalogoProdutos': catalogoProdutos.map((row) => row.toJson()).toList(),
      'planos': planos.map((row) => row.toJson()).toList(),
      'estadios': estadios.map((row) => row.toJson()).toList(),
      'produtosAplicacao':
          produtosAplicacao.map((row) => row.toJson()).toList(),
    };
  }

  SettingsEntity _toEntity(LocalUser row) => SettingsEntity(
        uid: row.uid,
        nome: row.nome,
        email: row.email,
        telefone: row.telefone,
        empresa: row.empresa,
        craRegistro: row.craRegistro,
        avatarUrl: row.avatarUrl,
        darkMode: row.darkMode,
        appIconKey: row.appIconKey,
        updatedAt: row.updatedAt,
      );
}
