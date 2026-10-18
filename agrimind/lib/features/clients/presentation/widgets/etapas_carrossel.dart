import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../plans/presentation/models/product_view_model.dart';
import '../../../plans/presentation/widgets/product_tile.dart';
import '../../domain/cronograma_soja/cronograma_soja_linha.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import 'talhao_timeline_stepper.dart';

/// Etapas do talhão em carrossel: um card por vez, deslize para os lados.
/// O card vizinho aparece na borda para indicar que há mais.
class EtapasCarrossel extends StatelessWidget {
  const EtapasCarrossel({
    super.key,
    required this.etapas,
    required this.controller,
    required this.onPageChanged,
    this.onEditarPlantio,
    this.hoje,
  });

  final List<EtapaTalhao> etapas;
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  /// Toque no card de Plantio para alterar a data (null = somente leitura).
  final VoidCallback? onEditarPlantio;
  final DateTime? hoje;

  static const double alturaCard = 340;

  @override
  Widget build(BuildContext context) {
    final agora = hoje ?? DateTime.now();
    final status = statusDasEtapas([for (final e in etapas) e.data], agora);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Etapas',
              style: AppTypography.h3.copyWith(color: context.appTextPrimary),
            ),
            const Spacer(),
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final pagina = controller.hasClients &&
                        controller.position.haveDimensions
                    ? (controller.page ?? 0).round()
                    : controller.initialPage;
                return Text(
                  '${pagina + 1} de ${etapas.length}',
                  style: AppTypography.caption.copyWith(
                    color: context.appTextSecondary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: alturaCard,
          // O PageView ocupa a largura toda (sangra o padding da página)
          // para o card vizinho aparecer na borda.
          child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: controller,
              itemCount: etapas.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: AppSpacing.xs,
                ),
                child: _CartaoEtapa(
                  etapa: etapas[i],
                  status: status[i],
                  hoje: agora,
                  onEditar: etapas[i].linha.tipo ==
                          CronogramaSojaLinhaTipo.plantio
                      ? onEditarPlantio
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Card de uma etapa. Hierarquia: estádio + situação → nome → quando →
/// por quê → produtos.
class _CartaoEtapa extends StatelessWidget {
  const _CartaoEtapa({
    required this.etapa,
    required this.status,
    required this.hoje,
    this.onEditar,
  });

  final EtapaTalhao etapa;
  final StepperNodeStatus status;
  final DateTime hoje;
  final VoidCallback? onEditar;

  bool get _proxima => status == StepperNodeStatus.atual;
  bool get _feito => status == StepperNodeStatus.concluido;

  @override
  Widget build(BuildContext context) {
    final l = etapa.linha;
    final nome = nomeCurtoEtapa(l);
    final nota = notaCurtaEtapa(l);
    final quando = [
      AppFormatters.data(l.data),
      if (l.dae != null) 'DAE ${l.dae}',
    ].join(' · ');

    return Semantics(
      container: true,
      button: onEditar != null,
      label: '$nome, $quando, ${textoRelativo(l.data, hoje)}'
          '${onEditar != null ? '. Toque para alterar a data.' : ''}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onEditar,
        child: Container(
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _proxima ? AppColors.primary : context.appBorder,
            width: _proxima ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: context.isDark ? 0 : 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Estádio + situação
                  Row(
                    children: [
                      _ChipEstadio(codigoEstagioEtapa(l), destaque: _proxima),
                      const Spacer(),
                      _PilulaSituacao(
                        status: status,
                        relativo: textoRelativo(l.data, hoje),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // 2. Nome da etapa — o que manda no card
                  Text(
                    nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.h2.copyWith(
                      color: _feito
                          ? context.appTextSecondary
                          : context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 3. Quando (+ "Alterar" no card de Plantio)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          quando,
                          style: AppTypography.body.copyWith(
                            fontSize: 15,
                            height: 1.3,
                            color: _proxima
                                ? AppColors.primary
                                : context.appTextSecondary,
                            fontWeight:
                                _proxima ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (onEditar != null)
                        Text(
                          'Alterar',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                  // 4. Por quê (regra do cronograma)
                  if (nota != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      nota,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: context.appTextSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Divider(height: 1, color: context.appBorder),
            // 5. Produtos
            Expanded(child: _Produtos(etapa: etapa, ativos: !_feito)),
          ],
        ),
      ),
      ),
    );
  }
}

class _Produtos extends StatelessWidget {
  const _Produtos({required this.etapa, required this.ativos});

  final EtapaTalhao etapa;
  final bool ativos;

  @override
  Widget build(BuildContext context) {
    final produtos = etapa.produtosVinculados;
    if (produtos.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_available_rounded,
              size: 28,
              color: context.appTextDisabled,
            ),
            const SizedBox(height: 6),
            Text(
              'Sem produtos nesta etapa',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 2),
          child: Text(
            'PRODUTOS · ${produtos.length}',
            style: AppTypography.label.copyWith(
              color: context.appTextSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 6, bottom: AppSpacing.sm),
            physics: const ClampingScrollPhysics(),
            itemCount: produtos.length,
            itemBuilder: (context, i) {
              final p = produtos[i];
              return ProductTile(
                product: ProductViewModel(
                  id: p.produtoId,
                  name: p.nome,
                  doseLabel: AppFormatters.dose(p.dosePorHa, p.unidade),
                  totalLabel: [
                    AppFormatters.total(p.totalCalculado, p.unidadeDoTotal),
                    if (p.detalhe != null) p.detalhe!,
                  ].join(' · '),
                  isActive: ativos,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChipEstadio extends StatelessWidget {
  const _ChipEstadio(this.codigo, {required this.destaque});

  final String codigo;
  final bool destaque;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: destaque
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        codigo,
        style: AppTypography.label.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: destaque ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}

/// "Próxima · em 21 dias" / "Concluída · há 9 dias" / "em 27 dias".
class _PilulaSituacao extends StatelessWidget {
  const _PilulaSituacao({required this.status, required this.relativo});

  final StepperNodeStatus status;
  final String relativo;

  @override
  Widget build(BuildContext context) {
    final (texto, icone, cor) = switch (status) {
      StepperNodeStatus.atual => (
          'Próxima · $relativo',
          Icons.radio_button_checked_rounded,
          AppColors.primary,
        ),
      StepperNodeStatus.concluido => (
          'Concluída · $relativo',
          Icons.check_circle_rounded,
          context.appTextSecondary,
        ),
      StepperNodeStatus.futuro => (
          relativo[0].toUpperCase() + relativo.substring(1),
          Icons.schedule_rounded,
          context.appTextSecondary,
        ),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, size: 15, color: cor),
        const SizedBox(width: 4),
        Text(
          texto,
          style: AppTypography.caption.copyWith(
            color: cor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
