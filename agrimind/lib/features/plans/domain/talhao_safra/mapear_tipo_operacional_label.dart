import 'fungicida_aplicacao_label.dart';
import 'tipo_operacional.dart';

/// Resultado da migração de [EstadioEntity.label] legado para [TipoOperacional].
sealed class MapeamentoTipoOperacional {
  const MapeamentoTipoOperacional();
}

class TipoOperacionalMapeado extends MapeamentoTipoOperacional {
  const TipoOperacionalMapeado(this.tipo, {this.incluirAdubacao = false});

  final TipoOperacional tipo;
  final bool incluirAdubacao;
}

class TipoOperacionalIndefinido extends MapeamentoTipoOperacional {
  const TipoOperacionalIndefinido(this.textoOriginal);

  final String textoOriginal;
}

/// Alias de spec: [ProgramaOperacionalTipo].
typedef ProgramaOperacionalTipo = TipoOperacional;

/// Todos os tipos selecionáveis (exclui [TipoOperacional.indefinido]).
final programaOperacionalTiposDropdown = TipoOperacional.values
    .where((t) => t != TipoOperacional.indefinido)
    .toList();

/// Cards **OP** — sem plantio (plantio só no módulo Clientes / talhões).
const programaOperacionalTiposDropdownOperacao = [
  TipoOperacional.dessecacaoPrePlantio,
  TipoOperacional.adubacao,
];

/// Cards **fenológicos** (V1, V3…) — título = tipo de aplicação no estádio.
const programaOperacionalTiposDropdownEstadio = [
  TipoOperacional.posEmergente,
  TipoOperacional.fungicidaRecorrente,
  TipoOperacional.dessecacaoPreColheita,
  TipoOperacional.aplicacaoExtra,
];

MapeamentoTipoOperacional mapearLabelOperacionalParaTipo(String label) {
  final texto = _normalizar(label);
  if (texto.isEmpty) return const TipoOperacionalIndefinido('');

  for (final tipo in programaOperacionalTiposDropdown) {
    if (texto == _normalizar(tipo.label) ||
        texto == _normalizar(tipo.name)) {
      return TipoOperacionalMapeado(tipo);
    }
  }

  final plantioAdubacao = _tentarPlantioComAdubacao(texto);
  if (plantioAdubacao != null) return plantioAdubacao;

  final porAlias = _porAliases(texto);
  if (porAlias != null) return TipoOperacionalMapeado(porAlias);

  return TipoOperacionalIndefinido(label.trim());
}

TipoOperacionalMapeado? _tentarPlantioComAdubacao(String texto) {
  final adubacaoLabel = _normalizar(TipoOperacional.adubacao.label);
  final plantioLabel = _normalizar(TipoOperacional.plantio.label);
  if (!texto.contains(plantioLabel)) return null;
  if (!texto.contains(adubacaoLabel)) {
    return const TipoOperacionalMapeado(TipoOperacional.plantio);
  }
  return const TipoOperacionalMapeado(
    TipoOperacional.plantio,
    incluirAdubacao: true,
  );
}

TipoOperacional? _porAliases(String texto) {
  if (_contem(texto, ['dessecacao', 'dessecação']) &&
      _contem(texto, ['pre', 'pré', 'plantio', 'plant'])) {
    return TipoOperacional.dessecacaoPrePlantio;
  }
  if (_contem(texto, ['dessecacao', 'dessecação']) &&
      _contem(texto, ['colheita', 'soja', 'pre-colheita', 'pré-colheita'])) {
    return TipoOperacional.dessecacaoPreColheita;
  }
  if (_contem(texto, ['dessecacao', 'dessecação']) &&
      !texto.contains('plantio')) {
    return TipoOperacional.dessecacaoPrePlantio;
  }
  if (_contem(texto, ['plantio'])) return TipoOperacional.plantio;
  if (_contem(texto, ['adubacao', 'adubação'])) {
    return TipoOperacional.adubacao;
  }
  if (_contem(texto, ['pos', 'pós', 'emergente'])) {
    return TipoOperacional.posEmergente;
  }
  if (_contem(texto, ['fungicida', 'recorrente'])) {
    return TipoOperacional.fungicidaRecorrente;
  }
  return null;
}

bool _contem(String texto, List<String> partes) {
  for (final p in partes) {
    if (texto.contains(_normalizar(p))) return true;
  }
  return false;
}

String _normalizar(String value) {
  return value
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('à', 'a')
      .replaceAll('ã', 'a')
      .replaceAll('â', 'a')
      .replaceAll('é', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ô', 'o')
      .replaceAll('õ', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ç', 'c')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

String labelOperacionalParaCard(
  TipoOperacional tipo, {
  bool incluirAdubacao = false,
}) {
  if (tipo == TipoOperacional.plantio && incluirAdubacao) {
    return '${tipo.cardLabel} + ${TipoOperacional.adubacao.cardLabel}';
  }
  return tipo.cardLabel;
}

/// Label do card considerando a numeração entre cards fungicida-recorrente
/// irmãos no roteiro (ex.: "1ª aplicação — Fungicida (recorrente)").
String labelOperacionalComAplicacao(
  TipoOperacional tipo, {
  bool incluirAdubacao = false,
  int? aplicacaoIndice,
}) {
  if (tipo == TipoOperacional.fungicidaRecorrente &&
      aplicacaoIndice != null &&
      aplicacaoIndice > 0) {
    return labelAplicacaoFungicida(aplicacaoIndice);
  }
  return labelOperacionalParaCard(tipo, incluirAdubacao: incluirAdubacao);
}
