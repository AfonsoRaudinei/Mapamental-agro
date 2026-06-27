import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/providers.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../../../../core/utils/extensions.dart';

class SettingsDataPage extends ConsumerStatefulWidget {
  const SettingsDataPage({super.key});

  @override
  ConsumerState<SettingsDataPage> createState() => _SettingsDataPageState();
}

class _SettingsDataPageState extends ConsumerState<SettingsDataPage> {
  bool _exporting = false;

  Future<void> _exportData() async {
    if (_exporting) return;
    setState(() => _exporting = true);

    try {
      final data = await ref.read(settingsRepoProvider).exportAllData();
      final json = const JsonEncoder.withIndent('  ').convert(data);
      final dir = await getTemporaryDirectory();
      final stamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .replaceAll('.', '-');
      final file = File('${dir.path}/agrimind-backup-$stamp.json');
      await file.writeAsString(json, flush: true);

      await SharePlus.instance.share(
        ShareParams(
          subject: 'Backup AgriMind',
          text: 'Backup completo dos dados locais do AgriMind.',
          files: [XFile(file.path, mimeType: 'application/json')],
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao exportar dados: $error'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _exporting = false);
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
            PhosphorIconsRegular.caretLeft,
            size: 22,
            color: AppColors.primary,
          ),
        ),
        title: const Text('Dados', style: AppTypography.h3),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          SettingsSection(
            title: 'Backup',
            children: [
              SettingsTile(
                title: 'Exportar dados',
                subtitle: 'Gera um arquivo JSON com os dados locais',
                leading: _iconBox(
                  PhosphorIconsRegular.arrowSquareOut,
                  AppColors.catNutricao,
                ),
                trailing: _exporting
                    ? const CupertinoActivityIndicator()
                    : PhosphorIcon(
                        PhosphorIconsRegular.caretRight,
                        size: 16,
                        color: context.appTextDisabled,
                      ),
                onTap: _exporting ? null : _exportData,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'O backup inclui perfil, clientes, fazendas, talhões, catálogo, planos, estádios e produtos aplicados armazenados neste aparelho.',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: PhosphorIcon(icon, size: 18, color: color)),
    );
  }
}
