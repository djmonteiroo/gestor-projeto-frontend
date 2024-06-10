import 'package:dasboard_project/models/colaboradorModel.dart';
import 'package:dasboard_project/services/registroCargo.dart';
import 'package:dasboard_project/services/registroColaborador.dart';
import 'package:dasboard_project/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class RegistroColaboradorForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const RegistroColaboradorForm({Key? key, required this.onSuccess})
      : super(key: key);

  @override
  _RegistroColaboradorFormState createState() =>
      _RegistroColaboradorFormState();
}

class _RegistroColaboradorFormState extends State<RegistroColaboradorForm> {
  final _formKey = GlobalKey<FormState>();
  String _nmColaborador = '';
  String _nmCargo = '';
  int _idGestor = 0;

  List<String> _cargos = [];

  @override
  void initState() {
    super.initState();
    _loadCargos(); // Carrega os cargos ao iniciar o widget
  }

  Future<void> _loadCargos() async {
    try {
      final cargos = await consultarLsCargo();
      setState(() {
        _cargos = cargos.map((cargo) => cargo.nmCargo).toList();
      });
    } catch (e) {
      print('Erro ao carregar os cargos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Registro de Colaboradores",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.colorTitulo,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 600,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome do Colaborador',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o nome do colaborador';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nmColaborador = value!;
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: 300,
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return _cargos.where((String option) {
                        return option
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      setState(() {
                        _nmCargo = selection;
                      });
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'Cargo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o cargo';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _nmCargo = value!;
                        },
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            width: 300, // Mesma largura do campo
                            color: Colors.white,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(option),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await criarRegistroColaborador(ColaboradorModel(
          nmColaborador: _nmColaborador,
          idGestor: _idGestor,
          nmCargo: _nmCargo));
      _showFlushbar(success);
      if (success) {
        widget.onSuccess(); // Chama o callback onSuccess
        _formKey.currentState!.reset(); // Reseta os campos do formulário
        _loadCargos(); // Recarrega a lista de cargos
      }
    }
  }

  void _showFlushbar(bool success) {
    Flushbar(
      message: success
          ? 'Colaborador registrado com Sucesso!'
          : 'Falha ao registrar Colaborador.',
      backgroundColor: success ? Colors.green : Colors.red,
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
