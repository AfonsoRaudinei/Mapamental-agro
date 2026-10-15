import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/theme/plan_stage_card_tokens.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../../../core/widgets/accordion_section.dart';
import '../../../../core/widgets/cupertino_destructive_confirm.dart';
import '../../../../core/widgets/ios_swipe_delete.dart';
import '../../../../core/widgets/summary_expandable_card.dart';
import '../../../consolidation/presentation/providers/consolidacao_provider.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../providers/expanded_panels_provider.dart';
import '../../domain/talhao_safra/estadio_cronograma_metadata.dart';
import '../../domain/talhao_safra/roteiro_plano_template.dart';
import '../../domain/talhao_safra/mapear_tipo_operacional_label.dart';
import '../../domain/talhao_safra/tipo_operacional.dart';
import 'accordion_stage_card.dart';
import 'operacional_stage_editor.dart';
import 'operacional_tipo_dropdown.dart';
import 'talhao_instancia_stage_badge.dart';
import 'semente_stage_block.dart';
import 'stage_references_button.dart';

abstract final class PlanCanvasWidgets {
  static const operacionalCodigo = 'Operacional';
  static const sementesCodigo = 'Sementes';
}

class PlanCanvasTopBar extends StatelessWidget {
  const PlanCanvasTopBar({
    super.key,
    required this.showConsolidation,
    required this.exporting,
    required this.onPlanTap,
    required this.onConsolidationTap,
    required this.onExportTap,
  });

  final bool showConsolidation;
  final bool exporting;
  final VoidCallback onPlanTap;
  final VoidCallback onConsolidationTap;
  final VoidCallback onExportTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      color: PlanStageCardTokens.canvas(context),
      child: Align(
        alignment: Alignment.centerRight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PlanStageCardTokens.border(context)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TopButton(
                  icon: PhosphorIconsRegular.note,
                  active: !showConsolidation,
                  onTap: onPlanTap,
                ),
                _TopButton(
                  icon: PhosphorIconsRegular.listChecks,
                  active: showConsolidation,
                  onTap: onConsolidationTap,
                ),
                _TopButton(
                  icon: exporting
                      ? PhosphorIconsRegular.circleNotch
                      : PhosphorIconsRegular.export,
                  onTap: exporting ? null : onExportTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton({required this.icon, this.active = false, this.onTap});

  final IconData icon;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor:
            active ? AppColors.primary.withValues(alpha: 0.12) : null,
        minimumSize: const Size(36, 36),
        fixedSize: const Size(36, 36),
        padding: EdgeInsets.zero,
      ),
      icon: PhosphorIcon(
        icon,
        size: 18,
        color: active ? AppColors.primary : context.appTextPrimary,
      ),
    );
  }
}

class PlanningView extends StatelessWidget {
  const PlanningView({
    super.key,
    required this.plano,
    required this.produtor,
    required this.fazenda,
    required this.onPlanoChanged,
    required this.onAddEstadio,
    required this.onAddSemente,
    required this.onAddProduto,
    required this.onAddProdutoFromReferencia,
    required this.onDeleteProduto,
    required this.onEditProduto,
    required this.onPickStageImage,
    required this.onUpdateEstadio,
    required this.onRemoveEstadio,
    this.onSyncFungicidaSubcards,
    this.filtroTalhaoId,
    this.talhaoNomes = const {},
    this.filtroTalhaoBannerLabel,
  });

  final PlanoEntity plano;
  final String produtor;
  final String fazenda;
  final ValueChanged<PlanoEntity> onPlanoChanged;
  final VoidCallback onAddEstadio;
  final Future<void> Function() onAddSemente;
  final void Function(EstadioEntity estadio) onAddProduto;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;
  final Future<void> Function(String estadioId, String produtoId)
      onDeleteProduto;
  final void Function(EstadioEntity estadio, ProdutoAplicacaoEntity produto)
      onEditProduto;
  final ValueChanged<EstadioEntity> onPickStageImage;
  final Future<void> Function(EstadioEntity estadio) onUpdateEstadio;
  final Future<void> Function(String estadioId) onRemoveEstadio;
  final Future<void> Function(EstadioEntity pai)? onSyncFungicidaSubcards;

