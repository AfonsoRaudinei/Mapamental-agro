import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/summary_expandable_card.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../../consolidation/presentation/providers/consolidacao_provider.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../providers/plano_detail_provider.dart';
import '../providers/plans_list_provider.dart';
import '../providers/produto_aplicacao_provider.dart';
import '../widgets/produto_panel.dart';
import '../widgets/stage_references_button.dart';
import '../../../../core/utils/extensions.dart';

class PlanCanvasPage extends ConsumerWidget {
  const PlanCanvasPage({super.key, required this.planoId});

  final String planoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planoAsync = ref.watch(planoDetailProvider(planoId));
    return planoAsync.when(
      data: (plano) => _CanvasView(planoId: planoId, plano: plano),
      loading: () => const Scaffold(body: LoadingSkeleton()),
      error: (_, __) => Scaffold(
        body: ErrorStateWidget(
          onRetry: () => ref.invalidate(planoDetailProvider(planoId)),
        ),
      ),
    );
  }
}

class _CanvasView extends ConsumerStatefulWidget {
  const _CanvasView({required this.planoId, required this.plano});

  final String planoId;
  final PlanoEntity plano;

  @override
  ConsumerState<_CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends ConsumerState<_CanvasView> {
  final _uuid = const Uuid();
  final _picker = ImagePicker();
  bool _showConsolidation = false;
  bool _exporting = false;

  PlanoEntity get _plano => widget.plano;

  Future<void> _updatePlano(PlanoEntity plano) async {
    await ref.read(plansRepoProvider).update(plano);
    _invalidatePlan();
  }

  void _invalidatePlan({String? estadioId}) {
    ref.invalidate(planoDetailProvider(widget.planoId));
    ref.invalidate(plansListNotifierProvider);
    ref.invalidate(consolidacaoProvider(widget.planoId));
    if (estadioId != null) {
      ref.invalidate(produtoAplicacaoNotifierProvider(estadioId));
    }
  }

  Future<void> _addEstadio() async {
    final used = _plano.estadios.map((item) => item.codigo).toSet();
    final available = AppConstants.estadiosCodigos
        .where((codigo) => !used.contains(codigo))
        .toList();
    if (available.isEmpty) {
      _showSnack('Todos os estádios já foram adicionados.');
      return;
    }
    final selected = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Novo Estádio'),
        actions: available
            .map(
              (codigo) => CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(codigo),
                child: Text(AppConstants.estadioLabels[codigo] ?? codigo),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ),
    );
    if (selected == null) return;

    await ref.read(plansRepoProvider).addEstadio(
          widget.planoId,
          EstadioEntity(
            id: _uuid.v4(),
            planoId: widget.planoId,
            codigo: selected,
            label: AppConstants.estadioLabels[selected] ?? selected,
            ordem: AppConstants.estadiosCodigos.indexOf(selected),
            createdAt: DateTime.now(),
          ),
        );
    _invalidatePlan();
  }

  Future<void> _updateEstadio(EstadioEntity estadio) async {
    await ref.read(plansRepoProvider).updateEstadio(estadio);
    _invalidatePlan(estadioId: estadio.id);
  }

  Future<void> _removeEstadio(String estadioId) async {
    await ref.read(plansRepoProvider).removeEstadio(estadioId);
    _invalidatePlan(estadioId: estadioId);
  }

  Future<void> _addProduto(
    EstadioEntity estadio, {
    required String nome,
    required double dose,
    required String unidade,
    required double areaHa,
    String produtoCategoria = 'Geral',
  }) async {
    await ref.read(plansRepoProvider).addProduto(
          estadio.id,
          ProdutoAplicacaoEntity(
            id: _uuid.v4(),
            estadioId: estadio.id,
            produtoNome: nome,
            produtoCategoria: produtoCategoria,
            dose: dose,
            doseUnidade: unidade,
            areaHa: areaHa,
            ordem: estadio.produtos.length,
            createdAt: DateTime.now(),
          ),
        );
    _invalidatePlan(estadioId: estadio.id);
  }

