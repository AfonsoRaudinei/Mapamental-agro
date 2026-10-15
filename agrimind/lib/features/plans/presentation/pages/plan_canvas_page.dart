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
import '../../../../core/theme/plan_stage_card_tokens.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../consolidation/presentation/providers/consolidacao_provider.dart';
import '../../domain/constants/sementes_embalagem.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/estadio_tipo.dart';
import '../../domain/entities/semente_talhao_entity.dart';
import '../providers/sementes_plano_provider.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../providers/plano_detail_provider.dart';
import '../providers/plans_list_provider.dart';
import '../providers/produto_aplicacao_provider.dart';
import '../widgets/consolidation_view.dart';
import '../widgets/plan_canvas_widgets.dart';
import '../models/escopo_selecionado.dart';
import '../providers/alocacao_provider.dart';
import '../providers/expanded_panels_provider.dart';
import '../widgets/area_selector_widget.dart';
import '../../domain/entities/tipo_escopo_alocacao.dart';
import '../widgets/produto_panel.dart';
import '../../domain/talhao_safra/estadio_cronograma_metadata.dart';
import '../../domain/talhao_safra/roteiro_plano_template.dart';
import '../../domain/talhao_safra/tipo_operacional.dart';
import '../../domain/usecases/sincronizar_subcards_fungicida_estadio_usecase.dart';

class PlanCanvasPage extends ConsumerWidget {
  const PlanCanvasPage({
    super.key,
    required this.planoId,
    this.canvasFiltroTalhaoId,
  });

  final String planoId;

  /// Recorte do canvas: só instâncias deste talhão (query `talhaoId`).
  final String? canvasFiltroTalhaoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planoAsync = ref.watch(planoDetailProvider(planoId));
    return planoAsync.when(
      data: (plano) => _CanvasView(
        planoId: planoId,
        plano: plano,
        canvasFiltroTalhaoId: canvasFiltroTalhaoId,
      ),
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
  const _CanvasView({
    required this.planoId,
    required this.plano,
    this.canvasFiltroTalhaoId,
  });

  final String planoId;
  final PlanoEntity plano;
  final String? canvasFiltroTalhaoId;

  @override
  ConsumerState<_CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends ConsumerState<_CanvasView> {
  final _uuid = const Uuid();
  final _picker = ImagePicker();
  bool _showConsolidation = false;
  bool _exporting = false;
  bool _fungicidaMigracaoFeita = false;
  Map<String, String> _talhaoNomes = {};

  PlanoEntity get _plano => widget.plano;

  @override
  void initState() {
    super.initState();
    _carregarNomesTalhoes();
    if (widget.canvasFiltroTalhaoId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _migrarFungicidaLegadoNoCanvas();
      });
    }
  }

  Future<void> _migrarFungicidaLegadoNoCanvas() async {
    if (_fungicidaMigracaoFeita || _plano.estadios.isEmpty) return;
    _fungicidaMigracaoFeita = true;
    await _syncFungicidaSubcards(_plano.estadios.first);
  }

  Future<void> _carregarNomesTalhoes() async {
    final nomes = await _mapaNomesTalhoes();
    if (!mounted) return;
    setState(() => _talhaoNomes = nomes);
  }

  Future<Map<String, String>> _mapaNomesTalhoes() async {
    final opts = await _talhoesDaFazenda();
    return {for (final t in opts) t.id: t.nome};
  }

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
    const operacionalKey = 'operacional';
    const sementesKey = 'sementes';

    final used = _plano.estadios
        .where((item) => item.isFenologico)
        .map((item) => item.codigo)
        .toSet();
    final available = AppConstants.estadiosCodigos
        .where((codigo) => !used.contains(codigo))
        .toList();

