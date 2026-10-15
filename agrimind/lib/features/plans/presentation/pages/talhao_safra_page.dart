import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/agronomy/linha_tempo_soja.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/accordion_section.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../clients/domain/cronograma_soja/calcular_cronograma_soja.dart'
    show parametrosFromCronograma, resumoCronogramaSoja;
import '../../../catalog/domain/dae_maturacao_cultivar.dart';
import '../../../catalog/domain/entities/produto_catalogo_entity.dart';
import '../../../clients/domain/cronograma_soja/aplicar_dae_catalogo_cronograma.dart';
import '../../../clients/domain/cronograma_soja/cronograma_soja_parametros.dart';
import '../../../clients/presentation/widgets/cronograma_soja_tabela.dart';
import '../../../clients/presentation/widgets/cultivar_talhao_selector.dart';
import '../../domain/talhao_safra/talhao_safra_entity.dart';
import '../../domain/usecases/resolver_cultivar_talhao_plano_usecase.dart';
import '../../domain/usecases/instanciar_roteiro_talhao_usecase.dart';
import '../../domain/usecases/sincronizar_programas_operacionais_talhao_usecase.dart';
import '../../domain/usecases/sincronizar_talhao_safra_plano_usecase.dart';
import '../../../../core/router/app_routes.dart';
import '../providers/plano_detail_provider.dart';
import '../providers/sementes_plano_provider.dart';

const _uuid = Uuid();

/// Cronograma operacional por talhão dentro do plano (spec TalhaoSafra).
class TalhaoSafraPage extends ConsumerStatefulWidget {
  const TalhaoSafraPage({
    super.key,
    required this.planoId,
    this.talhaoId,
  });

  final String planoId;
  final String? talhaoId;

  @override
  ConsumerState<TalhaoSafraPage> createState() => _TalhaoSafraPageState();
}

class _TalhaoSafraPageState extends ConsumerState<TalhaoSafraPage> {
  bool _loading = true;
  final Map<String, CronogramaSojaParametros> _porTalhao = {};
  final Map<String, String> _talhaoNomes = {};
  final Map<String, List<String>> _cultivaresPorTalhao = {};
  final Set<String> _expanded = {};
  final Map<String, Timer> _saveTimers = {};
  List<ProdutoCatalogoEntity> _catalogo = [];

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
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final plano = await ref.read(planoDetailProvider(widget.planoId).future);
    final fazendaId = plano.fazendaId;
    if (fazendaId == null) {
      setState(() => _loading = false);
      return;
    }

    await ref.read(catalogRepoProvider).seedIfEmpty();
    _catalogo = await ref.read(catalogRepoProvider).getAll();

    final talhoes = await ref.read(clientsRepoProvider).getTalhoes(fazendaId);
    var salvos = await ref
        .read(clientsRepoProvider)
        .getCronogramasSojaByPlano(widget.planoId);
    final sementes =
        await ref.read(sementesPlanoNotifierProvider(widget.planoId).future);
    const resolver = ResolverCultivarTalhaoPlanoUseCase();

    final map = <String, CronogramaSojaParametros>{};
    final nomes = <String, String>{};
    final cultivaresMap = <String, List<String>>{};
    for (final t in talhoes) {
      nomes[t.id] = t.nome;
      cultivaresMap[t.id] =
          resolver.call(talhaoId: t.id, sementes: sementes);
      final existente = salvos.where((s) => s.talhaoId == t.id).firstOrNull;
      if (existente != null) {
        final cultivar = resolver.escolherCultivar(
          talhaoId: t.id,
          sementes: sementes,
          cultivarSalva: existente.materialCultivar,
        );
        map[t.id] = enriquecerDaeMaturacaoDoCatalogo(
          aplicarDaeAoEscolherCultivar(
            params: existente.copyWith(cultura: plano.cultura),
            cultivar: cultivar,
            catalogo: _catalogo,
          ),
          _catalogo,
        );
      } else {
        final cultivar = resolver.escolherCultivar(
          talhaoId: t.id,
          sementes: sementes,
          cultivarSalva: null,
        );
        final nova = aplicarDaeAoEscolherCultivar(
          params: CronogramaSojaParametros.defaults(
            id: _uuid.v4(),
            talhaoId: t.id,
            cultura: plano.cultura,
          ),
          cultivar: cultivar,
          catalogo: _catalogo,
        );
        await ref.read(clientsRepoProvider).upsertCronogramaSoja(
              nova,
              planoId: widget.planoId,
            );
        map[t.id] = nova;
      }
    }

