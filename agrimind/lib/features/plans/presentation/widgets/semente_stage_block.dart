import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/theme/plan_stage_card_tokens.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/ios_swipe_delete.dart';
import '../../../clients/domain/entities/talhao_entity.dart';
import '../../domain/constants/sementes_embalagem.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/semente_talhao_entity.dart';
import '../../domain/usecases/calcular_sementes_talhao.dart';
import '../providers/expanded_panels_provider.dart';
import '../providers/sementes_plano_provider.dart';
import 'accordion_stage_card.dart';

const _uuid = Uuid();

/// Um card de sementes com várias linhas (talhão/cultivar) no mesmo estádio.
class SementeStageBlock extends ConsumerStatefulWidget {
  const SementeStageBlock({
    super.key,
    required this.planoId,
    required this.fazendaId,
    required this.estadio,
    required this.sementesEstadioIds,
    required this.onRemoveEstadio,
    required this.onUpdateEstadio,
  });

  final String planoId;
  final String fazendaId;
  final EstadioEntity estadio;

  /// Inclui estádios legados extras — todas as linhas aparecem neste card.
  final List<String> sementesEstadioIds;
  final Future<void> Function(String estadioId) onRemoveEstadio;
  final Future<void> Function(EstadioEntity estadio) onUpdateEstadio;

  @override
  ConsumerState<SementeStageBlock> createState() => _SementeStageBlockState();
}

class _SementeStageBlockState extends ConsumerState<SementeStageBlock> {
  static const _linhaExpandDuration = Duration(milliseconds: 220);

  List<TalhaoEntity> _talhoes = [];
  late final TextEditingController _tituloCard;
  String? _expandedLinhaId;
  bool _linhaExpansionBootstrapped = false;

  String _tituloExibicao(EstadioEntity estadio) {
    final label = estadio.label.trim();
    return label.isEmpty ? 'Sementes' : label;
  }

  @override
  void initState() {
    super.initState();
    _tituloCard = TextEditingController(text: _tituloExibicao(widget.estadio));
    _loadTalhoes();
  }

