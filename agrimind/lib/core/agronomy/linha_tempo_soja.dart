/// Modelos e cálculo da linha do tempo operacional da soja (plantio → colheita).
library;

/// Parâmetros fenológicos editáveis (defaults sugeridos, por cultivar no futuro).
class ParametrosFenologicosSoja {
  const ParametrosFenologicosSoja({
    required this.diasEmergencia,
    required this.daePosEmergente,
    required this.diasRecuperacaoPosEmergente,
    required this.intervaloFungicidaDias,
    required this.totalAplicacoesFungicida,
    required this.daeMaturacaoCiclo,
    required this.diasAntesR8Dessecante,
    required this.diasAntecipacaoColheitaReal,
    required this.diasDessecacaoPrePlantio,
  });

  final int diasEmergencia;
  final int daePosEmergente;
  final int diasRecuperacaoPosEmergente;
  final int intervaloFungicidaDias;
  final int totalAplicacoesFungicida;
  /// Ciclo da cultivar / DAE de maturação até R8 (fixo na colheita natural).
  final int daeMaturacaoCiclo;
  /// Campo 10 — dias antes do R8 natural para aplicação do dessecante (R7).
  final int diasAntesR8Dessecante;
  /// Campo 11 — antecipação real da colheita em relação ao R8 natural.
  final int diasAntecipacaoColheitaReal;
  /// Opcional: dessecação pré-plantio.
  final int diasDessecacaoPrePlantio;

  static const ParametrosFenologicosSoja padrao = ParametrosFenologicosSoja(
    diasEmergencia: 5,
    daePosEmergente: 25,
    diasRecuperacaoPosEmergente: 5,
    intervaloFungicidaDias: 15,
    totalAplicacoesFungicida: 4,
    daeMaturacaoCiclo: 110,
    diasAntesR8Dessecante: 12,
    diasAntecipacaoColheitaReal: 5,
    diasDessecacaoPrePlantio: 15,
  );
}

enum LinhaTempoSojaTipo {
  dessecacaoPrePlantio,
  plantio,
  emergencia,
  posEmergente,
  fungicida,
  dessecanteR7,
  colheitaReal,
  colheitaEstimada,
  /// Legado — mapeado para [dessecanteR7] em sync.
  dessecacaoPreColheita,
}

class LinhaTempoSojaItem {
  const LinhaTempoSojaItem({
    required this.etapa,
    required this.dae,
    required this.data,
    required this.tipo,
    this.fungicidaIndice,
    this.notaEtapa,
  });

  final String etapa;
  final int? dae;
  final DateTime data;
  final LinhaTempoSojaTipo tipo;
  final int? fungicidaIndice;
  final String? notaEtapa;
}