    _porTalhao
      ..clear()
      ..addAll(map);
    _talhaoNomes
      ..clear()
      ..addAll(nomes);
    _cultivaresPorTalhao
      ..clear()
      ..addAll(cultivaresMap);
    if (widget.talhaoId != null && map.containsKey(widget.talhaoId)) {
      _expanded.add(widget.talhaoId!);
    } else if (_expanded.isEmpty && map.isNotEmpty) {
      _expanded.add(map.keys.first);
    }
    setState(() => _loading = false);
  }

  Future<void> _atribuirRoteiro(String talhaoId) async {
    final nome = _talhaoNomes[talhaoId] ?? 'Talhão';
    final resultado = await InstanciarRoteiroTalhaoUseCase(
      ref.read(plansRepoProvider),
      ref.read(clientsRepoProvider),
    ).call(
      planoId: widget.planoId,
      talhaoId: talhaoId,
      talhaoNome: nome,
    );
    final params = _porTalhao[talhaoId];
    if (params != null) {
      setState(() {
        _porTalhao[talhaoId] = params.copyWith(
          programaOperacionalIds: resultado.programaOperacionalIds,
        );
      });
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          resultado.instanciasCriadas > 0
              ? 'Roteiro atribuído: ${resultado.instanciasCriadas} card(s) '
                  'vinculado(s) a $nome.'
              : 'Roteiro já estava atribuído a $nome (nada novo criado).',
        ),
      ),
    );
    ref.invalidate(planoDetailProvider(widget.planoId));
  }

  void _scheduleSave(CronogramaSojaParametros p) {
    _saveTimers[p.id]?.cancel();
    _saveTimers[p.id] = Timer(const Duration(milliseconds: 350), () async {
      await ref.read(clientsRepoProvider).upsertCronogramaSoja(
            p,
            planoId: widget.planoId,
          );
      if (p.plantioDefinido) {
        await SincronizarTalhaoSafraPlanoUseCase(ref.read(plansRepoProvider))
            .call(
          planoId: widget.planoId,
          talhaoId: p.talhaoId,
          talhaoNome: _talhaoNomes[p.talhaoId] ?? 'Talhão',
          parametros: p,
        );
      }
    });
  }

  void _patch(String talhaoId, CronogramaSojaParametros updated) {
    setState(() => _porTalhao[talhaoId] = updated);
    _scheduleSave(updated);
  }

  Future<void> _sync(String talhaoId) async {
    final p = _porTalhao[talhaoId];
    if (p == null) return;
    final repo = ref.read(plansRepoProvider);
    final resultado = await SincronizarProgramasOperacionaisTalhaoUseCase(repo)
        .call(
      planoId: widget.planoId,
      talhaoId: talhaoId,
      talhaoNome: _talhaoNomes[talhaoId] ?? 'Talhão',
      parametros: p,
    );
    if (!mounted) return;
    final msg = StringBuffer();
    if (resultado.totalAlteracoes == 0) {
      msg.write('Nenhuma alteração no plano.');
    } else {
      if (resultado.estadiosFenologicosAtualizados > 0) {
        msg.write(
          '${resultado.estadiosFenologicosAtualizados} estádio(s) fenológico(s). ',
        );
      }
      if (resultado.operacionaisCriados > 0 ||
          resultado.operacionaisAtualizados > 0) {
        msg.write(
          'Operacionais: ${resultado.operacionaisCriados} novo(s), '
          '${resultado.operacionaisAtualizados} atualizado(s). ',
        );
      }
      if (resultado.fungicidasCriados > 0 ||
          resultado.fungicidasAtualizados > 0 ||
          resultado.fungicidasRemovidos > 0) {
        msg.write(
          'Fungicidas: ${resultado.fungicidasCriados} novo(s), '
          '${resultado.fungicidasAtualizados} atualizado(s), '
          '${resultado.fungicidasRemovidos} removido(s).',
        );
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg.toString().trim())),
    );
    ref.invalidate(planoDetailProvider(widget.planoId));
  }

  @override
  Widget build(BuildContext context) {
    final planoAsync = ref.watch(planoDetailProvider(widget.planoId));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: planoAsync.when(
        loading: () => const LoadingSkeleton(),
        error: (_, __) => const Center(child: Text('Erro ao carregar plano.')),
        data: (plano) {
          if (plano.fazendaId == null) {
            return _scaffold(
              context,
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'Vincule uma fazenda ao plano para planejar por talhão.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
          if (_loading) {
            return _scaffold(context, const LoadingSkeleton());
          }
          if (_porTalhao.isEmpty) {
            return _scaffold(
              context,
              const EmptyStateWidget(
                icon: PhosphorIconsRegular.gridFour,
                title: 'Sem talhões',
                subtitle: 'Cadastre talhões na fazenda vinculada ao plano.',
              ),
            );
          }

          return _scaffold(
            context,
            ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  'Informe a data de plantio por talhão. Cultivar vem do vínculo Semente ↔ Talhão.',
                  style: AppTypography.caption.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                ..._porTalhao.entries
                    .where(
                      (e) =>
                          widget.talhaoId == null || e.key == widget.talhaoId,
                    )
                    .map((entry) {
                  final talhaoId = entry.key;
                  final params = entry.value;
                  final entity = TalhaoSafraEntity(
                    id: params.id,
                    planoId: widget.planoId,
                    talhaoId: talhaoId,
                    cultura: params.cultura,
                    cultivar: params.materialCultivar,
                    dataPlantio: params.dataPlantio,
                    parametros: parametrosFromCronograma(params),
                    programaOperacionalIds: params.programaOperacionalIds,
                  );
                  final linhas = entity.linhaTempoCalculada();
                  final titulo = entity.tituloCronograma;
                  final expanded = _expanded.contains(talhaoId);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: AccordionSection(
                      title: _talhaoLabel(talhaoId),
                      subtitle: params.materialCultivar.isEmpty
                          ? AppFormatters.data(params.dataPlantio)
                          : '${params.materialCultivar} · ${AppFormatters.data(params.dataPlantio)}',
                      isExpanded: expanded,
                      onToggle: (v) {
                        setState(() {
                          if (v) {
                            _expanded.add(talhaoId);
                          } else {
                            _expanded.remove(talhaoId);
                          }
                        });
                      },
                      child: _TalhaoSafraForm(
                        params: params,
                        catalogo: _catalogo,
                        culturas: AppConstants.culturas,
                        cultivaresVinculadas:
                            _cultivaresPorTalhao[talhaoId] ?? const [],
                        onChanged: (p) => _patch(talhaoId, p),
                        tituloTabela: titulo,
                        linhas: linhas,
                        resumo: resumoCronogramaSoja(params),
                        roteiroAtribuido: entity.roteiroAtribuido,
                        onAtribuirRoteiro: () => _atribuirRoteiro(talhaoId),
                        onVerCardsNoPlano: entity.roteiroAtribuido
                            ? () => context.push(
                                  AppRoutes.planCanvasPath(
                                    widget.planoId,
                                    talhaoId: talhaoId,
                                  ),
                                )
                            : null,
                        onSync: () => _sync(talhaoId),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  String _talhaoLabel(String talhaoId) {
    final nome = _talhaoNomes[talhaoId] ?? 'Talhão';
    return nome;
  }

  Widget _scaffold(BuildContext context, Widget body) {
    return Column(
      children: [
        CupertinoNavigationBar(
          middle: Text(
            widget.talhaoId != null
                ? (_talhaoNomes[widget.talhaoId] ?? 'Cronograma do talhão')
                : 'Cronograma por talhão',
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.pop(),
            child: const PhosphorIcon(
              PhosphorIconsRegular.caretLeft,
              size: 22,
              color: AppColors.primary,
            ),
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}

class _TalhaoSafraForm extends StatelessWidget {
  const _TalhaoSafraForm({
    required this.params,
    required this.catalogo,
    required this.culturas,
    required this.cultivaresVinculadas,
    required this.onChanged,
    required this.tituloTabela,
    required this.linhas,
    required this.resumo,
    required this.roteiroAtribuido,
    required this.onAtribuirRoteiro,
    this.onVerCardsNoPlano,
    required this.onSync,
  });

  final CronogramaSojaParametros params;
  final List<ProdutoCatalogoEntity> catalogo;
  final List<String> culturas;
  final List<String> cultivaresVinculadas;
  final ValueChanged<CronogramaSojaParametros> onChanged;
  final String tituloTabela;
  final List<LinhaTempoSojaItem> linhas;
  final String resumo;
  final bool roteiroAtribuido;
  final VoidCallback onAtribuirRoteiro;
  final VoidCallback? onVerCardsNoPlano;
  final VoidCallback onSync;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CultivarTalhaoSelector(
          label: 'Material / Cultivar',
          value: params.materialCultivar,
          opcoesVinculadas: cultivaresVinculadas,
          onChanged: (v) => onChanged(
            aplicarDaeAoEscolherCultivar(
              params: params,
              cultivar: v,
              catalogo: catalogo,
            ),
          ),
        ),
        _dateField(context),
        _intField(
          context,
          label: 'Dias para emergência',
          value: params.diasEmergencia,
          onChanged: (v) => onChanged(params.copyWith(diasEmergencia: v)),
        ),
        _intField(
          context,
          label: 'DAE do pós-emergente',
          value: params.daePosEmergente,
          onChanged: (v) => onChanged(params.copyWith(daePosEmergente: v)),
        ),
        _intField(
          context,
          label: 'Recuperação pós-emergente',
          value: params.diasRecuperacaoPosEmergente,
          onChanged: (v) =>
              onChanged(params.copyWith(diasRecuperacaoPosEmergente: v)),
        ),
        _intField(
          context,
          label: 'Total de aplicações de fungicida',
          value: params.totalAplicacoesFungicida,
          onChanged: (v) =>
              onChanged(params.copyWith(totalAplicacoesFungicida: v)),
        ),
        if (params.totalAplicacoesFungicida > 1)
          _intField(
            context,
            label: 'Intervalo entre fungicidas',
            value: params.intervaloFungicidaDias,
            onChanged: (v) =>
                onChanged(params.copyWith(intervaloFungicidaDias: v)),
          ),
        _intField(
          context,
          label: 'Ciclo da cultivar (DAE maturação)',
          value: params.daeMaturacaoCiclo,
          onChanged: (v) => onChanged(params.copyWith(daeMaturacaoCiclo: v)),
        ),
        if (resolverDaeMaturacaoCultivar(
              params.materialCultivar,
              catalogo,
            ) !=
            null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              'Catálogo de sementes: '
              '${resolverDaeMaturacaoCultivar(params.materialCultivar, catalogo)} dias '
              '(editável)',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
                fontSize: 11,
              ),
            ),
          ),
        _intField(
          context,
          label: 'Dessecação pré-plantio (dias antes do plantio)',
          value: params.diasDessecacaoPrePlantio,
          onChanged: (v) =>
              onChanged(params.copyWith(diasDessecacaoPrePlantio: v)),
        ),
        _intField(
          context,
          label: 'Dias antes do R8 para dessecante (R7)',
          value: params.diasAntesR8Dessecante,
          onChanged: (v) =>
              onChanged(params.copyWith(diasAntesR8Dessecante: v)),
        ),
        _intField(
          context,
          label: 'Antecipação real da colheita',
          value: params.diasAntecipacaoColheitaReal,
          onChanged: (v) =>
              onChanged(params.copyWith(diasAntecipacaoColheitaReal: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        if (!roteiroAtribuido)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              onPressed: onAtribuirRoteiro,
              child: const Text('Atribuir roteiro do plano a este talhão'),
            ),
          )
        else ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              'Roteiro do plano atribuído — o cronograma só atualiza datas '
              'nos cards deste talhão.',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
          if (onVerCardsNoPlano != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                onPressed: onVerCardsNoPlano,
                child: const Text('Ver cards deste talhão no plano'),
              ),
            ),
        ],
        CronogramaSojaTabela(
          titulo: tituloTabela,
          linhas: linhas,
          resumo: resumo,
        ),
        const SizedBox(height: AppSpacing.md),
        CupertinoButton.filled(
          onPressed: roteiroAtribuido ? onSync : null,
          child: const Text('Atualizar datas no plano'),
        ),
      ],
    );
  }

  Widget _dateField(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Data de plantio',
        style: AppTypography.caption.copyWith(color: context.appTextSecondary),
      ),
      subtitle: Text(AppFormatters.data(params.dataPlantio)),
      trailing: const Icon(Icons.calendar_today, size: 18),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: params.dataPlantio,
          firstDate: DateTime(2020),
          lastDate: DateTime(2040),
          locale: const Locale('pt', 'BR'),
        );
        if (picked != null) {
          onChanged(
            params.copyWith(
              dataPlantio: DateTime(picked.year, picked.month, picked.day),
            ),
          );
        }
      },
    );
  }

  Widget _intField(
    BuildContext context, {
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: AppTypography.caption.copyWith(color: context.appTextSecondary),
      ),
      trailing: SizedBox(
        width: 72,
        child: TextFormField(
          initialValue: '$value',
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          onChanged: (raw) {
            final n = int.tryParse(raw);
            if (n != null) onChanged(n);
          },
        ),
      ),
    );
  }
}
