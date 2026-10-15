import '../entities/estadio_entity.dart';
import '../entities/programa_operacional_entity.dart';
import 'tipo_operacional.dart';

/// Marca estádio operacional como card do roteiro-mãe (sem dono / talhão).
const String kObservacaoRoteiroTemplate = 'roteiroTemplate=1';

bool estadioEhRoteiroTemplate(EstadioEntity estadio) {
  if (!estadio.isOperacional) return false;
  final obs = estadio.observacao ?? '';
  if (obs.contains(kObservacaoRoteiroTemplate)) return true;
  return !obs.contains('talhaoId=');
}

bool estadioEhInstanciaTalhao(EstadioEntity estadio) {
  if (!estadio.isOperacional) return false;
  final obs = estadio.observacao ?? '';
  return obs.contains('talhaoId=') && !obs.contains(kObservacaoRoteiroTemplate);
}

/// Cards visíveis no canvas do plano: roteiro-mãe + fenológicos + sementes.
bool estadioVisivelNoCanvasRoteiro(EstadioEntity estadio) {
  if (!estadio.isOperacional) return true;
  if (estadio.isSubcardFungicida) return false;
  if (estadio.operacionalConfig?.fungicidaPaiEstadioId != null) return false;
  return estadioEhRoteiroTemplate(estadio);
}

String? talhaoIdNaObservacaoEstadio(EstadioEntity estadio) {
  final obs = estadio.observacao ?? '';
  final match = RegExp(r'talhaoId=([^;]+)').firstMatch(obs);
  return match?.group(1);
}

String? templateEstadioIdNaObservacao(EstadioEntity estadio) {
  final obs = estadio.observacao ?? '';
  final match = RegExp(r'templateEstadioId=([^;]+)').firstMatch(obs);
  return match?.group(1);
}

bool instanciaTalhaoParaTemplate(
  EstadioEntity estadio,
  String talhaoId,
  String templateEstadioId,
) {
  if (!estadioEhInstanciaTalhao(estadio)) return false;
  if (talhaoIdNaObservacaoEstadio(estadio) != talhaoId) return false;
  return templateEstadioIdNaObservacao(estadio) == templateEstadioId;
}

bool estadioInstanciaExisteParaTemplate(
  List<EstadioEntity> estadios,
  String talhaoId,
  String templateEstadioId,
) {
  return estadios.any(
    (e) => instanciaTalhaoParaTemplate(e, talhaoId, templateEstadioId),
  );
}

/// Cards do roteiro-mãe com fungicida (fenológico ou OP), ordenados por `ordem`.
List<EstadioEntity> templatesFungicidaRoteiro(List<EstadioEntity> estadios) {
  return estadios
      .where(
        (e) =>
            e.tipoOperacional == TipoOperacional.fungicidaRecorrente &&
            !estadioEhInstanciaTalhao(e) &&
            !e.isSubcardFungicida &&
            e.operacionalConfig?.fungicidaPaiEstadioId == null,
      )
      .toList()
    ..sort((a, b) => a.ordem.compareTo(b.ordem));
}

/// Rótulo do talhão para selo no canvas (nome cadastrado ou genérico).
String rotuloTalhaoInstanciaCanvas(
  EstadioEntity estadio,
  Map<String, String> nomesPorTalhaoId,
) {
  if (!estadioEhInstanciaTalhao(estadio)) return '';
  final id = talhaoIdNaObservacaoEstadio(estadio);
  if (id == null || id.isEmpty) return 'Talhão';
  final nome = nomesPorTalhaoId[id]?.trim();
  if (nome != null && nome.isNotEmpty) return nome;
  return 'Talhão';
}

/// Modo template (padrão) ou recorte por talhão (só instâncias dele).
bool estadioVisivelNoCanvasPlano(
  EstadioEntity estadio, {
  String? filtroTalhaoId,
}) {
  if (filtroTalhaoId == null || filtroTalhaoId.isEmpty) {
    return estadioVisivelNoCanvasRoteiro(estadio);
  }
  if (!estadio.isOperacional) return true;
  return estadioEhInstanciaTalhao(estadio) &&
      talhaoIdNaObservacaoEstadio(estadio) == filtroTalhaoId;
}

EstadioEntity? templateOperacionalPorTipo(
  List<EstadioEntity> estadios,
  TipoOperacional tipo,
) {
  return estadios
      .where(
        (e) =>
            e.isOperacional &&
            e.tipoOperacional == tipo &&
            !e.isSubcardFungicida &&
            estadioEhRoteiroTemplate(e),
      )
      .firstOrNull;
}

EstadioEntity? templateFungicidaPai(List<EstadioEntity> estadios) {
  return templateOperacionalPorTipo(
    estadios,
    TipoOperacional.fungicidaRecorrente,
  );
}

List<EstadioEntity> subcardsTemplateDoPai(
  List<EstadioEntity> estadios,
  String paiTemplateId,
) {
  return estadios
      .where(
        (e) =>
            e.isOperacional &&
            e.isSubcardFungicida &&
            e.operacionalConfig?.fungicidaPaiEstadioId == paiTemplateId,
      )
      .toList()
    ..sort(
      (a, b) => (a.operacionalConfig?.aplicacaoIndice ?? 0)
          .compareTo(b.operacionalConfig?.aplicacaoIndice ?? 0),
    );
}

String observacaoInstanciaTalhao(String talhaoId, {String? templateEstadioId}) {
  final parts = <String>['talhaoId=$talhaoId', 'instanciaRoteiro=1'];
  if (templateEstadioId != null) {
    parts.add('templateEstadioId=$templateEstadioId');
  }
  return parts.join(';');
}

ProgramaOperacionalEntity? programaTalhaoPorTipo(
  List<ProgramaOperacionalEntity> programas,
  String talhaoId,
  TipoOperacional tipo,
) {
  return programas
      .where(
        (p) =>
            p.talhaoId == talhaoId &&
            p.tipo == tipo &&
            !p.isAplicacaoFungicida &&
            (tipo != TipoOperacional.fungicidaRecorrente ||
                p.isProgramaFungicidaPai),
      )
      .firstOrNull;
}
