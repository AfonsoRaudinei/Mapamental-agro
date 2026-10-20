import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/cliente_entity.dart';
import '../providers/clients_provider.dart';
import '../../../../core/utils/extensions.dart';

/// Formulário de criação e edição de cliente.
///
/// Parâmetro [clienteId] opcional — se fornecido, modo edição.
class ClientFormPage extends ConsumerStatefulWidget {
  const ClientFormPage({super.key, this.clienteId});

  final String? clienteId;

  @override
  ConsumerState<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends ConsumerState<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeCtrl;
  late final TextEditingController _cpfCnpjCtrl;
  late final TextEditingController _telefoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _cidadeCtrl;
  String? _uf;
  bool _loading = false;
  bool _isEdit = false;
  String? _editId;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController();
    _cpfCnpjCtrl = TextEditingController();
    _telefoneCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _cidadeCtrl = TextEditingController();
    _isEdit = widget.clienteId != null;
    _editId = widget.clienteId;

    if (_isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadCliente());
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _cpfCnpjCtrl.dispose();
    _telefoneCtrl.dispose();
    _emailCtrl.dispose();
    _cidadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadCliente() async {
    final cliente = await ref.read(clienteDetailProvider(_editId!).future);
    if (cliente != null && mounted) {
      _nomeCtrl.text = cliente.nome;
      _cpfCnpjCtrl.text = cliente.cpfCnpj ?? '';
      _telefoneCtrl.text = cliente.telefone ?? '';
      _emailCtrl.text = cliente.email ?? '';
      _cidadeCtrl.text = cliente.cidade ?? '';
      setState(() => _uf = cliente.uf);
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final notifier = ref.read(clientsNotifierProvider.notifier);

      if (_isEdit) {
        final atual = await ref.read(clienteDetailProvider(_editId!).future);
        if (atual == null) return;
        await notifier.updateCliente(
          atual.copyWith(
            nome: _nomeCtrl.text.trim(),
            cpfCnpj:
                _cpfCnpjCtrl.text.isEmpty ? null : _cpfCnpjCtrl.text.trim(),
            telefone:
                _telefoneCtrl.text.isEmpty ? null : _telefoneCtrl.text.trim(),
            email: _emailCtrl.text.isEmpty ? null : _emailCtrl.text.trim(),
            cidade: _cidadeCtrl.text.isEmpty ? null : _cidadeCtrl.text.trim(),
            uf: _uf,
            updatedAt: DateTime.now(),
          ),
        );
      } else {
        await notifier.createCliente(
          ClienteEntity(
            id: '',
            nome: _nomeCtrl.text.trim(),
            cpfCnpj:
                _cpfCnpjCtrl.text.isEmpty ? null : _cpfCnpjCtrl.text.trim(),
            telefone:
                _telefoneCtrl.text.isEmpty ? null : _telefoneCtrl.text.trim(),
            email: _emailCtrl.text.isEmpty ? null : _emailCtrl.text.trim(),
            cidade: _cidadeCtrl.text.isEmpty ? null : _cidadeCtrl.text.trim(),
            uf: _uf,
            ativo: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            fazendas: const [],
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
          _isEdit ? 'Editar cliente' : 'Novo cliente',
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
            _FormSection(
              title: 'Informações básicas',
              children: [
                _FormField(
                  label: 'Nome *',
                  controller: _nomeCtrl,
                  hintText: 'Nome completo ou razão social',
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Nome é obrigatório' : null,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: AppSpacing.sm),
                _FormField(
                  label: 'CPF / CNPJ',
                  controller: _cpfCnpjCtrl,
                  hintText: '000.000.000-00',
                  keyboardType: TextInputType.number,
                  maxLength: 18,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _FormSection(
              title: 'Contato',
              children: [
                _FormField(
                  label: 'Telefone',
                  controller: _telefoneCtrl,
                  hintText: '(00) 00000-0000',
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                ),
                const SizedBox(height: AppSpacing.sm),
                _FormField(
                  label: 'E-mail',
                  controller: _emailCtrl,
                  hintText: 'email@exemplo.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    final regex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
                    return regex.hasMatch(v) ? null : 'E-mail inválido';
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _FormSection(
              title: 'Localização',
              children: [
                _FormField(
                  label: 'Cidade',
                  controller: _cidadeCtrl,
                  hintText: 'Ex: Sorriso',
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: AppSpacing.sm),
                _UfDropdown(
                  value: _uf,
                  onChanged: (v) => setState(() => _uf = v),
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

// ── Widgets auxiliares ────────────────────────────────────────────────────────

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.children});

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

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: context.appTextSecondary,
          ),
        ),
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
}

class _UfDropdown extends StatelessWidget {
  const _UfDropdown({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UF',
          style:
              AppTypography.caption.copyWith(color: context.appTextSecondary),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.appBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  'Selecionar UF',
                  style: AppTypography.body
                      .copyWith(color: context.appTextDisabled),
                ),
              ),
              onChanged: onChanged,
              isExpanded: true,
              menuMaxHeight: MediaQuery.sizeOf(context).height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              items: AppConstants.estadosBrasileiros
                  .map(
                    (uf) => DropdownMenuItem(
                      value: uf,
                      child: Text(
                        '$uf — ${AppConstants.estadosNomes[uf] ?? uf}',
                        style: AppTypography.body
                            .copyWith(color: context.appTextPrimary),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
