import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/accordion_section.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../plans/domain/usecases/resolver_plano_ativo_fazenda_usecase.dart';
import '../../../plans/domain/usecases/instanciar_roteiro_talhao_usecase.dart';
import '../../../plans/domain/usecases/sincronizar_cronograma_soja_plano_usecase.dart';
import '../../../plans/domain/usecases/sincronizar_talhao_safra_plano_usecase.dart';
import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../../../../core/agronomy/linha_tempo_soja_validacao.dart';
import '../../domain/cronograma_soja/calcular_cronograma_soja.dart'
    show calcularCronogramaSoja, parametrosFromCronograma, resumoCronogramaSoja;
import '../widgets/confirmar_aplicacao_sheet.dart';
import '../widgets/cronograma_modo_avulso_banner.dart';
import '../widgets/cronograma_soja_tabela.dart';
import '../widgets/cronograma_soja_talhao_focus_view.dart';
import '../widgets/cultivar_talhao_selector.dart';
import '../widgets/talhao_multi_selector.dart';
import '../widgets/talhao_timeline_stepper.dart';
import '../../domain/cronograma_soja/aplicar_dae_catalogo_cronograma.dart';
import '../../domain/cronograma_soja/cronograma_regulagem_grupo.dart';
import '../../domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../../catalog/domain/dae_maturacao_cultivar.dart';
import '../../../catalog/domain/entities/produto_catalogo_entity.dart';
import '../../domain/entities/talhao_entity.dart';
import '../../domain/talhao_etapas/etapa_talhao.dart';
import '../providers/clients_provider.dart';
import '../providers/etapas_do_talhao_provider.dart';
import '../../../plans/domain/entities/semente_talhao_entity.dart';
import '../../../plans/domain/usecases/resolver_cultivar_talhao_plano_usecase.dart';

const _uuid = Uuid();

/// Cronograma agrícola — **somente módulo Clientes** (`farmCronogramaSojaPath`).
/// Com plano ativo: regulagem em grupos (accordion); plantio na ficha do talhão.
/// Sem plano: modo avulso (calculadora — ver [CronogramaModoAvulsoBanner]).
class CronogramaSojaPage extends ConsumerStatefulWidget {
  const CronogramaSojaPage({
    super.key,
    required this.clienteId,
    required this.farmId,
    this.talhaoId,
  });

  final String clienteId;
  final String farmId;
  /// Abertura direta pela lista de talhões na fazenda.
  final String? talhaoId;

  @override
  ConsumerState<CronogramaSojaPage> createState() => _CronogramaSojaPageState();
}

class _CronogramaSojaPageState extends ConsumerState<CronogramaSojaPage> {
  bool _loading = true;
  List<CronogramaSojaParametros> _linhas = [];
  List<TalhaoEntity> _talhoes = [];
  String _culturaFazenda = 'Soja';
  final Set<String> _expandedIds = {};
  final Map<String, Timer> _saveTimers = {};
  List<SementeTalhaoEntity> _sementesPlano = [];
  final Map<String, List<String>> _cultivaresPorTalhao = {};
  List<ProdutoCatalogoEntity> _catalogo = [];
  CronogramaSojaParametros? _focusLinha;
  bool _focusCultivarConfirmada = false;
  String _focusCultivarPendente = '';
  String? _planoAtivoId;
  final GlobalKey _stepperHeaderKey = GlobalKey();

  /// Carrossel de etapas; criado na 1ª carga já na próxima etapa.
  PageController? _carrossel;

  /// Página-alvo enquanto o carrossel anima após toque no stepper; as páginas
  /// intermediárias não devem vibrar nem mover o destaque.
  int? _destinoCarrossel;

  /// Etapa visível no carrossel (alimenta o destaque do stepper).
  final ValueNotifier<int?> _etapaEmFoco = ValueNotifier<int?>(null);

  /// Últimas etapas do talhão em foco: evita sumir stepper/lista enquanto
  /// o provider recalcula após mudar plantio ou regulagem.
  ({String talhaoId, List<EtapaTalhao> etapas})? _ultimasEtapas;

  bool get _modoFocoTalhao =>
      widget.talhaoId != null && widget.talhaoId!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    for (final t in _saveTimers.values) {
      t.cancel();
    }
    _carrossel?.dispose();
    _etapaEmFoco.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final fazendas =
        await ref.read(fazendasNotifierProvider(widget.clienteId).future);
    final fazenda = fazendas.where((f) => f.id == widget.farmId).firstOrNull;
    _culturaFazenda = fazenda?.cultura ?? 'Soja';
    _planoAtivoId = (await ResolverPlanoAtivoFazendaUseCase(
      ref.read(plansRepoProvider),
    ).call(widget.farmId))
        ?.id;

    _talhoes = await ref.read(talhoesNotifierProvider(widget.farmId).future);
    await ref.read(catalogRepoProvider).seedIfEmpty();
    _catalogo = await ref.read(catalogRepoProvider).getAll();
    await _carregarCultivaresDoPlano();
    final repo = ref.read(clientsRepoProvider);
    var salvos = await repo.getCronogramasSojaByFazenda(widget.farmId);
    const resolver = ResolverCultivarTalhaoPlanoUseCase();
    salvos = salvos
        .map(
          (p) => p.copyWith(
            materialCultivar: resolver.escolherCultivar(
              talhaoId: p.talhaoId,
              sementes: _sementesPlano,
              cultivarSalva: p.materialCultivar,
            ),
          ),
        )
        .map((p) => enriquecerDaeMaturacaoDoCatalogo(p, _catalogo))
        .toList();