  /// Quando definido, mostra só instâncias deste talhão (roteiro atribuído).
  final String? filtroTalhaoId;

  final Map<String, String> talhaoNomes;

  final String? filtroTalhaoBannerLabel;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final sortedEstadios = [...plano.estadios]
      ..sort((a, b) => a.ordem.compareTo(b.ordem));
    final sementesEstadioIds = sortedEstadios
        .where((e) => e.isSementes)
        .map((e) => e.id)
        .toList();
    final primarySementesEstadioId =
        sementesEstadioIds.isEmpty ? null : sementesEstadioIds.first;

    final stageBlocks = <Widget>[];
    for (final estadio in sortedEstadios) {
      if (!estadioVisivelNoCanvasPlano(
        estadio,
        filtroTalhaoId: filtroTalhaoId,
      )) {
        continue;
      }
      if (estadio.isSementes && plano.fazendaId != null) {
        if (estadio.id != primarySementesEstadioId) continue;
        stageBlocks.add(
          SementeStageBlock(
            key: ValueKey(estadio.id),
            planoId: plano.id,
            fazendaId: plano.fazendaId!,
            estadio: estadio,
            sementesEstadioIds: sementesEstadioIds,
            onRemoveEstadio: onRemoveEstadio,
            onUpdateEstadio: onUpdateEstadio,
          ),
        );
        continue;
      }
      stageBlocks.add(
        StageBlock(
          key: ValueKey(estadio.id),
          plano: plano,
          estadio: estadio,
          onPickStageImage: onPickStageImage,
          onAddProduto: onAddProduto,
          onAddProdutoFromReferencia: onAddProdutoFromReferencia,
          onDeleteProduto: onDeleteProduto,
          onEditProduto: onEditProduto,
          onUpdateEstadio: onUpdateEstadio,
          onRemoveEstadio: onRemoveEstadio,
          onSyncFungicidaSubcards: onSyncFungicidaSubcards,
          talhaoNomes: talhaoNomes,
        ),
      );
    }

    final filtroBanner = filtroTalhaoBannerLabel != null &&
            filtroTalhaoBannerLabel!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                const PhosphorIcon(
                  PhosphorIconsRegular.mapPin,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Cards do talhão: $filtroTalhaoBannerLabel',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.appTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          )
        : null;

    final header = PlanHeaderCard(
      plano: plano,
      produtor: produtor,
      fazenda: fazenda,
      onChanged: onPlanoChanged,
    );

    return ColoredBox(
      color: PlanStageCardTokens.canvas(context),
      child: Column(
        children: [
          Expanded(
            child: plano.estadios.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        child: header,
                      ),
                      Expanded(
                        child: Center(
                          child: _CanvasHint(
                            onTap: onAddEstadio,
                            label: 'Adicionar',
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 12,
                    ),
                    children: [
                      header,
                      if (filtroBanner != null) filtroBanner,
                      const SizedBox(height: 8),
                      ...stageBlocks,
                      const SizedBox(height: 6),
                      _CanvasHint(
                        onTap: onAddEstadio,
                        label: 'Adicionar',
                      ),
                    ],
                  ),
          ),
          Container(
            color: PlanStageCardTokens.canvas(context),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 4,
              bottom: 8 + bottomInset,
            ),
            child: PlanSummaryCard(
              planoId: plano.id,
              areaHa: plano.areaHaTotal,
            ),
          ),
        ],
      ),
    );
  }
}

class PlanHeaderCard extends ConsumerStatefulWidget {
  const PlanHeaderCard({
    super.key,
    required this.plano,
    required this.produtor,
    required this.fazenda,
    required this.onChanged,
  });

  final PlanoEntity plano;
  final String produtor;
  final String fazenda;
  final ValueChanged<PlanoEntity> onChanged;

  @override
  ConsumerState<PlanHeaderCard> createState() => _PlanHeaderCardState();
}

