import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/talhao_entity.dart';
import '../providers/clients_provider.dart';
import '../../../../core/utils/extensions.dart';

/// Formulário de criação e edição de talhão.
class TalhaoFormPage extends ConsumerStatefulWidget {
  const TalhaoFormPage({
    super.key,
    required this.fazendaId,
    this.talhaoId,
  });

  final String fazendaId;
  final String? talhaoId;

  @override
  ConsumerState<TalhaoFormPage> createState() => _TalhaoFormPageState();
}

class _TalhaoFormPageState extends ConsumerState<TalhaoFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _obsCtrl;
  bool _loading = false;
  bool get _isEdit => widget.talhaoId != null;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController();
    _areaCtrl = TextEditingController();
    _obsCtrl = TextEditingController();

    if (_isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadTalhao());
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _areaCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadTalhao() async {
    final talhoes =
        await ref.read(talhoesNotifierProvider(widget.fazendaId).future);
    final talhao = talhoes.where((t) => t.id == widget.talhaoId).firstOrNull;
    if (talhao != null && mounted) {
      _nomeCtrl.text = talhao.nome;
      _areaCtrl.text = talhao.areaHa.toString();
      _obsCtrl.text = talhao.observacao ?? '';
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final notifier =
          ref.read(talhoesNotifierProvider(widget.fazendaId).notifier);

      if (_isEdit) {
        final talhoes =
            await ref.read(talhoesNotifierProvider(widget.fazendaId).future);
        final atual = talhoes.where((t) => t.id == widget.talhaoId).firstOrNull;
        if (atual == null) return;
        await notifier.updateTalhao(
          atual.copyWith(
            nome: _nomeCtrl.text.trim(),
            areaHa: double.parse(_areaCtrl.text),
            observacao: _obsCtrl.text.isEmpty ? null : _obsCtrl.text.trim(),
          ),
        );
      } else {
        await notifier.createTalhao(
          TalhaoEntity(
            id: '',
            fazendaId: widget.fazendaId,
            nome: _nomeCtrl.text.trim(),
            areaHa: double.parse(_areaCtrl.text),
            observacao: _obsCtrl.text.isEmpty ? null : _obsCtrl.text.trim(),
            ativo: true,
            createdAt: DateTime.now(),
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
          _isEdit ? 'Editar talhão' : 'Novo talhão',
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
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.appBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('Nome *'),
                  TextFormField(
                    controller: _nomeCtrl,
                    textCapitalization: TextCapitalization.words,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Nome é obrigatório' : null,
                    decoration: _inputDecoration('Ex: Talhão A'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildFieldLabel('Área (ha) *'),
                  TextFormField(
                    controller: _areaCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    maxLength: 7,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Área é obrigatória';
                      if (double.tryParse(v) == null) return 'Valor inválido';
                      return null;
                    },
                    decoration: _inputDecoration('0000000').copyWith(
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildFieldLabel('Observação'),
                  TextFormField(
                    controller: _obsCtrl,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _inputDecoration('Detalhes, localização...')
                        .copyWith(alignLabelWithHint: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(color: context.appTextSecondary),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.body.copyWith(color: context.appTextDisabled),
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
        vertical: 10,
      ),
    );
  }
}
