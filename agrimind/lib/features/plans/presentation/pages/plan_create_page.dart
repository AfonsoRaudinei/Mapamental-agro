import 'package:flutter/cupertino.dart';
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
import '../../../../core/di/providers.dart';
import '../../../../core/router/app_routes.dart';
import '../../../clients/domain/entities/fazenda_entity.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../domain/entities/plano_entity.dart';
import '../providers/plans_list_provider.dart';
import '../../../../core/utils/extensions.dart';

/// Criação de Plano — Sprint 6.
class PlanCreatePage extends ConsumerStatefulWidget {
  const PlanCreatePage({super.key});

  @override
  ConsumerState<PlanCreatePage> createState() => _PlanCreatePageState();
}

class _PlanCreatePageState extends ConsumerState<PlanCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  late final TextEditingController _nomeCtrl;
  late final TextEditingController _safraCtrl;
  late final TextEditingController _areaCtrl;

  String _cultura = AppConstants.culturas.first;
  String? _clienteId;
  String? _fazendaId;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: 'Plano ${_cultura.toLowerCase()}');
    _safraCtrl = TextEditingController(text: _safraAtual());
    _areaCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _safraCtrl.dispose();
    _areaCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final area = _parseArea(_areaCtrl.text);
    if (area == null || area <= 0) return;

    setState(() => _loading = true);
    try {
      final clientes = await ref.read(clientsNotifierProvider.future);
      final cliente =
          clientes.where((item) => item.id == _clienteId).firstOrNull;
      final fazendas = _clienteId == null
          ? const <FazendaEntity>[]
          : await ref.read(fazendasNotifierProvider(_clienteId!).future);
      final fazenda =
          fazendas.where((item) => item.id == _fazendaId).firstOrNull;
      final now = DateTime.now();
      final plano = PlanoEntity(
        id: _uuid.v4(),
        nome: _nomeCtrl.text.trim(),
        cultura: _cultura,
        safra: _safraCtrl.text.trim(),
        areaHaTotal: area,
        status: AppConstants.statusRascunho,
        createdAt: now,
        updatedAt: now,
        clienteId: cliente?.id,
        clienteNome: cliente?.nome,
        fazendaId: fazenda?.id,
        fazendaNome: fazenda?.nome,
      );

      await ref.read(plansRepoProvider).create(plano);
      ref.invalidate(plansListNotifierProvider);

      if (mounted) context.go(AppRoutes.planCanvasPath(plano.id));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar plano: $error'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _applyFazenda(FazendaEntity? fazenda) {
    if (fazenda == null) return;
    setState(() {
      _fazendaId = fazenda.id;
      _cultura = fazenda.cultura;
      _safraCtrl.text = fazenda.safra;
      _areaCtrl.text = fazenda.areaHa.toStringAsFixed(1);
      if (_nomeCtrl.text.trim().isEmpty ||
          _nomeCtrl.text.startsWith('Plano ')) {
        _nomeCtrl.text = 'Plano ${fazenda.nome}';
      }
    });
  }

  double? _parseArea(String value) =>
      double.tryParse(value.trim().replaceAll(',', '.'));

  String _safraAtual() {
    final now = DateTime.now();
    final start = now.month >= 7 ? now.year : now.year - 1;
    return '$start/${(start + 1).toString().substring(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final clientesAsync = ref.watch(clientsNotifierProvider);
    final fazendasAsync = _clienteId == null
        ? const AsyncValue.data(<FazendaEntity>[])
        : ref.watch(fazendasNotifierProvider(_clienteId!));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _loading ? null : () => context.pop(),
          child: PhosphorIcon(
            PhosphorIconsRegular.x,
            size: 20,
            color: context.appTextSecondary,
          ),
        ),
        title: const Text('Novo plano', style: AppTypography.h3),
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
              title: 'Origem',
              children: [
                clientesAsync.when(
                  data: (clientes) => DropdownButtonFormField<String?>(
                    initialValue: _clienteId,
                    decoration: _inputDecoration(context, 'Cliente'),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Sem cliente vinculado'),
                      ),
                      ...clientes.map(
                        (cliente) => DropdownMenuItem<String?>(
                          value: cliente.id,
                          child: Text(cliente.nome),
                        ),
                      ),
                    ],
                    onChanged: _loading
                        ? null
                        : (value) => setState(() {
                              _clienteId = value;
                              _fazendaId = null;
                            }),
                  ),
                  loading: () => const CupertinoActivityIndicator(),
                  error: (_, __) => const Text('Erro ao carregar clientes'),
                ),
                const SizedBox(height: AppSpacing.sm),
                fazendasAsync.when(
                  data: (fazendas) => DropdownButtonFormField<String?>(
                    initialValue: _fazendaId,
                    decoration: _inputDecoration(context, 'Fazenda'),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Sem fazenda vinculada'),
                      ),
                      ...fazendas.map(
                        (fazenda) => DropdownMenuItem<String?>(
                          value: fazenda.id,
                          child: Text(fazenda.nome),
                        ),
                      ),
                    ],
                    onChanged: _loading || _clienteId == null
                        ? null
                        : (value) {
                            final fazenda = fazendas
                                .where((item) => item.id == value)
                                .firstOrNull;
                            _applyFazenda(fazenda);
                            if (value == null) {
                              setState(() => _fazendaId = null);
                            }
                          },
                  ),
                  loading: () => const CupertinoActivityIndicator(),
                  error: (_, __) => const Text('Erro ao carregar fazendas'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _Section(
              title: 'Plano',
              children: [
                _TextField(
                  label: 'Nome *',
                  controller: _nomeCtrl,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nome é obrigatório'
                      : null,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: AppSpacing.sm),
                DropdownButtonFormField<String>(
                  initialValue: _cultura,
                  decoration: _inputDecoration(context, 'Cultura'),
                  items: AppConstants.culturas
                      .map(
                        (cultura) => DropdownMenuItem<String>(
                          value: cultura,
                          child: Text(cultura),
                        ),
                      )
                      .toList(),
                  onChanged: _loading
                      ? null
                      : (value) => setState(() {
                            _cultura = value ?? _cultura;
                            if (_nomeCtrl.text.startsWith('Plano ')) {
                              _nomeCtrl.text =
                                  'Plano ${_cultura.toLowerCase()}';
                            }
                          }),
                ),
                const SizedBox(height: AppSpacing.sm),
                _TextField(
                  label: 'Safra *',
                  controller: _safraCtrl,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Safra é obrigatória'
                      : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                _TextField(
                  label: 'Área total (ha) *',
                  controller: _areaCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  ],
                  validator: (value) {
                    final area = _parseArea(value ?? '');
                    if (area == null || area <= 0) {
                      return 'Informe uma área válida';
                    }
                    return null;
                  },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: AppTypography.body.copyWith(color: context.appTextPrimary),
      decoration: _inputDecoration(context, label),
    );
  }
}

InputDecoration _inputDecoration(BuildContext context, String label) =>
    InputDecoration(
      labelText: label,
      labelStyle: AppTypography.caption.copyWith(
        color: context.appTextSecondary,
      ),
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
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 12,
      ),
    );