class _PlanHeaderCardState extends ConsumerState<PlanHeaderCard> {
  late final TextEditingController _produtor;
  late final TextEditingController _fazenda;
  late final TextEditingController _area;
  late final TextEditingController _cidade;
  late final TextEditingController _safra;

  String get _accordionSubtitle {
    final faz = _fazenda.text.trim();
    final area = _area.text.trim();
    final cidade = _cidade.text.trim();
    final safra = _safra.text.trim();
    final parts = <String>[
      if (faz.isNotEmpty) faz,
      if (area.isNotEmpty) '$area ha',
      if (cidade.isNotEmpty) cidade,
      if (safra.isNotEmpty) safra,
    ];
    return parts.isEmpty
        ? 'Toque para preencher produtor, fazenda e área'
        : parts.join(' · ');
  }

  @override
  void initState() {
    super.initState();
    _produtor = TextEditingController(text: widget.produtor);
    _fazenda = TextEditingController(text: widget.fazenda);
    _area = TextEditingController(
        text: widget.plano.areaHaTotal.toStringAsFixed(1));
    _cidade = TextEditingController(text: widget.plano.cidadeUf ?? '');
    _safra = TextEditingController(text: widget.plano.safra);
    for (final controller in [_produtor, _fazenda, _area, _cidade, _safra]) {
      controller.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void didUpdateWidget(covariant PlanHeaderCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.produtor != widget.produtor &&
        _produtor.text != widget.produtor) {
      _produtor.text = widget.produtor;
    }
    if (oldWidget.fazenda != widget.fazenda &&
        _fazenda.text != widget.fazenda) {
      _fazenda.text = widget.fazenda;
    }
    final newArea = widget.plano.areaHaTotal.toStringAsFixed(1);
    if (oldWidget.plano.areaHaTotal != widget.plano.areaHaTotal &&
        _area.text != newArea) {
      _area.text = newArea;
    }
    final newCidade = widget.plano.cidadeUf ?? '';
    if (oldWidget.plano.cidadeUf != widget.plano.cidadeUf &&
        _cidade.text != newCidade) {
      _cidade.text = newCidade;
    }
    if (oldWidget.plano.safra != widget.plano.safra &&
        _safra.text != widget.plano.safra) {
      _safra.text = widget.plano.safra;
    }
  }

  @override
  void dispose() {
    _produtor.dispose();
    _fazenda.dispose();
    _area.dispose();
    _cidade.dispose();
    _safra.dispose();
    super.dispose();
  }

  void _save() {
    final area = double.tryParse(_area.text.replaceAll(',', '.'));
    widget.onChanged(
      widget.plano.copyWith(
        produtorNomeLivre:
            _produtor.text.trim().isEmpty ? null : _produtor.text.trim(),
        fazendaNomeLivre:
            _fazenda.text.trim().isEmpty ? null : _fazenda.text.trim(),
        cidadeUf: _cidade.text.trim().isEmpty ? null : _cidade.text.trim(),
        safra: _safra.text.trim().isEmpty
            ? widget.plano.safra
            : _safra.text.trim(),
        areaHaTotal:
            area == null || area <= 0 ? widget.plano.areaHaTotal : area,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final produtorField = _HeaderField(
      label: 'Produtor',
      controller: _produtor,
      onDone: _save,
    );
    final fazendaField = _HeaderField(
      label: 'Fazenda',
      controller: _fazenda,
      onDone: _save,
    );
    final areaField = _HeaderField(
      label: 'Área (ha)',
      controller: _area,
      onDone: _save,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    final cidadeField = _HeaderField(
      label: 'Cidade / UF',
      controller: _cidade,
      onDone: _save,
    );
    final safraField = _HeaderField(
      label: 'Safra / Talhão',
      controller: _safra,
      onDone: _save,
    );

    final produtorTitulo = _produtor.text.trim();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AccordionSection(
        title: produtorTitulo.isEmpty ? 'Produtor' : produtorTitulo,
        subtitle: _accordionSubtitle,
        quiet: true,
        borderColor: PlanStageCardTokens.border(context),
        isExpanded: ref.isPanelExpanded(identificacaoPanelId),
        onToggle: (_) => ref.togglePanel(identificacaoPanelId),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 520;
            if (narrow) {
              return Column(
                children: [
                  produtorField,
                  Divider(height: 1, color: context.appBorderSoft),
                  fazendaField,
                  Divider(height: 1, color: context.appBorderSoft),
                  areaField,
                  Divider(height: 1, color: context.appBorderSoft),
                  cidadeField,
                  Divider(height: 1, color: context.appBorderSoft),
                  safraField,
                ],
              );
            }
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: produtorField),
                    Expanded(child: fazendaField),
                    SizedBox(width: 120, child: areaField),
                  ],
                ),
                Divider(height: 1, color: context.appBorderSoft),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: cidadeField),
                    Expanded(child: safraField),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HeaderField extends StatelessWidget {
  const _HeaderField({
    required this.label,
    required this.controller,
    required this.onDone,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final VoidCallback onDone;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.label.copyWith(
              color: context.appTextDisabled,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTypography.body.copyWith(
              color: context.appTextPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: context.appBackground,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.appBorderSoft),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.appBorderSoft),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
            onSubmitted: (_) => onDone(),
            onTapOutside: (_) => onDone(),
          ),
        ],
      ),
    );
  }
}

