import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Tipo do provider social.
enum SocialSignInType { google, apple }

/// Botão de login social (Google / Apple) — estilo iOS-native.
class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
  });

  final SocialSignInType type;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isApple = type == SocialSignInType.apple;
    final bgColor = isApple ? Colors.black : Colors.white;
    final fgColor = isApple ? Colors.white : context.appTextPrimary;
    final borderColor = isApple ? Colors.black : context.appBorder;
    final label = isApple ? 'Continuar com Apple' : 'Continuar com Google';
    final icon = isApple ? Icons.apple : Icons.g_mobiledata_rounded;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 22, color: fgColor),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    label,
                    style: AppTypography.bodyBold.copyWith(color: fgColor),
                  ),
                ],
              ),
      ),
    );
  }
}
