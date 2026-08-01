import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/fazenda_entity.dart';
import '../providers/clients_provider.dart';
import '../../../../core/utils/extensions.dart';

/// Formulário de criação e edição de fazenda.
class FarmFormPage extends ConsumerStatefulWidget {
  const FarmFormPage({
    super.key,
    required this.clienteId,
    this.fazendaId,
  });

  final String clienteId;
  final String? fazendaId;

  @override
  ConsumerState<FarmFormPage> createState() => _FarmFormPageState();
}

class _FarmFormPageState extends ConsumerState<FarmFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _safraCtrl;
  late final TextEditingController _municipioCtrl;
  String? _cultura;
  String? _uf;
  bool _loading = false;
  bool get _isEdit => widget.fazendaId != null;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController();
    _areaCtrl = TextEditingController();
    _safraCtrl = TextEditingController(text: '2025/26');
    _municipioCtrl = TextEditingController();

    if (_isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadFazenda());
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _areaCtrl.dispose();
    _safraCtrl.dispose();
    _municipioCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadFazenda() async {
    final fazendas =
        await ref.read(fazendasNotifierProvider(widget.clienteId).future);
    final fazenda = fazendas.where((f) => f.id == widget.fazendaId).firstOrNull;
    if (fazenda != null && mounted) {
      _nomeCtrl.text = fazenda.nome;
      _areaCtrl.text = fazenda.areaHa.toString();
      _safraCtrl.text = fazenda.safra;
      _municipioCtrl.text = fazenda.municipio ?? '';
      setState(() {
        _cultura = fazenda.cultura;
        _uf = fazenda.uf;
      });
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final notifier =
          ref.read(fazendasNotifierProvider(widget.clienteId).notifier);

      if (_isEdit) {
        final fazendas =
            await ref.read(fazendasNotifierProvider(widget.clienteId).future);
        final atual =
            fazendas.where((f) => f.id == widget.fazendaId).firstOrNull;
        if (atual == null) return;
        await notifier.updateFazenda(
          atual.copyWith(
            nome: _nomeCtrl.text.trim(),
            areaHa: double.parse(_areaCtrl.text),
            cultura: _cultura!,
            safra: _safraCtrl.text.trim(),
            municipio:
                _municipioCtrl.text.isEmpty ? null : _municipioCtrl.text.trim(),
            uf: _uf,
            updatedAt: DateTime.now(),
          ),
        );
      } else {
        await notifier.createFazenda(
          FazendaEntity(
            id: '',
            clienteId: widget.clienteId,
            nome: _nomeCtrl.text.trim(),
            areaHa: double.parse(_areaCtrl.text),
            cultura: _cultura!,
            safra: _safraCtrl.text.trim(),
            municipio:
                _municipioCtrl.text.isEmpty ? null : _municipioCtrl.text.trim(),
            uf: _uf,
            ativo: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            talhoes: const [],
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
          _isEdit ? 'Editar fazenda' : 'Nova fazenda',
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
            _buildSection('Dados da Fazenda', [
              _buildField(
                label: 'Nome *',
                controller: _nomeCtrl,
                hintText: 'Ex: Fazenda Boa Vista',
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nome é obrigatório' : null,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildField(
                label: 'Área total (ha) *',
                controller: _areaCtrl,
                hintText: '0000000',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxLength: 7,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Área é obrigatória';
                  if (double.tryParse(v) == null) return 'Valor inválido';
                  return null;
                },
              ),
            ]),
            const SizedBox(height: AppSpacing.md),
            _buildSection('Cultura e Safra', [
              _buildDropdown<String>(
                label: 'Cultura *',
                value: _cultura,
                hint: 'Selecionar cultura',
                items: AppConstants.culturas,
                itemLabel: (c) => c,
                validator: (v) => v == null ? 'Selecione a cultura' : null,
                onChanged: (v) => setState(() => _cultura = v),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildField(
                label: 'Safra *',
                controller: _safraCtrl,
                hintText: 'Ex: 2025/26',
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Safra é obrigatória' : null,
              ),
            ]),
            const SizedBox(height: AppSpacing.md),
            _buildSection('Localização', [
              _buildField(
                label: 'Município',
                controller: _municipioCtrl,
                hintText: 'Ex: Lucas do Rio Verde',
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildDropdown<String>(
                label: 'UF',
                value: _uf,
                hint: 'Selecionar estado',
                items: AppConstants.estadosBrasileiros,
                itemLabel: (uf) =>
                    '$uf — ${AppConstants.estadosNomes[uf] ?? uf}',
                onChanged: (v) => setState(() => _uf = v),
              ),
            ]),

            // ── Talhões (apenas em modo edição) ──────────────────────────
            if (_isEdit) ...[
              const SizedBox(height: AppSpacing.md),
              _TalhoesSection(
                clienteId: widget.clienteId,
                fazendaId: widget.fazendaId!,
              ),
            ],

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.caption
                .copyWith(color: context.appTextSecondary)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          maxLength: maxLength,
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

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required String hint,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
    FormFieldValidator<T>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.caption
                .copyWith(color: context.appTextSecondary)),
        const SizedBox(height: 4),
        DropdownButtonFormField<T>(
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
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 10,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(itemLabel(item),
                        style: AppTypography.body
                            .copyWith(color: context.appTextPrimary)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// ── Seção de talhões inline ───────────────────────────────────────────────────

class _TalhoesSection extends ConsumerWidget {
  const _TalhoesSection({
    required this.clienteId,
    required this.fazendaId,
  });

  final String clienteId;
  final String fazendaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talhoesAsync = ref.watch(talhoesNotifierProvider(fazendaId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TALHÕES',
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                  letterSpacing: 0.6,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push(
                  '/clients/$clienteId/farms/$fazendaId/talhoes/new',
                ),
                child: const Text(
                  '+ Adicionar',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        talhoesAsync.when(
          data: (talhoes) {
            if (talhoes.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.appBorder),
                ),
                child: Text(
                  'Nenhum talhão cadastrado',
                  style: AppTypography.body
                      .copyWith(color: context.appTextSecondary),
                ),
              );
            }
            return Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: talhoes
                  .map((t) => Chip(
                        label: Text(
                          '${t.nome} — ${t.areaHa} ha',
                          style: AppTypography.label
                              .copyWith(color: context.appTextPrimary),
                        ),
                        backgroundColor: AppColors.primaryLight,
                        deleteIconColor: context.appTextSecondary,
                        onDeleted: () => ref
                            .read(talhoesNotifierProvider(fazendaId).notifier)
                            .deleteTalhao(t.id),
                      ))
                  .toList(),
            );
          },
          loading: () => const CupertinoActivityIndicator(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}
