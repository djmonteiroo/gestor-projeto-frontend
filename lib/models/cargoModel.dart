// To parse this JSON data, do
//
//     final cargoModel = cargoModelFromJson(jsonString);

import 'dart:convert';

CargoModel cargoModelFromJson(String str) =>
    CargoModel.fromJson(json.decode(str));

String cargoModelToJson(CargoModel data) => json.encode(data.toJson());

class CargoModel {
  String nmCargo;

  CargoModel({
    required this.nmCargo,
  });

  factory CargoModel.fromJson(Map<String, dynamic> json) => CargoModel(
        nmCargo: json["nmCargo"],
      );

  Map<String, dynamic> toJson() => {
        "nmCargo": nmCargo,
      };
}
