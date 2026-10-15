import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Avatar circular do perfil do usuário.
/// Exibe imagem de rede se [avatarUrl] for fornecido,
/// caso contrário exibe a inicial do nome.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.nome,
    this.avatarUrl,
    this.size = 64,
    this.onTap,
  });

  final String nome;
  final String? avatarUrl;
  final double size;
  final VoidCallback? onTap;

  String get _inicial => nome.isNotEmpty ? nome.trim()[0].toUpperCase() : '?';

  Color get _backgroundColor {
    const colors = [
      AppColors.primary,
      Color(0xFFAF52DE),
      Color(0xFFFF9500),
      Color(0xFF34C759),
      Color(0xFFFF3B30),
    ];
    return colors[nome.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _backgroundColor,
              border: Border.all(
                color: context.appBorder,
                width: 2,
              ),
            ),
            child: avatarUrl != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => _buildInicial(),
                      errorWidget: (_, __, ___) => _buildInicial(),
                    ),
                  )
                : _buildInicial(),
          ),
          if (onTap != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.32,
                height: size * 0.32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: size * 0.18,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInicial() {
    return Center(
      child: Text(
        _inicial,
        style: AppTypography.h2.copyWith(
          color: Colors.white,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}
