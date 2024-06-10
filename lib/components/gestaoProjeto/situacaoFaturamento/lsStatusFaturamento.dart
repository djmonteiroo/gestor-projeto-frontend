import 'package:flutter/material.dart';
import 'package:dasboard_project/models/StatusFaturamentoModel.dart';
import 'package:dasboard_project/services/statusFaturamentoService.dart';

class LsStatusFaturamento extends StatefulWidget {
  @override
  _LsStatusFaturamentoState createState() => _LsStatusFaturamentoState();
}

class _LsStatusFaturamentoState extends State<LsStatusFaturamento> {
  late Future<List<StatusFaturamentoModel>> _statusFaturamento;

  @override
  void initState() {
    super.initState();
    _statusFaturamento = consultalsStatusFaturamento();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<StatusFaturamentoModel>>(
        future: _statusFaturamento,
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

  Widget _buildDataTable(List<StatusFaturamentoModel> data) {
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
                  DataColumn(label: Text('Status Faturamento')),
                  DataColumn(label: Text('Ativo')),
                  DataColumn(label: Text('Data de Cadastro')),
                  DataColumn(label: Text('Ações'))
                ],
                rows: data.map((status) {
                  return DataRow(cells: [
                    DataCell(
                        Text(status.idSituacaoFaturamento?.toString() ?? '')),
                    DataCell(Text(status.nmSituacaoFaturamento)),
                    DataCell(Text(status.inAtivo == 1 ? 'Sim' : 'Não')),
                    DataCell(Text(status.dataCadastro ?? '')),
                    DataCell(
                      status.inAtivo == 1
                          ? TextButton(
                              onPressed: () {
                                desativarStatusFaturamento(status
                                            .idSituacaoFaturamento
                                            ?.toString() ??
                                        '')
                                    .then((_) {
                                  setState(() {
                                    _statusFaturamento =
                                        consultalsStatusFaturamento();
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
                                    ativarStatusFaturamento(status
                                                .idSituacaoFaturamento
                                                ?.toString() ??
                                            '')
                                        .then((_) {
                                      setState(() {
                                        _statusFaturamento =
                                            consultalsStatusFaturamento();
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
