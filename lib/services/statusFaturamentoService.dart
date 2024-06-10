import 'dart:convert';
import 'package:dasboard_project/models/StatusFaturamentoModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String host = dotenv.env['API_URL_REGISTRO_PROJETO'].toString();
String endPointRegistrarFaturamento =
    dotenv.env['ENDPOINT_REGISTRAR_FATURAMENTO'].toString();
String endPointConsultarSituacaoFaturamento =
    dotenv.env['ENDPOINT_CONSULTAR_SITUACAO_FATURAMENTO'].toString();
String endPointDesativarSituacaoFaturamento =
    dotenv.env['ENDPOINT_DESATIVAR_STATUS_FATURAMENTO'].toString();
String endPointAtivarSituacaoFaturamento =
    dotenv.env['ENDPOINT_ATIVAR_STATUS_FATURAMENTO'].toString();

Future<bool> criarStatusFaturamento(
    StatusFaturamentoModel statusFaturamentoModel) async {
  try {
    final response = await http.post(
      Uri.parse(host + endPointRegistrarFaturamento),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(statusFaturamentoModel.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception('Falha ao registrar status: $e');
  }
}

Future<List<StatusFaturamentoModel>> consultalsStatusFaturamento() async {
  try {
    final response =
        await http.get(Uri.parse(host + endPointConsultarSituacaoFaturamento));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse =
          jsonDecode(utf8.decode(response.bodyBytes))["dados"];
      List<StatusFaturamentoModel> dataList = jsonResponse
          .map((data) => StatusFaturamentoModel.fromJson(data))
          .toList();
      return dataList;
    } else {
      throw Exception("Falha ao carregar os dados");
    }
  } catch (e) {
    throw Exception("Falha ao buscar status: $e");
  }
}

Future<void> desativarStatusFaturamento(String codigo) async {
  try {
    final response = await http
        .put(Uri.parse(host + endPointDesativarSituacaoFaturamento + codigo));

    if (response.statusCode == 200) {
      print('Status de faturamento desativado com sucesso.');
    } else {
      throw Exception(
          'Falha ao desativar o status de faturamento: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha ao desativar o status de faturamento: $e');
  }
}

Future<void> ativarStatusFaturamento(String codigo) async {
  try {
    final response = await http
        .put(Uri.parse(host + endPointAtivarSituacaoFaturamento + codigo));

    if (response.statusCode == 200) {
      print('Status de faturamento desativado com sucesso.');
    } else {
      throw Exception(
          'Falha ao desativar o status de faturamento: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha ao desativar o status de faturamento: $e');
  }
}
