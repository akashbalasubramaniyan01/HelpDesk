import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/view/MainViewPage.dart';
import 'package:helpdesk/view/home_page.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:animate_do/animate_do.dart';
import 'package:helpdesk/view/MainViewPage.dart';
import 'package:helpdesk/view/home_page.dart';
import 'package:helpdesk/view/signin.dart';
import 'config/axpertAppSettings.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/view/MainViewPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:helpdesk/view/login.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:http_auth/http_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'config/axpertAppSettings.dart';
import 'model/LoginModel.dart';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
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
    initdeviceid();
    super.initState();

  }
  List <LoginModel>LoginModels=[];
  String userName = "";
  String Password =  "";
  Future<void> initdeviceid() async {
    final prefs = await SharedPreferences.getInstance();
    setState(()  {
      userName = prefs.getString('UserName')??"";
      Password =  prefs.getString('PassWord')??"";
    });

    if (userName.isNotEmpty && Password.isNotEmpty) {
      DigestAuthClient client = DigestAuthClient(
          'ri2helpdeskuser', r'6i$qu@6e');
      var url = "${GlobalConfiguration().get("ApiURl")}apilogin";
      print(url);
      http.Response response = await client.post(
          Uri.parse(url),
          headers: {
            'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
            'Content-Type': 'application/json',
            'Cookie': 'ci_session=691airnq2vc9vimljkp2j2fe6ml7bgfe'
          },
          body: json.encode({
            "userid": userName,
            "password": Password,
            "count": 0
          })
      );


      print(response.statusCode);


      setState(() {
        print(response.body);
        var jsonResponse = json.decode(response.body);

        LoginModels = [jsonResponse]
            .map((taskJson) => LoginModel.fromJson(taskJson))
            .toList();
      });


      Timer(Duration(seconds: 3),
              () =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder:
                      (context) =>
                      MainPage(0, loginModels: LoginModels)
                  )
              )
      );
    }else{
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  HomePage()
              )
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        FadeInUp(
        delay: Durations.extralong4,
        child: Center(
        child: Container(
        color: Colors.white,
        child: Image.asset('assets/logo.png')
    ),)),
          Container(height: 40,),
          AnimatedTextKit(
            animatedTexts: [

              ColorizeAnimatedText(
                speed: Duration(milliseconds: 10),
                'ELTEE',
                textStyle: GoogleFonts.poppins(
                    fontSize: 50,
                    fontWeight:FontWeight.bold
                ),
                colors:[ MyColors.btnBorderColor, Colors.yellow],
              ),
              ColorizeAnimatedText(
                'SOLUTIONS',
                textStyle: GoogleFonts.poppins(
                    fontSize: 50,
                    fontWeight:FontWeight.bold
                ),
                colors:[ MyColors.btnBorderColor, Colors.yellow],
              ),


            ],
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
            onTap: () {
              print("Tap Event");
            },
          ),
        ],
      ),
    );
  }
}