  Future<void> _addProdutoFromReferencia(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) async {
    _openProdutoPanel(
      estadio,
      nomeSugerido: nome,
      categoriaSugerida: produtoCategoria,
    );
  }

  Future<void> _updateProduto(
    String estadioId,
    ProdutoAplicacaoEntity produto,
  ) async {
    await ref.read(plansRepoProvider).updateProduto(produto);
    _invalidatePlan(estadioId: estadioId);
  }

  Future<void> _deleteProduto(String estadioId, String produtoId) async {
    await ref.read(plansRepoProvider).removeProduto(produtoId);
    _invalidatePlan(estadioId: estadioId);
  }

  void _openProdutoPanel(
    EstadioEntity estadio, {
    ProdutoAplicacaoEntity? produto,
    String? nomeSugerido,
    String? categoriaSugerida,
  }) {
    ProdutoPanel.show(
      context: context,
      estadioId: estadio.id,
      areaHaFazenda: _plano.areaHaTotal,
      fazendaNome: _displayFazenda,
      talhoes: const [],
      produtoInicial: produto,
      nomeSugerido: nomeSugerido,
      categoriaSugerida: categoriaSugerida,
      onSalvar: (dados) async {
        if (produto != null) {
          await _updateProduto(
            estadio.id,
            produto.copyWith(
              produtoNome: dados['produtoNome'] as String,
              produtoCategoria: dados['produtoCategoria'] as String,
              dose: (dados['dose'] as num).toDouble(),
              doseUnidade: dados['doseUnidade'] as String,
              areaHa: (dados['areaHa'] as num).toDouble(),
              totalOverride: dados['totalOverride'] as double?,
              overrideMotivo: dados['overrideMotivo'] as String?,
              observacao: dados['observacao'] as String?,
            ),
          );
        } else {
          await _addProduto(
            estadio,
            nome: dados['produtoNome'] as String,
            dose: (dados['dose'] as num).toDouble(),
            unidade: dados['doseUnidade'] as String,
            areaHa: (dados['areaHa'] as num).toDouble(),
            produtoCategoria: dados['produtoCategoria'] as String,
          );
        }
      },
    );
  }

