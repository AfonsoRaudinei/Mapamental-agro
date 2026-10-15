import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../clients/domain/entities/talhao_entity.dart';
import '../../../plans/presentation/providers/plano_detail_provider.dart';
import '../../data/exporters/export_excel_exporter.dart';
import '../../data/exporters/export_pdf_exporter.dart';
import '../../domain/entities/consolidacao_entity.dart';
import '../../domain/usecases/export_html_usecase.dart';
import '../../domain/usecases/gerar_consolidacao_usecase.dart';
import '../../domain/usecases/mapear_sementes_consolidacao.dart';

/// Provider that generates a [ConsolidacaoEntity] for a given plan id.
final consolidacaoProvider = FutureProvider.autoDispose
    .family<ConsolidacaoEntity, String>((ref, planId) async {
  final plan = await ref.watch(planoDetailProvider(planId).future);
  final produtos = const GerarConsolidacaoUseCase().call(plan);
  final sementes =
      await ref.read(plansRepoProvider).getSementesByPlano(planId);
  final talhoes = plan.fazendaId == null
      ? const <TalhaoEntity>[]
      : await ref.read(clientsRepoProvider).getTalhoes(plan.fazendaId!);
  return ConsolidacaoEntity(
    plano: produtos.plano,
    geradoEm: produtos.geradoEm,
    itens: produtos.itens,
    sementes: mapearSementesConsolidacao(
      sementes: sementes,
      talhoes: talhoes,
    ),
  );
});

/// Provider that exports the consolidation to PDF.
final exportPdfProvider =
    FutureProvider.autoDispose.family<File, String>((ref, planId) async {
  final consolidacao = await ref.watch(consolidacaoProvider(planId).future);
  return const ExportPdfExporter().call(consolidacao);
});

/// Provider that exports the consolidation to Excel.
final exportExcelProvider =
    FutureProvider.autoDispose.family<File, String>((ref, planId) async {
  final consolidacao = await ref.watch(consolidacaoProvider(planId).future);
  return const ExportExcelExporter().call(consolidacao);
});

/// Provider that exports the consolidation to offline HTML.
final exportHtmlProvider =
    FutureProvider.autoDispose.family<File, String>((ref, planId) async {
  final consolidacao = await ref.watch(consolidacaoProvider(planId).future);
  return const ExportHtmlUseCase().call(consolidacao);
});
