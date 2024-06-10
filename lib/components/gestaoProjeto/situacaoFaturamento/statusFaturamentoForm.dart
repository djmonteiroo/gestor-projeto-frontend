import 'package:dasboard_project/models/StatusFaturamentoModel.dart';
import 'package:dasboard_project/services/statusFaturamentoService.dart';
import 'package:dasboard_project/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class StatusFaturamentoForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const StatusFaturamentoForm({Key? key, required this.onSuccess})
      : super(key: key);

  @override
  _StatusFaturamentoFormState createState() => _StatusFaturamentoFormState();
}

class _StatusFaturamentoFormState extends State<StatusFaturamentoForm> {
  final _formKey = GlobalKey<FormState>();
  String _nmStatusFaturamento = '';
  int _isOn = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Registro de Status de Faturamento",
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
                    labelText: 'Novo Status de Faturamento',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um nome para o status';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nmStatusFaturamento = value!;
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
      bool success = await criarStatusFaturamento(StatusFaturamentoModel(
          nmSituacaoFaturamento: _nmStatusFaturamento, inAtivo: _isOn));
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
          ? 'Status de Faturamento registrado com sucesso!'
          : 'Falha ao registrar o Status de Faturamento.',
      backgroundColor: success ? Colors.green : Colors.red,
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
