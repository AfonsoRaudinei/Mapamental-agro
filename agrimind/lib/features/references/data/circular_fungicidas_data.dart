import '../domain/reference_models.dart';

/// Dados estáticos da Circular fungicidas (Embrapa CT-219 + Fundação MS).
///
/// Fonte: `estadio_doenca_1007.md` / `estadio_doenca_fungicida att 1007.md`.
abstract final class CircularFungicidasData {
  static const sources = [
    'Embrapa Soja CT-219 (safra 2024/25)',
    'Fundação MS Rede Multissítio 2024/25',
  ];

  static const _foxUltraFitotoxNote =
      'Fox Ultra sem multissítio apresenta fitotoxicidade elevada. Combinação com Milcozeb reduz fitotoxicidade e melhora controle de Cercospora.';

  static const _ferrugemRegistrados = <FungicidaRecommendation>[
    FungicidaRecommendation(
      rank: 1,
      product: 'Blindado TOV',
      activeIngredient: 'Picoxistrobina + Tebuconazol + Mancozebe',
      controlPercent: 76,
      productivityKgHa: 3808,
      fitotoxPercent: 4.8,
      source: 'Embrapa CT-219',
      notes: 'Maior controle de ferrugem entre registrados.',
    ),
    FungicidaRecommendation(
      rank: 2,
      product: 'Fox Ultra + Milcozeb',
      activeIngredient:
          'Impirfluxam + Protioconazol + Trifloxistrobina + Mancozebe',
      controlPercent: 75,
      productivityKgHa: 4028,
      fitotoxPercent: 2.7,
      source: 'Embrapa CT-219',
      notes: 'Melhor produtividade; $_foxUltraFitotoxNote',
    ),
    FungicidaRecommendation(
      rank: 3,
      product: 'Fox Supra + Milcozeb',
      activeIngredient: 'Impirfluxam + Protioconazol + Mancozebe',
      controlPercent: 74,
      productivityKgHa: 3957,
      fitotoxPercent: 2.8,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 4,
      product: 'Excalia Max + Tróia',
      activeIngredient: 'Impirfluxam + Tebuconazol + Mancozebe',
      controlPercent: 73,
      productivityKgHa: 3926,
      fitotoxPercent: 3.4,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 5,
      product: 'Almada',
      activeIngredient: 'Fluxapiroxade + Protioconazol + Mancozebe',
      controlPercent: 73,
      productivityKgHa: 3949,
      fitotoxPercent: 4.7,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 6,
      product: 'Curatis',
      activeIngredient: 'Picoxistrobina + Protioconazol + Mancozebe',
      controlPercent: 73,
      productivityKgHa: 3857,
      fitotoxPercent: 1.6,
      source: 'Embrapa CT-219',
      notes: 'Menor fitotoxicidade entre registrados.',
    ),
    FungicidaRecommendation(
      rank: 7,
      product: 'Tridium',
      activeIngredient: 'Azoxistrobina + Tebuconazol + Mancozebe',
      controlPercent: 71,
      productivityKgHa: 3875,
      fitotoxPercent: 4.7,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 8,
      product: 'Programa FRAC',
      activeIngredient: 'Rotação ISDH + IDM + IQe + multissítio',
      controlPercent: 70,
      productivityKgHa: 3884,
      fitotoxPercent: 3.6,
      source: 'Embrapa CT-219',
      notes: 'Rotação de modo de ação recomendada.',
    ),
    FungicidaRecommendation(
      rank: 9,
      product: 'Proteus',
      activeIngredient: 'Clorotalonil + Tebuconazol',
      controlPercent: 69,
      productivityKgHa: 3904,
      fitotoxPercent: 2.9,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 10,
      product: 'Cortina Gold',
      activeIngredient: 'Clorotalonil + Protioconazol',
      controlPercent: 68,
      productivityKgHa: 3855,
      fitotoxPercent: 3.5,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 11,
      product: 'Sugoy',
      activeIngredient: 'Clorotalonil + Impirfluxam + Metominostrobina',
      controlPercent: 67,
      productivityKgHa: 3693,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 12,
      product: 'Aproach Premium',
      activeIngredient: 'Picoxistrobina + Ciproconazol + Oxicloreto de cobre',
      controlPercent: 66,
      productivityKgHa: 3704,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 13,
      product: 'Fezan Gold',
      activeIngredient: 'Clorotalonil + Tebuconazol',
      controlPercent: 66,
      productivityKgHa: 3828,
      fitotoxPercent: 4.4,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 14,
      product: 'Evolution',
      activeIngredient: 'Azoxistrobina + Protioconazol + Mancozebe',
      controlPercent: 63,
      productivityKgHa: 3721,
      fitotoxPercent: 1.5,
      source: 'Embrapa CT-219',
    ),
    FungicidaRecommendation(
      rank: 15,
      product: 'Fox Ultra (sem Milcozeb)',
      activeIngredient: 'Impirfluxam + Protioconazol + Trifloxistrobina',
      controlPercent: 63,
      productivityKgHa: 3677,
      fitotoxPercent: 9.4,
      source: 'Embrapa CT-219',
      notes: _foxUltraFitotoxNote,
    ),
  ];