  Future<void> _pickStageImage(EstadioEntity estadio) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final path = await _copyImageToAppDir(picked.path, 'stage_${estadio.id}');
    await _updateEstadio(estadio.copyWith(imageLocalPath: path));
  }

  Future<void> _pickLogo() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final path = await _copyImageToAppDir(picked.path, 'plan_logo');
    await _updatePlano(_plano.copyWith(logoLocalPath: path));
  }

  Future<String> _copyImageToAppDir(String sourcePath, String prefix) async {
    final dir = await getApplicationDocumentsDirectory();
    final ext = sourcePath.split('.').last;
    final target = File(
        '${dir.path}/${prefix}_${DateTime.now().millisecondsSinceEpoch}.$ext');
    return (await File(sourcePath).copy(target.path)).path;
  }

  Future<void> _exportHtml() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final file = await ref.read(exportHtmlProvider(widget.planoId).future);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: 'Mapa Fenológico - ${_plano.nome}',
        ),
      );
    } catch (error) {
      _showSnack('Erro ao exportar HTML: $error');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String get _displayProdutor =>
      _plano.produtorNomeLivre ?? _plano.clienteNome ?? '';
  String get _displayFazenda =>
      _plano.fazendaNomeLivre ?? _plano.fazendaNome ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(
              title: _plano.nome,
              showConsolidation: _showConsolidation,
              exporting: _exporting,
              onTitleChanged: (value) {
                final title = value.trim();
                if (title.isNotEmpty) {
                  _updatePlano(_plano.copyWith(nome: title));
                }
              },
              onPlanTap: () => setState(() => _showConsolidation = false),
              onConsolidationTap: () =>
                  setState(() => _showConsolidation = true),
              onExportTap: _exportHtml,
            ),
            Expanded(
              child: _showConsolidation
                  ? _ConsolidationView(
                      plano: _plano,
                      onPlanoChanged: _updatePlano,
                      onPriceChanged: (name, price) async {
                        await ref
                            .read(plansRepoProvider)
                            .updateProdutoPricesForPlano(
                              planoId: widget.planoId,
                              produtoNome: name,
                              precoUnitario: price,
                            );
                        _invalidatePlan();
                      },
                    )
                  : _PlanningView(
                      plano: _plano,
                      produtor: _displayProdutor,
                      fazenda: _displayFazenda,
                      onPlanoChanged: _updatePlano,
                      onAddEstadio: _addEstadio,
                      onPickLogo: _pickLogo,
                      onAddProduto: (estadio) => _openProdutoPanel(estadio),
                      onAddProdutoFromReferencia: _addProdutoFromReferencia,
                      onDeleteProduto: _deleteProduto,
                      onEditProduto: (estadio, produto) =>
                          _openProdutoPanel(estadio, produto: produto),
                      onPickStageImage: _pickStageImage,
                      onUpdateEstadio: _updateEstadio,
                      onRemoveEstadio: _removeEstadio,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatefulWidget {
  const _TopBar({
    required this.title,
    required this.showConsolidation,
    required this.exporting,
    required this.onTitleChanged,
    required this.onPlanTap,
    required this.onConsolidationTap,
    required this.onExportTap,
  });

  final String title;
  final bool showConsolidation;
  final bool exporting;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onPlanTap;
  final VoidCallback onConsolidationTap;
  final VoidCallback onExportTap;

  @override
  State<_TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<_TopBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.title);
  }

  @override
  void didUpdateWidget(covariant _TopBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title && _controller.text != widget.title) {
      _controller.text = widget.title;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: context.appSurface.withValues(alpha: 0.95),
        border: Border(bottom: BorderSide(color: context.appBorderSoft)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: AppTypography.body.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(border: InputBorder.none),
              textInputAction: TextInputAction.done,
              onSubmitted: widget.onTitleChanged,
              onTapOutside: (_) => widget.onTitleChanged(_controller.text),
            ),
          ),
          _TopButton(
            icon: PhosphorIconsRegular.note,
            active: !widget.showConsolidation,
            onTap: widget.onPlanTap,
          ),
          _TopButton(
            icon: PhosphorIconsRegular.listChecks,
            active: widget.showConsolidation,
            onTap: widget.onConsolidationTap,
          ),
          _TopButton(
            icon: widget.exporting
                ? PhosphorIconsRegular.circleNotch
                : PhosphorIconsRegular.export,
            onTap: widget.exporting ? null : widget.onExportTap,
          ),
        ],
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
            active ? AppColors.primary.withValues(alpha: 0.1) : null,
        minimumSize: const Size(34, 34),
        fixedSize: const Size(34, 34),
      ),
      icon: PhosphorIcon(
        icon,
        size: 18,
        color: active ? AppColors.primary : context.appTextPrimary,
      ),
    );
  }
}

class _PlanningView extends StatelessWidget {
  const _PlanningView({
    required this.plano,
    required this.produtor,
    required this.fazenda,
    required this.onPlanoChanged,
    required this.onAddEstadio,
    required this.onPickLogo,
    required this.onAddProduto,
    required this.onAddProdutoFromReferencia,
    required this.onDeleteProduto,
    required this.onEditProduto,
    required this.onPickStageImage,
    required this.onUpdateEstadio,
    required this.onRemoveEstadio,
  });

