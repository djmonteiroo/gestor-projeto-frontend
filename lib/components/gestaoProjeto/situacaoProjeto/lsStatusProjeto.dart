import 'package:dasboard_project/services/statusProjetoService.dart';
import 'package:flutter/material.dart';
import 'package:dasboard_project/models/StatusProjetoModel.dart';

class LsStatusProjeto extends StatefulWidget {
  @override
  _LsStatusProjetoState createState() => _LsStatusProjetoState();
}

class _LsStatusProjetoState extends State<LsStatusProjeto> {
  late Future<List<StatusProjetoModel>> _statusProjeto;

  @override
  void initState() {
    super.initState();
    _statusProjeto = consultaLsStatusProjeto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<StatusProjetoModel>>(
        future: _statusProjeto,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to fetch data: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildDataTable(snapshot.data!);
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }

  Widget _buildDataTable(List<StatusProjetoModel> data) {
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
                  DataColumn(label: Text('Status Projeto')),
                  DataColumn(label: Text('Ativo')),
                  DataColumn(label: Text('Data de Cadastro')),
                  DataColumn(label: Text('Ações'))
                ],
                rows: data.map((status) {
                  return DataRow(cells: [
                    DataCell(Text(status.idSituacaoProjeto?.toString() ?? '')),
                    DataCell(Text(status.nmSituacaoProjeto)),
                    DataCell(Text(status.inAtivo == 1 ? 'Sim' : 'Não')),
                    DataCell(Text(status.dataCadastro ?? '')),
                    DataCell(
                      status.inAtivo == 1
                          ? TextButton(
                              onPressed: () {
                                desativarStatusProjeto(
                                        status.idSituacaoProjeto?.toString() ??
                                            '')
                                    .then((_) {
                                  setState(() {
                                    _statusProjeto = consultaLsStatusProjeto();
                                  });
                                });
                              },
                              child: Tooltip(
                                message: "Desativar",
                                child: Icon(Icons.disabled_by_default_rounded),
                              ),
                            )
                          : status.inAtivo == 0
                              ? TextButton(
                                  onPressed: () {
                                    ativarStatusProjeto(status.idSituacaoProjeto
                                                ?.toString() ??
                                            '')
                                        .then((_) {
                                      setState(() {
                                        _statusProjeto =
                                            consultaLsStatusProjeto();
                                      });
                                    });
                                  },
                                  child: Tooltip(
                                    message: "Ativar",
                                    child: Icon(Icons.library_add_check),
                                  ),
                                )
                              : SizedBox(), // Empty cell if not active
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