    if (salvos.isEmpty && _talhoes.isNotEmpty) {
      final grupoId = _uuid.v4();
      salvos = _talhoes
          .map(
            (t) => _comCultivarDoTalhao(
              CronogramaSojaParametros.defaults(
                id: _uuid.v4(),
                talhaoId: t.id,
                cultura: _culturaFazenda,
              ).copyWith(
                grupoRegulagemId: grupoId,
                plantioDefinido: false,
              ),
            ),
          )
          .toList();
      for (final linha in salvos) {
        await _persistTalhaoSafra(linha, sincronizarPlano: false);
      }
    }

    _linhas = salvos;
    if (_expandedIds.isEmpty && _linhas.isNotEmpty) {
      final g = agruparCronogramasPorRegulagem(_linhas).first;
      _expandedIds.add(g.grupoId);
    }
    if (_modoFocoTalhao) {
      await _prepareFocusTalhao(widget.talhaoId!);
    }
    setState(() => _loading = false);
  }

  Future<void> _prepareFocusTalhao(String talhaoId) async {
    if (_talhoes.every((t) => t.id != talhaoId)) {
      _focusLinha = null;
      return;
    }

    var linha = _linhas.where((l) => l.talhaoId == talhaoId).firstOrNull;
    if (linha == null) {
      linha = _comCultivarDoTalhao(
        CronogramaSojaParametros.defaults(
          id: _uuid.v4(),
          talhaoId: talhaoId,
          cultura: _culturaFazenda,
        ).copyWith(
          grupoRegulagemId: _uuid.v4(),
          plantioDefinido: false,
        ),
      );
      await _persistTalhaoSafra(linha, sincronizarPlano: false);
      _linhas = [..._linhas, linha];
    } else {
      final atualizada = _comCultivarDoTalhao(linha);
      linha = atualizada;
      _linhas =
          _linhas.map((l) => l.id == atualizada.id ? atualizada : l).toList();
    }

    _focusLinha = linha;
    final opcoes = _cultivaresPorTalhao[talhaoId] ?? const <String>[];
    if (opcoes.length <= 1) {
      _focusCultivarConfirmada = true;
      if (opcoes.length == 1) {
        final escolhida = aplicarDaeAoEscolherCultivar(
          params: linha,
          cultivar: opcoes.first,
          catalogo: _catalogo,
        );
        if (escolhida.materialCultivar != linha.materialCultivar ||
            escolhida.daeMaturacaoCiclo != linha.daeMaturacaoCiclo) {
          _focusLinha = escolhida;
          _linhas =
              _linhas.map((l) => l.id == escolhida.id ? escolhida : l).toList();
          _scheduleSave(escolhida);
        }
      }
    } else {
      _focusCultivarConfirmada = false;
      final salva = linha.materialCultivar.trim();
      _focusCultivarPendente =
          salva.isNotEmpty && opcoes.contains(salva) ? salva : opcoes.first;
    }
  }

  /// Etapas com produtos do plano para o talhão em foco (null enquanto carrega).
  List<EtapaTalhao>? _etapasFoco() {
    final planoId = _planoAtivoId;
    final linha = _focusLinha;
    if (planoId == null || linha == null || !linha.plantioDefinido) return null;
    final opcoes = _cultivaresPorTalhao[linha.talhaoId] ?? const <String>[];
    if (opcoes.length > 1 && !_focusCultivarConfirmada) return null;
    final atuais = ref
        .watch(
          etapasDoTalhaoProvider((
            planoId: planoId,
            talhaoId: linha.talhaoId,
            parametros: linha,
          )),
        )
        .valueOrNull;
    if (atuais != null) {
      _ultimasEtapas = (talhaoId: linha.talhaoId, etapas: atuais);
      return atuais;
    }
    final ultimas = _ultimasEtapas;
    return ultimas != null && ultimas.talhaoId == linha.talhaoId
        ? ultimas.etapas
        : null;
  }

  /// Controller do carrossel; abre na próxima etapa (ou na última, se a
  /// safra terminou) e já marca essa etapa no stepper.
  PageController _carrosselPara(List<EtapaTalhao> etapas) {
    final existente = _carrossel;
    if (existente != null) return existente;
    final inicial = resumoFaseTalhao(etapas, DateTime.now()).indiceProxima ??
        etapas.length - 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _etapaEmFoco.value = inicial;
    });
    return _carrossel = PageController(
      viewportFraction: 0.86,
      initialPage: inicial,
    );
  }

  /// Confirmação manual da aplicação (data real + produtos usados).
  Future<void> _confirmarEtapa(EtapaTalhao etapa) async {
    final linha = _focusLinha;
    if (linha == null) return;
    final resultado = await mostrarConfirmarAplicacao(
      context,
      talhaoId: linha.talhaoId,
      etapa: etapa,
      dataPlantio: linha.dataPlantio,
    );
    if (resultado == null || !mounted) return;
    final repo = ref.read(confirmacoesEtapaRepoProvider);
    final confirmacao = resultado.confirmacao;
    if (resultado.desfazer) {
      await repo.remover(linha.talhaoId, etapa.chave);
    } else if (confirmacao != null) {
      await repo.salvar(confirmacao);
    }
    ref.invalidate(confirmacoesEtapaProvider(linha.talhaoId));
  }

  /// Deslizar o carrossel → destaca a etapa no stepper.
  void _onEtapaVisivel(int indice) {
    if (_destinoCarrossel != null) return;
    HapticFeedback.selectionClick();
    _etapaEmFoco.value = indice;
  }

  /// Toque no nó do stepper → carrossel vai até o card da etapa.
  void _scrollParaEtapa(int indice) {
    final c = _carrossel;
    if (c == null || !c.hasClients) return;
    HapticFeedback.selectionClick();
    _etapaEmFoco.value = indice;
    _destinoCarrossel = indice;
    c
        .animateToPage(
          indice,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
        )
        .whenComplete(() => _destinoCarrossel = null);
  }

  void _patchFocusLinha(CronogramaSojaParametros linha) {
    setState(() {
      _focusLinha = linha;
      _linhas = _linhas.map((l) => l.id == linha.id ? linha : l).toList();
    });
    _scheduleSave(linha);
  }

  void _confirmarCultivarFocus() {
    if (_focusLinha == null) return;
    final atualizada = aplicarDaeAoEscolherCultivar(
      params: _focusLinha!,
      cultivar: _focusCultivarPendente,
      catalogo: _catalogo,
    );
    setState(() {
      _focusCultivarConfirmada = true;
      _focusLinha = atualizada;
      _linhas =
          _linhas.map((l) => l.id == atualizada.id ? atualizada : l).toList();
    });
    _scheduleSave(atualizada);
  }

  void _abrirRegulagemCompleta() {
    context.pushReplacement(
      AppRoutes.farmCronogramaSojaPath(widget.clienteId, widget.farmId),
    );
  }

  void _patchPlantioFocus(DateTime data) {
    final linha = _focusLinha;
    if (linha == null) return;
    _patchPlantioTalhao(linha, data);
    setState(() => _focusLinha = _linhas.firstWhere((l) => l.id == linha.id));
  }

  Future<void> _carregarCultivaresDoPlano() async {
    _sementesPlano = [];
    _cultivaresPorTalhao.clear();
    final planos = await ref.read(plansRepoProvider).getAll();
    final plano = planos
        .where(
          (p) => p.fazendaId == widget.farmId && p.status != 'consolidado',
        )
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    if (plano.isNotEmpty) {
      _sementesPlano =
          await ref.read(plansRepoProvider).getSementesByPlano(plano.first.id);
    }
    const resolver = ResolverCultivarTalhaoPlanoUseCase();
    for (final t in _talhoes) {
      _cultivaresPorTalhao[t.id] = resolver.call(
        talhaoId: t.id,
        sementes: _sementesPlano,
      );
    }
  }

  CronogramaSojaParametros _comCultivarDoTalhao(CronogramaSojaParametros p) {
    const resolver = ResolverCultivarTalhaoPlanoUseCase();
    final cultivar = resolver.escolherCultivar(
      talhaoId: p.talhaoId,
      sementes: _sementesPlano,
      cultivarSalva: p.materialCultivar,
    );
    return aplicarDaeAoEscolherCultivar(
      params: p,
      cultivar: cultivar,
      catalogo: _catalogo,
    );
  }

  Future<void> _persistTalhaoSafra(
    CronogramaSojaParametros params, {
    bool sincronizarPlano = false,
  }) async {
    final planoId = _planoAtivoId;
    if (planoId == null) return;
    await ref
        .read(clientsRepoProvider)
        .upsertCronogramaSoja(params, planoId: planoId);
    if (sincronizarPlano && params.plantioDefinido) {
      await SincronizarTalhaoSafraPlanoUseCase(ref.read(plansRepoProvider)).call(
        planoId: planoId,
        talhaoId: params.talhaoId,
        talhaoNome: _talhaoNome(params.talhaoId),
        parametros: params,
      );
    }
  }

  void _scheduleSave(
    CronogramaSojaParametros params, {
    bool sincronizarPlano = true,
  }) {
    _saveTimers[params.id]?.cancel();
    _saveTimers[params.id] = Timer(const Duration(milliseconds: 350), () async {
      await _persistTalhaoSafra(params, sincronizarPlano: sincronizarPlano);
    });
  }

  void _replaceLinhas(List<CronogramaSojaParametros> novas) {
    setState(() {
      final porId = {for (final l in _linhas) l.id: l};
      for (final n in novas) {
        porId[n.id] = n;
      }
      _linhas = porId.values.toList();
    });
    for (final n in novas) {
      _scheduleSave(n);
    }
  }

  void _patchModeloGrupo(
    CronogramaRegulagemGrupo grupo,
    CronogramaSojaParametros modelo,
  ) {
    final atualizadas = aplicarModeloNoGrupo(grupo: grupo, modelo: modelo);
    _replaceLinhas(atualizadas);
  }

  Future<void> _setTalhoesNoGrupo(
    CronogramaRegulagemGrupo grupo,
    Set<String> talhaoIds,
  ) async {
    if (talhaoIds.isEmpty) return;
    final repo = ref.read(clientsRepoProvider);
    final modelo = grupo.modelo;
    final mantidas =
        grupo.linhas.where((l) => talhaoIds.contains(l.talhaoId)).toList();
    final removidas =
        grupo.linhas.where((l) => !talhaoIds.contains(l.talhaoId)).toList();
    for (final r in removidas) {
      await repo.deleteCronogramaSoja(r.id);
    }
    final novas = <CronogramaSojaParametros>[];
    for (final id in talhaoIds) {
      final existente = mantidas.where((l) => l.talhaoId == id).firstOrNull ??
          _linhas.where((l) => l.talhaoId == id).firstOrNull;
      if (existente != null) {
        novas.add(
          existente.copyWith(
            grupoRegulagemId: grupo.grupoId,
            cultura: modelo.cultura,
            diasEmergencia: modelo.diasEmergencia,
            daePosEmergente: modelo.daePosEmergente,
            diasRecuperacaoPosEmergente: modelo.diasRecuperacaoPosEmergente,
            intervaloFungicidaDias: modelo.intervaloFungicidaDias,
            totalAplicacoesFungicida: modelo.totalAplicacoesFungicida,
            diasAntesR8Dessecante: modelo.diasAntesR8Dessecante,
            diasAntecipacaoColheitaReal: modelo.diasAntecipacaoColheitaReal,
            diasDessecacaoPrePlantio: modelo.diasDessecacaoPrePlantio,
          ),
        );
        continue;
      }
      novas.add(
        _comCultivarDoTalhao(
          CronogramaSojaParametros.defaults(
            id: _uuid.v4(),
            talhaoId: id,
            cultura: modelo.cultura,
          ).copyWith(
            grupoRegulagemId: grupo.grupoId,
            plantioDefinido: false,
            ordem: modelo.ordem,
            diasEmergencia: modelo.diasEmergencia,
            daePosEmergente: modelo.daePosEmergente,
            diasRecuperacaoPosEmergente: modelo.diasRecuperacaoPosEmergente,
            intervaloFungicidaDias: modelo.intervaloFungicidaDias,
            totalAplicacoesFungicida: modelo.totalAplicacoesFungicida,
            diasAntesR8Dessecante: modelo.diasAntesR8Dessecante,
            diasAntecipacaoColheitaReal: modelo.diasAntecipacaoColheitaReal,
            diasDessecacaoPrePlantio: modelo.diasDessecacaoPrePlantio,
          ),
        ),
      );
    }
    setState(() {
      _linhas = [
        ..._linhas.where((l) {
          if (l.grupoRegulagemId == grupo.grupoId) return false;
          if (talhaoIds.contains(l.talhaoId)) return false;
          return true;
        }),
        ...novas,
      ];
    });
    for (final n in novas) {
      await _persistTalhaoSafra(n, sincronizarPlano: false);
    }
  }

  void _patchPlantioTalhao(CronogramaSojaParametros linha, DateTime data) {
    final atualizada = linha.copyWith(
      dataPlantio: data,
      plantioDefinido: true,
    );
    setState(() {
      _linhas = _linhas.map((l) => l.id == linha.id ? atualizada : l).toList();
    });
    _scheduleSave(atualizada);
  }

  Future<void> _addLinha() async {
    if (_talhoes.isEmpty) return;
    final grupoId = _uuid.v4();
    final atribuidos = _linhas.map((l) => l.talhaoId).toSet();
    final livres = _talhoes.where((t) => !atribuidos.contains(t.id)).toList();
    if (livres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos os talhões já têm cronograma.'),
        ),
      );
      return;
    }
    final selecionados = livres;
    final novas = selecionados
        .map(
          (t) => _comCultivarDoTalhao(
            CronogramaSojaParametros.defaults(
              id: _uuid.v4(),
              talhaoId: t.id,
              cultura: _culturaFazenda,
            ).copyWith(
              grupoRegulagemId: grupoId,
              plantioDefinido: false,
              ordem: _linhas.length,
            ),
          ),
        )
        .toList();
    for (final n in novas) {
      await _persistTalhaoSafra(n, sincronizarPlano: false);
    }
    setState(() {
      _linhas = [..._linhas, ...novas];
      _expandedIds.add(grupoId);
    });
  }

  Future<void> _syncGrupo(CronogramaRegulagemGrupo grupo) async {
    final comPlantio =
        grupo.linhas.where((l) => l.plantioDefinido).toList();
    if (comPlantio.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Defina a data de plantio na ficha de cada talhão antes de aplicar ao plano.',
          ),
        ),
      );
      return;
    }

    final planoId = _planoAtivoId;
    var alteracoes = 0;
    if (planoId != null) {
      final plansRepo = ref.read(plansRepoProvider);
      final clientsRepo = ref.read(clientsRepoProvider);
      for (final linha in comPlantio) {
        final nome = _talhaoNome(linha.talhaoId);
        await InstanciarRoteiroTalhaoUseCase(plansRepo, clientsRepo).call(
          planoId: planoId,
          talhaoId: linha.talhaoId,
          talhaoNome: nome,
        );
        final r = await SincronizarTalhaoSafraPlanoUseCase(plansRepo).call(
          planoId: planoId,
          talhaoId: linha.talhaoId,
          talhaoNome: nome,
          parametros: linha,
        );
        alteracoes += r?.totalAlteracoes ?? 0;
      }
    } else {
      for (final linha in comPlantio) {
        final linhas = calcularCronogramaSoja(linha);
        alteracoes += await SincronizarCronogramaSojaPlanoUseCase(
          ref.read(plansRepoProvider),
        ).call(fazendaId: widget.farmId, linhas: linhas);
      }
    }
    if (!mounted) return;
    final msg = alteracoes == 0
        ? 'Nenhum estádio atualizado. Confira plantio nos talhões e o plano ativo.'
        : '$alteracoes alteração(ões) aplicada(s) ao plano.';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  String _talhaoNome(String talhaoId) =>
      _talhoes.where((t) => t.id == talhaoId).firstOrNull?.nome ?? 'Talhão';

  String _subtituloGrupo(CronogramaRegulagemGrupo grupo) {
    final nomes = grupo.linhas.map((l) => _talhaoNome(l.talhaoId)).join(', ');
    final mat = grupo.modelo.materialCultivar.trim();
    final partes = [nomes];
    if (mat.isNotEmpty) partes.add(mat);
    final comPlantio = grupo.linhas.where((l) => l.plantioDefinido).length;
    if (comPlantio > 0) {
      partes.add('plantio em $comPlantio/${grupo.linhas.length} talhão(ões)');
    } else {
      partes.add('plantio por talhão');
    }
    return partes.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final foco = !_loading && _modoFocoTalhao && _focusLinha != null;
    final comPlano = _planoAtivoId != null;
    final nomeFoco = foco ? _talhaoNome(_focusLinha!.talhaoId) : null;
    final etapasFoco = foco ? _etapasFoco() : null;
    final carrossel = etapasFoco == null || etapasFoco.isEmpty
        ? null
        : _carrosselPara(etapasFoco);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _loading
          ? const LoadingSkeleton()
          : CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text(
                    foco
                        ? nomeFoco!
                        : (comPlano
                            ? 'Cronograma Agrícola (Soja)'
                            : 'Cronograma avulso (Soja)'),
                  ),
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withValues(alpha: 0.85),
                  border: Border.all(color: Colors.transparent),
                  leading: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.pop(),
                    child: const PhosphorIcon(
                      PhosphorIconsRegular.caretLeft,
                      size: 22,
                      color: AppColors.primary,
                    ),
                  ),
                  trailing: foco
                      ? null
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _talhoes.isEmpty ? null : _addLinha,
                          child: Text(
                            '+ Linha',
                            style: TextStyle(
                              fontSize: 13,
                              color: _talhoes.isEmpty
                                  ? context.appTextSecondary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                ),
                if (etapasFoco != null && etapasFoco.isNotEmpty)
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StepperHeaderDelegate(
                      subtitulo: _subtituloFoco(_focusLinha!),
                      etapas: etapasFoco,
                      headerKey: _stepperHeaderKey,
                      foco: _etapaEmFoco,
                      onEtapaTap: _scrollParaEtapa,
                      background: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                if (!comPlano)
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: CronogramaModoAvulsoBanner(),
                    ),
                  ),
                if (comPlano && !foco)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Regulagem compartilhada por grupo. Data de plantio: '
                        'toque no talhão na ficha da fazenda.',
                        style: AppTypography.caption.copyWith(
                          color: context.appTextSecondary,
                        ),
                      ),
                    ),
                  ),
                if (foco)
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    sliver: SliverToBoxAdapter(
                      child: CronogramaSojaTalhaoFocusView(
                        talhaoNome: nomeFoco!,
                        linha: _focusLinha!,
                        opcoesCultivar:
                            _cultivaresPorTalhao[_focusLinha!.talhaoId] ??
                                const [],
                        catalogo: _catalogo,
                        cultivarConfirmada: _focusCultivarConfirmada,
                        cultivarPendente: _focusCultivarPendente,
                        onCultivarPendenteChanged: (v) =>
                            setState(() => _focusCultivarPendente = v),
                        onConfirmarCultivar: _confirmarCultivarFocus,
                        onLinhaChanged: _patchFocusLinha,
                        onPlantioChanged: _patchPlantioFocus,
                        onAbrirRegulagemCompleta: _abrirRegulagemCompleta,
                        avisosValidacao:
                            _avisosValidacaoCronograma(context, _focusLinha!),
                        etapas: etapasFoco,
                        carrossel: carrossel,
                        onEtapaVisivel: _onEtapaVisivel,
                        onConfirmarEtapa: _confirmarEtapa,
                      ),
                    ),
                  )
                else if (_talhoes.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: EmptyStateWidget(
                        icon: PhosphorIconsRegular.gridFour,
                        title: 'Cadastre talhões',
                        subtitle:
                            'Adicione talhões na fazenda para montar o cronograma.',
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) {
                          final grupos = agruparCronogramasPorRegulagem(_linhas);
                          final grupo = grupos[i];
                          final expanded =
                              _expandedIds.contains(grupo.grupoId);

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            child: AccordionSection(
                              title: grupo.modelo.cultura,
                              subtitle: _subtituloGrupo(grupo),
                              isExpanded: expanded,
                              onToggle: (v) {
                                setState(() {
                                  if (v) {
                                    _expandedIds.add(grupo.grupoId);
                                  } else {
                                    _expandedIds.remove(grupo.grupoId);
                                  }
                                });
                              },
                              child: _CronogramaRegulagemForm(
                                key: ValueKey(grupo.grupoId),
                                grupo: grupo,
                                talhoes: _talhoes,
                                catalogo: _catalogo,
                                cultivaresPorTalhao: _cultivaresPorTalhao,
                                talhaoNome: _talhaoNome,
                                plantioNoGrupo: !comPlano,
                                onModeloChanged: (m) =>
                                    _patchModeloGrupo(grupo, m),
                                onTalhoesChanged: (ids) =>
                                    _setTalhoesNoGrupo(grupo, ids),
                                onPlantioChanged: _patchPlantioTalhao,
                                onSyncPlano: () => _syncGrupo(grupo),
                                onDelete: grupos.length <= 1
                                    ? null
                                    : () async {
                                        final repo = ref.read(
                                          clientsRepoProvider,
                                        );
                                        for (final l in grupo.linhas) {
                                          await repo.deleteCronogramaSoja(
                                            l.id,
                                          );
                                        }
                                        setState(() {
                                          final rm = grupo.linhas
                                              .map((l) => l.id)
                                              .toSet();
                                          _linhas = _linhas
                                              .where((l) => !rm.contains(l.id))
                                              .toList();
                                          _expandedIds.remove(grupo.grupoId);
                                        });
                                      },
                              ),
                            ),
                          );
                        },
                        childCount:
                            agruparCronogramasPorRegulagem(_linhas).length,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xxl),
                ),
              ],
            ),
    );
  }
}

