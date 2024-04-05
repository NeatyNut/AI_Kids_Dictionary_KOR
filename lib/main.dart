import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'back_module/firebase.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseInit().SetFirebase();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
