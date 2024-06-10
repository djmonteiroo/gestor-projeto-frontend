// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

import 'package:dasboard_project/models/StatusFaturamentoModel.dart';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  DateTime timestamp;
  dynamic nrStatus;
  List<StatusFaturamentoModel> dados;

  ResponseModel({
    required this.timestamp,
    required this.nrStatus,
    required this.dados,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        timestamp: DateTime.parse(json["timestamp"]),
        nrStatus: json["nrStatus"],
        dados: List<StatusFaturamentoModel>.from(
            json["dados"].map((x) => StatusFaturamentoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "nrStatus": nrStatus,
        "dados": List<dynamic>.from(dados.map((x) => x.toJson())),
      };
}