  @override
  void didUpdateWidget(covariant SementeStageBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.estadio.label != widget.estadio.label &&
        _tituloCard.text.trim() != widget.estadio.label.trim()) {
      _tituloCard.text = _tituloExibicao(widget.estadio);
    }
  }

  @override
  void dispose() {
    _tituloCard.dispose();
    super.dispose();
  }

  Future<void> _loadTalhoes() async {
    final talhoes =
        await ref.read(clientsRepoProvider).getTalhoes(widget.fazendaId);
    if (!mounted) return;
    setState(() => _talhoes = talhoes);
  }

  void _unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _toggleExpanded() {
    _unfocusKeyboard();
    ref.togglePanel(widget.estadio.id);
  }

  List<SementeTalhaoEntity> _linhasDoCard(List<SementeTalhaoEntity> all) {
    final ids = widget.sementesEstadioIds.toSet();
    return all.where((s) => ids.contains(s.estadioId)).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Set<String> _talhoesReservados(
    List<SementeTalhaoEntity> linhas, {
    String? excetoSementeId,
  }) {
    return {
      for (final s in linhas)
        if (s.id != excetoSementeId && s.talhaoId != null) s.talhaoId!,
    };
  }

  TalhaoEntity? _talhaoById(String? id) {
    if (id == null) return null;
    for (final t in _talhoes) {
      if (t.id == id) return t;
    }
    return null;
  }

  static final _popFormatter = NumberFormat('#,##0', 'pt_BR');

  /// Cultivar + talhão mínimos para colapsar sozinha.
  bool _linhaProntaParaColapsar(SementeTalhaoEntity s) {
    return s.cultivar.trim().isNotEmpty && s.talhaoId != null;
  }

  String _resumoLinhaTexto(SementeTalhaoEntity s) {
    final cultivar = s.cultivar.trim().isEmpty ? '—' : s.cultivar.trim();
    final talhao = _talhaoById(s.talhaoId)?.nome ?? '—';
    final pop = s.populacaoSementesPorHa > 0
        ? '${_popFormatter.format(s.populacaoSementesPorHa)} sem/ha'
        : '— sem/ha';

    var embalagens = '— embalagens';
    final talhaoEnt = _talhaoById(s.talhaoId);
    if (talhaoEnt != null &&
        s.populacaoSementesPorHa > 0 &&
        s.sementesPorEmbalagem > 0) {
      final calc = calcularSementesTalhao(
        populacaoSementesPorHa: s.populacaoSementesPorHa,
        sementesPorEmbalagem: s.sementesPorEmbalagem,
        areaTalhaoHa: talhaoEnt.areaHa,
        espacamentoPlantioCm: s.espacamentoPlantioCm,
      );
      embalagens =
          '${calc.embalagensNecessarias} ${calc.embalagensNecessarias == 1 ? 'embalagem' : 'embalagens'}';
    }

    return '$cultivar · $talhao · $pop · $embalagens';
  }

  Widget _resumoLinhaWidget(SementeTalhaoEntity s) {
    return Text(
      _resumoLinhaTexto(s),
      style: AppTypography.caption.copyWith(
        color: context.appTextSecondary,
        height: 1.35,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  void _bootstrapLinhaExpansion(List<SementeTalhaoEntity> linhas) {
    if (_linhaExpansionBootstrapped) return;
    _linhaExpansionBootstrapped = true;
    final incompleta =
        linhas.where((l) => !_linhaProntaParaColapsar(l)).firstOrNull;
    _expandedLinhaId = incompleta?.id;
  }

  void _toggleLinha(
    List<SementeTalhaoEntity> linhas,
    String linhaId, {
    required bool expanded,
  }) {
    _unfocusKeyboard();
    final incompleta =
        linhas.where((l) => !_linhaProntaParaColapsar(l)).firstOrNull;
    if (incompleta != null && incompleta.id != linhaId) {
      setState(() => _expandedLinhaId = incompleta.id);
      return;
    }
    setState(() {
      _expandedLinhaId = expanded ? null : linhaId;
    });
  }

  void _ensureIncompleteLinhaExpanded(List<SementeTalhaoEntity> linhas) {
    final incompleta =
        linhas.where((l) => !_linhaProntaParaColapsar(l)).firstOrNull;
    if (incompleta == null || _expandedLinhaId == incompleta.id) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _expandedLinhaId = incompleta.id);
    });
  }

  Widget _headerSubtitleWidget(List<SementeTalhaoEntity> linhas) {
    if (linhas.isEmpty) {
      return Text(
        'Toque para preencher cultivar e talhão',
        style: AppTypography.caption.copyWith(
          color: context.appTextSecondary,
          height: 1.35,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < linhas.length; i++) ...[
          if (i > 0) const SizedBox(height: 2),
          _resumoLinhaWidget(linhas[i]),
        ],
      ],
    );
  }

  Future<void> _saveTituloCard() async {
    final text = _tituloCard.text.trim();
    final normalized = text.isEmpty ? 'Sementes' : text;
    if (normalized == widget.estadio.label.trim()) return;
    await widget.onUpdateEstadio(
      widget.estadio.copyWith(label: normalized),
    );
    if (mounted) setState(() {});
  }

  Future<void> _addLinha() async {
    _unfocusKeyboard();
    final now = DateTime.now();
    final novaId = _uuid.v4();
    await ref.read(plansRepoProvider).createSementeTalhao(
          SementeTalhaoEntity(
            id: novaId,
            planoId: widget.planoId,
            estadioId: widget.estadio.id,
            cultivar: '',
            populacaoSementesPorHa: 0,
            sementesPorEmbalagem: SementesEmbalagem.valores.last,
            espacamentoPlantioCm: 0,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await ref
        .read(sementesPlanoNotifierProvider(widget.planoId).notifier)
        .refresh();
    if (!mounted) return;
    ref.expandPanel(widget.estadio.id);
    setState(() => _expandedLinhaId = novaId);
  }

  Future<void> _onLinhaSaved(SementeTalhaoEntity updated) async {
    await ref
        .read(sementesPlanoNotifierProvider(widget.planoId).notifier)
        .refresh();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _removeCard() async {
    _unfocusKeyboard();
    ref.collapsePanel(widget.estadio.id);
    for (final estadioId in widget.sementesEstadioIds) {
      await widget.onRemoveEstadio(estadioId);
    }
    await ref
        .read(sementesPlanoNotifierProvider(widget.planoId).notifier)
        .refresh();
  }

  Widget _expandedContent(
    List<SementeTalhaoEntity> linhas,
    Set<String> reservados,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _tituloCard,
            style: AppTypography.label.copyWith(
              color: context.appTextSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
            decoration: const InputDecoration(
              labelText: 'Nome do card',
              border: InputBorder.none,
              isDense: true,
            ),
            onSubmitted: (_) => _saveTituloCard(),
            onTapOutside: (_) => _saveTituloCard(),
          ),
          const SizedBox(height: 8),
          if (linhas.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: PlanStageCardTokens.card(context),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: PlanStageCardTokens.border(context)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var i = 0; i < linhas.length; i++) ...[
                    _SementeLinhaAccordion(
                      key: ValueKey(linhas[i].id),
                      resumo: _resumoLinhaTexto(linhas[i]),
                      prontaParaColapsar: _linhaProntaParaColapsar(linhas[i]),
                      isExpanded: _expandedLinhaId == linhas[i].id,
                      onToggle: () => _toggleLinha(
                        linhas,
                        linhas[i].id,
                        expanded: _expandedLinhaId == linhas[i].id,
                      ),
                      child: _SementeLineEditor(
                        semente: linhas[i],
                        talhoes: _talhoes,
                        talhoesReservados: _talhoesReservados(
                          linhas,
                          excetoSementeId: linhas[i].id,
                        ),
                        canRemove: linhas.length > 1,
                        onDelete: () => _deleteLinha(linhas[i].id),
                        onSaved: _onLinhaSaved,
                      ),
                    ),
                    if (i < linhas.length - 1)
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: PlanStageCardTokens.separator(context),
                      ),
                  ],
                ],
              ),
            ),
          if (linhas.isEmpty)
            Text(
              'Nenhuma linha — adicione abaixo.',
              style: AppTypography.caption.copyWith(
                color: context.appTextDisabled,
              ),
            ),
          if (linhas.isNotEmpty)
            Divider(
              height: 12,
              color: context.appBorderSoft,
            ),
          GestureDetector(
            onTap: _addLinha,
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
                    'Adicionar outra semente',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (reservados.length >= _talhoes.length && _talhoes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Todos os talhões já possuem semente neste card.',
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _deleteLinha(String sementeId) async {
    await ref.read(plansRepoProvider).deleteSementeTalhao(sementeId);
    await ref
        .read(sementesPlanoNotifierProvider(widget.planoId).notifier)
        .refresh();
    if (!mounted) return;
    setState(() {
      if (_expandedLinhaId == sementeId) {
        _expandedLinhaId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sementesAsync =
        ref.watch(sementesPlanoNotifierProvider(widget.planoId));
    final linhas = sementesAsync.maybeWhen(
      data: _linhasDoCard,
      orElse: () => <SementeTalhaoEntity>[],
    );
    if (sementesAsync.hasValue) {
      _bootstrapLinhaExpansion(linhas);
      _ensureIncompleteLinhaExpanded(linhas);
    }
    final expanded = ref.isPanelExpanded(widget.estadio.id);
    final reservados = _talhoesReservados(linhas);
    final tituloHeader = _tituloExibicao(widget.estadio);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: IosSwipeDelete(
        dismissKey: ValueKey('swipe-semente-${widget.estadio.id}'),
        itemName: tituloHeader,
        onDelete: () => _removeCard(),
        child: AccordionStageCard(
          stageCode: 'SEM',
          stageName: tituloHeader,
          subtitleWidget: expanded ? null : _headerSubtitleWidget(linhas),
          isExpanded: expanded,
          onToggle: _toggleExpanded,
          child: _expandedContent(linhas, reservados),
        ),
      ),
    );
  }
}

class _SementeLinhaAccordion extends StatelessWidget {
  const _SementeLinhaAccordion({
    super.key,
    required this.resumo,
    required this.prontaParaColapsar,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  final String resumo;
  final bool prontaParaColapsar;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bodyExpanded = isExpanded;
    final showHeader = prontaParaColapsar || !bodyExpanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showHeader)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onToggle,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        prontaParaColapsar
                            ? resumo
                            : 'Nova linha — preencha cultivar e talhão',
                        style: AppTypography.body.copyWith(
                          fontSize: 14,
                          color: context.appTextPrimary,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (prontaParaColapsar)
                      AnimatedRotation(
                        turns: bodyExpanded ? 0.5 : 0,
                        duration:
                            _SementeStageBlockState._linhaExpandDuration,
                        curve: Curves.easeInOut,
                        child: PhosphorIcon(
                          PhosphorIconsRegular.caretDown,
                          size: 18,
                          color: context.appTextSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        AnimatedSize(
          duration: _SementeStageBlockState._linhaExpandDuration,
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: bodyExpanded
              ? Padding(
                  padding: EdgeInsets.fromLTRB(
                    12,
                    prontaParaColapsar ? 0 : 12,
                    12,
                    12,
                  ),
                  child: child,
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

class _SementeLineEditor extends ConsumerStatefulWidget {
  const _SementeLineEditor({
    required this.semente,
    required this.talhoes,
    required this.talhoesReservados,
    required this.canRemove,
    required this.onDelete,
    required this.onSaved,
  });

  final SementeTalhaoEntity semente;
  final List<TalhaoEntity> talhoes;
  final Set<String> talhoesReservados;
  final bool canRemove;
  final VoidCallback onDelete;
  final Future<void> Function(SementeTalhaoEntity updated) onSaved;

  @override
  ConsumerState<_SementeLineEditor> createState() =>
      _SementeLineEditorState();
}

class _SementeLineEditorState extends ConsumerState<_SementeLineEditor> {
  Timer? _debounce;

  late final TextEditingController _cultivar;
  late final TextEditingController _populacao;
  late final TextEditingController _espacamento;
  late int _embalagem;
  TalhaoEntity? _talhao;

  @override
  void initState() {
    super.initState();
    _cultivar = TextEditingController(text: widget.semente.cultivar);
    _populacao = TextEditingController();
    _espacamento = TextEditingController();
    _embalagem = widget.semente.sementesPorEmbalagem;
    _syncFromEntity(widget.semente);
    for (final c in [_cultivar, _populacao, _espacamento]) {
      c.addListener(_scheduleSave);
    }
  }

  @override
  void didUpdateWidget(covariant _SementeLineEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.semente.updatedAt != widget.semente.updatedAt) {
      _syncFromEntity(widget.semente);
    }
  }

  void _syncFromEntity(SementeTalhaoEntity s) {
    if (_cultivar.text != s.cultivar) _cultivar.text = s.cultivar;
    final popText = s.populacaoSementesPorHa > 0
        ? s.populacaoSementesPorHa.toStringAsFixed(0)
        : '';
    if (_populacao.text != popText) _populacao.text = popText;
    final espText = s.espacamentoPlantioCm > 0
        ? s.espacamentoPlantioCm.toStringAsFixed(0)
        : '';
    if (_espacamento.text != espText) _espacamento.text = espText;
    _embalagem = s.sementesPorEmbalagem;
    TalhaoEntity? found;
    for (final t in widget.talhoes) {
      if (t.id == s.talhaoId) {
        found = t;
        break;
      }
    }
    _talhao = found;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _cultivar.dispose();
    _populacao.dispose();
    _espacamento.dispose();
    super.dispose();
  }

  void _scheduleSave() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), _persist);
    setState(() {});
  }

  SementesTalhaoCalculo? get _calculo {
    final area = _talhao?.areaHa;
    if (area == null) return null;
    final pop = double.tryParse(_populacao.text.replaceAll(',', '.'));
    if (pop == null || pop <= 0 || _embalagem <= 0) return null;
    final esp = double.tryParse(_espacamento.text.replaceAll(',', '.'));
    return calcularSementesTalhao(
      populacaoSementesPorHa: pop,
      sementesPorEmbalagem: _embalagem,
      areaTalhaoHa: area,
      espacamentoPlantioCm: esp ?? 0,
    );
  }

  Future<void> _persist() async {
    final cultivar = _cultivar.text.trim();
    final pop = double.tryParse(_populacao.text.replaceAll(',', '.'));
    final esp = double.tryParse(_espacamento.text.replaceAll(',', '.'));
    final updated = widget.semente.copyWith(
      cultivar: cultivar,
      talhaoId: _talhao?.id,
      populacaoSementesPorHa: pop ?? 0,
      sementesPorEmbalagem: _embalagem,
      espacamentoPlantioCm: esp ?? 0,
      updatedAt: DateTime.now(),
    );
    await ref.read(plansRepoProvider).updateSementeTalhao(updated);
    await widget.onSaved(updated);
  }

  Future<void> _pickTalhao() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final disponiveis = widget.talhoes.where((t) {
      if (_talhao?.id == t.id) return true;
      return !widget.talhoesReservados.contains(t.id);
    }).toList();

    if (disponiveis.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não há talhões disponíveis. Os demais já têm semente neste card.',
          ),
        ),
      );
      return;
    }

    final selected = await showCupertinoModalPopup<TalhaoEntity>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text('Selecionar talhão'),
        actions: disponiveis
            .map(
              (t) => CupertinoActionSheetAction(
                onPressed: () => Navigator.of(ctx).pop(t),
                child: Text('${t.nome} — ${t.areaHa.toStringAsFixed(1)} ha'),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Cancelar'),
        ),
      ),
    );
    if (selected == null) return;
    setState(() => _talhao = selected);
    _scheduleSave();
  }

  @override
  Widget build(BuildContext context) {
    final calc = _calculo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.canRemove)
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: widget.onDelete,
              child: Text(
                'Remover linha',
                style: AppTypography.caption.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        _field('Cultivar', _cultivar, textInputAction: TextInputAction.next),
        const SizedBox(height: 8),
        _talhaoSelector(),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _field(
                'População (sem/ha)',
                _populacao,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _field(
                'Espaç. (cm)',
                _espacamento,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          initialValue: _embalagem,
          isDense: true,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Embalagem',
            isDense: true,
            filled: true,
            fillColor: context.appBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.appBorderSoft),
            ),
          ),
          items: SementesEmbalagem.valores
              .map(
                (v) => DropdownMenuItem(
                  value: v,
                  child: Text(SementesEmbalagem.label(v)),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            setState(() => _embalagem = v);
            _scheduleSave();
          },
        ),
        const SizedBox(height: 8),
        _resultBlock(calc),
      ],
    );
  }

  Widget _talhaoSelector() {
    final t = _talhao;
    return GestureDetector(
      onTap: _pickTalhao,
      behavior: HitTestBehavior.opaque,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Talhão',
          isDense: true,
          filled: true,
          fillColor: context.appBackground,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: context.appTextSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: context.appBorderSoft),
          ),
        ),
        child: Text(
          t == null
              ? 'Selecionar talhão'
              : '${t.nome} · ${t.areaHa.toStringAsFixed(1)} ha',
          style: AppTypography.body.copyWith(
            color: t == null ? AppColors.primary : context.appTextPrimary,
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    TextInputAction textInputAction = TextInputAction.done,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: AppTypography.body.copyWith(color: context.appTextPrimary),
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        filled: true,
        fillColor: context.appBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.appBorderSoft),
        ),
      ),
      onSubmitted: (_) {
        _persist();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  Widget _resultBlock(SementesTalhaoCalculo? calc) {
    if (calc == null) {
      return Text(
        'Informe talhão e população para ver as embalagens.',
        style: AppTypography.caption.copyWith(color: context.appTextDisabled),
      );
    }
    final n = calc.embalagensNecessarias;
    final porMetro = calc.sementesPorMetroLinear;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: context.appBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '$n ${n == 1 ? 'embalagem' : 'embalagens'}',
            style: AppTypography.body.copyWith(
              color: context.appTextPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          if (porMetro != null)
            Text(
              '${porMetro.toStringAsFixed(2)} sem/m',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
