import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/culturas_codec.dart';
import '../../domain/entities/produto_catalogo_entity.dart';
import 'catalog_cultivares_soja_seed.dart';
import 'catalog_nortox_nutricao_seed.dart';
import 'catalog_nortox_seed.dart';
import 'catalog_seed.dart';

/// Datasource local Drift para Catálogo de Produtos.
/// Inclui seed com ~30 produtos pré-cadastrados.
class CatalogLocalDatasource {
  CatalogLocalDatasource(this._database, {String? userId})
      : _scope = LocalUserScope(userId);

  final AppDatabase _database;
  final LocalUserScope _scope;
  final _uuid = const Uuid();

  // ── Mapeamento ─────────────────────────────────────────────────────────────

  ProdutoCatalogoEntity _toEntity(CatalogoProduto m) => ProdutoCatalogoEntity(
        id: m.uid,
        nomeComercial: m.nomeComercial,
        ingredienteAtivo: m.ingredienteAtivo,
        categoria: m.categoria,
        unidadePadrao: m.unidadePadrao,
        doseMin: m.doseMin,
        doseMax: m.doseMax,
        precoUnitario: m.precoUnitario,
        fabricante: m.fabricante,
        observacoes: m.observacoes,
        culturas: decodeCulturas(m.culturas),
        ativo: m.ativo,
        isSeed: m.isSeed,
        createdAt: m.createdAt,
        updatedAt: m.updatedAt,
      );

  CatalogoProdutosCompanion _toCompanion(ProdutoCatalogoEntity e) =>
      CatalogoProdutosCompanion.insert(
        uid: e.id,
        userId: e.isSeed ? const Value.absent() : Value(_scope.userId),
        nomeComercial: e.nomeComercial,
        ingredienteAtivo: Value(e.ingredienteAtivo),
        categoria: e.categoria,
        unidadePadrao: e.unidadePadrao,
        doseMin: Value(e.doseMin),
        doseMax: Value(e.doseMax),
        precoUnitario: Value(e.precoUnitario),
        fabricante: Value(e.fabricante),
        observacoes: Value(e.observacoes),
        culturas: Value(encodeCulturas(e.culturas)),
        ativo: Value(e.ativo),
        isSeed: Value(e.isSeed),
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  // ── Queries ────────────────────────────────────────────────────────────────

  Future<List<ProdutoCatalogoEntity>> getAll({
    bool includeInactive = false,
  }) async {
    final userId = _scope.optionalUserId;
    final query = _database.select(_database.catalogoProdutos);
    if (userId != null) {
      if (!includeInactive) {
        query.where(
          (row) =>
              (row.isSeed.equals(true) | row.userId.equals(userId)) &
              row.ativo.equals(true) &
              row.deletedAt.isNull(),
        );
      } else {
        query.where(
          (row) => row.isSeed.equals(true) | row.userId.equals(userId),
        );
      }
    } else if (!includeInactive) {
      query.where(
        (row) =>
            row.isSeed.equals(true) &
            row.ativo.equals(true) &
            row.deletedAt.isNull(),
      );
    } else {
      query.where((row) => row.isSeed.equals(true));
    }
    return (await query.get()).map(_toEntity).toList();
  }

  Future<List<ProdutoCatalogoEntity>> search(
    String query, {
    String? categoria,
    bool includeInactive = false,
  }) async {
    final q = query.toLowerCase();
    final all = await getAll(includeInactive: includeInactive);
    return all.where((p) {
      final matchNome = p.nomeComercial.toLowerCase().contains(q);
      final matchIa = p.ingredienteAtivo?.toLowerCase().contains(q) ?? false;
      final matchCat = categoria == null || p.categoria == categoria;
      final matchCultura = p.culturas.any((c) => c.toLowerCase().contains(q));
      return (matchNome || matchIa || matchCultura) && matchCat;
    }).toList();
  }

  Future<ProdutoCatalogoEntity?> getById(String uid) async {
    final userId = _scope.optionalUserId;
    final m = await (_database.select(_database.catalogoProdutos)
          ..where((row) {
            final owned = userId == null
                ? row.isSeed.equals(true)
                : row.isSeed.equals(true) | row.userId.equals(userId);
            return row.uid.equals(uid) & owned;
          }))
        .getSingleOrNull();
    if (m == null) return null;
    return _toEntity(m);
  }

  Future<ProdutoCatalogoEntity> create(ProdutoCatalogoEntity produto) async {
    final novo = produto.copyWith(
      id: _uuid.v4(),
      isSeed: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _database.into(_database.catalogoProdutos).insert(_toCompanion(novo));
    return novo;
  }

  Future<ProdutoCatalogoEntity> update(ProdutoCatalogoEntity produto) async {
    final existing = await getById(produto.id);
    if (existing == null) {
      throw Exception('Produto não encontrado: ${produto.id}');
    }
    final updated = produto.copyWith(updatedAt: DateTime.now());
    await _database
        .into(_database.catalogoProdutos)
        .insertOnConflictUpdate(_toCompanion(updated));
    return updated;
  }

  Future<void> toggleAtivo(String uid) async {
    final existing = await getById(uid);
    if (existing == null || existing.isSeed) return;
    final m = await (_database.select(_database.catalogoProdutos)
          ..where((row) => row.uid.equals(uid)))
        .getSingleOrNull();
    if (m == null) return;
    final now = DateTime.now();
    await (_database.update(_database.catalogoProdutos)
          ..where((row) => row.uid.equals(uid)))
        .write(
      CatalogoProdutosCompanion(
        ativo: Value(!m.ativo),
        updatedAt: Value(now),
        deletedAt: Value(m.ativo ? now : null),
        syncState: const Value('pending'),
      ),
    );
  }

  // ── Seed ~30 Produtos ──────────────────────────────────────────────────────

  Future<void> seedIfEmpty() async {
    final count = await _database.catalogoProdutos.count().getSingle();
    if (count == 0) {
      final now = DateTime.now();
      final produtos = [
        ...buildCatalogSeed(now, _uuid),
        ...buildNortoxCatalogSeed(now, _uuid),
        ...buildNortoxNutricaoCatalogSeed(now, _uuid),
      ];
      await _database.batch(
        (batch) => batch.insertAll(_database.catalogoProdutos, produtos),
      );
    }
    await ensureNortoxCatalogSeed(_database);
    await ensureNortoxNutricaoCatalogSeed(_database);
    await ensureCultivaresSojaCatalogSeed(_database);
  }
}
