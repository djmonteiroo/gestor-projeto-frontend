import 'package:dasboard_project/components/gestaoProjeto/situacaoFaturamento/lsStatusFaturamento.dart';
import 'package:dasboard_project/components/gestaoProjeto/situacaoFaturamento/statusFaturamentoForm.dart';
import 'package:dasboard_project/models/StatusFaturamentoModel.dart';
import 'package:dasboard_project/services/statusFaturamentoService.dart';
import 'package:flutter/material.dart';

class StatusFaturamento extends StatefulWidget {
  @override
  State<StatusFaturamento> createState() => _StatusFaturamentoState();
}

class _StatusFaturamentoState extends State<StatusFaturamento> {
  late Future<List<StatusFaturamentoModel>> _statusFaturamento;

  @override
  void initState() {
    super.initState();
    _refreshStatusFaturamento();
  }

  void _refreshStatusFaturamento() {
    setState(() {
      _statusFaturamento = consultalsStatusFaturamento();
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
              child: LsStatusFaturamento(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StatusFaturamentoForm(
                onSuccess: _refreshStatusFaturamento, // Passa o callback
              ),
            ),
          ),
        ],
      ),
    );
  }
}
