import 'package:dasboard_project/models/StatusProjetoModel.dart';
import 'package:dasboard_project/services/statusProjetoService.dart';
import 'package:dasboard_project/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class StatusProjetoForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const StatusProjetoForm({Key? key, required this.onSuccess})
      : super(key: key);

  @override
  _StatusProjetoFormState createState() => _StatusProjetoFormState();
}

class _StatusProjetoFormState extends State<StatusProjetoForm> {
  final _formKey = GlobalKey<FormState>();
  String _nmStatusProjeto = '';
  int _isOn = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Registro de Status de Projetos",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.colorTitulo,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Novo Status de Projetos',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um nome para o status';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nmStatusProjeto = value!;
                  },
                ),
              ),
              SizedBox(width: 10),
              Text('Status Ativo:'),
              Switch(
                value: _isOn == 1,
                onChanged: (value) {
                  setState(() {
                    _isOn = value ? 1 : 0;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await criarStatusProjeto(StatusProjetoModel(
          nmSituacaoProjeto: _nmStatusProjeto, inAtivo: _isOn));
      _showFlushbar(success);
      if (success) {
        widget.onSuccess(); // Chama o callback onSuccess
        _formKey.currentState!.reset(); // Reseta os campos do formulário
      }
    }
  }

  void _showFlushbar(bool success) {
    Flushbar(
      message: success
          ? 'Status de Projeto registrado com sucesso!'
          : 'Falha ao registrar o Status de Projeto.',
      backgroundColor: success ? Colors.green : Colors.red,
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
