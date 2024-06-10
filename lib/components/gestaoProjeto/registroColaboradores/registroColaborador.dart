import 'package:dasboard_project/components/gestaoProjeto/registroColaboradores/lsRegistroColaborador.dart';
import 'package:dasboard_project/components/gestaoProjeto/registroColaboradores/registroColaboradorForm.dart';
import 'package:dasboard_project/models/colaboradorModel.dart';
import 'package:dasboard_project/services/registroColaborador.dart';
import 'package:flutter/material.dart';

class RegistroColaborador extends StatefulWidget {
  @override
  State<RegistroColaborador> createState() => _RegistroColaboradorState();
}

class _RegistroColaboradorState extends State<RegistroColaborador> {
  late Future<List<ColaboradorModel>> _RegistroColaborador;

  @override
  void initState() {
    super.initState();
    _refreshRegistroColaborador();
  }

  void _refreshRegistroColaborador() {
    setState(() {
      _RegistroColaborador = consultaLsColaboradores(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LsColaboradores(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RegistroColaboradorForm(
                onSuccess: _refreshRegistroColaborador, // Passa o callback
              ),
            ),
          ),
        ],
      ),
    );
  }
}