/// Gera a linha do tempo a partir da data de plantio e parâmetros.
List<LinhaTempoSojaItem> calcularLinhaTempoSoja({
  required DateTime dataPlantio,
  required ParametrosFenologicosSoja parametros,
}) {
  final plantio = _dateOnly(dataPlantio);
  final diasEmerg = parametros.diasEmergencia;
  final emergencia = plantio.add(Duration(days: diasEmerg));
  final posEmergente =
      emergencia.add(Duration(days: parametros.daePosEmergente));
  final primeiraFungicida = posEmergente.add(
    Duration(days: parametros.diasRecuperacaoPosEmergente),
  );

  final linhas = <LinhaTempoSojaItem>[];

  final diasPrePlantio = parametros.diasDessecacaoPrePlantio;
  if (diasPrePlantio > 0) {
    linhas.add(
      LinhaTempoSojaItem(
        etapa: 'Dessecação (pré-plantio)',
        dae: null,
        data: plantio.subtract(Duration(days: diasPrePlantio)),
        tipo: LinhaTempoSojaTipo.dessecacaoPrePlantio,
        notaEtapa: '$diasPrePlantio dias antes do plantio',
      ),
    );
  }

  linhas.addAll([
    LinhaTempoSojaItem(
      etapa: 'Plantio',
      dae: null,
      data: plantio,
      tipo: LinhaTempoSojaTipo.plantio,
    ),
    LinhaTempoSojaItem(
      etapa: 'Emergência ($diasEmerg dias)',
      dae: 0,
      data: emergencia,
      tipo: LinhaTempoSojaTipo.emergencia,
    ),
    LinhaTempoSojaItem(
      etapa: 'Pós-emergente',
      dae: parametros.daePosEmergente,
      data: posEmergente,
      tipo: LinhaTempoSojaTipo.posEmergente,
    ),
  ]);

  final total = parametros.totalAplicacoesFungicida;
  if (total > 0) {
    final recuperacao = parametros.diasRecuperacaoPosEmergente;
    final intervalo = parametros.intervaloFungicidaDias;

    var dataFung = primeiraFungicida;
    var daeFung = parametros.daePosEmergente + recuperacao;

    for (var n = 1; n <= total; n++) {
      final etapa = n == 1
          ? 'Recuperação do pós-emergente ($recuperacao dias) → 1ª aplicação fungicida'
          : '$nª aplicação fungicida (+$intervalo dias)';
      linhas.add(
        LinhaTempoSojaItem(
          etapa: etapa,
          dae: daeFung,
          data: dataFung,
          tipo: LinhaTempoSojaTipo.fungicida,
          fungicidaIndice: n,
        ),
      );
      if (n < total && total > 1) {
        dataFung = dataFung.add(Duration(days: intervalo));
        daeFung += intervalo;
      }
    }
  }

  final ciclo = parametros.daeMaturacaoCiclo;
  if (ciclo > 0) {
    final colheitaR8 = plantio.add(Duration(days: ciclo));
    final daeR8 = _daeDesdeEmergencia(emergencia, colheitaR8);

    final diasR7 = parametros.diasAntesR8Dessecante;
    final diasColheitaReal = parametros.diasAntecipacaoColheitaReal;
    final camposIndependentes = diasR7 != diasColheitaReal;

    if (diasR7 > 0 && diasR7 < ciclo && camposIndependentes) {
      final dataDessec = colheitaR8.subtract(Duration(days: diasR7));
      linhas.add(
        LinhaTempoSojaItem(
          etapa: 'Aplicação do dessecante (R7)',
          dae: _daeDesdeEmergencia(emergencia, dataDessec),
          data: dataDessec,
          tipo: LinhaTempoSojaTipo.dessecanteR7,
          notaEtapa:
              'Aplicado $diasR7 dias antes do ponto de colheita natural (R8)',
        ),
      );
    }

    if (diasColheitaReal > 0 &&
        diasColheitaReal < ciclo &&
        camposIndependentes) {
      final dataReal = colheitaR8.subtract(Duration(days: diasColheitaReal));
      linhas.add(
        LinhaTempoSojaItem(
          etapa: 'Colheita real (após dessecação)',
          dae: _daeDesdeEmergencia(emergencia, dataReal),
          data: dataReal,
          tipo: LinhaTempoSojaTipo.colheitaReal,
          notaEtapa: 'Antecipa a colheita em $diasColheitaReal dias',
        ),
      );
    }

    linhas.add(
      LinhaTempoSojaItem(
        etapa: 'Colheita estimada (R8 — natural)',
        dae: daeR8,
        data: colheitaR8,
        tipo: LinhaTempoSojaTipo.colheitaEstimada,
      ),
    );
  }

  return linhas;
}

int _daeDesdeEmergencia(DateTime emergencia, DateTime data) {
  return _dateOnly(data).difference(_dateOnly(emergencia)).inDays;
}

/// Texto resumo exibido abaixo da tabela.
String resumoCronogramaSojaCompleto(ParametrosFenologicosSoja p) {
  final fung = resumoProgramaFungicidaSoja(p);
  final partes = <String>[fung];
  if (p.daeMaturacaoCiclo > 0) {
    partes.add(
      'Colheita natural (R8) aos ${p.daeMaturacaoCiclo} dias do plantio — '
      'referência fixa do ciclo.',
    );
  }
  if (p.diasAntesR8Dessecante > 0 &&
      p.daeMaturacaoCiclo > p.diasAntesR8Dessecante &&
      p.diasAntesR8Dessecante != p.diasAntecipacaoColheitaReal) {
    partes.add(
      'Dessecante (R7) ${p.diasAntesR8Dessecante} dias antes do R8 natural.',
    );
  }
  if (p.diasAntecipacaoColheitaReal > 0 &&
      p.daeMaturacaoCiclo > p.diasAntecipacaoColheitaReal &&
      p.diasAntesR8Dessecante != p.diasAntecipacaoColheitaReal) {
    partes.add(
      'Colheita real antecipa o R8 em ${p.diasAntecipacaoColheitaReal} dias.',
    );
  }
  if (p.diasDessecacaoPrePlantio > 0) {
    partes.add(
      'Dessecação pré-plantio ${p.diasDessecacaoPrePlantio} dias antes do plantio.',
    );
  }
  return partes.join(' ');
}

/// Texto resumo do programa de fungicidas.
String resumoProgramaFungicidaSoja(ParametrosFenologicosSoja p) {
  if (p.totalAplicacoesFungicida <= 0) {
    return 'Nenhuma aplicação de fungicida configurada.';
  }
  if (p.totalAplicacoesFungicida == 1) {
    return 'Total: 1 aplicação de fungicida, '
        '${p.diasRecuperacaoPosEmergente} dias após o pós-emergente (recuperação).';
  }
  return 'Total: ${p.totalAplicacoesFungicida} aplicações de fungicida, '
      'intervalo de ${p.intervaloFungicidaDias} dias entre elas, '
      'começando ${p.diasRecuperacaoPosEmergente} dias após o pós-emergente (recuperação).';
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
