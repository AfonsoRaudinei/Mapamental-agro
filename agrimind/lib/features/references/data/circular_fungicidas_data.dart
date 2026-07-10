import '../domain/reference_models.dart';

/// Dados estáticos da Circular fungicidas (Embrapa CT-219 + Fundação MS).
///
/// Fonte: `estadio_doenca_1007.md` / `estadio_doenca_fungicida att 1007.md`.
abstract final class CircularFungicidasData {
  static const sources = [
    'Embrapa Soja CT-219 (safra 2024/25)',
    'Fundação MS Rede Multissítio 2024/25',
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Controller NT',
          activeIngredient: 'Mancozebe',
          controlPercent: 78.5,
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
          source: 'Fundação MS 2024/25',
        ),
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Blindado TOV',
          activeIngredient: 'Picoxistrobina + Tebuconazol + Mancozebe',
          controlPercent: 76,
          productivityKgHa: 3808,
          fitotoxPercent: 4.8,
          source: 'Embrapa CT-219',
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
          notes: 'Melhor produtividade',
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Fox Ultra + Milcozeb',
          activeIngredient:
              'Impirfluxam + Protioconazol + Trifloxistrobina + Mancozebe',
          controlPercent: 75,
          productivityKgHa: 4028,
          fitotoxPercent: 2.7,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Fox Supra + Milcozeb',
          activeIngredient: 'Impirfluxam + Protioconazol + Mancozebe',
          controlPercent: 74,
          productivityKgHa: 3957,
          fitotoxPercent: 2.8,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Excalia Max + Tróia',
          activeIngredient: 'Impirfluxam + Tebuconazol + Mancozebe',
          controlPercent: 73,
          productivityKgHa: 3926,
          fitotoxPercent: 3.4,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 4,
          product: 'Almada',
          activeIngredient: 'Fluxapiroxade + Protioconazol + Mancozebe',
          controlPercent: 73,
          productivityKgHa: 3949,
          fitotoxPercent: 4.7,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 5,
          product: 'Proteus',
          activeIngredient: 'Clorotalonil + Tebuconazol',
          controlPercent: 69,
          productivityKgHa: 3904,
          fitotoxPercent: 2.9,
          source: 'Embrapa CT-219',
        ),
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Fox Ultra + Milcozeb',
          activeIngredient:
              'Impirfluxam + Protioconazol + Trifloxistrobina + Mancozebe',
          controlPercent: 75,
          productivityKgHa: 4028,
          fitotoxPercent: 2.7,
          source: 'Embrapa CT-219',
          notes: 'Melhor produtividade',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Blindado TOV',
          activeIngredient: 'Picoxistrobina + Tebuconazol + Mancozebe',
          controlPercent: 76,
          productivityKgHa: 3808,
          fitotoxPercent: 4.8,
          source: 'Embrapa CT-219',
          notes: 'Maior controle',
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
          product: 'Programa FRAC',
          activeIngredient: 'IDM + IQe + multissítio',
          controlPercent: 70,
          productivityKgHa: 3884,
          fitotoxPercent: 3.6,
          source: 'Embrapa CT-219',
          notes: 'Rotação ativa recomendada',
        ),
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Fox Ultra + Milcozeb',
          activeIngredient:
              'Impirfluxam + Protioconazol + Trifloxistrobina + Mancozebe',
          controlPercent: 75,
          productivityKgHa: 4028,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Almada + Mancozebe',
          activeIngredient: 'Fluxapiroxade + Protioconazol + Mancozebe',
          controlPercent: 73,
          productivityKgHa: 3949,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Curatis',
          activeIngredient: 'Programa IQe + IDM + multissítio',
          controlPercent: 73,
          productivityKgHa: 3857,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 4,
          product: 'Tridium',
          activeIngredient: 'Azoxistrobina + Tebuconazol + Mancozebe',
          controlPercent: 71,
          productivityKgHa: 3875,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 5,
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Programa FRAC',
          activeIngredient: 'IDM + IQe + multissítio (3ª aplic.)',
          controlPercent: 70,
          productivityKgHa: 3884,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Proteus',
          activeIngredient: 'Clorotalonil + Tebuconazol',
          controlPercent: 69,
          productivityKgHa: 3904,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Cortina Gold',
          activeIngredient: 'Clorotalonil + Protioconazol',
          controlPercent: 68,
          productivityKgHa: 3855,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 4,
          product: 'Tridium',
          activeIngredient: 'Azoxistrobina + Tebuconazol + Mancozebe',
          controlPercent: 71,
          productivityKgHa: 3875,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 5,
          product: 'Controller NT',
          activeIngredient: 'Mancozebe',
          controlPercent: 78.5,
          source: 'Fundação MS 2024/25',
          notes: 'Mancha-alvo — pico de pressão',
        ),
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Fox Ultra + Milcozeb',
          activeIngredient:
              'Impirfluxam + Protioconazol + Trifloxistrobina + Mancozebe',
          controlPercent: 75,
          productivityKgHa: 4028,
          fitotoxPercent: 2.7,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Excalia Max + Tróia',
          activeIngredient: 'Impirfluxam + Tebuconazol + Mancozebe',
          controlPercent: 73,
          productivityKgHa: 3926,
          fitotoxPercent: 3.4,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Almada',
          activeIngredient: 'Fluxapiroxade + Protioconazol + Mancozebe',
          controlPercent: 73,
          productivityKgHa: 3949,
          fitotoxPercent: 4.7,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 4,
          product: 'Blindado TOV',
          activeIngredient: 'Picoxistrobina + Tebuconazol + Mancozebe',
          controlPercent: 76,
          productivityKgHa: 3808,
          fitotoxPercent: 4.8,
          source: 'Embrapa CT-219',
          notes: 'Maior controle',
        ),
        FungicidaRecommendation(
          rank: 5,
          product: 'Curatis',
          activeIngredient: 'Programa IQe + IDM + multissítio',
          controlPercent: 73,
          productivityKgHa: 3857,
          fitotoxPercent: 1.6,
          source: 'Embrapa CT-219',
        ),
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
        FungicidaRecommendation(
          rank: 1,
          product: 'Fox Ultra + Milcozeb',
          activeIngredient:
              'Impirfluxam + Protioconazol + Trifloxistrobina + Mancozebe',
          controlPercent: 75,
          productivityKgHa: 4028,
          fitotoxPercent: 2.7,
          source: 'Embrapa CT-219',
          notes: 'Melhor custo-benefício',
        ),
        FungicidaRecommendation(
          rank: 2,
          product: 'Fox Supra + Milcozeb',
          activeIngredient: 'Impirfluxam + Protioconazol + Mancozebe',
          controlPercent: 74,
          productivityKgHa: 3957,
          fitotoxPercent: 2.8,
          source: 'Embrapa CT-219',
        ),
        FungicidaRecommendation(
          rank: 3,
          product: 'Blindado TOV',
          activeIngredient: 'Picoxistrobina + Tebuconazol + Mancozebe',
          controlPercent: 76,
          productivityKgHa: 3808,
          fitotoxPercent: 4.8,
          source: 'Embrapa CT-219',
          notes: 'Maior controle; maior fito.',
        ),
        FungicidaRecommendation(
          rank: 4,
          product: 'Unizeb Gold',
          activeIngredient: 'Mancozebe',
          controlPercent: 60.0,
          source: 'Fundação MS 2024/25',
          notes: 'DFCs — Crestamento foliar de Cercospora',
        ),
        FungicidaRecommendation(
          rank: 5,
          product: 'Manfil 800 WP',
          activeIngredient: 'Mancozebe',
          controlPercent: 59.5,
          source: 'Fundação MS 2024/25',
          notes: 'DFCs',
        ),
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
