import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

List<ReferenciasTecnicasCompanion> buildCesbReferences() {
  ReferenciasTecnicasCompanion cesb({
    required String uid,
    required String estadio,
    required String titulo,
    required String focoManejo,
    required String praticas,
    required String padrao,
    String? descricao,
    String? destaque,
    String? fonte,
    String? safraReferencia,
    DateTime? dataReferencia,
    String? resultado,
    String? local,
    String? tipoFonte,
  }) =>
      ReferenciasTecnicasCompanion.insert(
        uid: uid,
        categoria: 'cesb',
        estadio: estadio,
        titulo: titulo,
        descricao: Value(descricao),
        focoManejo: Value(focoManejo),
        praticas: Value(praticas),
        padrao: Value(padrao),
        destaque: Value(destaque),
        fonte: Value(fonte),
        safraReferencia: Value(safraReferencia),
        dataReferencia: Value(dataReferencia),
        resultado: Value(resultado),
        local: Value(local),
        tipoFonte: Value(tipoFonte),
      );

  const tetoProdutivo =
      'Cases CESB acima de 120 sc/ha, mais que 100% acima da média nacional.';

  return [
    cesb(
      uid: 'cesb-v2-ve',
      estadio: 'VE',
      titulo: 'Construção de Perfil e Arranque',
      descricao: tetoProdutivo,
      focoManejo: 'Construção de perfil, arranque e antecipação',
      praticas: 'Correção profunda de solo com calagem/gessagem.\n'
          'Adubação de sistema antes da demanda aparecer.\n'
          'Tratamento de sementes com Auxina, Citocinina e Giberelina.\n'
          'Inoculação robusta com Bradyrhizobium e Azospirillum.\n'
          'Manejo biológico em tratamento de sementes, sulco ou foliar.',
      padrao: 'Manejo Biológico',
      destaque: 'Quase 100% dos campeões usam biológicos',
    ),
    cesb(
      uid: 'cesb-v2-v1',
      estadio: 'V1',
      titulo: 'Arranque pós-emergência',
      descricao:
          'Fase ainda ligada ao pré-plantio/VE: o resultado depende da construção feita antes da carência aparecer.',
      focoManejo: 'Uniformidade e vigor inicial',
      praticas: 'Conferir estande e vigor.\n'
          'Preservar inoculação e saúde de raiz.\n'
          'Acompanhar resposta inicial ao ambiente construído.',
      padrao: 'Antecipação',
    ),
    cesb(
      uid: 'cesb-v2-v2',
      estadio: 'V2',
      titulo: 'Base para estruturação',
      descricao:
          'Transição para V3-V6, quando começa a estruturação de ramificações e nós produtivos.',
      focoManejo: 'Preparar arquitetura vegetativa',
      praticas: 'Monitorar vigor, raiz e uniformidade.\n'
          'Antecipar correções antes da fase de maior ramificação.\n'
          'Ajustar manejo ao estádio real do talhão.',
      padrao: 'Monitoramento e Precisão',
    ),
    cesb(
      uid: 'cesb-v2-v3',
      estadio: 'V3',
      titulo: 'Estruturação e Ramificação',
      descricao:
          'V3-V6 é a janela para aumentar nós produtivos e ramificações laterais.',
      focoManejo: 'Aumentar nós produtivos',
      praticas: 'Aplicar micronutrientes como Mn, Zn e B.\n'
          'Usar bioestimulantes para ramificação lateral.\n'
          'Iniciar monitoramento rigoroso de pragas.\n'
          'Usar dados do talhão para intervenção cirúrgica.',
      padrao: 'Equilíbrio Hormonal',
      destaque: 'V3-V6: construção da arquitetura produtiva',
    ),
    cesb(
      uid: 'cesb-v2-v4',
      estadio: 'V4',
      titulo: 'Nós produtivos e ramificação',
      descricao:
          'Fase vegetativa em que micronutrientes e bioestimulantes sustentam expansão e ramificações.',
      focoManejo: 'Estruturar planta antes da floração',
      praticas: 'Priorizar Mn, Zn e B.\n'
          'Acompanhar pressão inicial de pragas.\n'
          'Ajustar intervenção conforme vigor e zonas de manejo.',
      padrao: 'Nutrologia Vegetal',
    ),
    cesb(
      uid: 'cesb-v2-v5',
      estadio: 'V5',
      titulo: 'Ramificação lateral',
      descricao:
          'A estratégia campeã mantém nutrição e balanço hormonal até V6 para ampliar potencial de estruturas.',
      focoManejo: 'Sustentar crescimento horizontal',
      praticas: 'Manter micronutrição preventiva.\n'
          'Preservar área foliar sadia.\n'
          'Monitorar pragas antes da entrada reprodutiva.',
      padrao: 'Equilíbrio Hormonal',
    ),
    cesb(
      uid: 'cesb-v2-v6',
      estadio: 'V6',
      titulo: 'Fechamento da estrutura vegetativa',
      descricao:
          'Último ponto da janela V3-V6 antes da estratégia focar fixação floral em R1-R2.',
      focoManejo: 'Consolidar potencial reprodutivo',
      praticas: 'Finalizar estruturação de nós.\n'
          'Revisar sanidade foliar e pragas.\n'
          'Preparar entrada preventiva para floração.',
      padrao: 'Monitoramento e Precisão',
    ),
    cesb(
      uid: 'cesb-v2-r1',
      estadio: 'R1',
      titulo: 'Fixação de Flores',
      descricao:
          'R1 é divisor de águas nos cases campeões; foliares de alta performance em R1, R3 e R5 são recorrentes.',
      focoManejo: 'Reduzir abortamento floral',
      praticas: 'Aplicar Cálcio e Boro para fixação.\n'
          'Usar reguladores de crescimento para equilíbrio hormonal.\n'
          'Fazer primeira aplicação preventiva de fungicidas.\n'
          'Focar Mancha-alvo e Ferrugem desde o início da floração.',
      padrao: 'Nutrologia Vegetal',
      destaque: 'R1: divisor de águas para teto produtivo',
    ),
    cesb(
      uid: 'cesb-v2-r2',
      estadio: 'R2',
      titulo: 'Fixação plena de estruturas',
      descricao:
          'R1-R2 concentram esforço para evitar abortamento e proteger estruturas reprodutivas.',
      focoManejo: 'Manter flores e estruturas fixadas',
      praticas: 'Manter CaB e balanço hormonal.\n'
          'Reduzir efeito de estresse térmico ou hídrico.\n'
          'Preservar sanidade foliar para vagens futuras.',
      padrao: 'Equilíbrio Hormonal',
    ),
    cesb(
      uid: 'cesb-v2-r3',
      estadio: 'R3',
      titulo: 'Definição do Potencial',
      descricao:
          'R3-R4 é momento crítico para número de vagens e definição do potencial produtivo.',
      focoManejo: 'Definir número de vagens',
      praticas: 'Usar bioestimulantes para retenção.\n'
          'Priorizar nutrição foliar rica em K e S.\n'
          'Manter índice de área foliar com folha sadia.\n'
          'Intervir por talhão conforme NDVI, mapas de calor e zonas de manejo.',
      padrao: 'Monitoramento e Precisão',
      destaque: 'R3-R4: definição do potencial',
    ),
    cesb(
      uid: 'cesb-v2-r4',
      estadio: 'R4',
      titulo: 'Manutenção do potencial',
      descricao:
          'R4 preserva o potencial definido em R3, sustentando vagens e folha sadia.',
      focoManejo: 'Proteger vagens e área foliar',
      praticas: 'Manter K e S disponíveis.\n'
          'Evitar perda de área foliar.\n'
          'Ajustar manejo por ambiente e estádio real.',
      padrao: 'Nutrologia Vegetal',
    ),
    cesb(
      uid: 'cesb-v2-r5',
      estadio: 'R5.1',
      titulo: 'Enchimento de Grãos',
      descricao:
          'R5.1-R5.5 foca PMG e translocação de fotoassimilados; R5 é outro divisor de águas nos campeões.',
      focoManejo: 'Aumentar Peso de Mil Grãos',
      praticas: 'Priorizar K, Mg e S para translocação.\n'
          'Evitar senescência precoce com proteção fungicida.\n'
          'Preservar folha sadia durante o enchimento.\n'
          'Manter nutrição conforme curva de absorção.',
      padrao: 'Nutrologia Vegetal',
      destaque: 'R5: foco em PMG',
    ),
    cesb(
      uid: 'cesb-v2-r53',
      estadio: 'R5.3',
      titulo: 'Translocação para grãos',
      descricao:
          'Enchimento intermediário exige folha funcional e nutrição para sustentar PMG.',
      focoManejo: 'Garantir fluxo de fotoassimilados',
      praticas: 'Manter K, Mg e S.\n'
          'Monitorar senescência e sanidade.\n'
          'Reavaliar proteção fungicida conforme pressão no talhão.',
      padrao: 'Nutrologia Vegetal',
    ),
    cesb(
      uid: 'cesb-v2-r55',
      estadio: 'R5.5',
      titulo: 'Finalização do PMG',
      descricao:
          'R5.5 fecha a janela crítica de enchimento e consolida peso final dos grãos.',
      focoManejo: 'Finalizar enchimento sem senescência precoce',
      praticas: 'Preservar folha sadia até o fim do enchimento.\n'
          'Garantir translocação final.\n'
          'Registrar resposta por zona de manejo.',
      padrao: 'Monitoramento e Precisão',
    ),
    ...buildCesbCaseReferences(cesb),
  ];
}