  final PlanoEntity plano;
  final String produtor;
  final String fazenda;
  final ValueChanged<PlanoEntity> onPlanoChanged;
  final VoidCallback onAddEstadio;
  final VoidCallback onPickLogo;
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

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 14, right: 14, top: 16, bottom: 8),
            children: [
              _PlanHeaderCard(
                plano: plano,
                produtor: produtor,
                fazenda: fazenda,
                onChanged: onPlanoChanged,
              ),
              if (plano.estadios.isEmpty)
                _CanvasHint(onTap: onAddEstadio)
              else ...[
                ...plano.estadios.map(
                  (estadio) => _StageBlock(
                    plano: plano,
                    estadio: estadio,
                    onPickStageImage: onPickStageImage,
                    onAddProduto: onAddProduto,
                    onAddProdutoFromReferencia: onAddProdutoFromReferencia,
                    onDeleteProduto: onDeleteProduto,
                    onEditProduto: onEditProduto,
                    onUpdateEstadio: onUpdateEstadio,
                    onRemoveEstadio: onRemoveEstadio,
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.appSurface.withValues(alpha: 0.98),
            border: Border(top: BorderSide(color: context.appBorderSoft)),
          ),
          padding: EdgeInsets.only(
            left: 14,
            right: 14,
            top: 8,
            bottom: 8 + bottomInset,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AddStageHint(onTap: onAddEstadio),
              _PlanSummaryCard(planoId: plano.id, areaHa: plano.areaHaTotal),
              _ConsultorCard(
                plano: plano,
                onPickLogo: onPickLogo,
                onConsultorChanged: (value) => onPlanoChanged(
                  plano.copyWith(consultorNome: value.trim()),
                ),
                onExibirNomeChanged: (value) => onPlanoChanged(
                  plano.copyWith(consultorExibirNome: value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanHeaderCard extends StatefulWidget {
  const _PlanHeaderCard({
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
  State<_PlanHeaderCard> createState() => _PlanHeaderCardState();
}

class _PlanHeaderCardState extends State<_PlanHeaderCard> {
  late final TextEditingController _produtor;
  late final TextEditingController _fazenda;
  late final TextEditingController _area;
  late final TextEditingController _cidade;
  late final TextEditingController _safra;

  bool get _hasIdentifyingData =>
      widget.produtor.isNotEmpty ||
      widget.fazenda.isNotEmpty ||
      (widget.plano.cidadeUf?.isNotEmpty ?? false);

  String get _summaryPrimary {
    final prod = _produtor.text.trim();
    final faz = _fazenda.text.trim();
    if (prod.isEmpty && faz.isEmpty) return 'Identificação do plano';
    if (prod.isEmpty) return faz;
    if (faz.isEmpty) return prod;
    return '$prod · $faz';
  }

  String get _summarySecondary {
    final area = _area.text.trim();
    final cidade = _cidade.text.trim();
    final safra = _safra.text.trim();
    final parts = <String>[
      if (area.isNotEmpty) '$area ha',
      if (cidade.isNotEmpty) cidade,
      if (safra.isNotEmpty) safra,
    ];
    return parts.isEmpty ? 'Toque para preencher produtor, fazenda e área' : parts.join(' · ');
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
  void didUpdateWidget(covariant _PlanHeaderCard oldWidget) {
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

    return SummaryExpandableCard(
      initiallyExpanded: !_hasIdentifyingData,
      summary: SummaryDetailLine(
        primary: _summaryPrimary,
        secondary: _summarySecondary,
      ),
      detail: LayoutBuilder(
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

class _StageBlock extends StatefulWidget {
  const _StageBlock({
    required this.plano,
    required this.estadio,
    required this.onPickStageImage,
    required this.onAddProduto,
    required this.onAddProdutoFromReferencia,
    required this.onDeleteProduto,
    required this.onEditProduto,
    required this.onUpdateEstadio,
    required this.onRemoveEstadio,
  });

  final PlanoEntity plano;
  final EstadioEntity estadio;
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

  @override
  State<_StageBlock> createState() => _StageBlockState();
}

class _StageBlockState extends State<_StageBlock> {
  late final TextEditingController _phase;

  bool get _initiallyExpanded =>
      widget.estadio.produtos.isEmpty ||
      widget.estadio.codigo == 'Operacional';

  @override
  void initState() {
    super.initState();
    _phase = TextEditingController(text: widget.estadio.label);
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

  @override
  Widget build(BuildContext context) {
    return SummaryExpandableCard(
      initiallyExpanded: _initiallyExpanded,
      leading: _StageLeadingCluster(
        estadio: widget.estadio,
        plano: widget.plano,
        onPickStageImage: () => widget.onPickStageImage(widget.estadio),
        onAddProdutoFromReferencia: widget.onAddProdutoFromReferencia,
      ),
      summary: _StageSummary(
        estadioLabel: widget.estadio.label,
        produtos: widget.estadio.produtos,
      ),
      trailing: IconButton(
        onPressed: () => widget.onRemoveEstadio(widget.estadio.id),
        icon: PhosphorIcon(
          PhosphorIconsRegular.x,
          size: 16,
          color: context.appTextDisabled,
        ),
      ),
      detailPadding: EdgeInsets.zero,
      detail: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
  }
}

String _formatProdutoResumo(ProdutoAplicacaoEntity produto) {
  return '${produto.produtoNome} · ${_formatDose(produto.dose, produto.doseUnidade)} · '
      '${_formatTotal(produto.totalFinal, produto.doseUnidade)}';
}

String _formatDose(double value, String unidade) {
  final displayValue = UnitConverter.valorDisplay(value, unidade);
  return '${displayValue.toStringAsFixed(displayValue < 10 ? 2 : 1)} ${UnitConverter.unidadeBase(unidade)}';
}

String _formatTotal(double value, String unidade) {
  final displayValue = UnitConverter.valorDisplay(value, unidade);
  return '${displayValue.toStringAsFixed(displayValue < 10 ? 2 : 1)} ${UnitConverter.unidadeTotal(unidade)}';
}

class _StageSummary extends StatelessWidget {
  const _StageSummary({
    required this.estadioLabel,
    required this.produtos,
  });

  final String estadioLabel;
  final List<ProdutoAplicacaoEntity> produtos;

  @override
  Widget build(BuildContext context) {
    if (produtos.isEmpty) {
      return SummaryDetailLine(
        primary: estadioLabel,
        secondary: 'Nenhum produto — toque para adicionar',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          estadioLabel,
          style: AppTypography.body.copyWith(
            color: context.appTextPrimary,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        ...produtos.map(
          (produto) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              _formatProdutoResumo(produto),
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class _StageLeadingCluster extends ConsumerWidget {
  const _StageLeadingCluster({
    required this.estadio,
    required this.plano,
    required this.onPickStageImage,
    required this.onAddProdutoFromReferencia,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final VoidCallback onPickStageImage;
  final Future<void> Function(
    EstadioEntity estadio, {
    required String nome,
    required String produtoCategoria,
    required double areaHa,
  }) onAddProdutoFromReferencia;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPickStageImage,
          child: _StageCircle(estadio: estadio, compact: true),
        ),
        const SizedBox(width: 6),
        StageReferencesButton(
          estadio: estadio,
          plano: plano,
          compact: true,
          onAddProdutoFromReferencia: onAddProdutoFromReferencia,
        ),
      ],
    );
  }
}

class _StageCircle extends StatelessWidget {
  const _StageCircle({required this.estadio, this.compact = false});

  final EstadioEntity estadio;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final imagePath = estadio.imageLocalPath;
    final size = compact ? 40.0 : 58.0;
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.only(top: compact ? 0 : 2),
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
                style: (compact ? AppTypography.label : AppTypography.h3)
                    .copyWith(
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
    final unit = UnitConverter.unidadeBase(produto.doseUnidade);
    final total = _formatDisplayTotal(produto.totalFinal, produto.doseUnidade);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
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
                '$total $unit',
                style: AppTypography.caption.copyWith(
                  color: context.appTextPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              IconButton(
                onPressed: onDelete,
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
            ],
          ),
        ),
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

class _PlanSummaryCard extends ConsumerWidget {
  const _PlanSummaryCard({required this.planoId, required this.areaHa});

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
          summary: SummaryDetailLine(
            primary: 'Investimento ${currency.format(total)}',
            secondary: areaHa > 0
                ? '${currency.format(custoHa)} / ha · ${data.itens.length} produtos'
                : '${data.itens.length} produtos consolidados',
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
                value: areaHa > 0
                    ? '${currency.format(custoHa)} / ha'
                    : '— / ha',
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

class _ConsultorCard extends StatefulWidget {
  const _ConsultorCard({
    required this.plano,
    required this.onPickLogo,
    required this.onConsultorChanged,
    required this.onExibirNomeChanged,
  });

  final PlanoEntity plano;
  final VoidCallback onPickLogo;
  final ValueChanged<String> onConsultorChanged;
  final ValueChanged<bool> onExibirNomeChanged;

  @override
  State<_ConsultorCard> createState() => _ConsultorCardState();
}

class _ConsultorCardState extends State<_ConsultorCard> {
  late final TextEditingController _consultor;

  bool get _hasConsultor => _consultor.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _consultor = TextEditingController(text: widget.plano.consultorNome ?? '');
    _consultor.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant _ConsultorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nome = widget.plano.consultorNome ?? '';
    if (oldWidget.plano.consultorNome != widget.plano.consultorNome &&
        _consultor.text != nome) {
      _consultor.text = nome;
    }
  }

  @override
  void dispose() {
    _consultor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exibirNome = widget.plano.consultorExibirNome;
    final hasName = _hasConsultor;

    // Logo-only: no text space reserved. Tap logo to show name.
    if (hasName && !exibirNome) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: _FooterLogo(
            logoPath: widget.plano.logoLocalPath,
            size: 32,
            onTap: () => widget.onExibirNomeChanged(true),
          ),
        ),
      );
    }

    final primary = hasName
        ? (exibirNome ? _consultor.text.trim() : '')
        : 'Consultor';
    final secondary =
        hasName ? null : 'Toque para preencher nome e logo';

    return SummaryExpandableCard(
      initiallyExpanded: !hasName,
      leading: _FooterLogo(
        logoPath: widget.plano.logoLocalPath,
        size: 32,
        onTap: widget.onPickLogo,
      ),
      summary: SummaryDetailLine(
        primary: primary,
        secondary: secondary,
      ),
      trailing: hasName
          ? IconButton(
              onPressed: () =>
                  widget.onExibirNomeChanged(!exibirNome),
              tooltip: exibirNome ? 'Ocultar nome' : 'Exibir nome',
              icon: PhosphorIcon(
                exibirNome
                    ? PhosphorIconsRegular.eye
                    : PhosphorIconsRegular.eyeSlash,
                size: 18,
                color: context.appTextDisabled,
              ),
            )
          : null,
      detail: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _consultor,
            autofocus: !hasName,
            style: AppTypography.body.copyWith(color: context.appTextPrimary),
            decoration: const InputDecoration(
              hintText: 'Nome do consultor',
              border: InputBorder.none,
              isDense: true,
            ),
            onSubmitted: widget.onConsultorChanged,
            onTapOutside: (_) => widget.onConsultorChanged(_consultor.text),
          ),
          if (hasName) ...[
            const SizedBox(height: 4),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                'Exibir nome no plano',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
              value: exibirNome,
              onChanged: widget.onExibirNomeChanged,
            ),
          ],
        ],
      ),
    );
  }
}

class _FooterLogo extends StatelessWidget {
  const _FooterLogo({
    required this.logoPath,
    required this.size,
    required this.onTap,
  });

  final String? logoPath;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: context.appBorderSoft,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: logoPath == null
            ? PhosphorIcon(
                PhosphorIconsRegular.camera,
                color: context.appTextSecondary,
              )
            : Image.file(File(logoPath!), fit: BoxFit.cover),
      ),
    );
  }
}

class _ConsolidationView extends ConsumerWidget {
  const _ConsolidationView({
    required this.plano,
    required this.onPlanoChanged,
    required this.onPriceChanged,
  });

  final PlanoEntity plano;
  final ValueChanged<PlanoEntity> onPlanoChanged;
  final Future<void> Function(String produtoNome, double? preco) onPriceChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consolidation = ref.watch(consolidacaoProvider(plano.id));
    return ListView(
      padding: EdgeInsets.only(
        left: 14,
        right: 14,
        top: 16,
        bottom: 32 + MediaQuery.of(context).padding.bottom,
      ),
      children: [
        _ConsolidationParams(plano: plano, onPlanoChanged: onPlanoChanged),
        consolidation.when(
          data: (data) {
            final currency =
                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
            final total = data.custoGeral ?? 0;
            final pendingPrices =
                data.itens.where((item) => item.precoUnitario == null).length;

            return Column(
              children: [
                SummaryExpandableCard(
                  initiallyExpanded: data.itens.length <= 5,
                  summary: SummaryDetailLine(
                    primary: data.itens.isEmpty
                        ? 'Produtos consolidados'
                        : '${data.itens.length} produtos · ${currency.format(total)}',
                    secondary: data.itens.isEmpty
                        ? 'Adicione produtos no planejamento'
                        : pendingPrices > 0
                            ? '$pendingPrices preço(s) pendente(s) — toque para editar'
                            : 'Quantidades e preços unitários',
                  ),
                  detailPadding: EdgeInsets.zero,
                  detail: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        color: context.appBorderSoft,
                        child: const Row(
                          children: [
                            Expanded(child: _TableHead('Produto')),
                            SizedBox(width: 78, child: _TableHead('Qtd.')),
                            SizedBox(
                              width: 86,
                              child: _TableHead('R\$ Unit.'),
                            ),
                            SizedBox(
                              width: 86,
                              child: _TableHead('R\$ Total'),
                            ),
                          ],
                        ),
                      ),
                      if (data.itens.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Nenhum produto no planejamento.',
                            style: AppTypography.caption.copyWith(
                              color: context.appTextDisabled,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      else
                        ...data.itens.map(
                          (item) => _ConsolidationRow(
                            itemName: item.produtoNome,
                            quantity:
                                '${item.quantidadeTotal.toStringAsFixed(2)} ${item.unidade}',
                            initialPrice: item.precoUnitario,
                            total: item.custoTotal,
                            onPriceChanged: onPriceChanged,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _ConsolidationSummary(plano: plano, total: total),
              ],
            );
          },
          loading: () => const LoadingSkeleton(),
          error: (_, __) => Text(
            'Erro ao gerar consolidação',
            style: AppTypography.body.copyWith(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}

class _ConsolidationParams extends StatefulWidget {
  const _ConsolidationParams(
      {required this.plano, required this.onPlanoChanged});

  final PlanoEntity plano;
  final ValueChanged<PlanoEntity> onPlanoChanged;

  @override
  State<_ConsolidationParams> createState() => _ConsolidationParamsState();
}

class _ConsolidationParamsState extends State<_ConsolidationParams> {
  late final TextEditingController _grain;

  String get _grainSummary {
    final value = _grain.text.trim();
    if (value.isEmpty) return 'Preço do grão não informado';
    return 'R\$ $value / sc 60 kg';
  }

  String get _dateSummary {
    if (widget.plano.dataVencimento == null) {
      return 'Vencimento não definido';
    }
    return 'Vence em ${DateFormat('dd/MM/yyyy', 'pt_BR').format(widget.plano.dataVencimento!)}';
  }

  bool get _hasParams =>
      widget.plano.precoGraoSc60 != null ||
      widget.plano.dataVencimento != null;

  @override
  void initState() {
    super.initState();
    _grain = TextEditingController(
      text: widget.plano.precoGraoSc60?.toStringAsFixed(2) ?? '',
    );
    _grain.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _grain.dispose();
    super.dispose();
  }

  void _saveGrain() {
    widget.onPlanoChanged(
      widget.plano.copyWith(
        precoGraoSc60: double.tryParse(_grain.text.replaceAll(',', '.')),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: widget.plano.dataVencimento ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      widget.onPlanoChanged(widget.plano.copyWith(dataVencimento: date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SummaryExpandableCard(
      initiallyExpanded: !_hasParams,
      summary: SummaryDetailLine(
        primary: 'Parâmetros financeiros',
        secondary: '$_grainSummary · $_dateSummary',
      ),
      detail: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Valor do grão (R\$/sc 60 kg)'.toUpperCase(),
                  style: AppTypography.label.copyWith(
                    color: context.appTextDisabled,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 96,
                child: TextField(
                  controller: _grain,
                  textAlign: TextAlign.right,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: AppTypography.body.copyWith(
                    color: context.appTextPrimary,
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onSubmitted: (_) => _saveGrain(),
                  onTapOutside: (_) => _saveGrain(),
                ),
              ),
            ],
          ),
          Divider(color: context.appBorderSoft),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Data de vencimento'.toUpperCase(),
              style: AppTypography.label.copyWith(
                color: context.appTextDisabled,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              widget.plano.dataVencimento == null
                  ? 'Selecionar'
                  : DateFormat('dd/MM/yyyy', 'pt_BR')
                      .format(widget.plano.dataVencimento!),
              style: AppTypography.caption.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: _pickDate,
          ),
        ],
      ),
    );
  }
}

class _ConsolidationRow extends StatefulWidget {
  const _ConsolidationRow({
    required this.itemName,
    required this.quantity,
    required this.initialPrice,
    required this.total,
    required this.onPriceChanged,
  });

  final String itemName;
  final String quantity;
  final double? initialPrice;
  final double? total;
  final Future<void> Function(String produtoNome, double? preco) onPriceChanged;

  @override
  State<_ConsolidationRow> createState() => _ConsolidationRowState();
}

class _ConsolidationRowState extends State<_ConsolidationRow> {
  late final TextEditingController _price;

  @override
  void initState() {
    super.initState();
    _price = TextEditingController(
      text: widget.initialPrice?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant _ConsolidationRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPrice != widget.initialPrice) {
      final next = widget.initialPrice?.toStringAsFixed(2) ?? '';
      if (_price.text != next) _price.text = next;
    }
  }

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await widget.onPriceChanged(
      widget.itemName,
      double.tryParse(_price.text.replaceAll(',', '.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalText = widget.total == null
        ? '—'
        : NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
            .format(widget.total);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.appBorderSoft)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.itemName,
              style: AppTypography.caption.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 78,
            child: Text(
              widget.quantity,
              style: AppTypography.label.copyWith(
                color: context.appTextSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 86,
            child: TextField(
              controller: _price,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              ],
              decoration: InputDecoration(
                hintText: 'R\$ unit.',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.appBorderSoft),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
              style: AppTypography.label.copyWith(
                color: context.appTextPrimary,
              ),
              onSubmitted: (_) => _save(),
              onTapOutside: (_) => _save(),
            ),
          ),
          SizedBox(
            width: 86,
            child: Text(
              totalText,
              style: AppTypography.label.copyWith(
                fontWeight: FontWeight.w800,
                color: widget.total == null
                    ? context.appTextDisabled
                    : context.appTextPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsolidationSummary extends StatelessWidget {
  const _ConsolidationSummary({required this.plano, required this.total});

  final PlanoEntity plano;
  final double total;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final custoHa = plano.areaHaTotal > 0 ? total / plano.areaHaTotal : 0;
    final custoSc = (plano.precoGraoSc60 ?? 0) > 0
        ? custoHa / ((plano.precoGraoSc60 ?? 0) / 60)
        : null;

    return SummaryExpandableCard(
      initiallyExpanded: false,
      summary: SummaryDetailLine(
        primary: 'Total ${currency.format(total)}',
        secondary: plano.areaHaTotal > 0
            ? '${currency.format(custoHa)} / ha'
            : 'Detalhamento do investimento',
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
            value: '${currency.format(custoHa)} / ha',
          ),
          _SummaryRow(
            label: 'Custo em sacas',
            value: custoSc == null
                ? '—'
                : '${NumberFormat('#,##0.00', 'pt_BR').format(custoSc)} sc / ha',
          ),
          if (plano.dataVencimento != null)
            _SummaryRow(
              label: 'Vencimento',
              value: DateFormat('dd/MM/yyyy', 'pt_BR')
                  .format(plano.dataVencimento!),
            ),
        ],
      ),
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

class _TableHead extends StatelessWidget {
  const _TableHead(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.right,
      style: AppTypography.label.copyWith(
        color: context.appTextSecondary,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _CanvasHint extends StatelessWidget {
  const _CanvasHint({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 30),
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: context.appBorderSoft,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: PhosphorIcon(
                  PhosphorIconsRegular.plus,
                  color: context.appTextDisabled,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Adicione o primeiro estádio',
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

class _AddStageHint extends StatelessWidget {
  const _AddStageHint({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PhosphorIcon(
                  PhosphorIconsRegular.plus,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  'Adicionar estádio',
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
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
