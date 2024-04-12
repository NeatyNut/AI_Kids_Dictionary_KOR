import 'package:flutter/material.dart';
import '../contents/contents.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';
import '../back_module/sqlclient.dart';
import '../screen/login_screen.dart';
import '../contents/image_down.dart';
import '../back_module/modelapi.dart';
import '../back_module/audioplay.dart';
import 'dart:typed_data';

class Dict_Screen extends StatefulWidget {
  const Dict_Screen({Key? key}) : super(key: key);

  @override
  State<Dict_Screen> createState() => _Dict_ScreenState();
}

class _Dict_ScreenState extends State<Dict_Screen> {
  String? user_no;
  Uint8List? byte;

  // 세션 토큰 검사
  Future<void> _Checktoken() async {
    String? no = await Token().Gettoken();

    if (no == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        user_no = no;
      });}
  }
  // 발음듣기 버튼을 눌렀을경우 실행될 함수
  Future<void> GetbyteAndPlay(String? kor) async {
    Uint8List? Futurebyte = await GetSound(text:kor!).get_voice();
    setState(() {
      byte = Futurebyte;
    });

    byte!=null ? audioplay().byteplay(byte!):print("실패");
  }

  @override
  void initState() {
    super.initState();
    _Checktoken();
  }

  // DictListScreen에서 받아온 정보를 사용하기 위한 args변수 정의
  @override
  Widget build(BuildContext context) {
    final Map<String, String?> args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    // 가져온 정보 사용하기
    final String? mydic_no = args['mydic_no'];
    final String? kor = args['kor'];
    final String? eng = args['eng'];
    final String? mean = args['mean'];

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
              // Storage 에 저장된 이미지를 불러오는 코드
              child: SnapShotImage(user_no:user_no,mydic_no:mydic_no),
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
                    onPressed: () {
                      if (byte==null) {
                        GetbyteAndPlay(kor!); // 한국어로 저장된 label을 읽어주게함
                      }

                      byte!=null ? audioplay().byteplay(byte!):print("실패"); // 실패할경우
                    },
                    child: Text('발음듣기'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Container(
                width: 300,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text(mean!,
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
