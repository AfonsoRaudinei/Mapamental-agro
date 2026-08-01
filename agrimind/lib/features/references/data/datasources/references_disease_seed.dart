import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

List<ReferenciasTecnicasCompanion> buildDiseaseReferences() {
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
        fonte: const Value('Instrucao/Referencias/doenças 1 - cópia.md'),
        safraReferencia: const Value('Referência técnica permanente'),
        tipoFonte: const Value('Referência técnica'),
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