class StageBlock extends ConsumerStatefulWidget {
  const StageBlock({
    super.key,
    required this.plano,
    required this.estadio,
    required this.onPickStageImage,
    required this.onAddProduto,
    required this.onAddProdutoFromReferencia,
    required this.onDeleteProduto,
    required this.onEditProduto,
    required this.onUpdateEstadio,
    required this.onRemoveEstadio,
    this.onSyncFungicidaSubcards,
    this.talhaoNomes = const {},
  });

  final PlanoEntity plano;
  final EstadioEntity estadio;
  final Map<String, String> talhaoNomes;
  final ValueChanged<EstadioEntity> onPickStageImage;
  final void Function(EstadioEntity estadio) onAddProduto;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;
  final Future<void> Function(String estadioId, String produtoId)
      onDeleteProduto;
  final void Function(EstadioEntity estadio, ProdutoAplicacaoEntity produto)
      onEditProduto;
  final Future<void> Function(EstadioEntity estadio) onUpdateEstadio;
  final Future<void> Function(String estadioId) onRemoveEstadio;
  final Future<void> Function(EstadioEntity pai)? onSyncFungicidaSubcards;

  @override
  ConsumerState<StageBlock> createState() => _StageBlockState();
}

class _StageBlockState extends ConsumerState<StageBlock> {
  late final TextEditingController _phase;

  String get _stageCode =>
      widget.estadio.isOperacional ? 'OP' : widget.estadio.codigo;

  String get _stageName {
    final tipo = widget.estadio.tipoOperacional;
    if (widget.estadio.isOperacional) {
      if (widget.estadio.isSubcardFungicida) {
        return widget.estadio.label.trim();
      }
      if (tipo != null && tipo != TipoOperacional.indefinido) {
        final cfg = widget.estadio.operacionalConfig;
        return labelOperacionalComAplicacao(
          tipo,
          incluirAdubacao: cfg?.incluirAdubacao ?? false,
          aplicacaoIndice: cfg?.aplicacaoIndice,
        );
      }
      return 'Selecione o tipo de operação';
    }
    if (widget.estadio.isFenologico) {
      if (tipo != null && tipo != TipoOperacional.indefinido) {
        final cfg = widget.estadio.operacionalConfig;
        return labelOperacionalComAplicacao(
          tipo,
          incluirAdubacao: cfg?.incluirAdubacao ?? false,
          aplicacaoIndice: cfg?.aplicacaoIndice,
        );
      }
      return 'Selecione o tipo de aplicação';
    }
    final code = widget.estadio.codigo;
    final label = widget.estadio.label.trim();
    final prefix = '$code — ';
    if (label.startsWith(prefix)) return label.substring(prefix.length);
    if (label == code) return label;
    return label;
  }

