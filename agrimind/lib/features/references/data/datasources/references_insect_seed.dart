import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

List<ReferenciasTecnicasCompanion> buildInsectReferences() {
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
        fonte: const Value('Instrucao/Referencias/Insetos - cópia.md'),
        safraReferencia: const Value('Referência técnica permanente'),
        tipoFonte: const Value('Referência técnica'),
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
