// To parse this JSON data, do
//
//     final colaboradorModel = colaboradorModelFromJson(jsonString);

import 'dart:convert';

ColaboradorModel colaboradorModelFromJson(String str) =>
    ColaboradorModel.fromJson(json.decode(str));

String colaboradorModelToJson(ColaboradorModel data) =>
    json.encode(data.toJson());

class ColaboradorModel {
  String nmColaborador;
  String? dtInclusaoSaida;
  int? inAtivo;
  int? idGestor;
  int? idColaborador;
  String nmCargo;

  ColaboradorModel({
    required this.nmColaborador,
    this.dtInclusaoSaida,
    this.inAtivo,
    this.idGestor,
    this.idColaborador,
    required this.nmCargo,
  });

  factory ColaboradorModel.fromJson(Map<String, dynamic> json) =>
      ColaboradorModel(
        nmColaborador: json["nmColaborador"],
        dtInclusaoSaida: json["dtInclusaoSaida"],
        inAtivo: json["inAtivo"],
        idGestor: json["idGestor"],
        idColaborador: json["idColaborador"],
        nmCargo: json["nmCargo"],
      );

  Map<String, dynamic> toJson() => {
        "nmColaborador": nmColaborador,
        "dtInclusaoSaida": dtInclusaoSaida,
        "inAtivo": inAtivo,
        "idGestor": idGestor,
        "idColaborador": idColaborador,
        "nmCargo": nmCargo,
      };
}
