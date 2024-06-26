import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screen/profile_screen.dart';
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
  String? user_no;

  // 세션 토큰 검사
  void Checktoken() async {
    String? no = await Token().Gettoken();

    if (no == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        user_no = no;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Checktoken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // <-- Appbar -->
      appBar: Appbar_screen(isMainScreen: true),
      // true 일경우 Menu Button
      drawer: MenuScreen(),
      // Menu Button을 Click 할경우 Drawer가 실행됨

      // <-- body -->
      body: SingleChildScrollView(
        // 전체크기의 범주를 벗어나면 Overflowing 현상이 생겨 Scroll 기능 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          // <-- Contents -->
          children: [
            TitleBanner(
              text: '메인 화면',
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              imagepath: 'assets/images/mmd_rabbit.png',
              contentName: '나의 프로필',
              backcolor: CustomColor().yellow(),
            ),
            SizedBox(
              height: 30,
            ),
            // Container(
            //   width: 320,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            // Container(
            //   child: Text(
            //     '나만의 사전',
            //     style: TextStyle(
            //       color: CustomColor().red(),
            //       fontWeight: FontWeight.w700,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // Main_Screen_Dict.Main_FutureBuilder(context, user_no),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),

      // <-- Bottom NavigationBar -->
      /*
      * Floating Action Button 과 BottomNavigationBar가 공존하는 형태를 만들기위해
      * FloatingActionButtonLocation을 CenterDocked로 BottomBar의 부분을 차지하게 만듦
      * */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }
}