  @override
  void initState() {
    super.initState();
    _phase = TextEditingController(text: _fenologicoDisplayName());
  }

  String _fenologicoDisplayName() {
    if (widget.estadio.isFenologico) {
      return AppConstants.estadioLabels[widget.estadio.codigo] ??
          widget.estadio.codigo;
    }
    return _stageName;
  }

  @override
  void dispose() {
    _phase.dispose();
    super.dispose();
  }

  Future<void> _savePhase() async {
    final label = _phase.text.trim();
    if (label.isEmpty || label == widget.estadio.label) return;
    await widget.onUpdateEstadio(widget.estadio.copyWith(label: label));
  }

  void _removeStage() {
    ref.collapsePanel(widget.estadio.id);
    widget.onRemoveEstadio(widget.estadio.id);
  }

  Widget _collapsedSubtitleWidget(BuildContext context) {
    final produtos = widget.estadio.produtos;
    final meta = widget.estadio.isOperacional
        ? lerMetadataCronograma(widget.estadio)
        : null;
    final cronogramHint = meta != null && meta.geradoDoCronograma
        ? Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                const PhosphorIcon(
                  PhosphorIconsRegular.calculator,
                  size: 13,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    estadioDivergeDoCronograma(widget.estadio)
                        ? 'Calculado automaticamente · divergente'
                        : 'Calculado automaticamente',
                    style: AppTypography.caption.copyWith(
                      color: estadioDivergeDoCronograma(widget.estadio)
                          ? AppColors.warning
                          : context.appTextSecondary,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          )
        : null;

    if (produtos.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cronogramHint != null) cronogramHint,
          Text(
            'Nenhum produto — toque para adicionar',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
              height: 1.35,
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cronogramHint != null) cronogramHint,
        for (var i = 0; i < produtos.length; i++) ...[
          if (i > 0) const SizedBox(height: 2),
          _produtoResumoLinha(context, produtos[i]),
        ],
      ],
    );
  }

  Widget _produtoResumoLinha(
    BuildContext context,
    ProdutoAplicacaoEntity produto,
  ) {
    final dose = _formatDisplayDose(produto.dose, produto.doseUnidade);
    final totalQty =
        _formatDisplayTotal(produto.totalFinal, produto.doseUnidade);
    final totalUnit = UnitConverter.unidadeTotal(produto.doseUnidade);
    return Text.rich(
      TextSpan(
        style: AppTypography.caption.copyWith(
          color: context.appTextSecondary,
          height: 1.35,
        ),
        children: [
          TextSpan(
            text: produto.produtoNome,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: context.appTextPrimary,
            ),
          ),
          TextSpan(text: ' · $dose · $totalQty $totalUnit'),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = '$_stageCode — $_stageName';
    final talhaoLabel = rotuloTalhaoInstanciaCanvas(
      widget.estadio,
      widget.talhaoNomes,
    );
    final isInstancia = talhaoLabel.isNotEmpty;
    final isCardExpanded = ref.isPanelExpanded(widget.estadio.id);
    Widget? titleDropdown;
    if (widget.estadio.isOperacional && !widget.estadio.isSubcardFungicida) {
      titleDropdown = OperacionalTipoDropdown(
        estadio: widget.estadio,
        tipos: programaOperacionalTiposDropdownOperacao,
        plano: widget.plano,
        isExpanded: isCardExpanded,
        onSave: widget.onUpdateEstadio,
        onSyncFungicidaSubcards: widget.onSyncFungicidaSubcards,
      );
    } else if (widget.estadio.isFenologico) {
      titleDropdown = OperacionalTipoDropdown(
        estadio: widget.estadio,
        tipos: programaOperacionalTiposDropdownEstadio,
        plano: widget.plano,
        isExpanded: isCardExpanded,
        hintText: 'Selecione o tipo de aplicação',
        onSave: widget.onUpdateEstadio,
        onSyncFungicidaSubcards: widget.onSyncFungicidaSubcards,
      );
    } else {
      titleDropdown = null;
    }
    if (titleDropdown != null && !isCardExpanded) {
      // Dropdown só deve ser acionável com o card expandido.
      titleDropdown = IgnorePointer(child: titleDropdown);
    }

    final card = AccordionStageCard(
      stageCode: _stageCode,
      stageName: _stageName,
      titleWidget: titleDropdown,
      subtitleWidget: _collapsedSubtitleWidget(context),
      isExpanded: isCardExpanded,
      onToggle: () => ref.togglePanel(widget.estadio.id),
      borderColor: isInstancia
          ? PlanStageCardTokens.instanceBorder(context)
          : null,
      instanceTalhaoBadge: isInstancia
          ? TalhaoInstanciaStageBadge(talhaoLabel: talhaoLabel)
          : null,
      headerReferences: StageReferencesButton(
        estadio: widget.estadio,
        plano: widget.plano,
        compact: true,
        onAddProdutoFromReferencia: widget.onAddProdutoFromReferencia,
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.estadio.isOperacional || widget.estadio.isFenologico)
                OperacionalStageEditor(
                  estadio: widget.estadio,
                  onSave: widget.onUpdateEstadio,
                  onSyncFungicidaSubcards: widget.onSyncFungicidaSubcards,
                )
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                  child: TextField(
                    controller: _phase,
                    style: AppTypography.label.copyWith(
                      color: context.appTextSecondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Nome do estádio',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (_) => _savePhase(),
                    onTapOutside: (_) => _savePhase(),
                  ),
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => widget.onPickStageImage(widget.estadio),
                      child: _StageCircle(estadio: widget.estadio),
                    ),
                    const SizedBox(width: 9),
                    _OperationCard(
                      estadio: widget.estadio,
                      onAddProduto: () => widget.onAddProduto(widget.estadio),
                      onDeleteProduto: widget.onDeleteProduto,
                      onEditProduto: widget.onEditProduto,
                    ),
                  ],
                ),
              ),
            ],
          ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: IosSwipeDelete(
        dismissKey: ValueKey('swipe-${widget.estadio.id}'),
        itemName: label,
        onDelete: _removeStage,
        child: isInstancia
            ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                  border: const Border(
                    left: BorderSide(
                      color: PlanStageCardTokens.accent,
                      width: 3,
                    ),
                  ),
                ),
                child: card,
              )
            : card,
      ),
    );
  }
}

