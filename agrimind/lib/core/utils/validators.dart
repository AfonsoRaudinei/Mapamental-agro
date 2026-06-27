/// Validadores de formulários do AgriMind.
class Validators {
  Validators._();

  // ── E-MAIL ────────────────────────────────────────────────────────────────
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'E-mail é obrigatório';
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) return 'E-mail inválido';
    return null;
  }

  // ── SENHA ─────────────────────────────────────────────────────────────────
  static String? senha(String? value) {
    if (value == null || value.isEmpty) return 'Senha é obrigatória';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    if (!RegExp(r'\d').hasMatch(value)) return 'Inclua ao menos 1 número';
    return null;
  }

  static String? confirmarSenha(String? value, String? senha) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != senha) return 'Senhas não coincidem';
    return null;
  }

  // ── CAMPOS OBRIGATÓRIOS ───────────────────────────────────────────────────
  static String? required(String? value, {String label = 'Campo'}) {
    if (value == null || value.trim().isEmpty) return '$label é obrigatório';
    return null;
  }

  static String? nome(String? value) => required(value, label: 'Nome');

  // ── CPF ───────────────────────────────────────────────────────────────────
  static String? cpf(String? value) {
    if (value == null || value.trim().isEmpty) return null; // opcional
    final d = value.replaceAll(RegExp(r'\D'), '');
    if (d.length != 11) return 'CPF inválido';
    if (d.split('').toSet().length == 1) return 'CPF inválido';
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(d[i]) * (10 - i);
    }
    int r1 = 11 - (sum % 11);
    if (r1 >= 10) r1 = 0;
    if (r1 != int.parse(d[9])) return 'CPF inválido';
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(d[i]) * (11 - i);
    }
    int r2 = 11 - (sum % 11);
    if (r2 >= 10) r2 = 0;
    if (r2 != int.parse(d[10])) return 'CPF inválido';
    return null;
  }

  // ── CNPJ ──────────────────────────────────────────────────────────────────
  static String? cnpj(String? value) {
    if (value == null || value.trim().isEmpty) return null; // opcional
    final d = value.replaceAll(RegExp(r'\D'), '');
    if (d.length != 14) return 'CNPJ inválido';
    if (d.split('').toSet().length == 1) return 'CNPJ inválido';
    const w1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    const w2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int s1 = 0;
    for (int i = 0; i < 12; i++) {
      s1 += int.parse(d[i]) * w1[i];
    }
    final dg1 = (s1 % 11) < 2 ? 0 : 11 - (s1 % 11);
    if (dg1 != int.parse(d[12])) return 'CNPJ inválido';
    int s2 = 0;
    for (int i = 0; i < 13; i++) {
      s2 += int.parse(d[i]) * w2[i];
    }
    final dg2 = (s2 % 11) < 2 ? 0 : 11 - (s2 % 11);
    if (dg2 != int.parse(d[13])) return 'CNPJ inválido';
    return null;
  }

  // ── ÁREA ──────────────────────────────────────────────────────────────────
  static String? areaHa(String? value) {
    if (value == null || value.trim().isEmpty) return 'Área é obrigatória';
    final v = double.tryParse(value.replaceAll(',', '.'));
    if (v == null) return 'Valor inválido';
    if (v <= 0) return 'Área deve ser maior que zero';
    if (v > 9999999) return 'Máximo 7 dígitos';
    return null;
  }

  // ── DOSE ──────────────────────────────────────────────────────────────────
  static String? dose(String? value) {
    if (value == null || value.trim().isEmpty) return 'Dose é obrigatória';
    final v = double.tryParse(value.replaceAll(',', '.'));
    if (v == null) return 'Valor inválido';
    if (v <= 0) return 'Dose deve ser maior que zero';
    return null;
  }
}
