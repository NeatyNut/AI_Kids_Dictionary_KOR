import 'package:flutter/material.dart';
import 'package:mmd/screen/dict_list_screen.dart';
import 'package:mmd/screen/profile_screen.dart';
import 'package:mmd/screen/quiz/book_list.dart';
import 'package:mmd/screen/upload_camera.dart';
import 'package:mmd/style/custom_color.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double stateBarHeight = MediaQuery.of(context).padding.top; // 기본적인 상태바의 크기 공간을 띄우기 위해 변수 정의
    return Drawer(
      width: MediaQuery.of(context).size.width, // 각 모바일 Device의 전체범위를 지정하기 위해 MediaQuery 사용
      child: Container( // 뒷배경을 꾸며주기위해 Container로 배경 정의
        margin: EdgeInsets.only(top: stateBarHeight),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/menu_background.png'),
          ),
        ),
        child: Stack( // 각각의 버튼을 임의로 위치 지정을 하기위해 Stack + Mediaquery를 사용하여 배치 하였음
          children: [
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: CustomColor().red(),
                ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
            Positioned( // 각각의 요소를 Positioned으로 지정하였고, Device의 사이즈에 맞게 자리를 배치하기위해 반응형 사용
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.03,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpLoadCamera()));
                },
                child: Column(
                  children: [
                    Image.asset('assets/images/mmd_camera.png'), // 각각의 클릭할 메뉴의 아이콘 이미지
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      color: CustomColor().yellow(),
                      child: Text(
                        '카메라 촬영',
                        style: TextStyle(
                          color: CustomColor().text(),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.18,
              top: MediaQuery.of(context).size.height * 0.22,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DictListScreen()));
                },
                child: Column(
                  children: [
                    Image.asset('assets/images/mmd_dict.png'),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      color: CustomColor().yellow(),
                      child: Text(
                        '나만의 사전',
                        style: TextStyle(
                          color: CustomColor().text(),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.12,
              top: MediaQuery.of(context).size.height * 0.43,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookList()));
                },
                child: Column(
                  children: [
                    Image.asset('assets/images/mmd_quiz.png'),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      color: CustomColor().yellow(),
                      child: Text(
                        '퀴즈! 퀴즈!',
                        style: TextStyle(
                          color: CustomColor().text(),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.4,
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                child: Column(
                  children: [
                    Image.asset('assets/images/mmd_rabbit.png'),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      color: CustomColor().yellow(),
                      child: Text(
                        '나의 프로필',
                        style: TextStyle(
                          color: CustomColor().text(),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
