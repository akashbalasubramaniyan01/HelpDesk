import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/view/home_page.dart';
import 'package:global_configuration/global_configuration.dart';

import 'config/axpertAppSettings.dart';
Future<void> main() async {
  GlobalConfiguration().loadFromMap(AppSettings);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Intro Screen',
      theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 30,
              color: MyColors.titleTextColor,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
                fontSize: 18,
                color: MyColors.subTitleTextColor,
                fontWeight: FontWeight.w400,
                wordSpacing: 1.2,
                height: 1.2),
            displaySmall: TextStyle(
              fontSize: 18,
              color: MyColors.titleTextColor,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}