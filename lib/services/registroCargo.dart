import 'dart:convert';
import 'package:dasboard_project/models/cargoModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String host = dotenv.env['API_URL_REGISTRO_PESSOA'].toString();

String endPointConsultarCargo =
    dotenv.env['ENDPOINT_CONSULTAR_CARGOS'].toString();

Future<List<CargoModel>> consultarLsCargo() async {
  final response = await http.get(Uri.parse(host + endPointConsultarCargo));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes))["dados"];
    List<CargoModel> dataList =
        jsonResponse.map((data) => CargoModel.fromJson(data)).toList();
    return dataList;
  } else {
    throw Exception("Falha ao carregar os dados");
  }
}