String _subtituloFoco(CronogramaSojaParametros linha) {
  final plantio = 'plantio ${AppFormatters.data(linha.dataPlantio)}';
  final cultivar = linha.materialCultivar.trim();
  return cultivar.isEmpty ? plantio : '$cultivar · $plantio';
}

/// Cabeçalho fixo "onde estamos": DAE de hoje, próxima etapa com contagem
/// regressiva, % do ciclo e a linha do tempo. Ao rolar, a 2ª linha recolhe.
class _StepperHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StepperHeaderDelegate({
    required this.subtitulo,
    required this.etapas,
    required this.onEtapaTap,
    required this.background,
    required this.headerKey,
    required this.foco,
  });

  /// Cultivar · plantio (fallback quando não há próxima etapa).
  final String subtitulo;
  final List<EtapaTalhao> etapas;
  final ValueChanged<int> onEtapaTap;
  final Color background;
  final GlobalKey headerKey;
  final ValueListenable<int?> foco;

  static const double _resumoAberto = 50;
  static const double _resumoFechado = 26;
  static const double _base =
      AppSpacing.sm + TalhaoTimelineStepper.altura + 1;

  @override
  double get minExtent => _base + _resumoFechado;

  @override
  double get maxExtent => _base + _resumoAberto;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final hoje = DateTime.now();
    final resumo = resumoFaseTalhao(etapas, hoje);
    final prox =
        resumo.indiceProxima == null ? null : etapas[resumo.indiceProxima!];

    final titulo = resumo.daeHoje != null
        ? 'Hoje · DAE ${resumo.daeHoje}'
        : 'Hoje · ${AppFormatters.data(hoje).substring(0, 5)}';
    final pct = (resumo.progressoCiclo * 100).round();

    final sub = AppTypography.caption.copyWith(color: context.appTextSecondary);
    final linha2 = prox == null
        ? Text('Safra concluída · $subtitulo', style: sub, maxLines: 1)
        : Text.rich(
            TextSpan(
              style: sub,
              children: [
                TextSpan(
                  text: diasAte(prox.data, hoje) == 0 ? 'Hoje: ' : 'Próxima: ',
                ),
                TextSpan(
                  text: nomeCurtoEtapa(prox.linha),
                  style: TextStyle(
                    color: context.appTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (diasAte(prox.data, hoje) != 0)
                  TextSpan(
                    text: ' ${textoRelativo(prox.data, hoje)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                TextSpan(
                  text: ' · ${AppFormatters.data(prox.data).substring(0, 5)}',
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    return Container(
      key: headerKey,
      color: background,
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _resumoAberto - (_resumoAberto - _resumoFechado) * t,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.topLeft,
                minHeight: _resumoAberto,
                maxHeight: _resumoAberto,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              titulo,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.h3.copyWith(
                                fontSize: 17,
                                color: context.appTextPrimary,
                              ),
                            ),
                          ),
                          _AnelCiclo(progresso: resumo.progressoCiclo),
                          const SizedBox(width: 6),
                          Text(
                            '$pct% do ciclo',
                            style: AppTypography.label.copyWith(
                              fontSize: 12,
                              color: context.appTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Opacity(opacity: 1 - t, child: linha2),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TalhaoTimelineStepper(
            etapas: etapas,
            onEtapaTap: onEtapaTap,
            foco: foco,
          ),
          Divider(height: 1, color: context.appBorder),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_StepperHeaderDelegate old) =>
      old.subtitulo != subtitulo ||
      old.etapas != etapas ||
      old.background != background;
}

/// Anel de progresso do ciclo (plantio → R8), estilo Atividade do iOS.
class _AnelCiclo extends StatelessWidget {
  const _AnelCiclo({required this.progresso});

  final double progresso;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        value: progresso,
        strokeWidth: 3,
        strokeCap: StrokeCap.round,
        backgroundColor: context.appBorder,
        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }
}

List<LinhaTempoSojaItem> _linhasCore(CronogramaSojaParametros params) {
  return calcularLinhaTempoSoja(
    dataPlantio: params.dataPlantio,
    parametros: parametrosFromCronograma(params),
  );
}

List<Widget> _avisosValidacaoCronograma(
  BuildContext context,
  CronogramaSojaParametros params,
) {
  final fenologicos = parametrosFromCronograma(params);
  final mensagens = <String>[
    if (avisoAntecipacaoColheitaReal(params.diasAntecipacaoColheitaReal) !=
        null)
      avisoAntecipacaoColheitaReal(params.diasAntecipacaoColheitaReal)!,
    if (avisoDessecanteIndependenteColheitaReal(fenologicos) != null)
      avisoDessecanteIndependenteColheitaReal(fenologicos)!,
  ];
  return mensagens
      .map(
        (m) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Text(
            m,
            style: AppTypography.caption.copyWith(
              color: AppColors.warning,
              fontSize: 11,
            ),
          ),
        ),
      )
      .toList();
}

/// Blocos da sanfona interna de regulagem (exclusiva — só um aberto por vez).
/// "Referência da regulagem (DAE)" fica fora deste enum: é resultado
/// calculado (output), não um input, e por isso sempre fica visível.
enum _CronogramaBloco {
  selecao,
  ciclo,
  emergencia,
  fungicida,
  dessecacaoColheita,
}

class _CronogramaRegulagemForm extends StatefulWidget {
  const _CronogramaRegulagemForm({
    super.key,
    required this.grupo,
    required this.talhoes,
    required this.catalogo,
    required this.cultivaresPorTalhao,
    required this.talhaoNome,
    required this.plantioNoGrupo,
    required this.onModeloChanged,
    required this.onTalhoesChanged,
    required this.onPlantioChanged,
    required this.onSyncPlano,
    this.onDelete,
  });

  final CronogramaRegulagemGrupo grupo;
  final List<TalhaoEntity> talhoes;
  final List<ProdutoCatalogoEntity> catalogo;
  final Map<String, List<String>> cultivaresPorTalhao;
  final String Function(String talhaoId) talhaoNome;
  final bool plantioNoGrupo;
  final ValueChanged<CronogramaSojaParametros> onModeloChanged;
  final ValueChanged<Set<String>> onTalhoesChanged;
  final void Function(CronogramaSojaParametros linha, DateTime data)
      onPlantioChanged;
  final VoidCallback onSyncPlano;
  final VoidCallback? onDelete;

  @override
  State<_CronogramaRegulagemForm> createState() =>
      _CronogramaRegulagemFormState();
}

class _CronogramaRegulagemFormState extends State<_CronogramaRegulagemForm> {
  _CronogramaBloco? _blocoAberto = _CronogramaBloco.selecao;

  CronogramaSojaParametros get params => widget.grupo.modelo;

  List<String> _cultivaresDoGrupo() {
    final ids = widget.grupo.talhaoIds;
    final set = <String>{};
    for (final id in ids) {
      set.addAll(widget.cultivaresPorTalhao[id] ?? const []);
    }
    final list = set.toList();
    list.sort();
    return list;
  }

  String _resumoSelecao() {
    final nomes = widget.grupo.linhas
        .map((l) => widget.talhaoNome(l.talhaoId))
        .join(', ');
    final mat = params.materialCultivar.trim();
    return mat.isEmpty ? nomes : '$nomes · $mat';
  }

  String _resumoCiclo() => 'Ciclo ${params.daeMaturacaoCiclo} dias';

  String _resumoEmergencia() =>
      'Emergência ${params.diasEmergencia}d · '
      'Pós-em. DAE ${params.daePosEmergente} · '
      'Recup. ${params.diasRecuperacaoPosEmergente}d';

  String _resumoFungicida() {
    final total = params.totalAplicacoesFungicida;
    if (total <= 1) return '$total aplic.';
    return '$total aplic. · intervalo ${params.intervaloFungicidaDias}d';
  }

  String _resumoDessecacaoColheita() =>
      'Desseca ${params.diasDessecacaoPrePlantio}d antes · '
      'antecipa ${params.diasAntecipacaoColheitaReal}d';

  Widget _blocoAccordion({
    required _CronogramaBloco id,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AccordionSection(
        title: title,
        subtitle: subtitle,
        quiet: true,
        isExpanded: _blocoAberto == id,
        onToggle: (v) => setState(() => _blocoAberto = v ? id : null),
        child: child,
      ),
    );
  }

  Widget _blocoSelecao(BuildContext context) {
    return _blocoAccordion(
      id: _CronogramaBloco.selecao,
      title: 'Seleção',
      subtitle: _resumoSelecao(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TalhaoMultiSelector(
            talhoes: widget.talhoes,
            selectedIds: widget.grupo.talhaoIds,
            onChanged: widget.onTalhoesChanged,
          ),
          _CampoDropdown(
            label: 'Cultura',
            value: params.cultura,
            options: AppConstants.culturas,
            onChanged: (v) =>
                widget.onModeloChanged(params.copyWith(cultura: v)),
          ),
          CultivarTalhaoSelector(
            label: 'Material / Cultivar (referência)',
            value: params.materialCultivar,
            opcoesVinculadas: _cultivaresDoGrupo(),
            onChanged: (v) => widget.onModeloChanged(
              aplicarDaeAoEscolherCultivar(
                params: params,
                cultivar: v,
                catalogo: widget.catalogo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blocoCiclo(BuildContext context) {
    final daeCatalogo = resolverDaeMaturacaoCultivar(
      params.materialCultivar,
      widget.catalogo,
    );
    return _blocoAccordion(
      id: _CronogramaBloco.ciclo,
      title: 'Ciclo da cultivar',
      subtitle: _resumoCiclo(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CampoInteiro(
            label: 'Ciclo da cultivar (DAE maturação)',
            value: params.daeMaturacaoCiclo,
            suffix: 'dias',
            onChanged: (v) => widget.onModeloChanged(
              params.copyWith(daeMaturacaoCiclo: v),
            ),
          ),
          if (daeCatalogo != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                'Catálogo de sementes: $daeCatalogo dias (editável)',
                style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _blocoEmergencia(BuildContext context) {
    return _blocoAccordion(
      id: _CronogramaBloco.emergencia,
      title: 'Emergência',
      subtitle: _resumoEmergencia(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CampoInteiro(
            label: 'Dias para emergência',
            value: params.diasEmergencia,
            suffix: 'dias',
            onChanged: (v) =>
                widget.onModeloChanged(params.copyWith(diasEmergencia: v)),
          ),
          _CampoInteiro(
            label: 'DAE do pós-emergente',
            value: params.daePosEmergente,
            suffix: 'DAE',
            onChanged: (v) =>
                widget.onModeloChanged(params.copyWith(daePosEmergente: v)),
          ),
          _CampoInteiro(
            label: 'Recuperação pós-emergente',
            value: params.diasRecuperacaoPosEmergente,
            suffix: 'dias',
            onChanged: (v) => widget.onModeloChanged(
              params.copyWith(diasRecuperacaoPosEmergente: v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blocoFungicida(BuildContext context) {
    final total = params.totalAplicacoesFungicida;
    final aplicacoes = _linhasCore(
      params,
    ).where((l) => l.tipo == LinhaTempoSojaTipo.fungicida);
    return _blocoAccordion(
      id: _CronogramaBloco.fungicida,
      title: 'Fungicida',
      subtitle: _resumoFungicida(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _campoTotalAplicacoesFungicida(context, total),
          if (total > 1)
            _CampoInteiro(
              label: 'Intervalo entre fungicidas',
              value: params.intervaloFungicidaDias,
              suffix: 'dias',
              onChanged: (v) => widget.onModeloChanged(
                params.copyWith(intervaloFungicidaDias: v),
              ),
            ),
          // Pré-visualização gerada dinamicamente a partir do total acima —
          // nenhuma aplicação fica hardcoded, a lista acompanha o stepper.
          if (aplicacoes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final l in aplicacoes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '${l.fungicidaIndice}ª aplicação — DAE ${l.dae}',
                        style: AppTypography.caption.copyWith(
                          color: context.appTextSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _campoTotalAplicacoesFungicida(BuildContext context, int total) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total de aplicações de fungicida',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecoration(
              color: context.appSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: context.appBorder),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: total > 0
                      ? () => widget.onModeloChanged(
                          params.copyWith(
                            totalAplicacoesFungicida: total - 1,
                          ),
                        )
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.primary,
                  tooltip: 'Remover aplicação',
                ),
                Expanded(
                  child: Text(
                    total == 1 ? '1 aplicação' : '$total aplicações',
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.appTextPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => widget.onModeloChanged(
                    params.copyWith(totalAplicacoesFungicida: total + 1),
                  ),
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                  tooltip: 'Adicionar aplicação',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _blocoDessecacaoColheita(BuildContext context) {
    return _blocoAccordion(
      id: _CronogramaBloco.dessecacaoColheita,
      title: 'Dessecação e colheita',
      subtitle: _resumoDessecacaoColheita(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CampoInteiro(
            label: 'Dessecação pré-plantio (dias antes do plantio)',
            value: params.diasDessecacaoPrePlantio,
            suffix: 'dias',
            onChanged: (v) => widget.onModeloChanged(
              params.copyWith(diasDessecacaoPrePlantio: v),
            ),
          ),
          _CampoInteiro(
            label: 'Dias antes do R8 para dessecante (R7)',
            value: params.diasAntesR8Dessecante,
            suffix: 'dias',
            onChanged: (v) => widget.onModeloChanged(
              params.copyWith(diasAntesR8Dessecante: v),
            ),
          ),
          _CampoInteiro(
            label: 'Antecipação real da colheita (após dessecação)',
            value: params.diasAntecipacaoColheitaReal,
            suffix: 'dias',
            onChanged: (v) => widget.onModeloChanged(
              params.copyWith(diasAntecipacaoColheitaReal: v),
            ),
          ),
          ..._avisosValidacaoCronograma(context, params),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _blocoSelecao(context),
        _blocoCiclo(context),
        _blocoEmergencia(context),
        _blocoFungicida(context),
        _blocoDessecacaoColheita(context),
        if (!widget.plantioNoGrupo) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Plantio: defina na ficha de cada talhão na fazenda. '
            'Só talhões com plantio entram em “Aplicar datas ao plano”.',
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
              fontSize: 11,
            ),
          ),
        ],
        if (widget.plantioNoGrupo) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Plantio por talhão',
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              color: context.appTextPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ...widget.grupo.linhas.map((linha) {
            final label = widget.talhaoNome(linha.talhaoId);
            return _CampoData(
              label: label,
              value: linha.dataPlantio,
              hint: linha.plantioDefinido ? null : 'Toque para definir',
              onChanged: (d) => widget.onPlantioChanged(linha, d),
            );
          }),
        ],
        const SizedBox(height: AppSpacing.md),
        CronogramaSojaTabela(
          titulo: 'Referência da regulagem (DAE)',
          linhas: _linhasCore(params),
          resumo: resumoCronogramaSoja(params),
          mostrarColunaData: false,
        ),
        if (widget.plantioNoGrupo)
          ...widget.grupo.linhas.where((l) => l.plantioDefinido).map((linha) {
            return Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: CronogramaSojaTabela(
                titulo:
                    'Datas — ${widget.talhaoNome(linha.talhaoId)} (${AppFormatters.data(linha.dataPlantio)})',
                linhas: calcularLinhaTempoSoja(
                  dataPlantio: linha.dataPlantio,
                  parametros: parametrosFromCronograma(linha),
                ),
                resumo: '',
                mostrarColunaData: true,
              ),
            );
          }),
        const SizedBox(height: AppSpacing.md),
        CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          onPressed: widget.onSyncPlano,
          child: const Text('Aplicar datas ao plano'),
        ),
        if (widget.onDelete != null) ...[
          const SizedBox(height: AppSpacing.xs),
          CupertinoButton(
            onPressed: widget.onDelete,
            child: const Text(
              'Remover linha',
              style: TextStyle(color: AppColors.error, fontSize: 14),
            ),
          ),
        ],
      ],
    );
  }
}

class _CampoDropdown extends StatelessWidget {
  const _CampoDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            initialValue: options.contains(value) ? value : options.first,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.appSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            items: options
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}

class _CampoTexto extends StatefulWidget {
  const _CampoTexto({
    required this.label,
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<_CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<_CampoTexto> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _CampoTexto oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _ctrl.text != widget.value) {
      _ctrl.text = widget.value;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: context.appSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}

class _CampoInteiro extends StatefulWidget {
  const _CampoInteiro({
    required this.label,
    required this.value,
    required this.suffix,
    required this.onChanged,
  });

  final String label;
  final int value;
  final String suffix;
  final ValueChanged<int> onChanged;

  @override
  State<_CampoInteiro> createState() => _CampoInteiroState();
}

class _CampoInteiroState extends State<_CampoInteiro> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: '${widget.value}');
  }

  @override
  void didUpdateWidget(covariant _CampoInteiro oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final text = '${widget.value}';
      if (_ctrl.text != text) _ctrl.text = text;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(AppConstants.maxDigitosNumerico),
            ],
            decoration: InputDecoration(
              suffixText: widget.suffix,
              filled: true,
              fillColor: context.appSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            onChanged: (raw) {
              final parsed = int.tryParse(raw);
              if (parsed != null) widget.onChanged(parsed);
            },
          ),
        ],
      ),
    );
  }
}

class _CampoData extends StatelessWidget {
  const _CampoData({
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  final String? hint;

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
      locale: const Locale('pt', 'BR'),
    );
    if (picked != null) {
      onChanged(DateTime(picked.year, picked.month, picked.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => _pick(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.appBorder),
              ),
              child: Text(
                hint ?? AppFormatters.data(value),
                style: AppTypography.body.copyWith(
                  color: hint != null
                      ? context.appTextSecondary
                      : context.appTextPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
