import 'package:dasboard_project/components/gestaoProjeto/registroColaboradores/editarColaboradorForm.dart';
import 'package:dasboard_project/models/colaboradorModel.dart';
import 'package:dasboard_project/services/registroCargo.dart';
import 'package:dasboard_project/services/registroColaborador.dart';
import 'package:flutter/material.dart';

class LsColaboradores extends StatefulWidget {
  @override
  _LsColaboradoresState createState() => _LsColaboradoresState();
}

class _LsColaboradoresState extends State<LsColaboradores> {
  late Future<List<ColaboradorModel>> _futureColaboradores;
  List<ColaboradorModel> _colaboradores = [];
  List<ColaboradorModel> _filteredColaboradores = [];

  bool _filtroAtivo = true;
  int _inAtivo = 1;
  String _filtroNome = '';
  String _filtroCargo = '';

  @override
  void initState() {
    super.initState();
    _fetchColaboradores();
  }

  Future<void> _fetchColaboradores() async {
    _futureColaboradores = consultaLsColaboradores(_inAtivo);
    final data = await _futureColaboradores;
    setState(() {
      _colaboradores = data;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ColaboradorModel>>(
        future: _futureColaboradores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to fetch data: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFiltros(),
                Expanded(
                  child: _buildDataTable(_filteredColaboradores),
                ),
              ],
            );
          } else {
            return Center(child: Text('Sem registro nos filtros aplicados.'));
          }
        },
      ),
    );
  }

  Widget _buildDataTable(List<ColaboradorModel> data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Código')),
                  DataColumn(label: Text('Colaborador')),
                  DataColumn(label: Text('Função')),
                  DataColumn(label: Text('Ativo')),
                  DataColumn(label: Text('Data de Cadastro')),
                  DataColumn(label: Text('Ações'))
                ],
                rows: data.isNotEmpty
                    ? data.map((status) {
                        return DataRow(cells: [
                          DataCell(
                              Text(status.idColaborador?.toString() ?? '')),
                          DataCell(Text(status.nmColaborador)),
                          DataCell(Text(status.nmCargo)),
                          DataCell(Text(status.inAtivo == 1 ? 'Sim' : 'Não')),
                          DataCell(Text(status.dtInclusaoSaida ?? '')),
                          DataCell(
                            PopupMenuButton<String>(
                              onSelected: (String value) {
                                _performAction(status, value);
                              },
                              itemBuilder: (BuildContext context) =>
                                  _buildPopupMenuItems(status),
                            ),
                          ),
                        ]);
                      }).toList()
                    : [
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('No data available')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems(ColaboradorModel status) {
    if (status.inAtivo == 1) {
      return const [
        PopupMenuItem<String>(
          value: 'Desativar',
          child: ListTile(
            leading: Icon(Icons.disabled_by_default_rounded),
            title: Text('Desativar'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Editar',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
      ];
    } else {
      return const [
        PopupMenuItem<String>(
          value: 'Ativar',
          child: ListTile(
            leading: Icon(Icons.library_add_check),
            title: Text('Ativar'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Editar',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
      ];
    }
  }

  void _performAction(ColaboradorModel status, String value) async {
    if (value == 'Desativar') {
      desativarColaborador(status.idColaborador.toString()).then((_) {
        _fetchColaboradores();
      });
    } else if (value == 'Ativar') {
      ativarColaborador(status.idColaborador.toString()).then((_) {
        _fetchColaboradores();
      });
    } else if (value == 'Editar') {
      final listaCargos = await consultarLsCargo();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditarColaboradorForm(
            colaborador: status,
            listaCargos: listaCargos,
          );
        },
      );
    }
  }

  Widget _buildFiltros() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          _buildFiltroAtivo(),
          SizedBox(width: 16),
          Expanded(child: _buildFiltroNome()),
          Expanded(child: _buildFiltroCargo()),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearFilters,
            tooltip: 'Limpar Filtros',
          ),
        ],
      ),
    );
  }

  Widget _buildFiltroAtivo() {
    return Row(
      children: [
        Text('Ativo: '),
        Switch(
          value: _filtroAtivo,
          onChanged: (value) {
            setState(() {
              _filtroAtivo = value;
              _inAtivo = _filtroAtivo ? 1 : 0;
              _fetchColaboradores();
            });
          },
        ),
      ],
    );
  }

  Widget _buildFiltroNome() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Nome do colaborador',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        setState(() {
          _filtroNome = value;
          _applyFilters();
        });
      },
    );
  }

  Widget _buildFiltroCargo() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Cargo',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        setState(() {
          _filtroCargo = value;
          _applyFilters();
        });
      },
    );
  }

  void _applyFilters() {
    setState(() {
      _filteredColaboradores = _colaboradores.where((colaborador) {
        final matchNome = colaborador.nmColaborador
            .toLowerCase()
            .contains(_filtroNome.toLowerCase());
        final matchCargo = colaborador.nmCargo
            .toLowerCase()
            .contains(_filtroCargo.toLowerCase());
        return matchNome && matchCargo;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _filtroNome = '';
      _filtroCargo = '';
      _filtroAtivo = true;
      _inAtivo = 1;
      _futureColaboradores = consultaLsColaboradores(_inAtivo);
      _futureColaboradores.then((data) {
        _colaboradores = data;
        _applyFilters();
      });
    });
  }
}
