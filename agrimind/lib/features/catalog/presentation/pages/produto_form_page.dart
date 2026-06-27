import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/produto_catalogo_entity.dart';
import '../providers/catalog_provider.dart';
import '../../../../core/utils/extensions.dart';

/// Formulário de criação e edição de produto do catálogo.
class ProdutoFormPage extends ConsumerStatefulWidget {
  const ProdutoFormPage({super.key, this.produtoId});

  final String? produtoId;

  @override
  ConsumerState<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends ConsumerState<ProdutoFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeCtrl;
  late final TextEditingController _iaCtrl;
  late final TextEditingController _doseMinCtrl;
  late final TextEditingController _doseMaxCtrl;
  late final TextEditingController _precoCtrl;
  late final TextEditingController _fabricanteCtrl;
  late final TextEditingController _obsCtrl;

  String? _categoria;
  String _unidade = 'L/ha';
  bool _loading = false;
  bool get _isEdit => widget.produtoId != null;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController();
    _iaCtrl = TextEditingController();
    _doseMinCtrl = TextEditingController();
    _doseMaxCtrl = TextEditingController();
    _precoCtrl = TextEditingController();
    _fabricanteCtrl = TextEditingController();
    _obsCtrl = TextEditingController();

    if (_isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadProduto());
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _iaCtrl.dispose();
    _doseMinCtrl.dispose();
    _doseMaxCtrl.dispose();
    _precoCtrl.dispose();
    _fabricanteCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProduto() async {
    final produtos = await ref.read(catalogNotifierProvider.future);
    final produto = produtos.where((p) => p.id == widget.produtoId).firstOrNull;
    if (produto != null && mounted) {
      _nomeCtrl.text = produto.nomeComercial;
      _iaCtrl.text = produto.ingredienteAtivo ?? '';
      _doseMinCtrl.text = produto.doseMin?.toString() ?? '';
      _doseMaxCtrl.text = produto.doseMax?.toString() ?? '';
      _precoCtrl.text = produto.precoUnitario?.toString() ?? '';
      _fabricanteCtrl.text = produto.fabricante ?? '';
      _obsCtrl.text = produto.observacoes ?? '';
      setState(() {
        _categoria = produto.categoria;
        _unidade = produto.unidadePadrao;
      });
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final notifier = ref.read(catalogNotifierProvider.notifier);

      if (_isEdit) {
        final produtos = await ref.read(catalogNotifierProvider.future);
        final atual =
            produtos.where((p) => p.id == widget.produtoId).firstOrNull;
        if (atual == null) return;
        await notifier.updateProduto(
          atual.copyWith(
            nomeComercial: _nomeCtrl.text.trim(),
            ingredienteAtivo: _iaCtrl.text.isEmpty ? null : _iaCtrl.text.trim(),
            categoria: _categoria!,
            unidadePadrao: _unidade,
            doseMin: _doseMinCtrl.text.isEmpty
                ? null
                : double.tryParse(_doseMinCtrl.text),
            doseMax: _doseMaxCtrl.text.isEmpty
                ? null
                : double.tryParse(_doseMaxCtrl.text),
            precoUnitario: _precoCtrl.text.isEmpty
                ? null
                : double.tryParse(_precoCtrl.text),
            fabricante: _fabricanteCtrl.text.isEmpty
                ? null
                : _fabricanteCtrl.text.trim(),
            observacoes: _obsCtrl.text.isEmpty ? null : _obsCtrl.text.trim(),
            updatedAt: DateTime.now(),
          ),
        );
      } else {
        await notifier.create(
          ProdutoCatalogoEntity(
            id: '',
            nomeComercial: _nomeCtrl.text.trim(),
            ingredienteAtivo: _iaCtrl.text.isEmpty ? null : _iaCtrl.text.trim(),
            categoria: _categoria!,
            unidadePadrao: _unidade,
            doseMin: _doseMinCtrl.text.isEmpty
                ? null
                : double.tryParse(_doseMinCtrl.text),
            doseMax: _doseMaxCtrl.text.isEmpty
                ? null
                : double.tryParse(_doseMaxCtrl.text),
            precoUnitario: _precoCtrl.text.isEmpty
                ? null
                : double.tryParse(_precoCtrl.text),
            fabricante: _fabricanteCtrl.text.isEmpty
                ? null
                : _fabricanteCtrl.text.trim(),
            observacoes: _obsCtrl.text.isEmpty ? null : _obsCtrl.text.trim(),
            ativo: true,
            isSeed: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      }

      if (mounted) context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          child: PhosphorIcon(
            PhosphorIconsRegular.x,
            size: 20,
            color: context.appTextSecondary,
          ),
        ),
        title: Text(
          _isEdit ? 'Editar produto' : 'Novo produto',
          style: AppTypography.h3,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _loading ? null : _salvar,
              child: _loading
                  ? const CupertinoActivityIndicator()
                  : const Text(
                      'Salvar',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _Section(
              title: 'Identificação',
              children: [
                _Field(
                  label: 'Nome comercial *',
                  controller: _nomeCtrl,
                  hintText: 'Ex: Fox Xpro',
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Nome é obrigatório' : null,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: AppSpacing.sm),
                _Field(
                  label: 'Ingrediente ativo',
                  controller: _iaCtrl,
                  hintText: 'Ex: Trifloxistrobina + Protioconazol',
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: AppSpacing.sm),
                _DropField(
                  label: 'Categoria *',
                  value: _categoria,
                  hint: 'Selecionar categoria',
                  items: AppConstants.categoriasProduto,
                  onChanged: (v) => setState(() => _categoria = v),
                  validator: (v) =>
                      v == null ? 'Selecione uma categoria' : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                _Field(
                  label: 'Fabricante',
                  controller: _fabricanteCtrl,
                  hintText: 'Ex: Bayer',
                  textCapitalization: TextCapitalization.words,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _Section(
              title: 'Dose',
              children: [
                _DropField(
                  label: 'Unidade padrão',
                  value: _unidade,
                  hint: 'Selecionar unidade',
                  items: AppConstants.unidadesDose,
                  onChanged: (v) => setState(() => _unidade = v ?? 'L/ha'),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _Field(
                        label: 'Dose mínima',
                        controller: _doseMinCtrl,
                        hintText: '0.0',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        maxLength: 7,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _Field(
                        label: 'Dose máxima',
                        controller: _doseMaxCtrl,
                        hintText: '0.0',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        maxLength: 7,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _Section(
              title: 'Valores e observações',
              children: [
                _Field(
                  label: 'Preço unitário (R\$)',
                  controller: _precoCtrl,
                  hintText: '0.00',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  maxLength: 7,
                ),
                const SizedBox(height: AppSpacing.sm),
                _Field(
                  label: 'Observações',
                  controller: _obsCtrl,
                  hintText: 'Informações adicionais...',
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ── Componentes internos ──────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.xs),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.label.copyWith(
              color: context.appTextSecondary,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appBorder),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                AppTypography.caption.copyWith(color: context.appTextSecondary)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          maxLength: maxLength,
          maxLines: maxLines,
          style: AppTypography.body.copyWith(color: context.appTextPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                AppTypography.body.copyWith(color: context.appTextDisabled),
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.appBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.appBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class _DropField extends StatelessWidget {
  const _DropField({
    required this.label,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                AppTypography.caption.copyWith(color: context.appTextSecondary)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          initialValue: value,
          validator: validator,
          hint: Text(hint,
              style:
                  AppTypography.body.copyWith(color: context.appTextDisabled)),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.appBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.appBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: AppColors.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 10,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: AppTypography.body
                            .copyWith(color: context.appTextPrimary)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
