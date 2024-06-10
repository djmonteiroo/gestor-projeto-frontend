import 'package:dasboard_project/config/size_config.dart';
import 'package:dasboard_project/style/colors.dart';
import 'package:flutter/material.dart';

class NotificacaoGestao extends StatelessWidget {
  const NotificacaoGestao({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        color: AppColors.secondaryBg,
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month)),
              SizedBox(width: 10.0),
              IconButton(onPressed: () {}, icon: Icon(Icons.notification_add)),
            ]),
          ],
        ),
      ),
    );
  }
}