class _StageCircle extends StatelessWidget {
  const _StageCircle({required this.estadio});

  final EstadioEntity estadio;

  @override
  Widget build(BuildContext context) {
    final imagePath = estadio.imageLocalPath;
    return Container(
      width: 58,
      height: 58,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        color: context.appBorderSoft,
        shape: BoxShape.circle,
        border: Border.all(color: context.appBorderSoft, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: imagePath == null
          ? Center(
              child: Text(
                estadio.codigo == 'Operacional' ? 'OP' : estadio.codigo,
                style: AppTypography.h3.copyWith(
                  color: context.appTextPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          : Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Center(child: Text(estadio.codigo)),
            ),
    );
  }
}

class _OperationCard extends StatelessWidget {
  const _OperationCard({
    required this.estadio,
    required this.onAddProduto,
    required this.onDeleteProduto,
    required this.onEditProduto,
  });

  final EstadioEntity estadio;
  final VoidCallback onAddProduto;
  final Future<void> Function(String estadioId, String produtoId)
      onDeleteProduto;
  final void Function(EstadioEntity estadio, ProdutoAplicacaoEntity produto)
      onEditProduto;

  @override
  Widget build(BuildContext context) {
    return _Card(
      width: 270,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (estadio.produtos.isEmpty)
            Text(
              'Nenhum produto',
              style: AppTypography.caption.copyWith(
                color: context.appTextDisabled,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...estadio.produtos.map(
              (produto) => _InlineProductRow(
                key: ValueKey(produto.id),
                produto: produto,
                onEdit: () => onEditProduto(estadio, produto),
                onDelete: () => onDeleteProduto(estadio.id, produto.id),
              ),
            ),
          if (estadio.produtos.isNotEmpty)
            Divider(height: 12, color: context.appBorderSoft),
          GestureDetector(
            onTap: onAddProduto,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const PhosphorIcon(
                    PhosphorIconsRegular.plus,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Adicionar produto',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineProductRow extends StatelessWidget {
  const _InlineProductRow({
    super.key,
    required this.produto,
    required this.onEdit,
    required this.onDelete,
  });

  final ProdutoAplicacaoEntity produto;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final totalUnit = UnitConverter.unidadeTotal(produto.doseUnidade);
    final total = _formatDisplayTotal(produto.totalFinal, produto.doseUnidade);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: [
          InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.only(right: 30, top: 2, bottom: 2),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      produto.produtoNome,
                      style: AppTypography.caption.copyWith(
                        color: context.appTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    _formatDisplayDose(produto.dose, produto.doseUnidade),
                    style: AppTypography.label.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$total $totalUnit',
                    style: AppTypography.caption.copyWith(
                      color: context.appTextPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () async {
                final confirmed = await showCupertinoDestructiveConfirm(
                  context,
                  itemName: produto.produtoNome,
                );
                if (confirmed) onDelete();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 28,
                minHeight: 28,
              ),
              icon: PhosphorIcon(
                PhosphorIconsRegular.x,
                size: 14,
                color: context.appTextDisabled,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDisplayDose(double value, String unidade) {
  final displayValue = UnitConverter.valorDisplay(value, unidade);
  return '${displayValue.toStringAsFixed(displayValue < 10 ? 2 : 1)} ${UnitConverter.unidadeBase(unidade)}';
}

String _formatDisplayTotal(double value, String unidade) {
  final displayValue = UnitConverter.valorDisplay(value, unidade);
  return displayValue.toStringAsFixed(displayValue < 10 ? 2 : 1);
}

class PlanSummaryCard extends ConsumerWidget {
  const PlanSummaryCard({
    super.key,
    required this.planoId,
    required this.areaHa,
  });

  final String planoId;
  final double areaHa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consolidation = ref.watch(consolidacaoProvider(planoId));
    return consolidation.when(
      data: (data) {
        if (data.itens.isEmpty) return const SizedBox.shrink();
        final total = data.custoGeral ?? 0;
        final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
        final custoHa = areaHa > 0 ? total / areaHa : 0;
        return SummaryExpandableCard(
          initiallyExpanded: false,
          margin: EdgeInsets.zero,
          color: PlanStageCardTokens.footerCard(context),
          borderColor: PlanStageCardTokens.border(context),
          summary: SummaryDetailLine(
            primary: 'Investimento ${currency.format(total)}',
            secondary: areaHa > 0
                ? '${currency.format(custoHa)} / ha · ${data.itens.length} produtos'
                : '${data.itens.length} produtos consolidados',
            emphasize: true,
          ),
          detail: Column(
            children: [
              _SummaryRow(
                label: 'Total investimento',
                value: currency.format(total),
                highlight: true,
              ),
              Divider(color: context.appBorderSoft),
              _SummaryRow(
                label: 'Custo / hectare',
                value:
                    areaHa > 0 ? '${currency.format(custoHa)} / ha' : '— / ha',
              ),
              _SummaryRow(
                label: 'Produtos',
                value: '${data.itens.length}',
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.caption.copyWith(
              color: highlight ? AppColors.primary : context.appTextPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _CanvasHint extends StatelessWidget {
  const _CanvasHint({
    required this.onTap,
    required this.label,
  });

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: context.appBorderSoft,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: PhosphorIcon(
                  PhosphorIconsRegular.plus,
                  size: 22,
                  color: context.appTextDisabled,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.width,
    this.padding = const EdgeInsets.all(10),
    this.margin = const EdgeInsets.only(bottom: 14),
  });

  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: context.appSurface.withValues(alpha: 0.96),
        border: Border.all(color: context.appBorderSoft),
        borderRadius: BorderRadius.circular(10),
        boxShadow: context.isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: child,
    );
  }
}
