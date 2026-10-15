import '../../../clients/domain/cronograma_soja/cronograma_soja_linha.dart';
import '../entities/estadio_entity.dart';
import '../repositories/plans_repository.dart';

/// Aplica datas do cronograma nos estádios do plano vinculado à fazenda.
class SincronizarCronogramaSojaPlanoUseCase {
  const SincronizarCronogramaSojaPlanoUseCase(this._plansRepository);

  final PlansRepository _plansRepository;

  /// Retorna quantos estádios receberam [dataAplicacao].
  Future<int> call({
    required String fazendaId,
    required List<CronogramaSojaLinha> linhas,
  }) async {
    final planos = await _plansRepository.getAll();
    final candidatos = planos
        .where((p) => p.fazendaId == fazendaId && p.status != 'consolidado')
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    if (candidatos.isEmpty) return 0;
    return aplicarNoPlano(planoId: candidatos.first.id, linhas: linhas);
  }

  Future<int> aplicarNoPlano({
    required String planoId,
    required List<CronogramaSojaLinha> linhas,
  }) async {
    final full = await _plansRepository.getById(planoId);
    if (full == null) return 0;

    var atualizados = 0;
    for (final linha in linhas) {
      if (linha.tipo == CronogramaSojaLinhaTipo.plantio) continue;
      final estadio = _resolverEstadio(full.estadios, linha);
      if (estadio == null) continue;
      if (_sameDay(estadio.dataAplicacao, linha.data)) continue;
      await _plansRepository.updateEstadio(
        estadio.copyWith(dataAplicacao: linha.data),
      );
      atualizados++;
    }
    return atualizados;
  }
}

EstadioEntity? _resolverEstadio(
  List<EstadioEntity> estadios,
  CronogramaSojaLinha linha,
) {
  switch (linha.tipo) {
    case CronogramaSojaLinhaTipo.dessecacaoPrePlantio:
      return _porLabelDessecacaoPrePlantio(estadios);
    case CronogramaSojaLinhaTipo.emergencia:
      return _porCodigo(estadios, 'VE');
    case CronogramaSojaLinhaTipo.posEmergente:
      return _porLabelOuCodigo(
        estadios,
        codigo: 'V5',
        labelContains: 'pós-emergente',
      );
    case CronogramaSojaLinhaTipo.fungicida:
      final indice = linha.fungicidaIndice ?? 1;
      return _fungicidaPorIndice(estadios, indice);
    case CronogramaSojaLinhaTipo.colheitaEstimada:
      return _porCodigo(estadios, 'R8') ??
          _porLabelOuCodigo(
            estadios,
            codigo: 'R7',
            labelContains: 'colheita',
          );
    case CronogramaSojaLinhaTipo.dessecanteR7:
    case CronogramaSojaLinhaTipo.dessecacaoPreColheita:
      return _porLabelDessecacaoPreColheita(estadios);
    case CronogramaSojaLinhaTipo.colheitaReal:
      return _porLabelOuCodigo(
        estadios,
        codigo: 'R8',
        labelContains: 'colheita',
      );
    case CronogramaSojaLinhaTipo.plantio:
      return null;
  }
}

EstadioEntity? _porLabelDessecacaoPrePlantio(List<EstadioEntity> estadios) {
  for (final e in estadios) {
    final label = e.label.toLowerCase();
    if (label.contains('pré-plantio') || label.contains('pre-plantio')) {
      return e;
    }
  }
  return estadios
      .where((e) => e.isOperacional && e.label.contains('pré-plantio'))
      .firstOrNull;
}

EstadioEntity? _porLabelDessecacaoPreColheita(List<EstadioEntity> estadios) {
  for (final e in estadios) {
    final label = e.label.toLowerCase();
    if (label.contains('pré-colheita') ||
        label.contains('pre-colheita') ||
        label.contains('dessecação da soja') ||
        label.contains('dessecacao da soja')) {
      return e;
    }
  }
  for (final e in estadios) {
    if (e.isOperacional &&
        e.label.toLowerCase().contains('dessecação') &&
        e.label.toLowerCase().contains('soja')) {
      return e;
    }
  }
  return null;
}

EstadioEntity? _porCodigo(List<EstadioEntity> estadios, String codigo) {
  for (final e in estadios) {
    if (e.codigo == codigo && !e.isSementes) return e;
  }
  return null;
}

EstadioEntity? _porLabelOuCodigo(
  List<EstadioEntity> estadios, {
  required String codigo,
  required String labelContains,
}) {
  final normalized = labelContains.toLowerCase();
  for (final e in estadios) {
    final label = e.label.toLowerCase();
    if (label.contains(normalized) || label.contains('pos-emergente')) {
      return e;
    }
  }
  return _porCodigo(estadios, codigo);
}

const _fungicidaCodigos = [
  'V4',
  'R1',
  'R2',
  'R3',
  'R5.1',
  'R5.3',
  'R5.5',
  'R6',
];

EstadioEntity? _fungicidaPorIndice(List<EstadioEntity> estadios, int indice) {
  final codigo = _fungicidaCodigos.elementAtOrNull(indice - 1);
  if (codigo != null) {
    final match = _porCodigo(estadios, codigo);
    if (match != null) return match;
  }
  final operacionais = estadios.where((e) => e.isOperacional).toList()
    ..sort((a, b) => a.ordem.compareTo(b.ordem));
  return operacionais.elementAtOrNull(indice - 1);
}

bool _sameDay(DateTime? a, DateTime b) {
  if (a == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
