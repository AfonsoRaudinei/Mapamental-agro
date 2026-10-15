import 'linha_tempo_soja.dart';

/// Aviso se antecipação real da colheita está fora da faixa 3–7 dias.
String? avisoAntecipacaoColheitaReal(int dias) {
  if (dias > 7) {
    return 'Valor fora da faixa agronomicamente validada (máximo de 3 a 7 dias '
        'de antecipação real, mesmo aplicando o dessecante mais cedo).';
  }
  if (dias > 0 && dias < 3) {
    return 'Atenção: a faixa usual de antecipação real da colheita é de 3 a 7 dias.';
  }
  return null;
}

/// Campos 10 e 11 devem ser independentes (nunca o mesmo número).
String? avisoDessecanteIndependenteColheitaReal(ParametrosFenologicosSoja p) {
  if (p.diasAntesR8Dessecante <= 0 || p.diasAntecipacaoColheitaReal <= 0) {
    return null;
  }
  if (p.diasAntesR8Dessecante == p.diasAntecipacaoColheitaReal) {
    return 'Os dias antes do R8 para o dessecante e a antecipação real da '
        'colheita não podem ser iguais.';
  }
  return null;
}