  static const _manchaAlvoMultissitios = <FungicidaRecommendation>[
    FungicidaRecommendation(
      rank: 1,
      product: 'Controller NT',
      activeIngredient: 'Mancozebe',
      controlPercent: 78.5,
      productivityKgHa: 4536,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 2,
      product: 'Manfil 800 WP',
      activeIngredient: 'Mancozebe',
      controlPercent: 78.1,
      productivityKgHa: 4776,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 3,
      product: 'Unizeb Gold',
      activeIngredient: 'Mancozebe',
      controlPercent: 74.0,
      productivityKgHa: 4560,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 4,
      product: 'Trizeb',
      activeIngredient: 'Mancozebe',
      controlPercent: 69.7,
      productivityKgHa: 4818,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 5,
      product: 'Status',
      activeIngredient: 'Oxicloreto de cobre',
      controlPercent: 68.9,
      productivityKgHa: 4764,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 6,
      product: 'Bravonil 720',
      activeIngredient: 'Clorotalonil',
      controlPercent: 67.3,
      productivityKgHa: 4434,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 7,
      product: 'Absoluto Fix',
      activeIngredient: 'Clorotalonil',
      controlPercent: 67.0,
      productivityKgHa: 4404,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 8,
      product: 'Reconil',
      activeIngredient: 'Oxicloreto de cobre',
      controlPercent: 64.1,
      productivityKgHa: 4764,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 9,
      product: 'Gift',
      activeIngredient: 'Mancozebe',
      controlPercent: 62.0,
      productivityKgHa: 4218,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 10,
      product: 'Sem multissítio',
      activeIngredient: 'Programa base com sítio-específico',
      controlPercent: 57.4,
      productivityKgHa: 4266,
      source: 'Fundação MS 2024/25',
      notes: 'Base comparativa; sem incremento de multissítio.',
    ),
  ];

  static const _cercosporaMultissitios = <FungicidaRecommendation>[
    FungicidaRecommendation(
      rank: 1,
      product: 'Unizeb Gold',
      activeIngredient: 'Mancozebe',
      controlPercent: 60.0,
      productivityKgHa: 4560,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 2,
      product: 'Manfil 800 WP',
      activeIngredient: 'Mancozebe',
      controlPercent: 59.5,
      productivityKgHa: 4776,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 3,
      product: 'Bravonil 720',
      activeIngredient: 'Clorotalonil',
      controlPercent: 58.3,
      productivityKgHa: 4434,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 4,
      product: 'Trizeb',
      activeIngredient: 'Mancozebe',
      controlPercent: 57.1,
      productivityKgHa: 4818,
      source: 'Fundação MS 2024/25',
    ),
    FungicidaRecommendation(
      rank: 5,
      product: 'Absoluto Fix',
      activeIngredient: 'Clorotalonil',
      controlPercent: 56.8,
      productivityKgHa: 4404,
      source: 'Fundação MS 2024/25',
    ),
  ];

