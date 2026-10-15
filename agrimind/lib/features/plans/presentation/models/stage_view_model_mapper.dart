import '../../../../core/utils/unit_converter.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/talhao_safra/mapear_tipo_operacional_label.dart';
import '../../domain/talhao_safra/tipo_operacional.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import 'product_view_model.dart';
import 'stage_view_model.dart';

abstract final class StageViewModelMapper {
  static StageViewModel fromEntity(EstadioEntity estadio) {
    final code = estadio.codigo == 'Operacional' ? 'OP' : estadio.codigo;
    final name = _stageDisplayName(estadio);
    final count = estadio.produtos.length;
    return StageViewModel(
      id: estadio.id,
      stageCode: code,
      title: '$code — $name',
      countLabel: _countLabel(count),
      products: estadio.produtos.map(_productViewModel).toList(growable: false),
    );
  }

  static String _countLabel(int count) {
    if (count == 0) return 'Nenhum produto';
    if (count == 1) return '1 produto';
    return '$count produtos';
  }

  static String _stageDisplayName(EstadioEntity estadio) {
    if (estadio.isOperacional) {
      final tipo = estadio.tipoOperacional;
      if (tipo != null && tipo != TipoOperacional.indefinido) {
        return labelOperacionalParaCard(
          tipo,
          incluirAdubacao: estadio.operacionalConfig?.incluirAdubacao ?? false,
        );
      }
    }
    final code = estadio.codigo;
    final label = estadio.label.trim();
    final prefix = '$code — ';
    if (label.startsWith(prefix)) return label.substring(prefix.length);
    if (label == code) return label;
    return label;
  }

  static ProductViewModel _productViewModel(ProdutoAplicacaoEntity produto) {
    return ProductViewModel(
      id: produto.id,
      name: produto.produtoNome,
      doseLabel: _formatDose(produto.dose, produto.doseUnidade),
      totalLabel: _formatTotal(produto.totalFinal, produto.doseUnidade),
      isActive: produto.dose > 0,
    );
  }

  static String _formatDose(double value, String unidade) {
    final displayValue = UnitConverter.valorDisplay(value, unidade);
    final decimals = displayValue < 10 ? 2 : 1;
    return '${displayValue.toStringAsFixed(decimals)} '
        '${UnitConverter.unidadeBase(unidade)}';
  }

  static String _formatTotal(double value, String unidade) {
    final displayValue = UnitConverter.valorDisplay(value, unidade);
    final decimals = displayValue < 10 ? 2 : 1;
    final unit = UnitConverter.unidadeTotal(unidade);
    return '${displayValue.toStringAsFixed(decimals)} $unit';
  }
}
