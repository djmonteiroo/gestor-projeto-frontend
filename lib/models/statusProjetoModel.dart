class StatusProjetoModel {
  String nmSituacaoProjeto;
  int inAtivo;
  int? idSituacaoProjeto; // Campo opcional
  String? dataCadastro; // Campo opcional

  StatusProjetoModel({
    required this.nmSituacaoProjeto,
    required this.inAtivo,
    this.idSituacaoProjeto,
    this.dataCadastro,
  });

  factory StatusProjetoModel.fromJson(Map<String, dynamic> json) {
    return StatusProjetoModel(
      nmSituacaoProjeto: json['nmSituacaoProjeto'],
      inAtivo: json['inAtivo'],
      idSituacaoProjeto: json['idSituacaoProjeto'],
      dataCadastro: json['dtInclusaoSaida'],
    );
  }

  Map<String, dynamic> toJson() => {
        "nmSituacaoProjeto": nmSituacaoProjeto,
        "inAtivo": inAtivo,
        "codigo": idSituacaoProjeto,
        "dataCadastro": dataCadastro,
      };
}
