import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

List<ReferenciasTecnicasCompanion> buildPhysiologyReferences() {
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
        fonte: const Value(
          'Instrucao/Referencias/Hormônios Vegetais  - cópia.md',
        ),
        safraReferencia: const Value('Referência técnica permanente'),
        tipoFonte: const Value('Referência técnica'),
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
