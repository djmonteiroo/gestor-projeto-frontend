import 'dart:convert';
import 'package:dasboard_project/models/StatusProjetoModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String host = dotenv.env['API_URL_REGISTRO_PROJETO'].toString();
String endPointRegistrarStatusProjeto =
    dotenv.env['ENDPOINT_REGISTRAR_STATUS_PROJETO'].toString();
String endPointConsultarStatusProjeto =
    dotenv.env['ENDPOINT_CONSULTAR_SITUACAO_PROJETO'].toString();
String endPointDesativarStatusProjeto =
    dotenv.env['ENDPOINT_DESATIVAR_STATUS_PROJETO'].toString();
String endPointAtivarStatusProjeto =
    dotenv.env['ENDPOINT_ATIVAR_STATUS_PROJETO'].toString();

Future<bool> criarStatusProjeto(StatusProjetoModel statusprojetoModel) async {
  final response = await http.post(
    Uri.parse(host + endPointRegistrarStatusProjeto),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(statusprojetoModel.toJson()),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<StatusProjetoModel>> consultaLsStatusProjeto() async {
  final response =
      await http.get(Uri.parse(host + endPointConsultarStatusProjeto));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes))["dados"];
    List<StatusProjetoModel> dataList =
        jsonResponse.map((data) => StatusProjetoModel.fromJson(data)).toList();
    return dataList;
  } else {
    throw Exception("Falha ao carregar os dados");
  }
}

Future<void> desativarStatusProjeto(String codigo) async {
  try {
    final response = await http
        .put(Uri.parse(host + endPointDesativarStatusProjeto + codigo));

    if (response.statusCode == 200) {
      print('Status de projeto desativado com sucesso.');
    } else {
      throw Exception(
          'Falha ao desativar o status de projeto: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha ao desativar o status de projeto: $e');
  }
}

Future<void> ativarStatusProjeto(String codigo) async {
  try {
    final response =
        await http.put(Uri.parse(host + endPointAtivarStatusProjeto + codigo));

    if (response.statusCode == 200) {
      print('Status de projeto ativado com sucesso.');
    } else {
      throw Exception(
          'Falha ao desativar o status de projeto: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha ao ativar o status de projeto: $e');
  }
}
