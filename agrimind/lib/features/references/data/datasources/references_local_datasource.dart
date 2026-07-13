import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/referencia_tecnica_entity.dart';

/// Datasource local Drift para Referências Técnicas.
/// Inclui seed com dados agronômicos por categoria/estádio.
class ReferencesLocalDatasource {
  ReferencesLocalDatasource(this._database);

  final AppDatabase _database;

  ReferenciaTecnicaEntity _toEntity(ReferenciasTecnica m) =>
      ReferenciaTecnicaEntity(
        id: m.uid,
        categoria: m.categoria,
        estadio: m.estadio,
        titulo: m.titulo,
        descricao: m.descricao,
        focoManejo: m.focoManejo,
        praticas: m.praticas,
        padrao: m.padrao,
        destaque: m.destaque,
      );

  // ── Queries ────────────────────────────────────────────────────────────────

  Future<List<ReferenciaTecnicaEntity>> getByCategoria(
    String categoria,
  ) async {
    final models = await (_database.select(_database.referenciasTecnicas)
          ..where((row) => row.categoria.equals(categoria)))
        .get();
    return models.map(_toEntity).toList();
  }

  Future<List<ReferenciaTecnicaEntity>> getByEstadio(
    String categoria,
    String estadio,
  ) async {
    final models = await (_database.select(_database.referenciasTecnicas)
          ..where(
            (row) =>
                row.categoria.equals(categoria) & row.estadio.equals(estadio),
          ))
        .get();
    return models.map(_toEntity).toList();
  }

  Future<List<ReferenciaTecnicaEntity>> getCesb({String? estadio}) async {
    final query = _database.select(_database.referenciasTecnicas)
      ..where((row) => row.categoria.equals('cesb'));
    if (estadio != null) {
      query.where((row) => row.estadio.equals(estadio));
    }
    final models = await query.get();
    return models.map(_toEntity).toList();
  }

  // ── Seed Técnico (referências agronômicas) ─────────────────────────────────

  static const _diseaseReferencesMigrationKey = 'references_doencas_v3';
  static const _insectReferencesMigrationKey = 'references_insetos_v2';
  static const _nutritionReferencesMigrationKey = 'references_nutricao_v2';
  static const _physiologyReferencesMigrationKey = 'references_fisiologia_v2';
  static const _cesbReferencesMigrationKey = 'references_cesb_v2';

