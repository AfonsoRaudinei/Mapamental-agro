import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formatadores de texto e valores do AgriMind.
class AppFormatters {
  AppFormatters._();

  // ── MOEDA ─────────────────────────────────────────────────────────────────
  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  /// Ex: R$ 1.234,56
  static String moeda(double value) => _currency.format(value);

  // ── ÁREA ──────────────────────────────────────────────────────────────────
  static final _area = NumberFormat('#,##0.##', 'pt_BR');

  /// Ex: 80 ha ou 80,5 ha
  static String area(double value) => '${_area.format(value)} ha';

  // ── DOSE / TOTAL ──────────────────────────────────────────────────────────
  /// Ex: 0,4 L/ha
  static String dose(double value, String unidade) =>
      '${NumberFormat('#,##0.##', 'pt_BR').format(value)} $unidade';

  /// Ex: 32,0 L
  static String total(double value, String unidade) =>
      '${NumberFormat('#,##0.#', 'pt_BR').format(value)} $unidade';

  // ── DATA ──────────────────────────────────────────────────────────────────
  static final _date = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final _dateTime = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

  static String data(DateTime d) => _date.format(d);
  static String dataHora(DateTime d) => _dateTime.format(d);

  // ── TELEFONE ──────────────────────────────────────────────────────────────
  static String telefone(String raw) {
    final d = raw.replaceAll(RegExp(r'\D'), '');
    if (d.length == 11) {
      return '(${d.substring(0, 2)}) ${d.substring(2, 7)}-${d.substring(7)}';
    } else if (d.length == 10) {
      return '(${d.substring(0, 2)}) ${d.substring(2, 6)}-${d.substring(6)}';
    }
    return raw;
  }

  // ── CPF / CNPJ ────────────────────────────────────────────────────────────
  static String cpf(String digits) {
    final d = digits.replaceAll(RegExp(r'\D'), '');
    if (d.length != 11) return digits;
    return '${d.substring(0, 3)}.${d.substring(3, 6)}.${d.substring(6, 9)}-${d.substring(9)}';
  }

  static String cnpj(String digits) {
    final d = digits.replaceAll(RegExp(r'\D'), '');
    if (d.length != 14) return digits;
    return '${d.substring(0, 2)}.${d.substring(2, 5)}.${d.substring(5, 8)}/${d.substring(8, 12)}-${d.substring(12)}';
  }
}

/// InputFormatter: permite apenas números com até [maxDigits] dígitos.
class NumericInputFormatter extends TextInputFormatter {
  const NumericInputFormatter({
    this.maxDigits = 7,
    this.allowDecimal = true,
  });

  final int maxDigits;
  final bool allowDecimal;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(',', '.');
    if (text.isEmpty) return newValue;
    final pattern = allowDecimal
        ? RegExp(r'^\d{0,' + maxDigits.toString() + r'}(\.\d*)?$')
        : RegExp(r'^\d{0,' + maxDigits.toString() + r'}$');
    return pattern.hasMatch(text) ? newValue : oldValue;
  }
}
