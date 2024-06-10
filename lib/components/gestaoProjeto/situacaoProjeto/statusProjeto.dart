import 'package:dasboard_project/components/gestaoProjeto/situacaoProjeto/lsStatusProjeto.dart';
import 'package:dasboard_project/components/gestaoProjeto/situacaoProjeto/statusFaturamentoForm.dart';
import 'package:dasboard_project/models/StatusProjetoModel.dart';
import 'package:dasboard_project/services/statusProjetoService.dart';
import 'package:flutter/material.dart';

class StatusProjeto extends StatefulWidget {
  @override
  State<StatusProjeto> createState() => _StatusProjetoState();
}

class _StatusProjetoState extends State<StatusProjeto> {
  late Future<List<StatusProjetoModel>> _StatusProjeto;

  @override
  void initState() {
    super.initState();
    _refreshStatusProjeto();
  }

  void _refreshStatusProjeto() {
    setState(() {
      _StatusProjeto = consultaLsStatusProjeto();
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
              child: LsStatusProjeto(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StatusProjetoForm(
                onSuccess: _refreshStatusProjeto, // Passa o callback
              ),
            ),
          ),
        ],
      ),
    );
  }
}
