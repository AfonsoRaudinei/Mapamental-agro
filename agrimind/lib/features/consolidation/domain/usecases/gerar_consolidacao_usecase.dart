import '../../../plans/domain/entities/plano_entity.dart';
import '../entities/consolidacao_entity.dart';
import '../entities/consolidacao_item_entity.dart';

/// Gera a consolidação de um plano em memória.
///
/// Passos:
/// 1. Itera todos os estádios e produtos do plano.
/// 2. Agrupa por [produtoNome].
/// 3. Normaliza unidades mistas (mL→L, g→kg).
/// 4. Soma totais respeitando [totalOverride].
/// 5. Calcula custo se [precoUnitario] disponível.
/// 6. Ordena por categoria: Fungicida → Inseticida → Herbicida
///    → Fertilizante → Bioestimulante → Adjuvante.
class GerarConsolidacaoUseCase {
  const GerarConsolidacaoUseCase();

  /// Ordem das categorias na consolidação.
  static const List<String> _ordemCategorias = [
    'Fungicida',
    'Inseticida',
    'Herbicida',
    'Fertilizante',
    'Bioestimulante',
    'Adjuvante',
  ];

  ConsolidacaoEntity call(PlanoEntity plano) {
    // Mapa: produtoNome → lista de DetalheEstadio
    final Map<String, _Acumulador> acumuladores = {};

    for (final estadio in plano.estadios) {
      for (final produto in estadio.produtos) {
        final acum = acumuladores.putIfAbsent(
          produto.produtoNome,
          () => _Acumulador(
            produtoNome: produto.produtoNome,
            categoria: produto.produtoCategoria,
            precoUnitario: produto.precoUnitario,
          ),
        );

        // Normaliza dose e unidade para L ou kg
        final (totalNorm, unidadeNorm) = _normalizarTotal(
          produto.totalFinal,
          produto.doseUnidade,
        );

        acum.adicionar(
          DetalheEstadio(
            estadioCodigo: estadio.codigo,
            estadioLabel: estadio.label,
            dose: produto.dose,
            doseUnidade: produto.doseUnidade,
            areaHa: produto.areaHa,
            total: produto.totalFinal,
            isOverride: produto.isOverride,
            overrideMotivo: produto.overrideMotivo,
          ),
          totalNorm,
          unidadeNorm,
        );
      }
    }

    // Converte acumuladores em itens
    final itens = acumuladores.values.map((a) => a.toEntity()).toList();

    // Ordena por categoria (segundo _ordemCategorias)
    itens.sort((a, b) {
      final ia = _ordemCategorias.indexOf(a.categoria);
      final ib = _ordemCategorias.indexOf(b.categoria);
      final ca = ia == -1 ? 99 : ia;
      final cb = ib == -1 ? 99 : ib;
      if (ca != cb) return ca.compareTo(cb);
      return a.produtoNome.compareTo(b.produtoNome);
    });

    return ConsolidacaoEntity(
      plano: plano,
      geradoEm: DateTime.now(),
      itens: itens,
    );
  }

  // ── Normalização de unidades ─────────────────────────────────────────────

  /// Converte total para a unidade base (L ou kg).
  /// Retorna (valorNormalizado, unidadeNormalizada).
  static (double, String) _normalizarTotal(double total, String unidade) {
    switch (unidade) {
      case 'mL/ha':
        return (total / 1000, 'L');
      case 'g/ha':
        return (total / 1000, 'kg');
      case 'L/ha':
        return (total, 'L');
      case 'kg/ha':
        return (total, 'kg');
      case 'unid/ha':
        return (total, 'unid');
      default:
        return (total, unidade.replaceAll('/ha', '').trim());
    }
  }

  /// Retorna a unidade base a partir da unidade por hectare.
  static String unidadeBase(String unidadePorHa) {
    return _normalizarTotal(0, unidadePorHa).$2;
  }
}

// ── Acumulador interno ────────────────────────────────────────────────────────

class _Acumulador {
  _Acumulador({
    required this.produtoNome,
    required this.categoria,
    this.precoUnitario,
  });

  final String produtoNome;
  final String categoria;
  final double? precoUnitario;

  double _totalNorm = 0.0;
  String? _unidade;
  bool _temUnidadeMista = false;
  final List<DetalheEstadio> _detalhes = [];

  void adicionar(
    DetalheEstadio detalhe,
    double totalNorm,
    String unidadeNorm,
  ) {
    _detalhes.add(detalhe);
    _totalNorm += totalNorm;

    if (_unidade == null) {
      _unidade = unidadeNorm;
    } else if (_unidade != unidadeNorm) {
      _temUnidadeMista = true;
      // Mantém a unidade do primeiro, mas marca como mista
    }
  }

  ConsolidacaoItemEntity toEntity() => ConsolidacaoItemEntity(
        produtoNome: produtoNome,
        categoria: categoria,
        quantidadeTotal: double.parse(_totalNorm.toStringAsFixed(4)),
        unidade: _unidade ?? 'L',
        precoUnitario: precoUnitario,
        detalhe: List.unmodifiable(_detalhes),
        temUnidadeMista: _temUnidadeMista,
      );
}
