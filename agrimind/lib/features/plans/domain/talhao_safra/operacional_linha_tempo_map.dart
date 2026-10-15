import '../../../../core/agronomy/linha_tempo_soja.dart';
import 'tipo_operacional.dart';

/// Vínculo entre linha do cronograma e tipo/regra operacional no canvas.
class OperacionalLinhaSpec {
  const OperacionalLinhaSpec({
    required this.tipo,
    required this.regra,
  });

  final TipoOperacional tipo;
  final RegraCalculoOperacional regra;
}

OperacionalLinhaSpec? operacionalSpecParaLinha(LinhaTempoSojaTipo tipo) {
  switch (tipo) {
    case LinhaTempoSojaTipo.dessecacaoPrePlantio:
      return const OperacionalLinhaSpec(
        tipo: TipoOperacional.dessecacaoPrePlantio,
        regra: RegraCalculoOperacional.dataFixa,
      );
    case LinhaTempoSojaTipo.plantio:
      return const OperacionalLinhaSpec(
        tipo: TipoOperacional.plantio,
        regra: RegraCalculoOperacional.referenciaPlantio,
      );
    case LinhaTempoSojaTipo.posEmergente:
      return const OperacionalLinhaSpec(
        tipo: TipoOperacional.posEmergente,
        regra: RegraCalculoOperacional.porDae,
      );
    case LinhaTempoSojaTipo.dessecanteR7:
    case LinhaTempoSojaTipo.dessecacaoPreColheita:
      return const OperacionalLinhaSpec(
        tipo: TipoOperacional.dessecacaoPreColheita,
        regra: RegraCalculoOperacional.porDae,
      );
    case LinhaTempoSojaTipo.colheitaReal:
      return null;
    case LinhaTempoSojaTipo.emergencia:
    case LinhaTempoSojaTipo.fungicida:
    case LinhaTempoSojaTipo.colheitaEstimada:
      return null;
  }
}

int ordemCanvasParaTipo(TipoOperacional tipo) {
  switch (tipo) {
    case TipoOperacional.dessecacaoPrePlantio:
      return 10;
    case TipoOperacional.plantio:
      return 20;
    case TipoOperacional.adubacao:
      return 25;
    case TipoOperacional.posEmergente:
      return 30;
    case TipoOperacional.fungicidaRecorrente:
      return 40;
    case TipoOperacional.dessecacaoPreColheita:
      return 200;
    case TipoOperacional.aplicacaoExtra:
      return 35;
    case TipoOperacional.indefinido:
      return 999;
  }
}
