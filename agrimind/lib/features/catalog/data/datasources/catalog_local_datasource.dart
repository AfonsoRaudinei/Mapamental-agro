import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_user_scope.dart';
import '../../domain/entities/produto_catalogo_entity.dart';

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
        (row) => row.isSeed.equals(true) & row.ativo.equals(true) & row.deletedAt.isNull(),
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
      return (matchNome || matchIa) && matchCat;
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
    if (count > 0) return;

    final now = DateTime.now();
    final produtos = _buildSeed(now);
    await _database.batch(
      (batch) => batch.insertAll(_database.catalogoProdutos, produtos),
    );
  }

  List<CatalogoProdutosCompanion> _buildSeed(DateTime now) {
    final data = <Map<String, dynamic>>[
      // FUNGICIDAS
      {
        'nome': 'Fox Xpro',
        'ia': 'Trifloxistrobina + Protioconazol',
        'cat': 'Fungicida',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.6,
        'preco': 45.0,
        'fab': 'Bayer',
      },
      {
        'nome': 'Elatus',
        'ia': 'Azoxistrobina + Benzovindiflupir',
        'cat': 'Fungicida',
        'unid': 'kg/ha',
        'min': 0.15,
        'max': 0.2,
        'preco': 280.0,
        'fab': 'Syngenta',
      },
      {
        'nome': 'Orkestra SC',
        'ia': 'Fluxapiroxade + Piraclostrobina',
        'cat': 'Fungicida',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.4,
        'preco': 55.0,
        'fab': 'BASF',
      },
      {
        'nome': 'Priori Xtra',
        'ia': 'Azoxistrobina + Ciproconazol',
        'cat': 'Fungicida',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.5,
        'preco': 42.0,
        'fab': 'Syngenta',
      },
      {
        'nome': 'Opera',
        'ia': 'Piraclostrobina + Epoxiconazol',
        'cat': 'Fungicida',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 0.75,
        'preco': 35.0,
        'fab': 'BASF',
      },
      {
        'nome': 'Aproach Prima',
        'ia': 'Picoxistrobina + Ciproconazol',
        'cat': 'Fungicida',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.5,
        'preco': 48.0,
        'fab': 'Corteva',
      },
      // INSETICIDAS
      {
        'nome': 'Engeo Pleno',
        'ia': 'Tiametoxam + Lambda-cialotrina',
        'cat': 'Inseticida',
        'unid': 'mL/ha',
        'min': 100.0,
        'max': 200.0,
        'preco': 0.038,
        'fab': 'Syngenta',
      },
      {
        'nome': 'Karate Zeon',
        'ia': 'Lambda-cialotrina',
        'cat': 'Inseticida',
        'unid': 'mL/ha',
        'min': 200.0,
        'max': 300.0,
        'preco': 0.022,
        'fab': 'Syngenta',
      },
      {
        'nome': 'Intrepid 240 SC',
        'ia': 'Metoxifenozida',
        'cat': 'Inseticida',
        'unid': 'mL/ha',
        'min': 160.0,
        'max': 240.0,
        'preco': 0.05,
        'fab': 'Corteva',
      },
      {
        'nome': 'Ampligo',
        'ia': 'Clorantraniliprole + Lambda-cialotrina',
        'cat': 'Inseticida',
        'unid': 'mL/ha',
        'min': 250.0,
        'max': 350.0,
        'preco': 0.09,
        'fab': 'Syngenta',
      },
      {
        'nome': 'Lannate BR',
        'ia': 'Metomil',
        'cat': 'Inseticida',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 1.0,
        'preco': 25.0,
        'fab': 'Corteva',
      },
      // HERBICIDAS
      {
        'nome': 'Roundup Original',
        'ia': 'Glifosato',
        'cat': 'Herbicida',
        'unid': 'L/ha',
        'min': 2.0,
        'max': 3.0,
        'preco': 18.0,
        'fab': 'Bayer',
      },
      {
        'nome': 'Verdict R',
        'ia': 'Haloxifope-R-metílico',
        'cat': 'Herbicida',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 0.8,
        'preco': 75.0,
        'fab': 'Corteva',
      },
      {
        'nome': 'Poast',
        'ia': 'Setoxidim',
        'cat': 'Herbicida',
        'unid': 'L/ha',
        'min': 1.0,
        'max': 1.5,
        'preco': 55.0,
        'fab': 'BASF',
      },
      {
        'nome': 'Spider',
        'ia': 'Lactofen',
        'cat': 'Herbicida',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 0.8,
        'preco': 35.0,
        'fab': 'Nortox',
      },
      // FERTILIZANTES
      {
        'nome': 'Nutriplant',
        'ia': 'N-P-K + micronutrientes',
        'cat': 'Fertilizante',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 1.5,
        'preco': 30.0,
        'fab': 'Nutriplant',
      },
      {
        'nome': 'Booster Zn-Mn',
        'ia': 'Zinco + Manganês',
        'cat': 'Fertilizante',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 1.0,
        'preco': 28.0,
        'fab': 'Stoller',
      },
      {
        'nome': 'KaliPhos',
        'ia': 'Potássio + Fósforo',
        'cat': 'Fertilizante',
        'unid': 'L/ha',
        'min': 1.0,
        'max': 2.0,
        'preco': 32.0,
        'fab': 'Compo Expert',
      },
      {
        'nome': 'B-Mo Foliar',
        'ia': 'Boro + Molibdênio',
        'cat': 'Fertilizante',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.5,
        'preco': 22.0,
        'fab': 'Stoller',
      },
      // BIOESTIMULANTES
      {
        'nome': 'Stimulate',
        'ia': 'Cinetina + Ácido Indolbutírico + Ácido Giberélico',
        'cat': 'Bioestimulante',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 0.75,
        'preco': 38.0,
        'fab': 'Stoller',
      },
      {
        'nome': 'Locus',
        'ia': 'Auxinas + Citocininas + Giberelinas',
        'cat': 'Bioestimulante',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.5,
        'preco': 42.0,
        'fab': 'Koch',
      },
      {
        'nome': 'Acadian',
        'ia': 'Extrato de Ascophyllum nodosum',
        'cat': 'Bioestimulante',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 1.0,
        'preco': 45.0,
        'fab': 'Acadian',
      },
      {
        'nome': 'Rize',
        'ia': 'Microrganismos PGPR + Ácidos húmicos',
        'cat': 'Bioestimulante',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 1.0,
        'preco': 35.0,
        'fab': 'Agroterenas',
      },
      {
        'nome': 'MAX Vigor',
        'ia': 'Betaína + Aminoácidos',
        'cat': 'Bioestimulante',
        'unid': 'L/ha',
        'min': 0.3,
        'max': 0.5,
        'preco': 40.0,
        'fab': 'Fortgreen',
      },
      // ADJUVANTES
      {
        'nome': 'Nimbus',
        'ia': 'Óleo mineral',
        'cat': 'Adjuvante',
        'unid': 'mL/ha',
        'min': 500.0,
        'max': 1000.0,
        'preco': 0.012,
        'fab': 'Syngenta',
      },
      {
        'nome': 'Joint Oil',
        'ia': 'Óleo vegetal metilado',
        'cat': 'Adjuvante',
        'unid': 'L/ha',
        'min': 0.5,
        'max': 1.0,
        'preco': 15.0,
        'fab': 'Nufarm',
      },
      {
        'nome': 'Aureo',
        'ia': 'Óleo de soja',
        'cat': 'Adjuvante',
        'unid': 'mL/ha',
        'min': 500.0,
        'max': 1000.0,
        'preco': 0.01,
        'fab': 'BASF',
      },
    ];

    return data.map((d) {
      return CatalogoProdutosCompanion.insert(
        uid: _uuid.v4(),
        nomeComercial: d['nome'] as String,
        ingredienteAtivo: Value(d['ia'] as String?),
        categoria: d['cat'] as String,
        unidadePadrao: d['unid'] as String,
        doseMin: Value((d['min'] as num?)?.toDouble()),
        doseMax: Value((d['max'] as num?)?.toDouble()),
        precoUnitario: Value((d['preco'] as num?)?.toDouble()),
        fabricante: Value(d['fab'] as String?),
        ativo: const Value(true),
        isSeed: const Value(true),
        createdAt: now,
        updatedAt: now,
      );
    }).toList();
  }
}
