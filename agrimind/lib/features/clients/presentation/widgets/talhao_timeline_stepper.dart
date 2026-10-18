import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/cronograma_soja/cronograma_soja_linha.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';

/// Estado visual de um nó do stepper (derivado na UI; não persiste).
enum StepperNodeStatus { concluido, atual, futuro }

/// Concluído = data antes de hoje; atual = primeira com data >= hoje.
/// Sem nenhuma data futura (safra encerrada), nenhum nó fica atual.
List<StepperNodeStatus> statusDasEtapas(List<DateTime> datas, DateTime hoje) {
  final h = DateTime(hoje.year, hoje.month, hoje.day);
  var atualDefinido = false;
  return datas.map((d) {
    final dia = DateTime(d.year, d.month, d.day);
    if (dia.isBefore(h)) return StepperNodeStatus.concluido;
    if (atualDefinido) return StepperNodeStatus.futuro;
    atualDefinido = true;
    return StepperNodeStatus.atual;
  }).toList();
}

/// Código curto do estádio exibido sob o nó.
String codigoEstagioEtapa(CronogramaSojaLinha linha) {
  switch (linha.tipo) {
    case CronogramaSojaLinhaTipo.dessecacaoPrePlantio:
      return 'OP';
    case CronogramaSojaLinhaTipo.plantio:
      return 'SEM';
    case CronogramaSojaLinhaTipo.emergencia:
      return 'VE';
    case CronogramaSojaLinhaTipo.posEmergente:
      return 'V5';
    case CronogramaSojaLinhaTipo.fungicida:
      const codigos = ['V7', 'R3', 'R5.1', 'R5.5'];
      final i = (linha.fungicidaIndice ?? 1) - 1;
      return i >= 0 && i < codigos.length
          ? codigos[i]
          : '${linha.fungicidaIndice}ª F';
    case CronogramaSojaLinhaTipo.dessecanteR7:
    case CronogramaSojaLinhaTipo.dessecacaoPreColheita:
      return 'R7';
    case CronogramaSojaLinhaTipo.colheitaReal:
    case CronogramaSojaLinhaTipo.colheitaEstimada:
      return 'R8';
  }
}

/// Nós do stepper: todas as etapas, com uma única "Colheita" (R8 estimada).
/// Retorna os índices na lista original de [etapas].
List<int> indicesNosStepper(List<EtapaTalhao> etapas) => [
      for (var i = 0; i < etapas.length; i++)
        if (etapas[i].linha.tipo != CronogramaSojaLinhaTipo.colheitaReal) i,
    ];

/// Índice (na lista original) da etapa atual do stepper, ou `null`.
int? indiceEtapaAtual(List<EtapaTalhao> etapas, DateTime hoje) {
  final nos = indicesNosStepper(etapas);
  final status = statusDasEtapas([for (final i in nos) etapas[i].data], hoje);
  final pos = status.indexOf(StepperNodeStatus.atual);
  return pos < 0 ? null : nos[pos];
}

/// Código do estádio do Plano cujas referências valem para a etapa
/// (o dessecante R7 é o card R8 do Plano).
String codigoReferenciaEtapa(CronogramaSojaLinha linha) {
  final codigo = codigoEstagioEtapa(linha);
  return codigo == 'R7' ? 'R8' : codigo;
}

/// Nome curto da etapa, na linguagem do campo (cabeçalho e "Próxima").
String nomeCurtoEtapa(CronogramaSojaLinha linha) {
  switch (linha.tipo) {
    case CronogramaSojaLinhaTipo.dessecacaoPrePlantio:
      return 'Dessecação';
    case CronogramaSojaLinhaTipo.plantio:
      return 'Plantio';
    case CronogramaSojaLinhaTipo.emergencia:
      return 'Emergência';
    case CronogramaSojaLinhaTipo.posEmergente:
      return 'Pós-emergente';
    case CronogramaSojaLinhaTipo.fungicida:
      return '${linha.fungicidaIndice ?? 1}ª aplicação fungicida';
    case CronogramaSojaLinhaTipo.dessecanteR7:
    case CronogramaSojaLinhaTipo.dessecacaoPreColheita:
      return 'Dessecante';
    case CronogramaSojaLinhaTipo.colheitaReal:
      return 'Colheita';
    case CronogramaSojaLinhaTipo.colheitaEstimada:
      return 'Colheita (R8)';
  }
}