    final selected = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Novo estádio'),
        message: const Text('Escolha um estádio fenológico.'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(operacionalKey),
            child: const Text('Operacional'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(sementesKey),
            child: const Text('Sementes'),
          ),
          ...available.map(
            (codigo) => CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(codigo),
              child: Text(AppConstants.estadioLabels[codigo] ?? codigo),
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

    if (selected == operacionalKey) {
      await _addOperacional();
      return;
    }
    if (selected == sementesKey) {
      await _addSementes();
      return;
    }

    if (available.isEmpty) {
      _showSnack('Todos os estádios fenológicos já foram adicionados.');
      return;
    }

    await ref.read(plansRepoProvider).addEstadio(
          widget.planoId,
          EstadioEntity(
            id: _uuid.v4(),
            planoId: widget.planoId,
            codigo: selected,
            tipo: EstadioTipo.fenologico,
            label: 'Selecione o tipo de aplicação',
            tipoOperacional: TipoOperacional.indefinido,
            ordem: AppConstants.estadiosCodigos.indexOf(selected),
            createdAt: DateTime.now(),
          ),
        );
    _invalidatePlan();
  }

  Future<void> _addOperacional() async {
    final operationalCount =
        _plano.estadios.where((item) => item.isOperacional).length;
    final estadioId = _uuid.v4();
    final novo = EstadioEntity(
      id: estadioId,
      planoId: widget.planoId,
      codigo: PlanCanvasWidgets.operacionalCodigo,
      tipo: EstadioTipo.operacional,
      label: 'Selecione o tipo de operação',
      ordem: operationalCount,
      tipoOperacional: TipoOperacional.indefinido,
      observacao: kObservacaoRoteiroTemplate,
      createdAt: DateTime.now(),
    );
    await ref.read(plansRepoProvider).addEstadio(widget.planoId, novo);
    ref.expandPanel(estadioId);
    _invalidatePlan();
  }

  Future<void> _syncFungicidaSubcards(EstadioEntity _) async {
    await SincronizarSubcardsFungicidaEstadioUseCase(
      ref.read(plansRepoProvider),
    ).call(planoId: widget.planoId);
    _invalidatePlan();
  }

  int _nextEstadioOrdem() {
    if (_plano.estadios.isEmpty) return 0;
    var max = _plano.estadios.first.ordem;
    for (final e in _plano.estadios) {
      if (e.ordem > max) max = e.ordem;
    }
    return max + 1;
  }

  Future<void> _addSementes() async {
    if (_plano.fazendaId == null) {
      _showSnack(
        'Vincule uma fazenda na identificação do plano para adicionar sementes.',
      );
      return;
    }

    final existentes = _plano.estadios.where((e) => e.isSementes).toList()
      ..sort((a, b) => a.ordem.compareTo(b.ordem));

    if (existentes.isNotEmpty) {
      await _addSementeLinha(existentes.first.id);
      ref.expandPanel(existentes.first.id);
      _invalidatePlan();
      return;
    }

    final estadioId = _uuid.v4();
    final now = DateTime.now();
    await ref.read(plansRepoProvider).addSementeEstadio(
          planoId: widget.planoId,
          estadio: EstadioEntity(
            id: estadioId,
            planoId: widget.planoId,
            codigo: PlanCanvasWidgets.sementesCodigo,
            tipo: EstadioTipo.sementes,
            label: 'Sementes',
            ordem: _nextEstadioOrdem(),
            createdAt: now,
          ),
          semente: SementeTalhaoEntity(
            id: _uuid.v4(),
            planoId: widget.planoId,
            estadioId: estadioId,
            cultivar: '',
            populacaoSementesPorHa: 0,
            sementesPorEmbalagem: SementesEmbalagem.valores.last,
            espacamentoPlantioCm: 0,
            createdAt: now,
            updatedAt: now,
          ),
        );
    ref.invalidate(sementesPlanoNotifierProvider(widget.planoId));
    ref.expandPanel(estadioId);
    _invalidatePlan();
  }

  Future<void> _addSementeLinha(String estadioId) async {
    final now = DateTime.now();
    await ref.read(plansRepoProvider).createSementeTalhao(
          SementeTalhaoEntity(
            id: _uuid.v4(),
            planoId: widget.planoId,
            estadioId: estadioId,
            cultivar: '',
            populacaoSementesPorHa: 0,
            sementesPorEmbalagem: SementesEmbalagem.valores.last,
            espacamentoPlantioCm: 0,
            createdAt: now,
            updatedAt: now,
          ),
        );
    ref.invalidate(sementesPlanoNotifierProvider(widget.planoId));
  }

  Future<void> _updateEstadio(EstadioEntity estadio) async {
    final anterior = _plano.estadios
        .where((e) => e.id == estadio.id)
        .firstOrNull;
    var salvar = estadio;
    if (anterior != null &&
        anterior.dataAplicacao != estadio.dataAplicacao &&
        estadio.dataAplicacao != null) {
      salvar = marcarDataEditadaManualmente(
        estadio,
        estadio.dataAplicacao!,
      );
    }
    await ref.read(plansRepoProvider).updateEstadio(salvar);
    _invalidatePlan(estadioId: estadio.id);
  }

  Future<void> _removeEstadio(String estadioId) async {
    await ref.read(plansRepoProvider).removeEstadio(estadioId);
    ref.invalidate(sementesPlanoNotifierProvider(widget.planoId));
    _invalidatePlan(estadioId: estadioId);
  }

  Future<void> _addProduto(
    EstadioEntity estadio, {
    required String nome,
    required double dose,
    required String unidade,
    required double areaHa,
    String produtoCategoria = 'Geral',
    double? totalOverride,
    String? overrideMotivo,
    String? observacao,
    EscopoSelecionado? escopo,
  }) async {
    final produto = ProdutoAplicacaoEntity(
      id: _uuid.v4(),
      estadioId: estadio.id,
      produtoNome: nome,
      produtoCategoria: produtoCategoria,
      dose: dose,
      doseUnidade: unidade,
      areaHa: areaHa,
      totalOverride: totalOverride,
      overrideMotivo: overrideMotivo,
      observacao: observacao,
      ordem: estadio.produtos.length,
      createdAt: DateTime.now(),
    );
    await ref.read(plansRepoProvider).addProduto(estadio.id, produto);
    await _aplicarRateioSePossivel(produto, escopo);
    _invalidatePlan(estadioId: estadio.id);
  }

  Future<List<TalhaoOption>> _talhoesDaFazenda() async {
    final fazendaId = _plano.fazendaId;
    if (fazendaId == null) return const [];
    final talhoes = await ref.read(clientsRepoProvider).getTalhoes(fazendaId);
    return talhoes
        .map(
          (t) => TalhaoOption(id: t.id, nome: t.nome, areaHa: t.areaHa),
        )
        .toList();
  }

  Future<void> _aplicarRateioSePossivel(
    ProdutoAplicacaoEntity produto,
    EscopoSelecionado? escopo,
  ) async {
    if (escopo == null || _plano.fazendaId == null) return;

    final talhoes =
        await ref.read(clientsRepoProvider).getTalhoes(_plano.fazendaId!);
    if (talhoes.isEmpty) return;

    final rateioUseCase = ref.read(ratearProdutoPorTalhaoUseCaseProvider);
    final validacao = rateioUseCase.validarArea(
      tipo: escopo.tipo,
      fazendaAreaTotalHa: _plano.areaHaTotal,
      talhoesDaFazenda: talhoes,
      talhoesIdsEscopo: escopo.talhoesIds,
    );

    if (validacao.temAreaNaoCoberta) {
      final ha = validacao.areaNaoCobertaHa.toStringAsFixed(2);
      if (!mounted) return;
      final ok = await showCupertinoDialog<bool>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Área não coberta'),
          content: Text(
            'Área não coberta: $ha ha. Confirmar rateio com a quantidade '
            'informada?',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }

    final escopoId = _uuid.v4();
    final gerado = rateioUseCase.call(
      escopoId: escopoId,
      produtoAplicacaoId: produto.id,
      quantidadeTotal: produto.totalFinal,
      tipo: escopo.tipo,
      talhoesIdsEscopo: escopo.talhoesIds,
      talhoesDaFazenda: talhoes,
      fazendaAreaTotalHa: _plano.areaHaTotal,
    );

    if (gerado.lancamentos.isEmpty) return;

    await ref.read(alocacaoRepoProvider).salvarRateio(
          escopo: gerado.escopo,
          lancamentos: gerado.lancamentos,
        );
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

  Future<void> _openProdutoPanel(
    EstadioEntity estadio, {
    ProdutoAplicacaoEntity? produto,
    String? nomeSugerido,
    String? categoriaSugerida,
  }) async {
    final talhoes = await _talhoesDaFazenda();
    if (!mounted) return;

    EscopoSelecionado? escopoFromDados(Map<String, dynamic> dados) {
      if (_plano.fazendaId == null) return null;
      if (dados['areaPersonalizada'] == true) return null;
      final raw = dados['talhoesExcluidos'];
      final excluidos = raw is List
          ? raw.map((e) => e.toString()).toList()
          : const <String>[];
      if (excluidos.isEmpty) {
        return const EscopoSelecionado(
          tipo: TipoEscopoAlocacao.fazendaInteira,
        );
      }
      final incluidos = talhoes
          .where((t) => !excluidos.contains(t.id))
          .map((t) => t.id)
          .toList();
      if (incluidos.isEmpty) return null;
      return EscopoSelecionado(
        tipo: TipoEscopoAlocacao.talhoesSelecionados,
        talhoesIds: incluidos,
      );
    }

    await ProdutoPanel.show(
      context: context,
      estadioId: estadio.id,
      areaHaFazenda: _plano.areaHaTotal,
      fazendaNome: _displayFazenda,
      talhoes: talhoes,
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
          final escopo = escopoFromDados(dados);
          await _addProduto(
            estadio,
            nome: dados['produtoNome'] as String,
            dose: (dados['dose'] as num).toDouble(),
            unidade: dados['doseUnidade'] as String,
            areaHa: (dados['areaHa'] as num).toDouble(),
            produtoCategoria: dados['produtoCategoria'] as String,
            totalOverride: dados['totalOverride'] as double?,
            overrideMotivo: dados['overrideMotivo'] as String?,
            observacao: dados['observacao'] as String?,
            escopo: escopo,
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
      backgroundColor: PlanStageCardTokens.canvas(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            PlanCanvasTopBar(
              showConsolidation: _showConsolidation,
              exporting: _exporting,
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
                      filtroTalhaoId: widget.canvasFiltroTalhaoId,
                      talhaoNomes: _talhaoNomes,
                      filtroTalhaoBannerLabel: widget.canvasFiltroTalhaoId != null
                          ? (_talhaoNomes[widget.canvasFiltroTalhaoId!] ??
                              'Talhão')
                          : null,
                      onPlanoChanged: _updatePlano,
                      onAddEstadio: _addEstadio,
                      onAddSemente: _addSementes,
                      onAddProduto: (estadio) => _openProdutoPanel(estadio),
                      onAddProdutoFromReferencia: _addProdutoFromReferencia,
                      onDeleteProduto: _deleteProduto,
                      onEditProduto: (estadio, produto) =>
                          _openProdutoPanel(estadio, produto: produto),
                      onPickStageImage: _pickStageImage,
                      onUpdateEstadio: _updateEstadio,
                      onRemoveEstadio: _removeEstadio,
                      onSyncFungicidaSubcards: _syncFungicidaSubcards,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
