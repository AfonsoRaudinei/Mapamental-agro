import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../consolidation/presentation/providers/consolidacao_provider.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../providers/plano_detail_provider.dart';
import '../providers/plans_list_provider.dart';
import '../providers/produto_aplicacao_provider.dart';
import '../widgets/consolidation_view.dart';
import '../widgets/plan_canvas_widgets.dart';
import '../widgets/produto_panel.dart';
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
    final selected = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Novo Estádio'),
        message: const Text(
          'Escolha um estádio fenológico ou crie uma aplicação operacional.',
        ),
        actions: [
          ...available.map(
            (codigo) => CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(codigo),
              child: Text(AppConstants.estadioLabels[codigo] ?? codigo),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () =>
                Navigator.of(context).pop(PlanCanvasWidgets.operacionalCodigo),
            child: Text(
              AppConstants.estadioLabels[PlanCanvasWidgets.operacionalCodigo] ??
                  PlanCanvasWidgets.operacionalCodigo,
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ),
    );
    if (selected == null) return;

    if (selected == PlanCanvasWidgets.operacionalCodigo) {
      await _addOperacional();
      return;
    }

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

  Future<void> _addOperacional() async {
    final operationalCount = _plano.estadios
        .where((item) => item.codigo == PlanCanvasWidgets.operacionalCodigo)
        .length;
    await ref.read(plansRepoProvider).addEstadio(
          widget.planoId,
          EstadioEntity(
            id: _uuid.v4(),
            planoId: widget.planoId,
            codigo: PlanCanvasWidgets.operacionalCodigo,
            label: AppConstants
                    .estadioLabels[PlanCanvasWidgets.operacionalCodigo] ??
                PlanCanvasWidgets.operacionalCodigo,
            ordem: operationalCount,
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

  Future<String> _copyImageToAppDir(String sourcePath, String prefix) async {
    final dir = await getApplicationDocumentsDirectory();
    final ext = sourcePath.split('.').last;
    final target = File(
        '${dir.path}/${prefix}_${DateTime.now().millisecondsSinceEpoch}.$ext');
    return (await File(sourcePath).copy(target.path)).path;
  }

  Future<void> _chooseExport() async {
    final choice = await showCupertinoModalPopup<String>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text('Exportar plano'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(ctx).pop('html'),
            child: const Text('Mapa HTML'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(ctx).pop('excel'),
            child: const Text('Planilha Excel'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Cancelar'),
        ),
      ),
    );
    if (!mounted || choice == null) return;
    if (choice == 'html') {
      await _shareExport(
        ref.read(exportHtmlProvider(widget.planoId).future),
        subject: 'Mapa Fenológico - ${_plano.nome}',
        errorLabel: 'HTML',
      );
    } else if (choice == 'excel') {
      await _shareExport(
        ref.read(exportExcelProvider(widget.planoId).future),
        subject: 'Planilha - ${_plano.nome}',
        errorLabel: 'Excel',
      );
    }
  }

  Future<void> _shareExport(
    Future<File> fileFuture, {
    required String subject,
    required String errorLabel,
  }) async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final file = await fileFuture;
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: subject,
        ),
      );
    } catch (error) {
      _showSnack('Erro ao exportar $errorLabel: $error');
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
            PlanCanvasTopBar(
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
              onExportTap: _chooseExport,
            ),
            Expanded(
              child: _showConsolidation
                  ? ConsolidationView(
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
                  : PlanningView(
                      plano: _plano,
                      produtor: _displayProdutor,
                      fazenda: _displayFazenda,
                      onPlanoChanged: _updatePlano,
                      onAddEstadio: _addEstadio,
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
