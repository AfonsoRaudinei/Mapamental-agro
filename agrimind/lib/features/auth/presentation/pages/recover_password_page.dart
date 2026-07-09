import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../auth_error_mapper.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../../../../core/utils/extensions.dart';

/// Tela de recuperação de senha com Supabase Auth.
class RecoverPasswordPage extends ConsumerStatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  ConsumerState<RecoverPasswordPage> createState() =>
      _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends ConsumerState<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _enviado = false;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .recoverPassword(_emailCtrl.text.trim());
      if (mounted) {
        setState(() {
          _enviado = true;
          _loading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AuthErrorMapper.message(error)),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.appTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Recuperar senha', style: AppTypography.h3),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _enviado ? _buildSucesso() : _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          const Text('Recuperar senha', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Digite seu e-mail para receber um link de recuperação.',
            style: TextStyle(fontSize: 16, color: context.appTextSecondary),
          ),
          const SizedBox(height: AppSpacing.xl),
          AuthTextField(
            label: 'E-mail',
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: Validators.email,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: _enviar,
          ),
          const SizedBox(height: AppSpacing.xl),
          AuthPrimaryButton(
            label: 'Enviar link',
            onPressed: _loading ? null : _enviar,
            isLoading: _loading,
          ),
        ],
      ),
    );
  }

  Widget _buildSucesso() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.mark_email_read_outlined,
            size: 72, color: AppColors.success),
        const SizedBox(height: AppSpacing.lg),
        const Text('E-mail enviado!',
            style: AppTypography.h2, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Enviamos um link para ${_emailCtrl.text}. Verifique sua caixa de entrada.',
          style: TextStyle(fontSize: 16, color: context.appTextSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        AuthPrimaryButton(
          label: 'Voltar para o login',
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
