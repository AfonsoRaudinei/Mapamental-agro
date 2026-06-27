import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/settings_provider.dart';
import '../widgets/profile_avatar.dart';
import '../../../../core/utils/extensions.dart';

/// Página de edição do perfil do usuário.
class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeCtrl;
  late final TextEditingController _telefoneCtrl;
  late final TextEditingController _empresaCtrl;
  late final TextEditingController _craCtrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController();
    _telefoneCtrl = TextEditingController();
    _empresaCtrl = TextEditingController();
    _craCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSettings());
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _telefoneCtrl.dispose();
    _empresaCtrl.dispose();
    _craCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final settings = await ref.read(settingsNotifierProvider.future);
    if (settings != null && mounted) {
      _nomeCtrl.text = settings.nome;
      _telefoneCtrl.text = settings.telefone ?? '';
      _empresaCtrl.text = settings.empresa ?? '';
      _craCtrl.text = settings.craRegistro ?? '';
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final atual = await ref.read(settingsNotifierProvider.future);
      if (atual == null) {
        setState(() => _loading = false);
        return;
      }

      await ref.read(settingsNotifierProvider.notifier).updateProfile(
            atual.copyWith(
              nome: _nomeCtrl.text.trim(),
              telefone:
                  _telefoneCtrl.text.isEmpty ? null : _telefoneCtrl.text.trim(),
              empresa:
                  _empresaCtrl.text.isEmpty ? null : _empresaCtrl.text.trim(),
              craRegistro: _craCtrl.text.isEmpty ? null : _craCtrl.text.trim(),
              updatedAt: DateTime.now(),
            ),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil atualizado com sucesso!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
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
    final settingsAsync = ref.watch(settingsNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          child: const PhosphorIcon(
            PhosphorIconsRegular.caretLeft,
            size: 22,
            color: AppColors.primary,
          ),
        ),
        title: const Text('Editar perfil', style: AppTypography.h3),
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
      body: settingsAsync.when(
        data: (settings) => Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // ── Avatar ────────────────────────────────────────────────
              Center(
                child: ProfileAvatar(
                  nome: settings?.nome ?? '',
                  avatarUrl: settings?.avatarUrl,
                  size: 80,
                  onTap: () {/* TODO: image_picker */},
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Campos ────────────────────────────────────────────────
              _Section(
                title: 'Dados pessoais',
                children: [
                  _Field(
                    label: 'Nome completo *',
                    controller: _nomeCtrl,
                    hintText: 'Seu nome',
                    validator: _validarNome,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _Field(
                    label: 'Telefone',
                    controller: _telefoneCtrl,
                    hintText: '(00) 00000-0000',
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
                    validator: _validarTelefone,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _Section(
                title: 'Dados profissionais',
                children: [
                  _Field(
                    label: 'Empresa / Consultora',
                    controller: _empresaCtrl,
                    hintText: 'Ex: AgroConsult Ltda',
                    textCapitalization: TextCapitalization.words,
                    validator: _validarTextoOpcional,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _Field(
                    label: 'Registro CREA/CRA',
                    controller: _craCtrl,
                    hintText: 'Ex: CREA-MT 123456',
                    textCapitalization: TextCapitalization.characters,
                    validator: _validarTextoOpcional,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
        loading: () => const LoadingSkeleton(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  String? _validarNome(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Nome é obrigatório';
    if (text.length < 3) return 'Informe ao menos 3 caracteres';
    return null;
  }

  String? _validarTelefone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final digits = text.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 11) {
      return 'Telefone deve ter DDD e número';
    }
    return null;
  }

  String? _validarTextoOpcional(String? value) {
    final text = value?.trim() ?? '';
    if (text.isNotEmpty && text.length < 2) {
      return 'Informe ao menos 2 caracteres';
    }
    return null;
  }
}

// ── Widgets auxiliares ────────────────────────────────────────────────────────

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
