import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../contents/contents.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';
import '../back_module/firebase.dart';
import '../back_module/sqlclient.dart';
import '../back_module/modelapi.dart';
import 'login_screen.dart';
import '../contents/image_down.dart';

class MyCamera2 extends StatefulWidget {
  @override
  State<MyCamera2> createState() => _MyCamera2State();
}

class _MyCamera2State extends State<MyCamera2> {
  String? user_no;
  String? eng = null;
  String? label = null;
  String? dic_no = null;
  String? mydic_no;

  // 4. 세션 토큰 검사
  void Checktoken() async {
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

  void GetData() async {
    // mydic_no 넘버 도출
    String? future_mydic_no = await sqlget().GetNewMyDicNo();
    setState(() {
      mydic_no = future_mydic_no;
    });

    // EC2모델 접근
    // String future_eng = await GetLabel(user_no: user_no, mydic_no: mydic_no)
    //     .get_label() ?? "오류";

    setState(() {
      // eng = future_eng.trim();
    });

    if (eng != "오류") {
      // eng통해 sql 접근
      String? future_label = await sqlget().GetWordKorByEng(eng: this.eng);

      setState(() {
        label = future_label;
      });
    } else {
      label = "서버 오류";
    }
  }
  @override
  void initState() {
    super.initState();
    Checktoken();
    FirebaseClient(user_no: user_no, mydic_no: mydic_no).getImage();
    GetData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(
        isMainScreen: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleBanner(text: '카메라 촬영'),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(0.1)
                )
              ]
            ),
            child: SnapShotImage(
              user_no: user_no,
              mydic_no: mydic_no,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: label != null ? Text(label!) : Text("분석 중"), // 얘를 위젯 처리 해야한다. LoadingWidget
            alignment: Alignment.center,
            width: 300,
            height: 60,
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseClient(user_no: user_no, mydic_no: mydic_no)
                        .remove(); // s3 사진 지우기
                    Navigator.pop(context);
                  },
                  child: Text(
                    '취소하기',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor().yellow(),
                    fixedSize: Size(130, 60),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '저장하기',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor().green(),
                    fixedSize: Size(130, 60),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomScreen(),
      floatingActionButton: BottomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class MyPage extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }
//
// class _MyPageState extends State<MyPage> {
//   String _result = '';
//   bool _isAnalyzing = false;
//
//   Future<void> _startAnalysis() async {
//     setState(() {
//       _isAnalyzing = true;
//     });
//
//     // API 호출
//     var response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
//
//     if (response.statusCode == 200) {
//       // 모델 분석이 완료되면 결과 표시
//       setState(() {
//         _result = response.body;
//         _isAnalyzing = false;
//       });
//     } else {
//       // 오류 처리
//       setState(() {
//         _result = '모델 분석에 오류가 발생했습니다.';
//         _isAnalyzing = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('모델 분석'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_isAnalyzing)
//               CircularProgressIndicator() // 분석 중이면 진행 표시줄 표시
//             else
//               Text(_result), // 분석 결과 표시
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _startAnalysis,
//               child: Text('분석 시작'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: MyPage(),
//   ));
// }
