import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/quiz/book_list.dart';
import '../screen/dict_list_screen.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';
import '../contents/main_content.dart';
import '../contents/contents.dart';
import '../state_bar/menu.dart';
import 'upload_camera.dart';
import 'login_screen.dart';
import '../back_module/sqlclient.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar 들어갈 자리
      appBar: Appbar_screen(isMainScreen: true),
      drawer: MenuScreen(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(
              text: 'My Memory Dictionary',
            ),
            SizedBox(
              height: 30,
            ),
            MainContent(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpLoadCamera()));
              },
              imagepath: 'assets/images/mmd_camera.png',
              contentName: '카메라 촬영',
              backcolor: CustomColor().blue(),
            ),
            SizedBox(
              height: 20,
            ),
            MainContent(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DictListScreen()));
              },
              imagepath: 'assets/images/mmd_dict.png',
              contentName: '나만의 사전',
              backcolor: CustomColor().green(),
            ),
            SizedBox(
              height: 20,
            ),
            MainContent(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookList()));
              },
              imagepath: 'assets/images/mmd_quiz.png',
              contentName: '퀴즈! 퀴즈!',
              backcolor: CustomColor().red(),
            ),
            SizedBox(
              height: 20,
            ),
            MainContent(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              imagepath: 'assets/images/mmd_rabbit.png',
              contentName: '나의 프로필',
              backcolor: CustomColor().yellow(),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () async {
              // 로그아웃 기능
              Token().Deltoken();
              await GoogleSignIn().signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }, child: Text('히히')),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      //floating Button + bottom Bar 들어갈 자리
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }
}
