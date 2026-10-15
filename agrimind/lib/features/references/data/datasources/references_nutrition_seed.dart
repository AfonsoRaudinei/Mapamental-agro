import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

List<ReferenciasTecnicasCompanion> buildNutritionReferences() {
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
        fonte: const Value(
          'Instrucao/Referencias/Nutrientes 1 - cópia.md',
        ),
        safraReferencia: const Value('Referência técnica permanente'),
        tipoFonte: const Value('Referência técnica'),
      );

  return [
    nutrition(
      uid: 'nutricao-v2-ve',
      estadio: 'VE',
      titulo: 'Arranque nutricional',
      descricao:
          'Emergência com baixa absorção relativa, próxima de 2-4%, mas dependente de P, Co, Mo e Zn para raiz e FBN inicial.',
      focoManejo: 'Garantir base nutricional antes da demanda acelerar em V4.',
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
