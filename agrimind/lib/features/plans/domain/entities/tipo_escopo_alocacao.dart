/// Escopo de rateio de produto no plano.
enum TipoEscopoAlocacao {
  fazendaInteira,
  talhoesSelecionados,
}

extension TipoEscopoAlocacaoCodec on TipoEscopoAlocacao {
  String toStorage() => switch (this) {
        TipoEscopoAlocacao.fazendaInteira => 'fazenda_inteira',
        TipoEscopoAlocacao.talhoesSelecionados => 'talhoes_selecionados',
      };

  static TipoEscopoAlocacao fromStorage(String value) => switch (value) {
        'fazenda_inteira' => TipoEscopoAlocacao.fazendaInteira,
        'talhoes_selecionados' => TipoEscopoAlocacao.talhoesSelecionados,
        _ => TipoEscopoAlocacao.fazendaInteira,
      };
}
