import 'package:dasboard_project/dasboard.dart';
import 'package:dasboard_project/style/icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dasboard_project/style/colors.dart';

class MenuGestaoProjeto extends StatelessWidget {
  final Function(int) onMenuButtonTapped;

  const MenuGestaoProjeto({
    Key? key,
    required this.onMenuButtonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Tooltip(
            message: "Inicio",
            child: TextButton(
              onPressed: () => onMenuButtonTapped(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.home,
                  color: AppColors.colorMenu,
                ),
              ),
            ),
          ),
          Tooltip(
            message: "Situação de Faturamento",
            child: TextButton(
                onPressed: () => onMenuButtonTapped(1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.monetization_on,
                    color: AppColors.colorMenu,
                  ),
                )),
          ),
          Tooltip(
            message: "Situação de Projetos",
            child: TextButton(
                onPressed: () => onMenuButtonTapped(2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.receipt_long,
                    color: AppColors.colorMenu,
                  ),
                )),
          ),
          Tooltip(
            message: "Colaboradores/Time",
            child: TextButton(
                onPressed: () => onMenuButtonTapped(3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.people,
                    color: AppColors.colorMenu,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
