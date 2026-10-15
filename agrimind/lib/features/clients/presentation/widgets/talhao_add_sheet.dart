import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../domain/entities/talhao_entity.dart';
import '../providers/clients_provider.dart';

/// Bottom sheet para adicionar talhão (detail ou edit da fazenda).
class TalhaoAddSheet extends ConsumerStatefulWidget {
  const TalhaoAddSheet({
    super.key,
    required this.fazendaId,
    required this.fazendaAreaTotalHa,
    this.onCreated,
  });

  final String fazendaId;
  final double fazendaAreaTotalHa;
  final void Function(TalhaoEntity created)? onCreated;

  static Future<TalhaoEntity?> show({
    required BuildContext context,
    required WidgetRef ref,
    required String fazendaId,
    required double fazendaAreaTotalHa,
  }) {
    return showAppBottomSheet<TalhaoEntity>(
      context: context,
      builder: (ctx) => TalhaoAddSheet(
        fazendaId: fazendaId,
        fazendaAreaTotalHa: fazendaAreaTotalHa,
        onCreated: (t) => Navigator.of(ctx).pop(t),
      ),
    );
  }

  @override
  ConsumerState<TalhaoAddSheet> createState() => _TalhaoAddSheetState();
}

class _TalhaoAddSheetState extends ConsumerState<TalhaoAddSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _areaCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final areaNova = double.parse(_areaCtrl.text.replaceAll(',', '.'));
    final talhoes =
        await ref.read(talhoesNotifierProvider(widget.fazendaId).future);
    final somaAtual = talhoes.fold<double>(0, (s, t) => s + t.areaHa);
    final somaProjetada = somaAtual + areaNova;

    if (somaProjetada > widget.fazendaAreaTotalHa + 0.001) {
      final excesso = (somaProjetada - widget.fazendaAreaTotalHa).toStringAsFixed(2);
      if (!mounted) return;
      final ok = await showCupertinoDialog<bool>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Área dos talhões'),
          content: Text(
            'A soma das áreas ($somaProjetada ha) ultrapassa a área total '
            'da fazenda (${widget.fazendaAreaTotalHa} ha) em $excesso ha. '
            'Deseja salvar mesmo assim?',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Voltar'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Salvar'),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }

    setState(() => _loading = true);
    try {
      final notifier =
          ref.read(talhoesNotifierProvider(widget.fazendaId).notifier);
      final criado = await notifier.createTalhao(
        TalhaoEntity(
          id: '',
          fazendaId: widget.fazendaId,
          nome: _nomeCtrl.text.trim(),
          areaHa: areaNova,
          ativo: true,
          createdAt: DateTime.now(),
        ),
      );
      widget.onCreated?.call(criado);
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
    return AppBottomSheetScaffold(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Text(
          'Novo talhão',
          style: AppTypography.h3.copyWith(color: context.appTextPrimary),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nome',
                style: AppTypography.caption
                    .copyWith(color: context.appTextSecondary),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: _nomeCtrl,
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nome obrigatório' : null,
                decoration: _decoration('Ex: Talhão A'),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Área (ha)',
                style: AppTypography.caption
                    .copyWith(color: context.appTextSecondary),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: _areaCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  LengthLimitingTextInputFormatter(7),
                ],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Área obrigatória';
                  if (double.tryParse(v.replaceAll(',', '.')) == null) {
                    return 'Valor inválido';
                  }
                  return null;
                },
                decoration: _decoration('0,0'),
              ),
              const SizedBox(height: AppSpacing.lg),
              CupertinoButton.filled(
                onPressed: _loading ? null : _salvar,
                child: _loading
                    ? const CupertinoActivityIndicator()
                    : const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 10,
      ),
    );
  }
}
