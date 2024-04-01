import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screen/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // for 안드로이드
        GlobalCupertinoLocalizations.delegate, // for IOS
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KO'),
      ],
      title: 'Appbar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/splash.png'),
        nextScreen: MyPage(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
        splashIconSize: 200,
        //backgroundColor: Colors.white,
        //duration: 3000,
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}