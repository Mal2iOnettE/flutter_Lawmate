
import 'package:final_project_ver_2/ChatPage/ChatPage.dart';
import 'package:final_project_ver_2/Login/LoginByPhoneNumber.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/HomePage.dart';
import 'package:final_project_ver_2/SplashScreen/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splashscreen/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{    
            '/homepage': (BuildContext context) => HomePage(),    
            '/loginpage': (BuildContext context) => LoginByPhoneNumber(),
            //'/loginpage': (BuildContext context) => LoginByPhoneNumber(),        
            }, 
      theme: ThemeData(
        primaryColor: Color(0xFF010037),
      ),
      home: SplashScreenMain(),
      //home: LoginByPhoneNumber(),
    );
  }

  
}
