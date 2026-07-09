import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../catalog/domain/entities/produto_catalogo_entity.dart';
import '../../../catalog/presentation/widgets/produto_search_dropdown.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import 'area_selector_widget.dart';
import '../../../../core/utils/extensions.dart';

// ── Constantes ───────────────────────────────────────────────────────────────

const _unidades = ['L/ha', 'mL/ha', 'kg/ha', 'g/ha', 'unid/ha'];

// ── ProdutoPanel ─────────────────────────────────────────────────────────────

/// Bottom sheet para adicionar ou editar um ProdutoAplicacao.
///
/// Aberto diretamente ao tocar em "Adicionar produto" ou em um produto existente.
class ProdutoPanel extends ConsumerStatefulWidget {
  const ProdutoPanel({
    super.key,
    required this.estadioId,
    required this.areaHaFazenda,
    required this.fazendaNome,
    required this.talhoes,
    this.produtoInicial,
    this.nomeSugerido,
    this.categoriaSugerida,
    required this.onSalvar,
  });

  final String estadioId;
  final double areaHaFazenda;
  final String fazendaNome;
  final List<TalhaoOption> talhoes;

  /// Produto existente (modo edição). Null = adicionar novo.
  final ProdutoAplicacaoEntity? produtoInicial;

  /// Pré-preenche o nome ao adicionar (ex.: referência técnica).
  final String? nomeSugerido;

  /// Pré-preenche a categoria ao adicionar via referência.
  final String? categoriaSugerida;

  final void Function(Map<String, dynamic> dados) onSalvar;

  /// Abre o painel de produto.
  static Future<void> show({
    required BuildContext context,
    required String estadioId,
    required double areaHaFazenda,
    required String fazendaNome,
    required List<TalhaoOption> talhoes,
    ProdutoAplicacaoEntity? produtoInicial,
    String? nomeSugerido,
    String? categoriaSugerida,
    required void Function(Map<String, dynamic>) onSalvar,
  }) {
    return showAppBottomSheet(
      context: context,
      builder: (_) => ProdutoPanel(
        estadioId: estadioId,
        areaHaFazenda: areaHaFazenda,
        fazendaNome: fazendaNome,
        talhoes: talhoes,
        produtoInicial: produtoInicial,
        nomeSugerido: nomeSugerido,
        categoriaSugerida: categoriaSugerida,
        onSalvar: onSalvar,
      ),
    );
  }

  @override
  ConsumerState<ProdutoPanel> createState() => _ProdutoPanelState();
}

