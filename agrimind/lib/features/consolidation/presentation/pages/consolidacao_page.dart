import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../providers/consolidacao_provider.dart';
import '../../../../core/utils/extensions.dart';

class ConsolidacaoPage extends ConsumerWidget {
  const ConsolidacaoPage({super.key, required this.planoId});

  final String planoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(consolidacaoProvider(planoId));
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Consolidação', style: AppTypography.h3),
        actions: [
          IconButton(
            tooltip: 'Exportar HTML',
            onPressed: () =>
                _shareExport(ref.read(exportHtmlProvider(planoId).future)),
            icon: const PhosphorIcon(PhosphorIconsRegular.export, size: 20),
          ),
          IconButton(
            tooltip: 'Exportar PDF',
            onPressed: () =>
                _shareExport(ref.read(exportPdfProvider(planoId).future)),
            icon: const PhosphorIcon(PhosphorIconsRegular.filePdf, size: 20),
          ),
          IconButton(
            tooltip: 'Exportar Excel',
            onPressed: () =>
                _shareExport(ref.read(exportExcelProvider(planoId).future)),
            icon: const PhosphorIcon(PhosphorIconsRegular.fileXls, size: 20),
          ),
        ],
      ),
      body: async.when(
        data: (consolidacao) => ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _InfoCard(
              title: consolidacao.plano.nome,
              subtitle:
                  '${consolidacao.plano.cultura} · ${consolidacao.plano.areaHaTotal.toStringAsFixed(1)} ha · ${consolidacao.plano.safra}',
            ),
            const SizedBox(height: AppSpacing.md),
            if (consolidacao.itens.isEmpty)
              const _InfoCard(
                title: 'Nenhum produto',
                subtitle: 'Adicione produtos no canvas para consolidar.',
              )
            else
              ...consolidacao.itens.map(
                (item) => Card(
                  child: ListTile(
                    title: Text(item.produtoNome),
                    subtitle: Text(
                      '${item.categoria} · ${item.quantidadeTotal.toStringAsFixed(2)} ${item.unidade}',
                    ),
                    trailing: Text(
                      item.custoTotal == null
                          ? '—'
                          : currency.format(item.custoTotal),
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.md),
            _InfoCard(
              title: 'Total investimento',
              subtitle: consolidacao.custoGeral == null
                  ? 'Preencha os preços unitários no canvas.'
                  : currency.format(consolidacao.custoGeral),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Erro ao gerar consolidação: $error',
            style: AppTypography.body.copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }

  Future<void> _shareExport(Future<dynamic> fileFuture) async {
    final file = await fileFuture;
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
