import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/summary_expandable_card.dart';
import '../../../../core/utils/extensions.dart';
import '../../../consolidation/presentation/providers/consolidacao_provider.dart';
import '../../domain/entities/plano_entity.dart';

class ConsolidationView extends ConsumerWidget {
  const ConsolidationView({
    super.key,
    required this.plano,
    required this.onPlanoChanged,
    required this.onPriceChanged,
  });

  final PlanoEntity plano;
  final ValueChanged<PlanoEntity> onPlanoChanged;
  final Future<void> Function(String produtoNome, double? preco) onPriceChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consolidation = ref.watch(consolidacaoProvider(plano.id));
    return ListView(
      padding: EdgeInsets.only(
        left: 14,
        right: 14,
        top: 16,
        bottom: 32 + MediaQuery.of(context).padding.bottom,
      ),
      children: [
        _ConsolidationParams(plano: plano, onPlanoChanged: onPlanoChanged),
        consolidation.when(
          data: (data) {
            final currency =
                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
            final total = data.custoGeral ?? 0;
            final pendingPrices =
                data.itens.where((item) => item.precoUnitario == null).length;

            return Column(
              children: [
                SummaryExpandableCard(
                  initiallyExpanded: data.itens.length <= 5,
                  summary: SummaryDetailLine(
                    primary: data.itens.isEmpty
                        ? 'Produtos consolidados'
                        : '${data.itens.length} produtos · ${currency.format(total)}',
                    secondary: data.itens.isEmpty
                        ? 'Adicione produtos no planejamento'
                        : pendingPrices > 0
                            ? '$pendingPrices preço(s) pendente(s) — toque para editar'
                            : 'Quantidades e preços unitários',
                  ),
                  detailPadding: EdgeInsets.zero,
                  detail: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        color: context.appBorderSoft,
                        child: const Row(
                          children: [
                            Expanded(child: _TableHead('Produto')),
                            SizedBox(width: 78, child: _TableHead('Qtd.')),
                            SizedBox(
                              width: 86,
                              child: _TableHead('R\$ Unit.'),
                            ),
                            SizedBox(
                              width: 86,
                              child: _TableHead('R\$ Total'),
                            ),
                          ],
                        ),
                      ),
                      if (data.itens.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Nenhum produto no planejamento.',
                            style: AppTypography.caption.copyWith(
                              color: context.appTextDisabled,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      else
                        ...data.itens.map(
                          (item) => _ConsolidationRow(
                            itemName: item.produtoNome,
                            quantity:
                                '${item.quantidadeTotal.toStringAsFixed(2)} ${item.unidade}',
                            initialPrice: item.precoUnitario,
                            total: item.custoTotal,
                            onPriceChanged: onPriceChanged,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _ConsolidationSummary(plano: plano, total: total),
              ],
            );
          },
          loading: () => const LoadingSkeleton(),
          error: (_, __) => Text(
            'Erro ao gerar consolidação',
            style: AppTypography.body.copyWith(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}

class _ConsolidationParams extends StatefulWidget {
  const _ConsolidationParams({
    required this.plano,
    required this.onPlanoChanged,
  });

  final PlanoEntity plano;
  final ValueChanged<PlanoEntity> onPlanoChanged;

  @override
  State<_ConsolidationParams> createState() => _ConsolidationParamsState();
}

class _ConsolidationParamsState extends State<_ConsolidationParams> {
  late final TextEditingController _grain;

  String get _grainSummary {
    final value = _grain.text.trim();
    if (value.isEmpty) return 'Preço do grão não informado';
    return 'R\$ $value / sc 60 kg';
  }

  String get _dateSummary {
    if (widget.plano.dataVencimento == null) {
      return 'Vencimento não definido';
    }
    return 'Vence em ${DateFormat('dd/MM/yyyy', 'pt_BR').format(widget.plano.dataVencimento!)}';
  }

  bool get _hasParams =>
      widget.plano.precoGraoSc60 != null || widget.plano.dataVencimento != null;

  @override
  void initState() {
    super.initState();
    _grain = TextEditingController(
      text: widget.plano.precoGraoSc60?.toStringAsFixed(2) ?? '',
    );
    _grain.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _grain.dispose();
    super.dispose();
  }

  void _saveGrain() {
    widget.onPlanoChanged(
      widget.plano.copyWith(
        precoGraoSc60: double.tryParse(_grain.text.replaceAll(',', '.')),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: widget.plano.dataVencimento ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      widget.onPlanoChanged(widget.plano.copyWith(dataVencimento: date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SummaryExpandableCard(
      initiallyExpanded: !_hasParams,
      summary: SummaryDetailLine(
        primary: 'Parâmetros financeiros',
        secondary: '$_grainSummary · $_dateSummary',
      ),
      detail: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Valor do grão (R\$/sc 60 kg)'.toUpperCase(),
                  style: AppTypography.label.copyWith(
                    color: context.appTextDisabled,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 96,
                child: TextField(
                  controller: _grain,
                  textAlign: TextAlign.right,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: AppTypography.body.copyWith(
                    color: context.appTextPrimary,
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onSubmitted: (_) => _saveGrain(),
                  onTapOutside: (_) => _saveGrain(),
                ),
              ),
            ],
          ),
          Divider(color: context.appBorderSoft),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Data de vencimento'.toUpperCase(),
              style: AppTypography.label.copyWith(
                color: context.appTextDisabled,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              widget.plano.dataVencimento == null
                  ? 'Selecionar'
                  : DateFormat('dd/MM/yyyy', 'pt_BR')
                      .format(widget.plano.dataVencimento!),
              style: AppTypography.caption.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: _pickDate,
          ),
        ],
      ),
    );
  }
}

class _ConsolidationRow extends StatefulWidget {
  const _ConsolidationRow({
    required this.itemName,
    required this.quantity,
    required this.initialPrice,
    required this.total,
    required this.onPriceChanged,
  });

  final String itemName;
  final String quantity;
  final double? initialPrice;
  final double? total;
  final Future<void> Function(String produtoNome, double? preco) onPriceChanged;

  @override
  State<_ConsolidationRow> createState() => _ConsolidationRowState();
}

class _ConsolidationRowState extends State<_ConsolidationRow> {
  late final TextEditingController _price;

  @override
  void initState() {
    super.initState();
    _price = TextEditingController(
      text: widget.initialPrice?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant _ConsolidationRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPrice != widget.initialPrice) {
      final next = widget.initialPrice?.toStringAsFixed(2) ?? '';
      if (_price.text != next) _price.text = next;
    }
  }

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await widget.onPriceChanged(
      widget.itemName,
      double.tryParse(_price.text.replaceAll(',', '.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalText = widget.total == null
        ? '—'
        : NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
            .format(widget.total);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.appBorderSoft)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.itemName,
              style: AppTypography.caption.copyWith(
                color: context.appTextPrimary,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 78,
            child: Text(
              widget.quantity,
              style: AppTypography.label.copyWith(
                color: context.appTextSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 86,
            child: TextField(
              controller: _price,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              ],
              decoration: InputDecoration(
                hintText: 'R\$ unit.',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.appBorderSoft),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
              style: AppTypography.label.copyWith(
                color: context.appTextPrimary,
              ),
              onSubmitted: (_) => _save(),
              onTapOutside: (_) => _save(),
            ),
          ),
          SizedBox(
            width: 86,
            child: Text(
              totalText,
              style: AppTypography.label.copyWith(
                fontWeight: FontWeight.w800,
                color: widget.total == null
                    ? context.appTextDisabled
                    : context.appTextPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsolidationSummary extends StatelessWidget {
  const _ConsolidationSummary({required this.plano, required this.total});

  final PlanoEntity plano;
  final double total;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final custoHa = plano.areaHaTotal > 0 ? total / plano.areaHaTotal : 0;
    final custoSc = (plano.precoGraoSc60 ?? 0) > 0
        ? custoHa / ((plano.precoGraoSc60 ?? 0) / 60)
        : null;

    return SummaryExpandableCard(
      initiallyExpanded: false,
      summary: SummaryDetailLine(
        primary: 'Total ${currency.format(total)}',
        secondary: plano.areaHaTotal > 0
            ? '${currency.format(custoHa)} / ha'
            : 'Detalhamento do investimento',
      ),
      detail: Column(
        children: [
          _SummaryRow(
            label: 'Total investimento',
            value: currency.format(total),
            highlight: true,
          ),
          Divider(color: context.appBorderSoft),
          _SummaryRow(
            label: 'Custo / hectare',
            value: '${currency.format(custoHa)} / ha',
          ),
          _SummaryRow(
            label: 'Custo em sacas',
            value: custoSc == null
                ? '—'
                : '${NumberFormat('#,##0.00', 'pt_BR').format(custoSc)} sc / ha',
          ),
          if (plano.dataVencimento != null)
            _SummaryRow(
              label: 'Vencimento',
              value: DateFormat('dd/MM/yyyy', 'pt_BR')
                  .format(plano.dataVencimento!),
            ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.caption.copyWith(
              color: highlight ? AppColors.primary : context.appTextPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHead extends StatelessWidget {
  const _TableHead(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.right,
      style: AppTypography.label.copyWith(
        color: context.appTextSecondary,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    );
  }
}
