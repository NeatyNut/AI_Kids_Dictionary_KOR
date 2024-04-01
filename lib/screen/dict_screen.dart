import 'package:flutter/material.dart';
import '../contents/contents.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';

class Dict_Screen extends StatefulWidget {
  const Dict_Screen({Key? key}) : super(key: key);

  @override
  State<Dict_Screen> createState() => _Dict_ScreenState();
}

class _Dict_ScreenState extends State<Dict_Screen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String?> args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    // 가져온 정보 사용하기
    final String? image = args['image'];
    final String? kor = args['kor'];
    final String? eng = args['eng'];
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(text: '나만의 사전'),
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 3,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
                color: Colors.white,
              ),
              child: Image.asset(image ?? "", fit: BoxFit.cover,),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 60,
                    child: Text("$kor / $eng"),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 60),
                      backgroundColor: CustomColor().yellow(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    onPressed: () {},
                    child: Text('발음듣기'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Container(
                width: 300,
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Text(
                      '하하',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }
}