List<ReferenciasTecnicasCompanion> buildCesbCaseReferences(
  ReferenciasTecnicasCompanion Function({
    required String uid,
    required String estadio,
    required String titulo,
    required String focoManejo,
    required String praticas,
    required String padrao,
    String? descricao,
    String? destaque,
    String? fonte,
    String? safraReferencia,
    DateTime? dataReferencia,
    String? resultado,
    String? local,
    String? tipoFonte,
  }) cesb,
) {
  const disclaimer =
      'Constatação técnica CESB: case campeão não deve ser tratado como recomendação de manejo.';

  List<ReferenciasTecnicasCompanion> caseRefs({
    required String slug,
    required String campeao,
    required String produtor,
    required String consultor,
    required String fazenda,
    required String resultado,
    required String local,
    required String fonte,
    required String focoManejo,
    required String praticasBase,
    required Map<String, String> legendaPorEstadio,
    required List<String> estadios,
    required String destaque,
    required String padrao,
    required DateTime dataReferencia,
    required String dataOperacional,
  }) {
    return estadios
        .map(
          (estadio) => cesb(
            uid: 'cesb-2026-$slug-${estadio.toLowerCase().replaceAll('.', '')}',
            estadio: estadio,
            titulo: '$campeao — $estadio',
            descricao: [
              disclaimer,
              'Legenda da dica: ${legendaPorEstadio[estadio] ?? focoManejo}.',
              'Produtor campeão: $produtor.',
              'Fazenda: $fazenda. Consultor: $consultor.',
              dataOperacional,
            ].join('\n'),
            focoManejo: focoManejo,
            praticas: [
              'Dica do campeão: ${legendaPorEstadio[estadio] ?? focoManejo}.',
              praticasBase,
            ].join('\n'),
            padrao: padrao,
            destaque: destaque,
            fonte: fonte,
            safraReferencia: '2025/2026',
            dataReferencia: dataReferencia,
            resultado: resultado,
            local: local,
            tipoFonte: '18º Fórum Nacional CESB — Case campeão',
          ),
        )
        .toList();
  }

  return [
    ...caseRefs(
      slug: 'sul-nacional',
      campeao: 'Campeão Sul/Nacional',
      produtor: 'Lourival Ruthes',
      consultor: 'Daicon Godeski Moreira',
      fazenda: 'Agrícola Lourival Ruthes',
      resultado: '156,13 sc/ha',
      local: 'Major Vieira-SC',
      fonte: 'CESB / CONAB / IBRA / Agrymet / Agrymax / Produtor',
      focoManejo: 'Proteção de plantas e investimento contínuo em solo',
      praticasBase:
          'Constatações do case: decisões baseadas em dados de pesquisa, dedicação operacional e proteção de plantas.\n'
          'Estádios citados no manejo: V4, V6, R1, R3, R5 e R5.5.',
      legendaPorEstadio: const {
        'V4':
            'entrada vegetativa com fungicida e nutrição foliar para proteger o arranque.',
        'V6':
            'reforço sanitário antes da fase reprodutiva, com fungicidas e nutrição foliar.',
        'R1':
            'proteção da floração com fungicidas e nutrição para reduzir perda de estruturas.',
        'R3':
            'proteção de vagens e manutenção de folha ativa no início da definição produtiva.',
        'R5.1': 'preservação de área foliar e nutrição no enchimento de grãos.',
        'R5.5':
            'última proteção do enchimento para sustentar PMG até a maturação.',
      },
      estadios: const ['V4', 'V6', 'R1', 'R3', 'R5.1', 'R5.5'],
      destaque: 'Produtividade auditada: 156,13 sc/ha',
      padrao: 'Case Campeão',
      dataReferencia: DateTime(2025, 11, 11),
      dataOperacional: 'Semeadura em 11/11/2025.',
    ),
    ...caseRefs(
      slug: 'nordeste',
      campeao: 'Campeão Nordeste',
      produtor: 'Grupo Gorgen',
      consultor: 'Edinei Antônio Fugalli',
      fazenda: 'Fazenda Barcelona',
      resultado: '143,77 sc/ha',
      local: 'Riachão das Neves-BA',
      fonte: 'CESB / Produtor / CONAB / IBRA / Agrymet / Agrymex / Consultor',
      focoManejo: 'Construção de sistema com rotação, correção e bioinsumos',
      praticasBase:
          'Constatações do case: histórico com cinco culturas, correção/adubação de sistema e uso de bioinsumos no sulco.\n'
          'Estádios citados no manejo: V4, V7, R1, R3, R4, R5.1, R6 e R7.',
      legendaPorEstadio: const {
        'V4':
            'primeira combinação de fungicida, bioestimulante e nutrição foliar no vegetativo.',
        'V7': 'manutenção do vigor vegetativo antes da floração.',
        'R1':
            'entrada forte na floração com fungicidas, bioestimulante e nutrição.',
        'R3': 'proteção de vagens com fungicidas e multissítios.',
        'R4': 'aplicação aérea para sustentar enchimento e folha funcional.',
        'R5.1': 'proteção sanitária no começo do enchimento.',
        'R6': 'proteção final contra doenças no fim do enchimento.',
        'R7': 'dessecação operacional para fechamento do ciclo.',
      },
      estadios: const ['V4', 'V7', 'R1', 'R3', 'R4', 'R5.1', 'R6', 'R7'],
      destaque: 'Produtividade auditada: 143,77 sc/ha',
      padrao: 'Case Campeão',
      dataReferencia: DateTime(2025, 11, 3),
      dataOperacional: 'Semeadura em 03/11/2025.',
    ),
    ...caseRefs(
      slug: 'irrigado-nacional',
      campeao: 'Campeão Irrigado Nacional',
      produtor: 'Luis Fernando Benaglia de Oliveira',
      consultor: 'Dheividy Borges Fernandes',
      fazenda: 'Lago Bonito',
      resultado: '138,97 sc/ha',
      local: 'Mundo Novo-GO',
      fonte:
          'CESB / CONAB / IBRA / Agrymet / Agrymax / Brasmax / Produtor / Consultor',
      focoManejo: 'Rigor no plantio, manejo biológico/fisiológico e timing',
      praticasBase:
          'Constatações do case: plantio rigoroso, manejo biológico e fisiológico, e timing de aplicações.\n'
          'Estádios citados no manejo: V4, V8, R1, R3, R5.3, R5.4, R5.5 e R7.',
      legendaPorEstadio: const {
        'V4':
            'primeira proteção vegetativa com pacote sanitário e nutrição foliar.',
        'V8': 'pré-florada com reforço fisiológico e nutricional.',
        'R1': 'floração protegida por fungicidas, bioestimulantes e nutrição.',
        'R3': 'definição de vagens com proteção sanitária e fisiológica.',
        'R5.3': 'enchimento intermediário com foco em folha sadia.',
        'R5.4': 'continuidade da proteção no enchimento avançado.',
        'R5.5': 'fechamento do enchimento e preparação para dessecação.',
        'R7': 'dessecação no encerramento do ciclo.',
      },
      estadios: const ['V4', 'V8', 'R1', 'R3', 'R5.3', 'R5.4', 'R5.5', 'R7'],
      destaque: 'Produtividade auditada: 138,97 sc/ha',
      padrao: 'Case Campeão',
      dataReferencia: DateTime(2025, 10, 1),
      dataOperacional: 'Semeadura em 01/10/2025.',
    ),
    ...caseRefs(
      slug: 'norte',
      campeao: 'Campeão Norte',
      produtor: 'Pedro Foresto Crispim',
      consultor: 'Luiz Gabriel de Moraes Júnior',
      fazenda: 'Fazenda Bela',
      resultado: '136,64 sc/ha',
      local: 'Goiatins-TO',
      fonte:
          'CESB / CONAB / Agrymet / Agrymax / IBRA Megalab / Falker / Produtor / Consultor',
      focoManejo: 'Sistema de rotação, correção de solo e resposta por estádio',
      praticasBase:
          'Constatações do case: quatro culturas no histórico, correção de solo recorrente e adubação de sistema.\n'
          'Estádios citados no manejo: V2, V3, V6, V7, R1, R2, R5.1, R5.3 e R5.5.',
      legendaPorEstadio: const {
        'V2':
            'adubação inicial para sustentar arranque e perfil de solo construído.',
        'V3':
            'monitoramento e suporte vegetativo antes do fechamento de entrelinhas.',
        'V6': 'reforço vegetativo próximo da transição reprodutiva.',
        'V7':
            'fungicidas em pré-florada para entrar no reprodutivo com folha protegida.',
        'R1': 'uso de bioinsumo na floração para suporte fisiológico.',
        'R2': 'proteção sanitária em floração plena.',
        'R5.1': 'fungicidas e multissítio no início do enchimento.',
        'R5.3': 'nova proteção no enchimento intermediário.',
        'R5.5':
            'aplicação final do enchimento, registrada como R5.4/R5.5 no case.',
      },
      estadios: const [
        'V2',
        'V3',
        'V6',
        'V7',
        'R1',
        'R2',
        'R5.1',
        'R5.3',
        'R5.5'
      ],
      destaque: 'Produtividade auditada: 136,64 sc/ha',
      padrao: 'Case Campeão',
      dataReferencia: DateTime(2025, 11, 2),
      dataOperacional: 'Semeadura em 02/11/2025.',
    ),
    ...caseRefs(
      slug: 'sudeste',
      campeao: 'Campeão Sudeste',
      produtor: 'Agropecuária Três Irmãos',
      consultor: 'Túlio Madureira da Costa Xavier',
      fazenda: 'Fazenda Floresta',
      resultado: '122,66 sc/ha',
      local: 'Cambuquira-MG',
      fonte: 'CESB / CONAB / IBRA Megalab / Falker / Produtor / Consultor',
      focoManejo: 'Plantio uniforme, construção de solo e integração biológica',
      praticasBase:
          'Constatações do case: plantabilidade, profundidade efetiva e integração de biológicos ao manejo.\n'
          'Estádios citados no manejo: V2, V4, R1, R2, R3 e R5.',
      legendaPorEstadio: const {
        'V2': 'arranque com bioestimulante, bioinsumos e nutrição foliar.',
        'V4':
            'primeira proteção sanitária vegetativa com fungicidas e bioinsumo.',
        'R1': 'floração protegida com fungicidas, bioinsumo e nutrição.',
        'R2': 'manutenção de sanidade e nutrição na floração plena.',
        'R3': 'proteção de vagens com fungicidas e bioestimulante.',
        'R5.1': 'enchimento com proteção sanitária e suporte nutricional.',
      },
      estadios: const ['V2', 'V4', 'R1', 'R2', 'R3', 'R5.1'],
      destaque: 'Produtividade auditada: 122,66 sc/ha',
      padrao: 'Case Campeão',
      dataReferencia: DateTime(2025, 11, 10),
      dataOperacional: 'Semeadura em 10/11/2025.',
    ),
    ...caseRefs(
      slug: 'centro-oeste',
      campeao: 'Campeão Centro-Oeste',
      produtor: 'Rodolfo Paulo Schlatter',
      consultor: 'Fabiano Müller',
      fazenda: 'Monte Sinai',
      resultado: '118,36 sc/ha',
      local: 'Confresa-MT',
      fonte:
          'CESB / CONAB / IBRA / Agrymet / Agrymax / Brasmax / Produtor / Consultor',
      focoManejo: 'Perfil de solo, adubação antecipada e manejo por estádio',
      praticasBase:
          'Constatações do case: rotação com quatro culturas, correção de solo e manejo por aplicações em estádios definidos.\n'
          'Estádios citados no manejo: V2, V4, V5, R1, R4, R5.3 e R6/R7.',
      legendaPorEstadio: const {
        'V2': 'arranque com adubação foliar e suporte inicial.',
        'V4': 'entrada vegetativa para vigor, nutrição e proteção.',
        'V5': 'bioinsumo e fungicida antes da fase reprodutiva.',
        'R1': 'floração com bioinsumo, fungicida e multissítio.',
        'R4': 'enchimento inicial com bioinsumo e proteção sanitária.',
        'R5.3': 'granação com reforço foliar e fungicida.',
        'R6': 'dessecação operacional no fim do enchimento.',
        'R7': 'dessecação no encerramento do ciclo.',
      },
      estadios: const ['V2', 'V4', 'V5', 'R1', 'R4', 'R5.3', 'R6', 'R7'],
      destaque: 'Produtividade auditada: 118,36 sc/ha',
      padrao: 'Case Campeão',
      dataReferencia: DateTime(2025, 10, 30),
      dataOperacional: 'Semeadura em 30/10/2025.',
    ),
  ];
}
