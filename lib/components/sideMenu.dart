import 'package:dasboard_project/config/size_config.dart';
import 'package:dasboard_project/dasboard.dart';
import 'package:dasboard_project/style/colors.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        color: AppColors.secondaryBg,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Icon(
                    Icons.dashboard,
                  ),
                ),
              ),
              IconButton(
                  color: AppColors.colorMenuPrincipal,
                  onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Dashboard();
                      })),
                  icon: const Icon(Icons.cases_rounded)),
              IconButton(
                  color: AppColors.colorMenuPrincipal,
                  onPressed: () {},
                  icon: const Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}
