import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/categoria_referencia.dart';
import '../../../../core/constants/references_book_accents.dart';
import '../../../../core/widgets/references_book_icon.dart';
import '../../../../core/utils/extensions.dart';
import '../../../references/data/circular_fungicidas_data.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/plano_entity.dart';
import '../providers/estadio_referencias_content_provider.dart';
import 'categoria_bottom_sheet.dart';
import 'referencia_display_mapper.dart';

/// Categorias do livro padrão (não monetizadas).
const _standardCategorias = <CategoriaReferencia>[
  CategoriaReferencia.doencas,
  CategoriaReferencia.insetos,
  CategoriaReferencia.nutricao,
  CategoriaReferencia.fisiologia,
];

/// Qual livro está aberto num card (atalhos exibidos abaixo dele).
enum LivroReferencias { padrao, circular }

/// Livro aberto por estádio. Toque no mesmo livro fecha; no outro, troca.
final livroAbertoProvider = StateProvider.autoDispose
    .family<LivroReferencias?, String>((ref, estadioId) => null);

typedef AddProdutoFromReferencia = Future<void> Function(
  EstadioEntity estadio, {
  required String nome,
  required String produtoCategoria,
  required double areaHa,
});

void _alternarLivro(WidgetRef ref, String estadioId, LivroReferencias livro) {
  final n = ref.read(livroAbertoProvider(estadioId).notifier);
  n.state = n.state == livro ? null : livro;
}

/// Cluster: livro padrão + livro dourado (Circular técnica / CESB) lado a lado.
/// Tocar num livro abre/fecha os atalhos em [StageReferencesStrip].
class StageReferencesButton extends ConsumerWidget {
  const StageReferencesButton({
    super.key,
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
    this.compact = false,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final AddProdutoFromReferencia onAddProdutoFromReferencia;

  /// Versão compacta para o header colapsado do estádio (ao lado do badge V5).
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StandardReferencesBook(
          estadio: estadio,
          plano: plano,
          compact: compact,
          onAddProdutoFromReferencia: onAddProdutoFromReferencia,
        ),
        SizedBox(width: compact ? 4 : 6),
        _CircularTecnicaBook(
          estadio: estadio,
          plano: plano,
          compact: compact,
          onAddProdutoFromReferencia: onAddProdutoFromReferencia,
        ),
      ],
    );
  }
}

// ── Livro padrão (outline) — Doenças / Insetos / Nutrição / Fisiologia ───────

class _StandardReferencesBook extends ConsumerWidget {
  const _StandardReferencesBook({
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
    required this.compact,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final AddProdutoFromReferencia onAddProdutoFromReferencia;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync =
        ref.watch(estadioReferenciasContentMapProvider(estadio.codigo));
    final aberto =
        ref.watch(livroAbertoProvider(estadio.id)) == LivroReferencias.padrao;

    return contentAsync.when(
      data: (contentMap) {
        final hasContent =
            _standardCategorias.any((cat) => contentMap[cat] == true);
        return ReferencesBookIcon(
          accent: context.appTextPrimary,
          enabled: hasContent,
          compact: compact,
          filled: false,
          selected: aberto,
          onTap: hasContent
              ? () => _alternarLivro(ref, estadio.id, LivroReferencias.padrao)
              : null,
        );
      },
      loading: () => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
      ),
      error: (_, __) => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
      ),
    );
  }
}

// ── Livro dourado — Circular técnica + CESB (trilha monetizável) ─────────────