class _ProdutoPanelState extends ConsumerState<ProdutoPanel> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _doseCtrl = TextEditingController();
  final _overrideCtrl = TextEditingController();
  final _motivoCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();

  late String _unidade;
  late double _areaHa;
  bool _overrideAtivo = false;
  String _categoriaSelecionada = 'Geral';

  bool get _isEdit => widget.produtoInicial != null;

  @override
  void initState() {
    super.initState();
    final p = widget.produtoInicial;
    if (p != null) {
      // Modo edição — preenche campos com dados existentes
      _nomeCtrl.text = p.produtoNome;
      _categoriaSelecionada = p.produtoCategoria;
      _doseCtrl.text = p.dose.toString();
      _unidade = p.doseUnidade;
      _areaHa = p.areaHa;
      _overrideAtivo = p.isOverride;
      if (p.totalOverride != null) {
        _overrideCtrl.text = p.totalOverride!.toString();
      }
      _motivoCtrl.text = p.overrideMotivo ?? '';
      _obsCtrl.text = p.observacao ?? '';
    } else {
      _unidade = _unidades.first;
      _areaHa = widget.areaHaFazenda;
      _categoriaSelecionada = widget.categoriaSugerida ?? 'Geral';
      if (widget.nomeSugerido != null) {
        _nomeCtrl.text = widget.nomeSugerido!;
      }
    }
  }

  void _onCatalogoSelected(ProdutoCatalogoEntity produto) {
    _nomeCtrl.text = produto.nomeComercial;
    _categoriaSelecionada = produto.categoria;
    if (_unidades.contains(produto.unidadePadrao)) {
      _unidade = produto.unidadePadrao;
    }
    final doseSugerida = produto.doseMin != null &&
            produto.doseMax != null &&
            produto.doseMin == produto.doseMax
        ? produto.doseMin!
        : (produto.doseMin ?? 0);
    if (doseSugerida > 0) {
      _doseCtrl.text = doseSugerida.toString();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _doseCtrl.dispose();
    _overrideCtrl.dispose();
    _motivoCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  double get _dose => double.tryParse(_doseCtrl.text.replaceAll(',', '.')) ?? 0;

  double get _totalCalculado => _dose * _areaHa;

  double? get _totalOverride {
    if (!_overrideAtivo) return null;
    return double.tryParse(_overrideCtrl.text.replaceAll(',', '.'));
  }

  void _salvar() {
    if (_nomeCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o produto')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    widget.onSalvar({
      'estadioId': widget.estadioId,
      'produtoNome': _nomeCtrl.text.trim(),
      'produtoCategoria': _isEdit
          ? widget.produtoInicial!.produtoCategoria
          : _categoriaSelecionada,
      'dose': _dose,
      'doseUnidade': _unidade,
      'areaHa': _areaHa,
      'totalOverride': _totalOverride,
      'overrideMotivo': _overrideAtivo && _motivoCtrl.text.isNotEmpty
          ? _motivoCtrl.text.trim()
          : null,
      'observacao': _obsCtrl.text.isNotEmpty ? _obsCtrl.text.trim() : null,
    });

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollCtrl) => AppBottomSheetScaffold(
        header: _PanelHeader(isEdit: _isEdit),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            controller: scrollCtrl,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Nome do produto (catálogo)
                    const _FieldLabel('Produto'),
                    const SizedBox(height: 6),
                    ProdutoSearchDropdown(
                      controller: _nomeCtrl,
                      hintText: 'Buscar no catálogo...',
                      onSelected: _onCatalogoSelected,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Dose + unidade
                    const _FieldLabel('Dose'),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: _PanelTextField(
                            controller: _doseCtrl,
                            hint: '0,0',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9,.]'),
                              ),
                              LengthLimitingTextInputFormatter(7),
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Informe a dose';
                              }
                              if (double.tryParse(v.replaceAll(',', '.')) ==
                                  null) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _UnidadeDropdown(
                          value: _unidade,
                          items: _unidades,
                          onChanged: (v) =>
                              setState(() => _unidade = v ?? _unidade),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Área de aplicação
                    AreaSelectorWidget(
                      areaHaFazenda: widget.areaHaFazenda,
                      fazendaNome: widget.fazendaNome,
                      talhoes: widget.talhoes,
                      initialArea: _areaHa,
                      onChanged: (v) => setState(() => _areaHa = v),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Total calculado
                    _TotalCalculado(
                      dose: _dose,
                      areaHa: _areaHa,
                      unidade: _unidade,
                      totalCalculado: _totalCalculado,
                      overrideAtivo: _overrideAtivo,
                      totalOverride: _totalOverride,
                      onToggleOverride: (v) =>
                          setState(() => _overrideAtivo = v),
                    ),

                    // Campos de override
                    if (_overrideAtivo) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: _PanelTextField(
                              controller: _overrideCtrl,
                              hint: 'Total manual',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9,.]'),
                                ),
                                LengthLimitingTextInputFormatter(7),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            _unidade.split('/').first,
                            style: AppTypography.body.copyWith(
                              color: context.appTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _PanelTextField(
                        controller: _motivoCtrl,
                        hint: 'Motivo do ajuste (ex: Estoque limitado)',
                      ),
                    ],

                    const SizedBox(height: AppSpacing.md),

                    // Observação
                    const _FieldLabel('Observação (opcional)'),
                    const SizedBox(height: 6),
                    _PanelTextField(
                      controller: _obsCtrl,
                      hint: 'Anotações, cuidados, etc.',
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Botões
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              side: BorderSide(
                                color: context.appBorder,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancelar',
                              style: AppTypography.button.copyWith(
                                color: context.appTextPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: _salvar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              _isEdit ? 'Atualizar' : 'Adicionar',
                              style: AppTypography.button,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widgets internos do painel ───────────────────────────────────────────────

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text(
            isEdit ? 'Editar Produto' : 'Adicionar Produto',
            style: AppTypography.h3,
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.label.copyWith(color: context.appTextSecondary),
    );
  }
}

class _PanelTextField extends StatelessWidget {
  const _PanelTextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.body.copyWith(color: context.appTextDisabled),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.appBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.appBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}

class _UnidadeDropdown extends StatelessWidget {
  const _UnidadeDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: context.appBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items
              .map(
                (u) => DropdownMenuItem(
                  value: u,
                  child: Text(u, style: AppTypography.body),
                ),
              )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          isDense: true,
        ),
      ),
    );
  }
}

class _TotalCalculado extends StatelessWidget {
  const _TotalCalculado({
    required this.dose,
    required this.areaHa,
    required this.unidade,
    required this.totalCalculado,
    required this.overrideAtivo,
    required this.totalOverride,
    required this.onToggleOverride,
  });

  final double dose;
  final double areaHa;
  final String unidade;
  final double totalCalculado;
  final bool overrideAtivo;
  final double? totalOverride;
  final void Function(bool) onToggleOverride;

  String get _unit => unidade.split('/').first;

  @override
  Widget build(BuildContext context) {
    final totalFinal = totalOverride ?? totalCalculado;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total',
                style: AppTypography.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '$dose $unidade × ${areaHa.toStringAsFixed(1)} ha',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${totalFinal.toStringAsFixed(2)} $_unit',
            style: AppTypography.h3.copyWith(
              color: overrideAtivo ? AppColors.warning : AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Switch.adaptive(
                value: overrideAtivo,
                onChanged: onToggleOverride,
                activeThumbColor: AppColors.warning,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Ajuste manual do total',
                style: AppTypography.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