  static const stages = <ReferenceStageEntry>[
    ReferenceStageEntry(
      stageCode: 'VE–V3',
      stageName: 'Emergência a 3º nó',
      aliases: ['VE', 'VC', 'V1', 'V2', 'V3'],
      diseases: [
        'Damping-off',
        'Mancha-parda',
        'Míldio',
        'Crestamento bacteriano',
      ],
      management:
          'Sem aplicação foliar recomendada em condições normais. Manejo via tratamento de sementes.',
      recommendations: [],
      incidences: {'Damping-off': '5–15%', 'Míldio (V3)': '8%'},
    ),
    ReferenceStageEntry(
      stageCode: 'V4',
      stageName: '4º nó',
      aliases: ['V4'],
      diseases: [
        'Mancha-alvo',
        'Oídio',
        'Crestamento bacteriano',
        'Míldio',
      ],
      primaryDisease: 'Mancha-alvo',
      management:
          'Avaliar primeira aplicação se Mancha-alvo + Oídio estiverem presentes.',
      incidences: {
        'Crestamento bacteriano': '12%',
        'Míldio': '15%',
      },
      recommendations: [
        ..._manchaAlvoMultissitios,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'V5',
      stageName: '5º nó',
      aliases: ['V5'],
      diseases: [
        'Antracnose',
        'Ferrugem asiática',
        'Mancha-alvo',
        'Crestamento bacteriano',
        'Míldio',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Primeira aplicação preventiva se Ferrugem + Mancha-alvo forem confirmadas na região.',
      incidences: {
        'Antracnose': '~40%',
        'Crestamento bacteriano': '18%',
        'Míldio': '15%',
      },
      recommendations: [
        ..._ferrugemRegistrados,
        ..._manchaAlvoMultissitios,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'V6',
      stageName: '6º nó',
      aliases: ['V6', 'V7'],
      diseases: [
        'Ferrugem asiática',
        'Oídio',
        'Mancha-alvo',
        'Pústula bacteriana',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Aplicação preventiva de ferrugem se vazio sanitário tardio ou cultivar suscetível.',
      recommendations: [
        ..._ferrugemRegistrados,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R1',
      stageName: 'Início da floração',
      aliases: ['R1'],
      diseases: [
        'Ferrugem asiática',
        'Antracnose',
        'Oídio',
        'Míldio',
        'Crestamento bacteriano',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Aplicação obrigatória se ferrugem confirmada na região. Ponto de decisão crítico.',
      incidences: {
        'Ferrugem asiática': '5–10%',
        'Antracnose': '50%',
        'Oídio': '20,25%',
      },
      recommendations: [
        ..._ferrugemRegistrados,
        ..._cercosporaMultissitios,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R2',
      stageName: 'Plena floração',
      aliases: ['R2'],
      diseases: [
        'Ferrugem asiática',
        'Mofo branco',
        'Pústula bacteriana',
        'Antracnose',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Segunda aplicação de ferrugem (intervalo 14 dias). Monitoramento para Mofo Branco. Rotacionar grupo FRAC.',
      incidences: {
        'Ferrugem asiática': '15–20%',
        'Mofo branco': '12%',
        'Pústula bacteriana': '15%',
      },
      recommendations: [
        ..._ferrugemRegistrados,
        FungicidaRecommendation(
          rank: 16,
          product: 'Fluazinam',
          activeIngredient: 'Multissítio',
          source: 'Embrapa CT-219',
          notes: 'Principal produto para mofo branco',
        ),
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R3',
      stageName: 'Início de vagem',
      aliases: ['R3'],
      diseases: [
        'Ferrugem asiática',
        'Mofo branco',
        'Antracnose',
        'Mancha-alvo',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Período crítico. Terceira aplicação de fungicida para ferrugem. Mancha-alvo e DFCs em ascensão.',
      incidences: {
        'Ferrugem asiática': '30–35%',
        'Mofo branco': '28%',
        'Antracnose': '60%',
      },
      recommendations: [
        ..._ferrugemRegistrados,
        ..._manchaAlvoMultissitios,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R4',
      stageName: 'Vagem desenvolvida',
      aliases: ['R4'],
      diseases: [
        'Ferrugem asiática',
        'Mofo branco',
        'Antracnose',
        'Mancha-alvo',
        'Mancha-parda',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Quarta aplicação de ferrugem se necessário. Preferir misturas com multissítio para reduzir fitotoxicidade.',
      incidences: {
        'Ferrugem asiática': '40–65%',
        'Mofo branco': '45%',
        'Antracnose': '70%',
      },
      recommendations: [
        ..._ferrugemRegistrados,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R5',
      stageName: 'Início do enchimento de grãos',
      aliases: ['R5', 'R5.1', 'R5.3', 'R5.5'],
      diseases: [
        'Ferrugem asiática',
        'DFCs / Cercospora',
        'Oídio',
        'Mancha-parda',
      ],
      primaryDisease: 'Ferrugem asiática',
      management:
          'Estádio mais crítico para Ferrugem. Última janela eficaz de aplicação. DFCs em ascensão.',
      incidences: {
        'Ferrugem asiática': '60–85%',
        'DFCs': '40%',
        'Oídio': '73,75%',
      },
      recommendations: [
        ..._ferrugemRegistrados,
        ..._cercosporaMultissitios,
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R6',
      stageName: 'Grão cheio',
      aliases: ['R6'],
      diseases: [
        'DFCs',
        'Ferrugem asiática',
        'Mancha-parda',
        'Cercospora',
        'Antracnose em vagem',
      ],
      primaryDisease: 'DFCs',
      management:
          'DFCs dominantes. Avaliar custo-benefício de nova aplicação.',
      incidences: {
        'DFCs': '60–90%',
        'Ferrugem asiática': '95%',
        'Mancha-parda': '45%',
      },
      recommendations: [
        FungicidaRecommendation(
          rank: 1,
          product: 'Trizeb',
          activeIngredient: 'Mancozebe',
          controlPercent: 57.1,
          source: 'Fundação MS 2024/25',
          notes: 'Maior produtividade em R6 (80,3 sc/ha)',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Manfil 800 WP',
          activeIngredient: 'Mancozebe',
          controlPercent: 59.5,
          source: 'Fundação MS 2024/25',
          notes: '79,6 sc/ha · Mancha-alvo 78,1%',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Unizeb Gold',
          activeIngredient: 'Mancozebe',
          controlPercent: 60.0,
          source: 'Fundação MS 2024/25',
          notes: 'Melhor eficácia Cercospora',
        ),
        FungicidaRecommendation(
          rank: 4,
          product: 'Status',
          activeIngredient: 'Oxicloreto de cobre',
          controlPercent: 56.3,
          source: 'Fundação MS 2024/25',
        ),
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R7',
      stageName: 'Início da maturação',
      aliases: ['R7'],
      diseases: [
        'DFCs',
        'Oídio',
        'Cercospora',
        'Macrophomina',
        'Mancha-parda',
      ],
      primaryDisease: 'DFCs',
      management:
          'Avaliar viabilidade econômica. Macrophomina sem controle foliar eficaz.',
      incidences: {
        'DFCs': '> 90%',
        'Oídio': '98,75%',
        'Macrophomina': '70%',
      },
      recommendations: [
        FungicidaRecommendation(
          rank: 1,
          product: 'Bravonil 720',
          activeIngredient: 'Clorotalonil',
          source: 'Fundação MS 2024/25',
          notes: 'Multissítio residual para DFCs',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Unizeb Gold',
          activeIngredient: 'Mancozebe',
          source: 'Fundação MS 2024/25',
          notes: 'Custo baixo, efeito protetor',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Tebuconazol + Clorotalonil',
          activeIngredient: 'IDM + multissítio',
          source: 'Embrapa CT-219',
          notes: 'Amplo espectro, curativos',
        ),
      ],
    ),
    ReferenceStageEntry(
      stageCode: 'R8',
      stageName: 'Maturação plena',
      aliases: ['R8'],
      diseases: [
        'Macrophomina',
        'Mancha-parda',
      ],
      primaryDisease: 'Macrophomina',
      management:
          'Sem aplicação recomendada. Colheita oportuna para evitar deterioração por umidade.',
      incidences: {
        'Macrophomina': '85%',
        'Mancha-parda': '85%',
      },
      recommendations: [],
    ),
  ];

  static ReferenceStageEntry? entryForStage(String codigo) {
    for (final stage in stages) {
      if (stage.matchesStage(codigo)) return stage;
    }
    return null;
  }

  static bool hasContentForStage(String codigo) {
    final entry = entryForStage(codigo);
    if (entry == null) return false;
    return entry.recommendations.isNotEmpty ||
        entry.diseases.isNotEmpty ||
        entry.management.isNotEmpty;
  }
}