class _CircularTecnicaBook extends ConsumerWidget {
  const _CircularTecnicaBook({
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
    required this.compact,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final AddProdutoFromReferencia onAddProdutoFromReferencia;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync =
        ref.watch(estadioReferenciasContentMapProvider(estadio.codigo));
    final hasCircular =
        CircularFungicidasData.hasContentForStage(estadio.codigo);
    final aberto =
        ref.watch(livroAbertoProvider(estadio.id)) == LivroReferencias.circular;

    return contentAsync.when(
      data: (contentMap) {
        final hasCesb = contentMap[CategoriaReferencia.cesb] == true;
        final hasContent = hasCircular || hasCesb;
        return ReferencesBookIcon(
          accent: ReferencesBookAccents.fungicidas,
          enabled: hasContent,
          compact: compact,
          filled: true,
          selected: aberto,
          onTap: hasContent
              ? () =>
                  _alternarLivro(ref, estadio.id, LivroReferencias.circular)
              : null,
        );
      },
      loading: () => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
        filled: true,
      ),
      error: (_, __) => ReferencesBookIcon(
        accent: AppColors.textDisabled,
        enabled: false,
        compact: compact,
        filled: true,
      ),
    );
  }
}

// ── Atalhos abaixo do card (substituem os sheets de escolha) ─────────────────

/// Faixa de atalhos do livro aberto, logo abaixo do card do estádio.
/// Mesmos ícones das antigas listas: categorias coloridas (livro padrão) ou
/// livro dourado (Circular fungicidas / Campeões CESB).
class StageReferencesStrip extends ConsumerWidget {
  const StageReferencesStrip({
    super.key,
    required this.estadio,
    required this.plano,
    required this.onAddProdutoFromReferencia,
  });

  final EstadioEntity estadio;
  final PlanoEntity plano;
  final AddProdutoFromReferencia onAddProdutoFromReferencia;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final livro = ref.watch(livroAbertoProvider(estadio.id));
    final contentMap = ref
            .watch(estadioReferenciasContentMapProvider(estadio.codigo))
            .valueOrNull ??
        const <CategoriaReferencia, bool>{};

    Widget? conteudo;
    if (livro == LivroReferencias.padrao) {
      conteudo = _Faixa(
        key: const ValueKey('padrao'),
        titulo: 'Referências',
        estadioCodigo: estadio.codigo,
        corTitulo: context.appTextPrimary,
        itens: [
          for (final cat in _standardCategorias)
            _Atalho(
              rotulo: cat.label,
              icone: _IconeCategoria(cat),
              onTap: contentMap[cat] == true
                  ? () => _abrirCategoria(context, ref, cat)
                  : null,
            ),
        ],
      );
    } else if (livro == LivroReferencias.circular) {
      final hasCircular =
          CircularFungicidasData.hasContentForStage(estadio.codigo);
      final hasCesb = contentMap[CategoriaReferencia.cesb] == true;
      conteudo = _Faixa(
        key: const ValueKey('circular'),
        titulo: 'Circular técnica',
        estadioCodigo: estadio.codigo,
        corTitulo: ReferencesBookAccents.fungicidas,
        itens: [
          _Atalho(
            rotulo: 'Circular\nfungicidas',
            corRotulo: ReferencesBookAccents.fungicidas,
            icone: const _IconeLivroDourado(),
            onTap: hasCircular ? () => _abrirCircular(context) : null,
          ),
          _Atalho(
            rotulo: 'Campeões\nCESB',
            corRotulo: ReferencesBookAccents.cesb,
            icone: const _IconeLivroDourado(),
            onTap: hasCesb ? () => _abrirCesb(context, ref) : null,
          ),
        ],
      );
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: conteudo ?? const SizedBox(width: double.infinity),
      ),
    );
  }

  Future<void> _abrirCategoria(
    BuildContext context,
    WidgetRef ref,
    CategoriaReferencia categoria,
  ) async {
    final itens = await ref.read(
      referenciasDisplayByCategoriaProvider(
        categoria: categoria,
        estadioCodigo: estadio.codigo,
      ).future,
    );
    if (!context.mounted) return;
    await CategoriaBottomSheet.show(
      context: context,
      categoria: categoria,
      estadioCodigo: estadio.codigo,
      itens: itens,
      onUsarNoPlano: (item) async {
        if (context.mounted) Navigator.of(context).pop();
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: categoria.filtroCatalogo ?? 'Geral',
          areaHa: plano.areaHaTotal,
        );
      },
    );
  }

  Future<void> _abrirCesb(BuildContext context, WidgetRef ref) async {
    final itens = await ref.read(
      referenciasDisplayByCategoriaProvider(
        categoria: CategoriaReferencia.cesb,
        estadioCodigo: estadio.codigo,
      ).future,
    );
    if (!context.mounted) return;
    await CategoriaBottomSheet.show(
      context: context,
      categoria: CategoriaReferencia.cesb,
      estadioCodigo: estadio.codigo,
      titleOverride: 'Campeões CESB',
      subtitleOverride: 'Manejo dos produtores recordistas',
      accentOverride: ReferencesBookAccents.cesb,
      itens: itens,
      onUsarNoPlano: (item) async {
        if (context.mounted) Navigator.of(context).pop();
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: 'Geral',
          areaHa: plano.areaHaTotal,
        );
      },
    );
  }

  Future<void> _abrirCircular(BuildContext context) async {
    final entry = CircularFungicidasData.entryForStage(estadio.codigo);
    if (entry == null || !context.mounted) return;
    final itens = ReferenciaDisplayMapper.fromCircularEntry(entry);
    await CategoriaBottomSheet.show(
      context: context,
      categoria: CategoriaReferencia.doencas,
      estadioCodigo: estadio.codigo,
      titleOverride: 'Circular técnica',
      subtitleOverride: 'Estádio → doença → fungicida',
      accentOverride: ReferencesBookAccents.fungicidas,
      itens: itens,
      onUsarNoPlano: (item) async {
        if (context.mounted) Navigator.of(context).pop();
        await onAddProdutoFromReferencia(
          estadio,
          nome: item.titulo,
          produtoCategoria: 'Fungicida',
          areaHa: plano.areaHaTotal,
        );
      },
    );
  }
}