DateTime _dia(DateTime d) => DateTime(d.year, d.month, d.day);

/// Diferença em dias de calendário (positivo = futuro).
int diasAte(DateTime data, DateTime hoje) =>
    _dia(data).difference(_dia(hoje)).inDays;

/// "hoje", "amanhã", "ontem", "em 22 dias", "há 8 dias".
String textoRelativo(DateTime data, DateTime hoje) {
  final d = diasAte(data, hoje);
  if (d == 0) return 'hoje';
  if (d == 1) return 'amanhã';
  if (d == -1) return 'ontem';
  return d > 0 ? 'em $d dias' : 'há ${-d} dias';
}

/// Situação do talhão hoje: base do cabeçalho "onde estamos".
class ResumoFaseTalhao {
  const ResumoFaseTalhao({
    required this.indiceProxima,
    required this.daeHoje,
    required this.progressoCiclo,
  });

  /// Próxima etapa (lista original); `null` = safra concluída.
  final int? indiceProxima;

  /// Dias após emergência hoje; `null` antes da emergência.
  final int? daeHoje;

  /// 0..1 entre plantio e colheita estimada (R8).
  final double progressoCiclo;
}

ResumoFaseTalhao resumoFaseTalhao(List<EtapaTalhao> etapas, DateTime hoje) {
  final status = statusDasEtapas([for (final e in etapas) e.data], hoje);
  final prox = status.indexOf(StepperNodeStatus.atual);

  DateTime? dataDo(CronogramaSojaLinhaTipo tipo) {
    for (final e in etapas) {
      if (e.linha.tipo == tipo) return e.data;
    }
    return null;
  }

  final emergencia = dataDo(CronogramaSojaLinhaTipo.emergencia);
  final dae = emergencia == null ? null : -diasAte(emergencia, hoje);

  final plantio = dataDo(CronogramaSojaLinhaTipo.plantio);
  final colheita = dataDo(CronogramaSojaLinhaTipo.colheitaEstimada);
  var progresso = 0.0;
  if (plantio != null && colheita != null) {
    final total = diasAte(colheita, plantio);
    if (total > 0) {
      progresso = (-diasAte(plantio, hoje) / total).clamp(0.0, 1.0);
    }
  }

  return ResumoFaseTalhao(
    indiceProxima: prox < 0 ? null : prox,
    daeHoje: dae != null && dae >= 0 ? dae : null,
    progressoCiclo: progresso,
  );
}

/// Posição do marcador "Hoje" entre os nós, em unidades de nó
/// (0 = centro do 1º nó). Ex.: 2.3 = 30% do caminho entre o 3º e o 4º.
double posicaoHoje(List<DateTime> datasDosNos, DateTime hoje) {
  if (datasDosNos.isEmpty) return 0;
  final status = statusDasEtapas(datasDosNos, hoje);
  final prox = status.indexOf(StepperNodeStatus.atual);
  if (prox < 0) return datasDosNos.length - 1 + 0.4; // safra concluída
  if (diasAte(datasDosNos[prox], hoje) == 0) return prox.toDouble();
  if (prox == 0) return -0.4; // antes da primeira etapa
  final ult = prox - 1;
  final total = diasAte(datasDosNos[prox], datasDosNos[ult]);
  final andado = -diasAte(datasDosNos[ult], hoje);
  final f = total <= 0 ? 0.5 : (andado / total).clamp(0.15, 0.85);
  return ult + f;
}

/// Linha do tempo da lavoura: caminho percorrido em azul, marcador "Hoje"
/// e a próxima etapa pulsando. Toque num nó rola a lista até a etapa.
class TalhaoTimelineStepper extends StatefulWidget {
  const TalhaoTimelineStepper({
    super.key,
    required this.etapas,
    required this.onEtapaTap,
    this.foco,
    this.hoje,
  });

  final List<EtapaTalhao> etapas;

  /// Índice (lista original) da etapa visível na lista; destaca o nó com um
  /// anel e mantém a faixa acompanhando. `null` = só o estado por data.
  final ValueListenable<int?>? foco;

  /// Recebe o índice da etapa na lista original.
  final ValueChanged<int> onEtapaTap;
  final DateTime? hoje;

  static const double altura = 84;
  static const double _larguraNo = 64;
  static const double _padding = AppSpacing.md;
  static const double _yLinha = 42;