  Future<void> seedIfEmpty() async {
    final count = await _database.referenciasTecnicas.count().getSingle();
    if (count == 0) {
      final seed = _buildSeed();
      await _database.batch(
        (batch) => batch.insertAll(_database.referenciasTecnicas, seed),
      );
    }

    if (!await _database
        .hasCompletedMigration(_diseaseReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('doencas')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            _buildDiseaseReferences(),
          ),
        );
        await _database.markMigrationCompleted(_diseaseReferencesMigrationKey);
      });
    }

    if (!await _database.hasCompletedMigration(_insectReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('insetos')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            _buildInsectReferences(),
          ),
        );
        await _database.markMigrationCompleted(_insectReferencesMigrationKey);
      });
    }

    if (!await _database
        .hasCompletedMigration(_nutritionReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('nutricao')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            _buildNutritionReferences(),
          ),
        );
        await _database
            .markMigrationCompleted(_nutritionReferencesMigrationKey);
      });
    }

    if (!await _database
        .hasCompletedMigration(_physiologyReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('fisiologia')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            _buildPhysiologyReferences(),
          ),
        );
        await _database
            .markMigrationCompleted(_physiologyReferencesMigrationKey);
      });
    }

    if (!await _database.hasCompletedMigration(_cesbReferencesMigrationKey)) {
      await _database.transaction(() async {
        await (_database.delete(_database.referenciasTecnicas)
              ..where((row) => row.categoria.equals('cesb')))
            .go();
        await _database.batch(
          (batch) => batch.insertAll(
            _database.referenciasTecnicas,
            _buildCesbReferences(),
          ),
        );
        await _database.markMigrationCompleted(_cesbReferencesMigrationKey);
      });
    }
  }

  List<ReferenciasTecnicasCompanion> _buildSeed() {
    final items = <ReferenciasTecnicasCompanion>[];

    items.addAll(_buildDiseaseReferences());

    items.addAll(_buildInsectReferences());

    items.addAll(_buildNutritionReferences());

    items.addAll(_buildPhysiologyReferences());

    items.addAll(_buildCesbReferences());

    return items;
  }

  List<ReferenciasTecnicasCompanion> _buildCesbReferences() {
    ReferenciasTecnicasCompanion cesb({
      required String uid,
      required String estadio,
      required String titulo,
      required String focoManejo,
      required String praticas,
      required String padrao,
      String? descricao,
      String? destaque,
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
    ];
  }

  List<ReferenciasTecnicasCompanion> _buildNutritionReferences() {
    ReferenciasTecnicasCompanion nutrition({
      required String uid,
      required String estadio,
      required String titulo,
      required String descricao,
      required String focoManejo,
      String? destaque,
    }) =>
        ReferenciasTecnicasCompanion.insert(
          uid: uid,
          categoria: 'nutricao',
          estadio: estadio,
          titulo: titulo,
          descricao: Value(descricao),
          focoManejo: Value(focoManejo),
          destaque: Value(destaque),
        );

    return [
      nutrition(
        uid: 'nutricao-v2-ve',
        estadio: 'VE',
        titulo: 'Arranque nutricional',
        descricao:
            'Emergência com baixa absorção relativa, próxima de 2-4%, mas dependente de P, Co, Mo e Zn para raiz e FBN inicial.',
        focoManejo:
            'Garantir base nutricional antes da demanda acelerar em V4.',
      ),
      nutrition(
        uid: 'nutricao-v2-vc',
        estadio: 'VC',
        titulo: 'Estabelecimento inicial',
        descricao:
            'Cotiledonário ainda na faixa de 2-4% de absorção relativa; P sustenta energia e enraizamento.',
        focoManejo:
            'Observar vigor e uniformidade antes da expansão das trifolioladas.',
      ),
      nutrition(
        uid: 'nutricao-v2-v1',
        estadio: 'V1',
        titulo: 'P, Co, Mo e Zn',
        descricao:
            'V1 abre a fase V1-V3 de estabelecimento, com foco em P, Co, Mo e Zn e absorção ainda baixa, próxima de 2-10%.',
        focoManejo: 'Prevenir limitações de raiz, FBN e atividade enzimática.',
      ),
      nutrition(
        uid: 'nutricao-v2-v2',
        estadio: 'V2',
        titulo: 'Estabelecimento vegetativo',
        descricao:
            'V2 mantém demanda inicial por P, Co, Mo e Zn; risco de deficiência ainda corrigível dentro da faixa de 2-15%.',
        focoManejo:
            'Monitorar sintomas precoces como plantas roxeadas, folhas pequenas e internódios curtos.',
      ),
      nutrition(
        uid: 'nutricao-v2-v3',
        estadio: 'V3',
        titulo: 'Zona de alerta precoce',
        descricao:
            'V3-V4 entram na zona de alerta de 2-15%: P pode ficar em 4-11% e Zn abaixo de 10%, com risco para base produtiva.',
        focoManejo:
            'Usar análise foliar e correções antecipadas enquanto a janela ainda é ampla.',
        destaque: 'V3-V4: alerta de 2-15%',
      ),
      nutrition(
        uid: 'nutricao-v2-v4',
        estadio: 'V4',
        titulo: 'Primeira explosão de demanda',
        descricao:
            'V4 inicia intensificação de 8-17% absorvido. Demandas altas: Ca 14-16%, Mg 15%, P 11-13%, N 8-9%.',
        focoManejo:
            'Entrar com monitoramento nutricional antes da aceleração até R1.',
        destaque: 'V4: 8-17% absorvido',
      ),
      nutrition(
        uid: 'nutricao-v2-v5',
        estadio: 'V5',
        titulo: 'Crescimento vegetativo',
        descricao:
            'Fase V4-V6 com foco em N, Mn, Cu e Fe; N intensifica FBN e Mn sustenta fotossíntese.',
        focoManejo:
            'Prevenir clorose internerval em folhas novas e queda de eficiência fotossintética.',
      ),
      nutrition(
        uid: 'nutricao-v2-v6',
        estadio: 'V6',
        titulo: 'Pré-intensificação reprodutiva',
        descricao:
            'Final da fase V4-V6 ainda exige N, Mn, Cu e Fe antes da demanda saltar para 40-60% em V8-R1.',
        focoManejo:
            'Preparar a planta para pré-floração com folhas ativas e FBN eficiente.',
      ),
      nutrition(
        uid: 'nutricao-v2-v7',
        estadio: 'V7',
        titulo: 'Pré-floração: B, Ca e Mg',
        descricao:
            'V7-R1 prioriza B, Ca e Mg para tubo polínico e fixação floral; a demanda entra em aceleração para 40-60%.',
        focoManejo: 'Antecipar B/Ca para reduzir risco de abortamento floral.',
      ),
      nutrition(
        uid: 'nutricao-v2-r1',
        estadio: 'R1',
        titulo: 'Floração: 45-62% absorvido',
        descricao:
            'R1 concentra 45-62% de absorção: Ca 59-62%, Fe 55-57%, N 53-54%, B até 47% e Mn até 51%.',
        focoManejo:
            'Corrigir antes do fechamento da janela; deficiência aqui compromete flores e vagens.',
        destaque: 'R1: 45-62% absorvido',
      ),
      nutrition(
        uid: 'nutricao-v2-r2',
        estadio: 'R2',
        titulo: 'Floração e vagem',
        descricao:
            'R2-R3 entram na corrida de 65-85% absorvido, com K, Mg, Cu e S em janela estreita de correção.',
        focoManejo:
            'Priorizar K, P, S e Zn para energia, proteína e formação de vagens.',
      ),
      nutrition(
        uid: 'nutricao-v2-r3',
        estadio: 'R3',
        titulo: 'Última chance real de correção',
        descricao:
            'R3 chega a 70-84% absorvido. Ca pode atingir 81-84%, Fe 77-79%, Zn 75-77% e K 75-77%.',
        focoManejo:
            'Focar K, P, S, Zn e Mg; após R3 a compensação radicular cai fortemente.',
        destaque: 'R3: 70-84% absorvido',
      ),
      nutrition(
        uid: 'nutricao-v2-r4',
        estadio: 'R4',
        titulo: 'Zona vermelha nutricional',
        descricao:
            'R4-R5 entram em zona de 85-95%; Cu pode chegar a 89% e Ni a 76-78%, com risco terminal para grãos vazios e qualidade proteica.',
        focoManejo:
            'Intervenção limitada: preservar fotossíntese e translocação para vagens.',
      ),
      nutrition(
        uid: 'nutricao-v2-r5',
        estadio: 'R5.1',
        titulo: 'Enchimento de grãos',
        descricao:
            'R5-R6 demandam N, K, Mg, S e B. A absorção entra em faixa acima de 90% e passa a depender de translocação.',
        focoManejo:
            'Sustentar enchimento, clorofila e transporte de fotoassimilados.',
      ),
      nutrition(
        uid: 'nutricao-v2-r53',
        estadio: 'R5.3',
        titulo: 'Absorção final acelerada',
        descricao:
            'R5 intermediário mantém a fase terminal acima de 90%, com macros caminhando para 95-99% absorvidos.',
        focoManejo:
            'Evitar senescência precoce e queda na remobilização para grãos.',
      ),
      nutrition(
        uid: 'nutricao-v2-r55',
        estadio: 'R5.5',
        titulo: 'Fim da absorção efetiva',
        descricao:
            'R5.5 atinge 90-99% absorvido: Fe 97-99%, Ca 97-99%, B 92-94%, Zn até 97% e macros 95-99%.',
        focoManejo:
            'Após R5.5, a planta praticamente só redistribui nutrientes internamente.',
        destaque: 'R5.5: 90-99% absorvido',
      ),
      nutrition(
        uid: 'nutricao-v2-r6',
        estadio: 'R6',
        titulo: 'Grão cheio e translocação',
        descricao:
            'R6 segue acima de 90% de absorção, com N, K, Mg, S e B voltados à finalização de peso e qualidade.',
        focoManejo:
            'Acompanhar eficiência de translocação e manutenção de folhas funcionais.',
      ),
      nutrition(
        uid: 'nutricao-v2-r7',
        estadio: 'R7',
        titulo: 'Maturação: baixa demanda externa',
        descricao:
            'R7-R8 são fases de translocação final; a demanda externa diminui drasticamente após mais de 90% da absorção já concluída.',
        focoManejo:
            'Registrar sintomas tardios para correção de manejo na próxima safra.',
      ),
      nutrition(
        uid: 'nutricao-v2-r8',
        estadio: 'R8',
        titulo: 'Maturação plena',
        descricao:
            'R8 encerra a translocação final com absorção praticamente concluída, acima de 90%.',
        focoManejo:
            'Usar o diagnóstico final como histórico nutricional do talhão.',
      ),
    ];
  }

  List<ReferenciasTecnicasCompanion> _buildPhysiologyReferences() {
    ReferenciasTecnicasCompanion physiology({
      required String uid,
      required String estadio,
      required String titulo,
      required String descricao,
      required String focoManejo,
      String? destaque,
    }) =>
        ReferenciasTecnicasCompanion.insert(
          uid: uid,
          categoria: 'fisiologia',
          estadio: estadio,
          titulo: titulo,
          descricao: Value(descricao),
          focoManejo: Value(focoManejo),
          destaque: Value(destaque),
        );

    return [
      physiology(
        uid: 'fisiologia-v2-ve',
        estadio: 'VE',
        titulo: 'Auxinas e Giberelinas',
        descricao:
            'VE-V2 são dominados por Auxinas e Giberelinas, com foco em emergência rápida e desenvolvimento radicular.',
        focoManejo:
            'Favorecer arranque inicial, germinação uniforme e crescimento de raízes.',
        destaque: 'VE-V2: Auxinas + Giberelinas',
      ),
      physiology(
        uid: 'fisiologia-v2-vc',
        estadio: 'VC',
        titulo: 'Arranque hormonal',
        descricao:
            'Cotiledonário ainda responde ao balanço Auxinas/Giberelinas para vigor inicial e expansão da plântula.',
        focoManejo:
            'Preservar vigor de plântulas e evitar estresse no estabelecimento.',
      ),
      physiology(
        uid: 'fisiologia-v2-v1',
        estadio: 'V1',
        titulo: 'Raiz e expansão inicial',
        descricao:
            'V1 mantém predominância de Auxinas e Giberelinas, com transição gradual para divisão celular foliar.',
        focoManejo: 'Estimular raiz, emissão foliar e uniformidade de plantas.',
      ),
      physiology(
        uid: 'fisiologia-v2-v2',
        estadio: 'V2',
        titulo: 'Fechamento da fase inicial',
        descricao:
            'V2 fecha a janela VE-V2 de emergência e raiz, preparando a mudança para Citocininas e Auxinas em V3-V6.',
        focoManejo: 'Reduzir estresse que limite raiz e início de área foliar.',
      ),
      physiology(
        uid: 'fisiologia-v2-v3',
        estadio: 'V3',
        titulo: 'Citocininas e Auxinas',
        descricao:
            'V3-V6 têm Citocininas e Auxinas como eixo hormonal, promovendo expansão foliar e início de ramificações laterais.',
        focoManejo:
            'Favorecer divisão celular, ramificação e construção de nós produtivos.',
        destaque: 'V3-V6: ramificação lateral',
      ),
      physiology(
        uid: 'fisiologia-v2-v4',
        estadio: 'V4',
        titulo: 'Ramificação e nós produtivos',
        descricao:
            'V4 é janela prática para bioestimulantes hormonais, com foco em ramificação e número de nós produtivos.',
        focoManejo:
            'Reduzir estresse e manter balanço entre crescimento vegetativo e estruturação.',
      ),
      physiology(
        uid: 'fisiologia-v2-v5',
        estadio: 'V5',
        titulo: 'Expansão foliar',
        descricao:
            'Citocininas sustentam divisão celular e retardam senescência, enquanto Auxinas organizam crescimento e dominância apical.',
        focoManejo: 'Construir área foliar sem antecipar senescência.',
      ),
      physiology(
        uid: 'fisiologia-v2-v6',
        estadio: 'V6',
        titulo: 'Pré-floração hormonal',
        descricao:
            'Final de V3-V6 prepara a planta para a fase R1-R2, em que Citocininas e Giberelinas passam a sustentar flores e estruturas.',
        focoManejo:
            'Manter ramificações ativas e reduzir estresse antes da floração.',
      ),
      physiology(
        uid: 'fisiologia-v2-v7',
        estadio: 'V7',
        titulo: 'Transição para floração',
        descricao:
            'V7 antecipa R1-R2: Citocininas e Giberelinas ganham importância para divisão celular e formação floral.',
        focoManejo:
            'Preparar retenção de flores e reduzir estresse hídrico/térmico.',
      ),
      physiology(
        uid: 'fisiologia-v2-r1',
        estadio: 'R1',
        titulo: 'Citocininas e Giberelinas',
        descricao:
            'R1-R2 exigem máxima divisão celular para formação de flores e fixação de estruturas reprodutivas.',
        focoManejo:
            'Reduzir abortamento floral e proteger flores contra estresse.',
        destaque: 'R1-R2: fixação de flores',
      ),
      physiology(
        uid: 'fisiologia-v2-r2',
        estadio: 'R2',
        titulo: 'Fixação reprodutiva',
        descricao:
            'Plena floração ainda depende de Citocininas e Giberelinas para sustentar estruturas e reduzir queda de flores.',
        focoManejo:
            'Manter balanço hormonal favorável à fixação e ao início de vagens.',
      ),
      physiology(
        uid: 'fisiologia-v2-r3',
        estadio: 'R3',
        titulo: 'Auxinas e Citocininas',
        descricao:
            'R3-R5 mudam para Auxinas e Citocininas, direcionando fotoassimilados para vagens e grãos.',
        focoManejo:
            'Favorecer retenção de vagens e início eficiente do enchimento.',
        destaque: 'R3-R5: direção de fotoassimilados',
      ),
      physiology(
        uid: 'fisiologia-v2-r4',
        estadio: 'R4',
        titulo: 'Retenção de vagens',
        descricao:
            'Auxinas e Citocininas sustentam vagens desenvolvidas e mantêm folhas verdes por mais tempo.',
        focoManejo:
            'Evitar estresse que aumente Etileno e abscisão de estruturas.',
      ),
      physiology(
        uid: 'fisiologia-v2-r5',
        estadio: 'R5.1',
        titulo: 'Enchimento inicial',
        descricao:
            'R5 segue com Auxinas e Citocininas para translocação de fotoassimilados e enchimento de grãos.',
        focoManejo: 'Sustentar folhas ativas e reduzir senescência precoce.',
      ),
      physiology(
        uid: 'fisiologia-v2-r53',
        estadio: 'R5.3',
        titulo: 'Enchimento intermediário',
        descricao:
            'Citocininas ajudam a retardar senescência durante o enchimento, enquanto Auxinas participam do direcionamento de assimilados.',
        focoManejo: 'Manter fluxo para grãos e limitar estresse hídrico.',
      ),
      physiology(
        uid: 'fisiologia-v2-r55',
        estadio: 'R5.5',
        titulo: 'Enchimento avançado',
        descricao:
            'Fim da fase R3-R5: o balanço Auxinas/Citocininas ainda favorece grãos antes da dominância de Etileno e ABA.',
        focoManejo:
            'Evitar senescência antecipada e perda de área foliar funcional.',
      ),
      physiology(
        uid: 'fisiologia-v2-r6',
        estadio: 'R6',
        titulo: 'Etileno e Ácido Abscísico',
        descricao:
            'R6-R8 passam a predominar Etileno e ABA, regulando maturação, translocação final e senescência.',
        focoManejo:
            'Acompanhar maturação fisiológica e evitar estresse que acelere senescência.',
        destaque: 'R6-R8: maturação e senescência',
      ),
      physiology(
        uid: 'fisiologia-v2-r7',
        estadio: 'R7',
        titulo: 'Senescência regulada',
        descricao:
            'Etileno regula queda de folhas e amadurecimento; ABA responde a seca e fechamento estomático.',
        focoManejo:
            'Diferenciar maturação natural de senescência acelerada por estresse.',
      ),
      physiology(
        uid: 'fisiologia-v2-r8',
        estadio: 'R8',
        titulo: 'Maturação plena',
        descricao:
            'R8 encerra o ciclo sob maior influência de Etileno e ABA, com maturação de grãos e senescência final.',
        focoManejo:
            'Registrar efeitos de estresse tardio para ajuste de manejo na próxima safra.',
      ),
    ];
  }

  List<ReferenciasTecnicasCompanion> _buildInsectReferences() {
    ReferenciasTecnicasCompanion insect({
      required String uid,
      required String estadio,
      required String titulo,
      required String descricao,
      required String focoManejo,
      String? destaque,
    }) =>
        ReferenciasTecnicasCompanion.insert(
          uid: uid,
          categoria: 'insetos',
          estadio: estadio,
          titulo: titulo,
          descricao: Value(descricao),
          focoManejo: Value(focoManejo),
          destaque: Value(destaque),
        );

    return [
      insect(
        uid: 'insetos-v2-ve',
        estadio: 'VE',
        titulo: 'Pragas de solo e iniciais',
        descricao:
            'Elasmo, corós e lagarta-rosca causam morte de plântulas e redução de estande. Impacto estimado: 10-30%.',
        focoManejo:
            'Proteger emergência e priorizar talhões com histórico de falhas iniciais.',
        destaque: 'VE-VC: risco inicial de 10-30%',
      ),
      insect(
        uid: 'insetos-v2-vc',
        estadio: 'VC',
        titulo: 'Pragas iniciais',
        descricao:
            'Elasmo, corós e lagarta-rosca seguem como principais riscos no cotiledonário. Impacto estimado: 10-30%.',
        focoManejo:
            'Monitorar estande, plantas cortadas e sintomas de coração morto.',
      ),
      insect(
        uid: 'insetos-v2-v1',
        estadio: 'V1',
        titulo: 'Tamanduá-da-soja e lagarta-da-soja',
        descricao:
            'Pragas iniciais e desfolhadoras causam raspagem de caule e desfolha inicial. Impacto estimado: 5-15%.',
        focoManejo:
            'Acompanhar raspagem, cortes e início de desfolha nas primeiras trifolioladas.',
      ),
      insect(
        uid: 'insetos-v2-v2',
        estadio: 'V2',
        titulo: 'Pragas iniciais e desfolhadoras',
        descricao:
            'Tamanduá-da-soja e lagarta-da-soja permanecem relevantes. Impacto estimado: 5-15%.',
        focoManejo:
            'Manter inspeção de plantas jovens e evolução percentual de desfolha.',
      ),
      insect(
        uid: 'insetos-v2-v3',
        estadio: 'V3',
        titulo: 'Lagarta-da-soja e tripes em ascensão',
        descricao:
            'Fim da faixa inicial com impacto estimado de 5-15%; tripes começam a ganhar peso relativo antes de V7.',
        focoManejo:
            'Preparar monitoramento de tripes e lagartas para a fase vegetativa avançada.',
      ),
      insect(
        uid: 'insetos-v2-v4',
        estadio: 'V4',
        titulo: 'Desfolhadoras e sugadoras',
        descricao:
            'Lagarta-da-soja, falsa-medideira e mosca-branca reduzem área fotossintética e sugam seiva. Impacto estimado: 20-40%.',
        focoManejo:
            'Medir desfolha em percentual e observar aumento de sugadoras no dossel.',
      ),
      insect(
        uid: 'insetos-v2-v5',
        estadio: 'V5',
        titulo: 'Lagartas e mosca-branca',
        descricao:
            'Desfolhadoras e sugadoras seguem na faixa de 20-40% de impacto estimado.',
        focoManejo:
            'Evitar perda de área foliar antes da entrada em pré-floração.',
      ),
      insect(
        uid: 'insetos-v2-v6',
        estadio: 'V6',
        titulo: 'Pressão vegetativa avançada',
        descricao:
            'Lagarta-da-soja, falsa-medideira e mosca-branca mantêm risco de 20-40% na fase vegetativa avançada.',
        focoManejo:
            'Consolidar monitoramento antes da transição para florescimento.',
      ),
      insect(
        uid: 'insetos-v2-v7',
        estadio: 'V7',
        titulo: 'Tripes dominantes',
        descricao:
            'Tripes representam a maior pressão relativa em V7, aproximadamente 95% do complexo observado neste estádio; lagartas ficam perto de 4% e percevejos abaixo de 1%.',
        focoManejo:
            'Foco em controle de tripes e monitoramento preventivo de lagartas.',
        destaque: 'V7-R2: domínio relativo de tripes',
      ),
      insect(
        uid: 'insetos-v2-r1',
        estadio: 'R1',
        titulo: 'Tripes, lagartas e mosca-branca',
        descricao:
            'No início da floração, tripes ainda lideram com cerca de 54% da pressão relativa; mosca-branca fica próxima de 31% e lagartas em torno de 15%. Impacto reprodutivo estimado: 30-50%.',
        focoManejo:
            'Reduzir tripes e monitorar crescimento percentual de lagartas no início do florescimento.',
      ),
      insect(
        uid: 'insetos-v2-r2',
        estadio: 'R2',
        titulo: 'Tripes em declínio e lagartas em alta',
        descricao:
            'Tripes representam cerca de 45%, lagartas 27%, mosca-branca 27% e percevejos abaixo de 1% da pressão relativa. Impacto estimado: 30-50%.',
        focoManejo:
            'Preparar controle de lagartas e acompanhar sugadoras no florescimento pleno.',
      ),
      insect(
        uid: 'insetos-v2-r3',
        estadio: 'R3',
        titulo: 'Ponto de equilíbrio: tripes e lagartas',
        descricao:
            'Tripes ficam perto de 50%, lagartas em torno de 47% e percevejos próximos de 4% da pressão relativa. Danos em vagens e grãos: 40-60%.',
        focoManejo:
            'Controle dual de tripes e lagartas com atenção ao início de colonização por percevejos.',
        destaque: 'R3: virada para pragas reprodutivas',
      ),
      insect(
        uid: 'insetos-v2-r4',
        estadio: 'R4',
        titulo: 'Lagartas no pico',
        descricao:
            'Lagartas dominam R4 e respondem por cerca de 85% da pressão entre lagartas e percevejos; percevejos ficam próximos de 15%. Danos reprodutivos estimados: 40-60%.',
        focoManejo:
            'Controle intensivo de lagartas para proteger vagens desenvolvidas.',
        destaque: 'R4-R6: período mais perigoso para lagartas',
      ),
      insect(
        uid: 'insetos-v2-r5',
        estadio: 'R5.1',
        titulo: 'Lagartas e percevejos no enchimento',
        descricao:
            'Lagartas representam cerca de 77% da pressão relativa entre lagartas e percevejos; percevejos sobem para aproximadamente 23%. Danos em peso e qualidade: 60-80%.',
        focoManejo:
            'Manter controle de lagartas e intensificar monitoramento percentual de percevejos.',
      ),
      insect(
        uid: 'insetos-v2-r53',
        estadio: 'R5.3',
        titulo: 'Transição para sugadores de grãos',
        descricao:
            'Durante R5, lagartas ainda predominam, mas percevejos avançam dentro da faixa de dano de 60-80% em peso e qualidade de grãos.',
        focoManejo:
            'Reavaliar percentual de dano em vagens e presença de grãos deformados.',
      ),
      insect(
        uid: 'insetos-v2-r55',
        estadio: 'R5.5',
        titulo: 'Percevejos em aceleração',
        descricao:
            'Final de R5 mantém risco de 60-80%; percevejos aceleram e passam a definir qualidade final dos grãos.',
        focoManejo:
            'Priorizar proteção da qualidade de grãos e reduzir retenção foliar futura.',
      ),
      insect(
        uid: 'insetos-v2-r6',
        estadio: 'R6',
        titulo: 'Lagartas em queda e percevejos em alta',
        descricao:
            'Lagartas ficam próximas de 64% e percevejos em torno de 36% da pressão relativa. Danos em peso e qualidade: 60-80%.',
        focoManejo:
            'Transição do controle de lagartas para percevejos sugadores de grãos.',
      ),
      insect(
        uid: 'insetos-v2-r7',
        estadio: 'R7',
        titulo: 'Percevejos dominantes',
        descricao:
            'Percevejos atingem cerca de 51% da pressão relativa contra 49% de lagartas em declínio. Perda de vigor e retenção foliar: acima de 80%.',
        focoManejo:
            'Controle final de percevejos para preservar qualidade fisiológica dos grãos.',
        destaque: 'R7-R8: era dos percevejos',
      ),
      insect(
        uid: 'insetos-v2-r8',
        estadio: 'R8',
        titulo: 'Percevejos persistentes e ácaros',
        descricao:
            'Pragas de final de ciclo causam retenção foliar e perda de vigor de sementes acima de 80%; percevejos seguem como grupo dominante.',
        focoManejo:
            'Avaliar dano final, retenção foliar e histórico de pressão para a próxima safra.',
      ),
    ];
  }

  List<ReferenciasTecnicasCompanion> _buildDiseaseReferences() {
    ReferenciasTecnicasCompanion disease({
      required String uid,
      required String estadio,
      required String titulo,
      required String descricao,
      required String focoManejo,
      String? destaque,
    }) =>
        ReferenciasTecnicasCompanion.insert(
          uid: uid,
          categoria: 'doencas',
          estadio: estadio,
          titulo: titulo,
          descricao: Value(descricao),
          focoManejo: Value(focoManejo),
          destaque: Value(destaque),
        );

    return [
      disease(
        uid: 'doencas-v2-ve',
        estadio: 'VE',
        titulo: 'Damping-off',
        descricao:
            'Emergência com risco de tombamento por Rhizoctonia, Fusarium e Pythium. Incidência estimada: 5-15%.',
        focoManejo:
            'Priorizar tratamento de sementes, qualidade de emergência e checagem de estande.',
        destaque: 'Fase inicial: proteção de plântulas',
      ),
      disease(
        uid: 'doencas-v2-vc',
        estadio: 'VC',
        titulo: 'Damping-off e Mancha-parda',
        descricao:
            'Cotiledonário com damping-off e início de Mancha-parda (Septoria). Incidência estimada: menor que 5%.',
        focoManejo:
            'Monitorar falhas de estande e primeiras lesões foliares após expansão das unifolioladas.',
      ),
      disease(
        uid: 'doencas-v2-v1',
        estadio: 'V1',
        titulo: 'Mancha-parda',
        descricao:
            'Primeira folha trifoliolada expandida com pressão inicial de Mancha-parda. Incidência estimada: 5-10%.',
        focoManejo:
            'Registrar presença em folhas baixas e acompanhar evolução para V2-V4.',
      ),
      disease(
        uid: 'doencas-v2-v2',
        estadio: 'V2',
        titulo: 'Crestamento Bacteriano e Míldio',
        descricao:
            'Crestamento Bacteriano lidera a intensidade em V2 com cerca de 5%; Mancha-parda e Míldio entram no monitoramento.',
        focoManejo:
            'Começar inspeção fitossanitária foliar e separar sintomas bacterianos de manchas fúngicas.',
        destaque: 'Início do ciclo: bacterioses e Míldio',
      ),
      disease(
        uid: 'doencas-v2-v3',
        estadio: 'V3',
        titulo: 'Míldio e Mancha-alvo latente',
        descricao:
            'Míldio é a maior intensidade em V3, com cerca de 8%; Mancha-alvo pode aparecer de forma latente, com Oídio e Pústula Bacteriana ainda baixos.',
        focoManejo:
            'Monitorar terço inferior e condições de umidade favoráveis à progressão de Míldio.',
      ),
      disease(
        uid: 'doencas-v2-v4',
        estadio: 'V4',
        titulo: 'Crestamento Bacteriano, Míldio e Mancha-alvo',
        descricao:
            'Crestamento Bacteriano chega a 12%, Míldio se mantém elevado em torno de 15% e Mancha-alvo/Oídio ganham relevância.',
        focoManejo:
            'Intensificar monitoramento preventivo antes do fechamento de entrelinhas.',
      ),
      disease(
        uid: 'doencas-v2-v5',
        estadio: 'V5',
        titulo: 'Antracnose, Mancha-alvo e início de Ferrugem',
        descricao:
            'Antracnose pode atingir cerca de 40%; Míldio mantém 15%, Crestamento Bacteriano pode chegar a 18% e Mancha-alvo ganha pressão. Ferrugem Asiática deve entrar no radar regional.',
        focoManejo:
            'Mapear focos, monitorar alertas de Ferrugem e preparar estratégia preventiva para a transição reprodutiva.',
        destaque: 'Vegetativo avançado: pressão crescente',
      ),
      disease(
        uid: 'doencas-v2-vn',
        estadio: 'V6',
        titulo: 'Mancha-alvo e início de Ferrugem',
        descricao:
            'Estádio vegetativo avançado com Mancha-alvo, Oídio e possível início de Ferrugem, conforme pressão regional.',
        focoManejo:
            'Acompanhar alertas regionais de Ferrugem e fechar diagnóstico antes de R1.',
      ),
      disease(
        uid: 'doencas-v2-r1',
        estadio: 'R1',
        titulo: 'Míldio, Oídio, Ferrugem e Antracnose',
        descricao:
            'Início do florescimento com Míldio em cerca de 25%, Oídio próximo de 20,25%, Ferrugem em 5-10% e Antracnose em até 50%.',
        focoManejo:
            'Aplicação preventiva no florescimento e monitoramento de abortamento, terço inferior e início de pústulas.',
        destaque: 'Florescimento: entrada da janela crítica',
      ),
      disease(
        uid: 'doencas-v2-r2',
        estadio: 'R2',
        titulo: 'Ferrugem, Pústula Bacteriana e Mofo Branco',
        descricao:
            'Plena floração com Míldio em torno de 20%, Pústula Bacteriana em 15%, Mofo Branco em 12% e Ferrugem em 15-20%.',
        focoManejo:
            'Proteger dossel em florescimento pleno, rotacionar fungicidas para Ferrugem e observar microclima favorável ao Mofo Branco.',
      ),
      disease(
        uid: 'doencas-v2-r3',
        estadio: 'R3',
        titulo: 'Ferrugem Asiática, Mofo Branco e Antracnose',
        descricao:
            'Início de vagens com Ferrugem acelerando para cerca de 35%, Mofo Branco em 28% e Antracnose em 15-60%.',
        focoManejo:
            'Reforçar fungicida e priorizar proteção de vagens recém-formadas.',
        destaque: 'R3: virada para doenças reprodutivas',
      ),
      disease(
        uid: 'doencas-v2-r4',
        estadio: 'R4',
        titulo: 'Ferrugem Asiática dominante',
        descricao:
            'Vagem desenvolvida com Ferrugem Asiática em torno de 65%, Mofo Branco em 45%, Antracnose até 70% e início de Mancha-parda.',
        focoManejo:
            'Manter folha sadia e evitar perda fotossintética antes do enchimento de grãos.',
      ),
      disease(
        uid: 'doencas-v2-r5',
        estadio: 'R5.1',
        titulo: 'Ferrugem Asiática e DFCs',
        descricao:
            'Início do enchimento com Ferrugem Asiática em 60-85%, Oídio podendo atingir 73,75% e DFCs como Septoria/Cercospora em ascensão.',
        focoManejo:
            'Proteger o enchimento e evitar desfolha/senescência precoce.',
        destaque: 'R5: máxima pressão de Ferrugem',
      ),
      disease(
        uid: 'doencas-v2-r53',
        estadio: 'R5.3',
        titulo: 'Ferrugem Asiática, Oídio e DFCs',
        descricao:
            'Enchimento intermediário ainda dentro da janela crítica de R5, com Ferrugem em 60-85%, Oídio alto e DFCs em expansão.',
        focoManejo:
            'Reavaliar residual de fungicidas e manter o terço médio/superior funcional.',
      ),
      disease(
        uid: 'doencas-v2-r55',
        estadio: 'R5.5',
        titulo: 'Ferrugem, DFCs e senescência precoce',
        descricao:
            'Enchimento avançado ainda sob risco de Ferrugem e com DFCs, Mancha-parda e Cercospora acelerando a perda de área foliar.',
        focoManejo:
            'Evitar perda prematura de folhas, avaliar residual da última aplicação e registrar falhas para ajuste do programa fitossanitário.',
      ),
      disease(
        uid: 'doencas-v2-r6',
        estadio: 'R6',
        titulo: 'Ferrugem, Cercospora e Mancha-parda',
        descricao:
            'Grão cheio com Ferrugem até 95%, Cercospora em cerca de 55%, Mancha-parda em 45% e DFCs entre 60-90%.',
        focoManejo:
            'Avaliar proteção residual e preservar qualidade fisiológica dos grãos.',
      ),
      disease(
        uid: 'doencas-v2-r7',
        estadio: 'R7',
        titulo: 'Doenças de final de ciclo',
        descricao:
            'Início da maturação com Oídio em até 98,75%, Cercospora em 75%, Macrophomina em 70%, Podridão de grãos e DFCs acima de 90%.',
        focoManejo:
            'Registrar severidade final, qualidade de grãos e aprendizado para o manejo da próxima safra.',
        destaque: 'Final do ciclo: DFCs, Cercospora e Macrophomina',
      ),
      disease(
        uid: 'doencas-v2-r8',
        estadio: 'R8',
        titulo: 'Macrophomina e Mancha-parda',
        descricao:
            'Maturação plena com Macrophomina e Mancha-parda chegando a cerca de 85%; período crítico para doenças de final de ciclo.',
        focoManejo:
            'Priorizar avaliação de perdas, sanidade de grãos e histórico do talhão.',
      ),
    ];
  }
}
