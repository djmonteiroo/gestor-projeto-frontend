import 'package:dasboard_project/models/cargoModel.dart';
import 'package:dasboard_project/services/registroColaborador.dart';
import 'package:flutter/material.dart';
import 'package:dasboard_project/models/colaboradorModel.dart';

class EditarColaboradorForm extends StatefulWidget {
  final ColaboradorModel colaborador;
  final List<CargoModel> listaCargos;

  const EditarColaboradorForm({
    Key? key,
    required this.colaborador,
    required this.listaCargos,
  }) : super(key: key);

  @override
  _EditarColaboradorFormState createState() =>
      _EditarColaboradorFormState(listaCargos);
}

class _EditarColaboradorFormState extends State<EditarColaboradorForm> {
  late TextEditingController _codigoController;
  late TextEditingController _colaboradorController;
  late TextEditingController _funcaoController;
  bool _ativo = false;
  List<CargoModel> _listaCargos;

  _EditarColaboradorFormState(this._listaCargos);

  @override
  void initState() {
    super.initState();
    _codigoController = TextEditingController(
        text: widget.colaborador.idColaborador?.toString() ?? '');
    _colaboradorController =
        TextEditingController(text: widget.colaborador.nmColaborador);
    _funcaoController = TextEditingController(text: widget.colaborador.nmCargo);
    _ativo = widget.colaborador.inAtivo == 1; // Convertendo para booleano
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _colaboradorController.dispose();
    _funcaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Colaborador'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _colaboradorController,
              decoration: InputDecoration(labelText: 'Colaborador'),
            ),
            DropdownButtonFormField<String>(
              value: _funcaoController.text,
              onChanged: (value) {
                setState(() {
                  _funcaoController.text = value!;
                });
              },
              items: _listaCargos.map((cargo) {
                return DropdownMenuItem<String>(
                  value: cargo.nmCargo,
                  child: Text(cargo.nmCargo),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Função'),
            ),
            Row(
              children: [
                Text('Ativo: '),
                Checkbox(
                  value: _ativo,
                  onChanged: (value) {
                    setState(() {
                      _ativo = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            _salvarDados();
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }

  void _salvarDados() {
    // Convertendo valor booleano para 0 ou 1
    int inAtivo = _ativo ? 1 : 0;

    // Criando uma instância de ColaboradorModel com os dados atualizados
    ColaboradorModel colaborador = ColaboradorModel(
      nmColaborador: _colaboradorController.text,
      nmCargo: _funcaoController.text,
      inAtivo: inAtivo,
      idColaborador: int.tryParse(_codigoController.text),
      // Preencha os outros campos conforme necessário
    );

    // Agora você pode usar a instância colaborador para enviar os dados
    // para a função atualizarColaborador
    atualizarColaborador(colaborador).then((_) {
      // Atualizando a lista de colaboradores após a atualização
      // Aqui você pode recarregar a lista ou fazer outra operação necessária
      // Exemplo:
      // _fetchColaboradores();
    });

    Navigator.of(context).pop();
    ;
  }
}
