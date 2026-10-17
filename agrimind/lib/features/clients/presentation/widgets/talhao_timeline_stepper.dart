import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
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

/// Etapa "em foco" ao rolar: a última cujo topo já passou de [limite]
/// (borda inferior do cabeçalho fixo). `null` se nenhuma passou.
int? indiceEtapaEmFoco(List<double?> topos, double limite) {
  int? foco;
  for (var i = 0; i < topos.length; i++) {
    final t = topos[i];
    if (t != null && t <= limite) foco = i;
  }
  return foco;
}

/// Faixa horizontal com a fase da lavoura; toque rola até a etapa.
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

  static const double altura = 64;
  static const double _larguraNo = 64;
  static const double _padding = AppSpacing.sm;

  @override
  State<TalhaoTimelineStepper> createState() => _TalhaoTimelineStepperState();
}

class _TalhaoTimelineStepperState extends State<TalhaoTimelineStepper> {
  final _scroll = ScrollController();
  int? _atualPos;

  @override
  void initState() {
    super.initState();
    widget.foco?.addListener(_onFoco);
    _atualPos = _posAtual();
    // Centraliza o nó atual só na faixa horizontal (não mexe na lista).
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _centralizar(_atualPos, animar: false));
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
          .addPostFrameCallback((_) => _centralizar(nova, animar: true));
    }
  }

  @override
  void dispose() {
    widget.foco?.removeListener(_onFoco);
    _scroll.dispose();
    super.dispose();
  }

  int? _posAtual() {
    final nos = indicesNosStepper(widget.etapas);
    final status = statusDasEtapas(
      [for (final i in nos) widget.etapas[i].data],
      widget.hoje ?? DateTime.now(),
    );
    final pos = status.indexOf(StepperNodeStatus.atual);
    return pos < 0 ? null : pos;
  }

  /// Posição (entre os nós) da etapa em foco, ou `null`.
  int? _posFoco() {
    final f = widget.foco?.value;
    if (f == null) return null;
    final pos = indicesNosStepper(widget.etapas).indexOf(f);
    return pos < 0 ? null : pos;
  }

  void _onFoco() => _centralizar(_posFoco() ?? _atualPos, animar: true);

  void _centralizar(int? pos, {required bool animar}) {
    if (!mounted || pos == null || !_scroll.hasClients) return;
    final pista = _scroll.position;
    final alvo = (TalhaoTimelineStepper._padding +
            pos * TalhaoTimelineStepper._larguraNo +
            TalhaoTimelineStepper._larguraNo / 2 -
            pista.viewportDimension / 2)
        .clamp(0.0, pista.maxScrollExtent);
    if (animar) {
      _scroll.animateTo(
        alvo,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else {
      _scroll.jumpTo(alvo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nos = indicesNosStepper(widget.etapas);
    final status = statusDasEtapas(
      [for (final i in nos) widget.etapas[i].data],
      widget.hoje ?? DateTime.now(),
    );

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
            final posFoco = foco == null ? null : nos.indexOf(foco);
            return SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: TalhaoTimelineStepper._padding,
              ),
              child: Row(
                children: [
                  for (var n = 0; n < nos.length; n++)
                    _No(
                      codigo: codigoEstagioEtapa(widget.etapas[nos[n]].linha),
                      status: status[n],
                      emFoco: n == posFoco,
                      linhaEsquerda: n == 0
                          ? null
                          : status[n] != StepperNodeStatus.futuro,
                      linhaDireita: n == nos.length - 1
                          ? null
                          : status[n + 1] != StepperNodeStatus.futuro,
                      onTap: () => widget.onEtapaTap(nos[n]),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _No extends StatelessWidget {
  const _No({
    required this.codigo,
    required this.status,
    required this.emFoco,
    required this.linhaEsquerda,
    required this.linhaDireita,
    required this.onTap,
  });

  final String codigo;
  final StepperNodeStatus status;

  /// Etapa visível na lista agora (anel + rótulo em destaque).
  final bool emFoco;

  /// `null` = sem segmento; `true` = segmento percorrido.
  final bool? linhaEsquerda;
  final bool? linhaDireita;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final atual = status == StepperNodeStatus.atual;
    final cinza = context.appTextSecondary;
    final claro = context.appBorder;

    Widget segmento(bool? feito) => Expanded(
          child: feito == null
              ? const SizedBox()
              : Container(height: 2, color: feito ? cinza : claro),
        );

    Widget circulo = switch (status) {
      StepperNodeStatus.concluido => Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: cinza, shape: BoxShape.circle),
        ),
      StepperNodeStatus.atual => Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                spreadRadius: 4,
              ),
            ],
          ),
        ),
      StepperNodeStatus.futuro => Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: claro, width: 2),
          ),
        ),
    };

    if (emFoco && !atual) {
      circulo = Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: circulo,
      );
    }

    return Semantics(
      button: true,
      label: 'Etapa $codigo',
      selected: atual,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: TalhaoTimelineStepper._larguraNo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 26,
                child: Row(
                  children: [
                    segmento(linhaEsquerda),
                    circulo,
                    segmento(linhaDireita),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                codigo,
                style: AppTypography.label.copyWith(
                  color: atual || emFoco
                      ? AppColors.primary
                      : status == StepperNodeStatus.concluido
                          ? cinza
                          : cinza.withValues(alpha: 0.6),
                  fontWeight:
                      atual || emFoco ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
