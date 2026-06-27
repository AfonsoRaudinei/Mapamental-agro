import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../plans/presentation/providers/plano_detail_provider.dart';
import '../../domain/entities/consolidacao_entity.dart';
import '../../domain/usecases/gerar_consolidacao_usecase.dart';
import '../../domain/usecases/export_pdf_usecase.dart';
import '../../domain/usecases/export_excel_usecase.dart';
import '../../domain/usecases/export_html_usecase.dart';

/// Provider that generates a [ConsolidacaoEntity] for a given plan id.
final consolidacaoProvider = FutureProvider.autoDispose
    .family<ConsolidacaoEntity, String>((ref, planId) async {
  final plan = await ref.watch(planoDetailProvider(planId).future);
  return const GerarConsolidacaoUseCase().call(plan);
});

/// Provider that exports the consolidation to PDF.
final exportPdfProvider =
    FutureProvider.autoDispose.family<File, String>((ref, planId) async {
  final consolidacao = await ref.watch(consolidacaoProvider(planId).future);
  return const ExportPdfUseCase().call(consolidacao);
});

/// Provider that exports the consolidation to Excel.
final exportExcelProvider =
    FutureProvider.autoDispose.family<File, String>((ref, planId) async {
  final consolidacao = await ref.watch(consolidacaoProvider(planId).future);
  return const ExportExcelUseCase().call(consolidacao);
});

/// Provider that exports the consolidation to offline HTML.
final exportHtmlProvider =
    FutureProvider.autoDispose.family<File, String>((ref, planId) async {
  final consolidacao = await ref.watch(consolidacaoProvider(planId).future);
  return const ExportHtmlUseCase().call(consolidacao);
});
