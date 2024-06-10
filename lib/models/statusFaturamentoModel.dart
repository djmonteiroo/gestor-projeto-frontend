class StatusFaturamentoModel {
  String nmSituacaoFaturamento;
  int inAtivo;
  int? idSituacaoFaturamento; // Campo opcional
  String? dataCadastro; // Campo opcional

  StatusFaturamentoModel({
    required this.nmSituacaoFaturamento,
    required this.inAtivo,
    this.idSituacaoFaturamento,
    this.dataCadastro,
  });

  factory StatusFaturamentoModel.fromJson(Map<String, dynamic> json) {
    return StatusFaturamentoModel(
      nmSituacaoFaturamento: json['nmSituacaoFaturamento'],
      inAtivo: json['inAtivo'],
      idSituacaoFaturamento: json['idSituacaoFaturamento'],
      dataCadastro: json['dtInclusaoSaida'],
    );
  }

  Map<String, dynamic> toJson() => {
        "nmSituacaoFaturamento": nmSituacaoFaturamento,
        "inAtivo": inAtivo,
        "codigo": idSituacaoFaturamento,
        "dataCadastro": dataCadastro,
      };
}
