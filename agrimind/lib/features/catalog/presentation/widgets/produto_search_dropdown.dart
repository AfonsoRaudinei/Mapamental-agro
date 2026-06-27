import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/produto_catalogo_entity.dart';
import '../providers/catalog_provider.dart';
import 'categoria_badge.dart';
import '../../../../core/utils/extensions.dart';

/// Campo de busca com dropdown para selecionar produto do catálogo.
///
/// Uso:
/// ```dart
/// ProdutoSearchDropdown(
///   onSelected: (produto) { ... },
///   categoriaFilter: 'Fungicida', // opcional
///   onCadastrarNovo: (nome) { ... }, // abre ProdutoFormPage
/// )
/// ```
class ProdutoSearchDropdown extends ConsumerStatefulWidget {
  const ProdutoSearchDropdown({
    super.key,
    required this.onSelected,
    this.categoriaFilter,
    this.onCadastrarNovo,
    this.hintText = 'Buscar produto...',
    this.initialValue,
  });

  final ValueChanged<ProdutoCatalogoEntity> onSelected;
  final String? categoriaFilter;
  final ValueChanged<String>? onCadastrarNovo;
  final String hintText;
  final ProdutoCatalogoEntity? initialValue;

  @override
  ConsumerState<ProdutoSearchDropdown> createState() =>
      _ProdutoSearchDropdownState();
}

class _ProdutoSearchDropdownState extends ConsumerState<ProdutoSearchDropdown> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _showDropdown = false;
  String _query = '';

  // Debounce simples com delay
  DateTime? _lastType;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!.nomeComercial;
    }
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) setState(() => _showDropdown = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final now = DateTime.now();
    _lastType = now;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_lastType == now && mounted) {
        setState(() {
          _query = value;
          _showDropdown = true;
        });
      }
    });
  }

  void _selectProduto(ProdutoCatalogoEntity produto) {
    _controller.text = produto.nomeComercial;
    setState(() => _showDropdown = false);
    _focusNode.unfocus();
    widget.onSelected(produto);
  }

  void _cadastrarNovo() {
    final nome = _controller.text.trim();
    setState(() => _showDropdown = false);
    _focusNode.unfocus();
    widget.onCadastrarNovo?.call(nome);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Campo de busca
        Container(
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focusNode.hasFocus ? AppColors.primary : context.appBorder,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: PhosphorIcon(
                  PhosphorIconsRegular.magnifyingGlass,
                  size: 18,
                  color: context.appTextSecondary,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: _onChanged,
                  onTap: () => setState(() => _showDropdown = true),
                  style: AppTypography.body.copyWith(
                    color: context.appTextPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: AppTypography.body.copyWith(
                      color: context.appTextDisabled,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              if (_controller.text.isNotEmpty)
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _query = '';
                      _showDropdown = false;
                    });
                  },
                  child: PhosphorIcon(
                    PhosphorIconsRegular.x,
                    size: 16,
                    color: context.appTextSecondary,
                  ),
                ),
            ],
          ),
        ),
        // Dropdown
        if (_showDropdown)
          _DropdownContent(
            query: _query,
            categoriaFilter: widget.categoriaFilter,
            onSelectProduto: _selectProduto,
            onCadastrarNovo:
                widget.onCadastrarNovo != null ? _cadastrarNovo : null,
            digitado: _controller.text.trim(),
          ),
      ],
    );
  }
}

// ── Conteúdo do dropdown ──────────────────────────────────────────────────────

class _DropdownContent extends ConsumerWidget {
  const _DropdownContent({
    required this.query,
    required this.categoriaFilter,
    required this.onSelectProduto,
    required this.onCadastrarNovo,
    required this.digitado,
  });

  final String query;
  final String? categoriaFilter;
  final ValueChanged<ProdutoCatalogoEntity> onSelectProduto;
  final VoidCallback? onCadastrarNovo;
  final String digitado;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProdutos = ref.watch(
      searchProdutosProvider(query, categoria: categoriaFilter),
    );

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.xs),
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: asyncProdutos.when(
        data: (produtos) => _buildList(context, produtos),
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        error: (_, __) => Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            'Erro ao buscar produtos',
            style: AppTypography.body.copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<ProdutoCatalogoEntity> produtos) {
    // Filtra apenas ativos
    final ativos = produtos.where((p) => p.ativo).toList();

    if (ativos.isEmpty && digitado.length < 2) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Text(
          'Digite pelo menos 2 caracteres para buscar',
          style: AppTypography.caption.copyWith(color: context.appTextSecondary),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: ativos.length + (onCadastrarNovo != null ? 1 : 0),
      separatorBuilder: (_, __) => Divider(
        height: 1,
        indent: AppSpacing.md,
        color: context.appBorder,
      ),
      itemBuilder: (context, index) {
        // Último item: "Cadastrar novo"
        if (index == ativos.length) {
          return _CadastrarNovoTile(
            nome: digitado,
            onTap: onCadastrarNovo!,
          );
        }
        final produto = ativos[index];
        return _ProdutoDropdownTile(
          produto: produto,
          onTap: () => onSelectProduto(produto),
        );
      },
    );
  }
}

// ── Tile de produto no dropdown ───────────────────────────────────────────────

class _ProdutoDropdownTile extends StatelessWidget {
  const _ProdutoDropdownTile({
    required this.produto,
    required this.onTap,
  });

  final ProdutoCatalogoEntity produto;
  final VoidCallback onTap;

  String get _doseRange {
    if (produto.doseMin != null && produto.doseMax != null) {
      return '${produto.doseMin} – ${produto.doseMax} ${produto.unidadePadrao}';
    } else if (produto.doseMin != null) {
      return '≥${produto.doseMin} ${produto.unidadePadrao}';
    } else if (produto.doseMax != null) {
      return '≤${produto.doseMax} ${produto.unidadePadrao}';
    }
    return produto.unidadePadrao;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nomeComercial,
                    style: AppTypography.body.copyWith(
                      color: context.appTextPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _doseRange,
                    style: AppTypography.caption.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            CategoriaBadge(categoria: produto.categoria),
          ],
        ),
      ),
    );
  }
}

// ── Tile "Cadastrar novo" ─────────────────────────────────────────────────────

class _CadastrarNovoTile extends StatelessWidget {
  const _CadastrarNovoTile({
    required this.nome,
    required this.onTap,
  });

  final String nome;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        child: Row(
          children: [
            const PhosphorIcon(
              PhosphorIconsRegular.plus,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTypography.body.copyWith(color: AppColors.primary),
                  children: [
                    const TextSpan(text: 'Cadastrar '),
                    if (nome.isNotEmpty)
                      TextSpan(
                        text: '"$nome"',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    else
                      const TextSpan(text: 'novo produto'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
