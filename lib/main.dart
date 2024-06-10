import 'package:dasboard_project/config/size_config.dart';
import 'package:dasboard_project/dasboard.dart';
import 'package:dasboard_project/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConfiGeP',
      theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: AppColors.primaryBg),
      home: Dashboard(),
    );
  }
}