/// Bandeja dos atalhos: título curto + ícones lado a lado (menu de navegação).
class _Faixa extends StatelessWidget {
  const _Faixa({
    super.key,
    required this.titulo,
    required this.estadioCodigo,
    required this.corTitulo,
    required this.itens,
  });

  final String titulo;
  final String estadioCodigo;
  final Color corTitulo;
  final List<Widget> itens;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        10,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: context.appBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: titulo,
                  style: AppTypography.caption.copyWith(
                    color: corTitulo,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '  ·  Estádio $estadioCodigo',
                  style: AppTypography.caption.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final item in itens) Expanded(child: item),
              // Mantém a largura de 4 colunas mesmo com 2 atalhos.
              for (var i = itens.length; i < 4; i++) const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Atalho extends StatelessWidget {
  const _Atalho({
    required this.rotulo,
    required this.icone,
    required this.onTap,
    this.corRotulo,
  });

  final String rotulo;
  final Widget icone;
  final VoidCallback? onTap;
  final Color? corRotulo;

  @override
  Widget build(BuildContext context) {
    final ativo = onTap != null;
    return Semantics(
      button: true,
      enabled: ativo,
      label: rotulo.replaceAll('\n', ' '),
      child: Opacity(
        opacity: ativo ? 1 : 0.35,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                icone,
                const SizedBox(height: 6),
                Text(
                  rotulo,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppTypography.label.copyWith(
                    fontWeight: FontWeight.w600,
                    color: corRotulo ?? context.appTextPrimary,
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

/// Mesmo ícone das listas antigas: quadrado colorido da categoria.
class _IconeCategoria extends StatelessWidget {
  const _IconeCategoria(this.categoria);

  final CategoriaReferencia categoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: categoria.color,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Center(
        child: PhosphorIcon(categoria.icone, color: Colors.white, size: 24),
      ),
    );
  }
}

/// Mesmo ícone das listas antigas: livro dourado em fundo escuro.
class _IconeLivroDourado extends StatelessWidget {
  const _IconeLivroDourado();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.refBookFungicidasSurface,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: AppColors.refBookFungicidasDark.withValues(alpha: 0.5),
        ),
      ),
      child: const Center(
        child: PhosphorIcon(
          PhosphorIconsFill.bookOpen,
          color: ReferencesBookAccents.fungicidas,
          size: 24,
        ),
      ),
    );
  }
}