  @override
  State<TalhaoTimelineStepper> createState() => _TalhaoTimelineStepperState();
}

class _TalhaoTimelineStepperState extends State<TalhaoTimelineStepper>
    with SingleTickerProviderStateMixin {
  final _scroll = ScrollController();
  late final AnimationController _pulso = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  int? _atualPos;

  DateTime get _hoje => widget.hoje ?? DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.foco?.addListener(_onFoco);
    _atualPos = _posAtual();
    // Centraliza o "agora" só na faixa horizontal (não mexe na lista).
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _centralizar(_alvoHoje(), animar: false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Respeita "Reduzir movimento" do iOS: sem pulso.
    if (MediaQuery.of(context).disableAnimations) {
      _pulso
        ..stop()
        ..value = 0.4;
    } else if (!_pulso.isAnimating) {
      _pulso.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(TalhaoTimelineStepper old) {
    super.didUpdateWidget(old);
    if (old.foco != widget.foco) {
      old.foco?.removeListener(_onFoco);
      widget.foco?.addListener(_onFoco);
    }
    // Plantio/regulagem mudou: a fase atual pode ter andado.
    final nova = _posAtual();
    if (nova != _atualPos) {
      _atualPos = nova;
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _centralizar(_alvoHoje(), animar: true));
    }
  }

  @override
  void dispose() {
    widget.foco?.removeListener(_onFoco);
    _pulso.dispose();
    _scroll.dispose();
    super.dispose();
  }

  List<DateTime> _datasDosNos(List<int> nos) =>
      [for (final i in nos) widget.etapas[i].data];

  int? _posAtual() {
    final nos = indicesNosStepper(widget.etapas);
    final pos =
        statusDasEtapas(_datasDosNos(nos), _hoje).indexOf(StepperNodeStatus.atual);
    return pos < 0 ? null : pos;
  }

  double _alvoHoje() =>
      posicaoHoje(_datasDosNos(indicesNosStepper(widget.etapas)), _hoje);

  void _onFoco() {
    final f = widget.foco?.value;
    final pos = f == null ? -1 : indicesNosStepper(widget.etapas).indexOf(f);
    _centralizar(pos < 0 ? _alvoHoje() : pos.toDouble(), animar: true);
  }

  static double _centro(double pos) =>
      TalhaoTimelineStepper._padding +
      pos * TalhaoTimelineStepper._larguraNo +
      TalhaoTimelineStepper._larguraNo / 2;

  void _centralizar(double pos, {required bool animar}) {
    if (!mounted || !_scroll.hasClients) return;
    final pista = _scroll.position;
    final alvo = (_centro(pos) - pista.viewportDimension / 2)
        .clamp(0.0, pista.maxScrollExtent);
    if (animar) {
      _scroll.animateTo(
        alvo,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    } else {
      _scroll.jumpTo(alvo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nos = indicesNosStepper(widget.etapas);
    if (nos.isEmpty) return const SizedBox(height: TalhaoTimelineStepper.altura);
    final datas = _datasDosNos(nos);
    final status = statusDasEtapas(datas, _hoje);
    final xHoje = _centro(posicaoHoje(datas, _hoje));
    final largura =
        TalhaoTimelineStepper._padding * 2 + nos.length * TalhaoTimelineStepper._larguraNo;
    final xIni = _centro(0);
    final xFim = _centro(nos.length - 1.0);
    const y = TalhaoTimelineStepper._yLinha;

    return SizedBox(
      height: TalhaoTimelineStepper.altura,
      // Arrasto horizontal com qualquer dispositivo (toque, mouse, caneta).
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: PointerDeviceKind.values.toSet(),
        ),
        child: ValueListenableBuilder<int?>(
          valueListenable: widget.foco ?? ValueNotifier<int?>(null),
          builder: (context, foco, _) {
            final posFoco = foco == null ? -1 : nos.indexOf(foco);
            return SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: SizedBox(
                width: largura,
                height: TalhaoTimelineStepper.altura,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Trilho inteiro (futuro).
                    Positioned(
                      left: xIni,
                      width: xFim - xIni,
                      top: y - 1,
                      height: 2,
                      child: ColoredBox(color: context.appBorder),
                    ),
                    // Caminho percorrido até hoje.
                    Positioned(
                      left: xIni,
                      width: (xHoje - xIni).clamp(0.0, xFim - xIni),
                      top: y - 1.5,
                      height: 3,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                    Positioned(
                      left: xHoje - 30,
                      width: 60,
                      top: 0,
                      height: y + 5,
                      child: const _MarcadorHoje(),
                    ),
                    for (var n = 0; n < nos.length; n++)
                      Positioned(
                        left: TalhaoTimelineStepper._padding +
                            n * TalhaoTimelineStepper._larguraNo,
                        top: 0,
                        width: TalhaoTimelineStepper._larguraNo,
                        height: TalhaoTimelineStepper.altura,
                        child: _No(
                          codigo:
                              codigoEstagioEtapa(widget.etapas[nos[n]].linha),
                          data: datas[n],
                          status: status[n],
                          emFoco: n == posFoco,
                          pulso: _pulso,
                          onTap: () => widget.onEtapaTap(nos[n]),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Pílula "Hoje" com haste até o trilho.
class _MarcadorHoje extends StatelessWidget {
  const _MarcadorHoje();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Hoje',
      child: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Hoje',
              style: AppTypography.label.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Container(width: 2, color: AppColors.primary),
          ),
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: context.appBackground,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2.5),
            ),
          ),
          const SizedBox(height: 0.5),
        ],
      ),
    );
  }
}

class _No extends StatelessWidget {
  const _No({
    required this.codigo,
    required this.data,
    required this.status,
    required this.emFoco,
    required this.pulso,
    required this.onTap,
  });

  final String codigo;
  final DateTime data;
  final StepperNodeStatus status;

  /// Etapa visível na lista agora (anel + rótulo em destaque).
  final bool emFoco;
  final Animation<double> pulso;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final proxima = status == StepperNodeStatus.atual;
    final feito = status == StepperNodeStatus.concluido;
    final fundo = context.appBackground;

    final Widget circulo;
    if (feito) {
      circulo = Container(
        width: 18,
        height: 18,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, size: 12, color: Colors.white),
      );
    } else if (proxima) {
      circulo = AnimatedBuilder(
        animation: pulso,
        builder: (context, child) => Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: fundo,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 4),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary
                    .withValues(alpha: 0.30 * (1 - pulso.value) + 0.06),
                spreadRadius: 2 + 5 * pulso.value,
              ),
            ],
          ),
        ),
      );
    } else {
      circulo = Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: fundo,
          shape: BoxShape.circle,
          border: Border.all(color: context.appBorder, width: 2),
        ),
      );
    }

    final corCodigo = proxima || emFoco
        ? AppColors.primary
        : feito
            ? context.appTextPrimary
            : context.appTextSecondary;

    return Semantics(
      button: true,
      selected: emFoco,
      label: 'Etapa $codigo, ${AppFormatters.data(data)}'
          '${proxima ? ', próxima' : feito ? ', concluída' : ''}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (emFoco && !proxima)
              Positioned(
                top: TalhaoTimelineStepper._yLinha - 15,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            Positioned(
              top: TalhaoTimelineStepper._yLinha - (feito ? 9 : proxima ? 11 : 6),
              child: circulo,
            ),
            Positioned(
              top: TalhaoTimelineStepper._yLinha + 16,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    codigo,
                    textAlign: TextAlign.center,
                    style: AppTypography.label.copyWith(
                      fontSize: 12,
                      color: corCodigo,
                      fontWeight:
                          proxima || emFoco ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  if (proxima)
                    Text(
                      AppFormatters.data(data).substring(0, 5),
                      style: AppTypography.label.copyWith(
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Complemento curto da etapa (ex.: "6 dias após o pós-emergente"), para o
/// título do card ficar só com o nome. `null` quando não há o que dizer.
String? notaCurtaEtapa(CronogramaSojaLinha linha) {
  final nota = linha.notaEtapa?.trim();
  if (nota != null && nota.isNotEmpty) return nota;
  final dias = RegExp(r'\((\+?)(\d+) dias\)').firstMatch(linha.etapa)?.group(2);
  if (dias == null) return null;
  switch (linha.tipo) {
    case CronogramaSojaLinhaTipo.emergencia:
      return '$dias dias após o plantio';
    case CronogramaSojaLinhaTipo.fungicida:
      return (linha.fungicidaIndice ?? 1) == 1
          ? '$dias dias após o pós-emergente'
          : '+$dias dias da aplicação anterior';
    default:
      return null;
  }
}
