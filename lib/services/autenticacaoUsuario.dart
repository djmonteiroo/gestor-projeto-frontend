import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

String host = dotenv.env['API_URL_AUTENTICACAO'].toString();

String endPointAutenticacao = dotenv.env['ENDPOINT_LOGAR_USUARIO'].toString();

logarUsuario(TextEditingController usuarioController,
    TextEditingController senhaController) async {
  var response =
      await http.post(Uri.parse('$host$endPointAutenticacao'), body: {
    'userName': usuarioController.text,
    'password': senhaController.text,
  });

  if (response.statusCode == 200) {
    return '';
  } else {
    throw Exception("Erro ao realizar login");
  }
}
