import 'package:flutter/material.dart';
import 'package:mmd/screen/main_screen.dart';
import 'package:mmd/screen/quiz/book_list.dart';
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
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
      * 현재 디바이스의 기기의 언어 기반으로 되어있기에 LocalizationsDelegates를 사용하여 언어의 범주를 넓힌 뒤,
      * supportedLocales를 사용하여 한국어 기반으로 언어를 적용시키기 위해 사용
      */
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KO'),
      ],
      title: 'Appbar',
      debugShowCheckedModeBanner: false,
      /*
      * Font를 NotoSansKR로 쓰기위해 App의 ThemeData에 Font를 전부 적용 시키며,
      * 처음에 Splash Screen을 쓰기위해 home에 배치하고, 3초간 유지 한 뒤 MyPage() 클래스가
      * 실행되게 구조 해놓았음
      * */
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/splash.png'),
        nextScreen: MyPage(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
        splashIconSize: 200,
      ),
      routes: {
        '/main': (context) => MainScreen(),
        '/book': (context) => BookList(),
      },
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
