import 'dart:convert';
import 'package:dasboard_project/models/colaboradorModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String host = dotenv.env['API_URL_REGISTRO_PESSOA'].toString();
String endPointRegistrarColaborador =
    dotenv.env['ENDPOINT_REGISTRAR_COLABORADOR'].toString();
String endPointConsultarColaboradores =
    dotenv.env['ENDPOINT_CONSULTAR_COLABORADORES'].toString();

String endPointDesativarColaborador =
    dotenv.env['ENDPOINT_DESATIVAR_COLABORADOR'].toString();

String endPointAtivarColaborador =
    dotenv.env['ENDPOINT_ATIVAR_COLABORADOR'].toString();

String endPointAtualizarColaborador =
    dotenv.env['ENDPOINT_ATUALIZAR_COLABORADOR'].toString();

Future<bool> criarRegistroColaborador(ColaboradorModel colaboradorModel) async {
  final response = await http.post(
    Uri.parse(host + endPointRegistrarColaborador),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(colaboradorModel.toJson()),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<ColaboradorModel>> consultaLsColaboradores(int ativo) async {
  final response = await http.get(Uri.parse(host +
      endPointConsultarColaboradores +
      "?idGestor=1&inAtivo=${ativo}")); // Usando o filtro ativo

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes))["dados"];
    List<ColaboradorModel> dataList =
        jsonResponse.map((data) => ColaboradorModel.fromJson(data)).toList();
    return dataList;
  } else {
    throw Exception("Falha ao carregar os dados");
  }
}

Future<void> desativarColaborador(String codigo) async {
  try {
    final response =
        await http.put(Uri.parse(host + endPointDesativarColaborador + codigo));

    if (response.statusCode == 200) {
      print('Colaborador desativado com sucesso.');
    } else {
      throw Exception(
          'Falha ao desativar colaborador: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha: $e');
  }
}

Future<void> ativarColaborador(String codigo) async {
  try {
    final response =
        await http.put(Uri.parse(host + endPointAtivarColaborador + codigo));

    if (response.statusCode == 200) {
      print('Colaborador ativado com sucesso.');
    } else {
      throw Exception('Falha ao ativar colaborador: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha: $e');
  }
}

Future<void> atualizarColaborador(ColaboradorModel colaborador) async {
  try {
    final response = await http.put(
      Uri.parse(host + endPointAtualizarColaborador),
      body: json.encode(colaborador.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Colaborador atualizado com sucesso.');
    } else {
      throw Exception(
          'Falha ao atualizar colaborador: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Falha: $e');
  }
}
