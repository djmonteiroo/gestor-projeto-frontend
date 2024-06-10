import 'package:dasboard_project/components/gestaoProjeto/registroColaboradores/registroColaborador.dart';
import 'package:dasboard_project/components/gestaoProjeto/situacaoFaturamento/statusFaturamento.dart';
import 'package:dasboard_project/components/gestaoProjeto/situacaoProjeto/statusProjeto.dart';
import 'package:flutter/material.dart';
import 'package:dasboard_project/components/notificacacaoGestao.dart';
import 'package:dasboard_project/components/gestaoProjeto/menuGestaoProjeto.dart';
import 'package:dasboard_project/components/sideMenu.dart';
import 'package:dasboard_project/config/size_config.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMenuButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu
            const SideMenu(),
            // Páginas Principais
            Expanded(
              flex: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MenuGestaoProjeto(onMenuButtonTapped: _onMenuButtonTapped),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      children: [
                        Text("Construir"),
                        StatusFaturamento(),
                        StatusProjeto(),
                        RegistroColaborador()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Demais dados
            NotificacaoGestao(),
          ],
        ),
      ),
    );
  }
}
