import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../contents/contents.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';
import 'dart:io';
import '../back_module/firebase.dart';
import '../back_module/sqlclient.dart';
import '../back_module/modelapi.dart';
import 'login_screen.dart';

class MyCamera2 extends StatefulWidget {
  @override
  State<MyCamera2> createState() => _MyCamera2State();
}

class _MyCamera2State extends State<MyCamera2> {
  String? user_no;
  String? label;
  String? dic_no;
  String? mydic_no;
  bool isLoading = true;

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

  void GetData(String path) async {
    //모델api 접근
    // 모델에 접근하여 이미지의 label을 불러오며, 잘못되었을경우 오류라고 출력
    // eng인 이유는 모델이 영어로 받는것이 매우 정확하기 때문
    String future_eng = await GetLabel().get_label(path) ?? "오류";
    late String? future_label;
    String? future_dic_no;

    if (future_eng != "오류") {
      // eng통해 sql 접근
      // 만약에 "오류" 라는 단어와 다를경우 SQL에 접근하여 라벨을 불러옴
      future_label = await sqlget().GetWordKorByEng(eng: future_eng);
      future_dic_no = await sqlget().GetNoByEng(eng: future_eng);
    } else {
      future_label = "서버 오류";
    }

    setState(() {
      label = future_label;
      dic_no = future_dic_no;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // 네비게이터 데이터 받기
    super.initState();
    Checktoken();
  }

  @override
  Widget build(BuildContext context) {
    // UploadCamera에서 Route Setting 값으로 보낸것을 받아오기 위한 코드
    var arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String path = arguments['path'];

    if (label == null) {
      GetData(path);
    }

    return Scaffold(
      appBar: Appbar_screen(
        isMainScreen: false,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        color: Colors.black.withOpacity(0.1))
                  ]),
              child: Image.file(
                  File(path)), // 받은 이미지를 다시 창에 띄게 하기 위해 Path에있는 image값 호출
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: isLoading
                  ? SizedBox(
                      width: 260,
                      height: 10,
                      child: LinearProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(CustomColor().green()),
                        backgroundColor: CustomColor().yellow(),
                      ),
                    ) // 모델 API에서 라벨데이터를 가져오는 중일 때 ProgressIndicator를 보여줌
                  : Text(
                      label!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
              alignment: Alignment.center,
              width: 300,
              height: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: Row(
                // 정해진 사이즈의 양끝의 값을 0으로 벌리기 위해 spaceBetween 사용
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
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
                    /*
                    * 한국어 라벨을 받았을 경우 sql문을 통하여 user_no와 mydic_no 를 받아 그안에 정보데이터를 저장하는 방법
                    * 모델 API를 돌려 kor 라벨을 받지않았을 경우에는 저장이 안되게 막아놓는 코드 포함
                    * */
                    onPressed: () async {
                      if (dic_no != null) {
                        String? mydic_no = await sqlget().GetNewMyDicNo();
                        await FirebaseClient(
                                user_no: user_no, mydic_no: mydic_no)
                            .upload(path);
                        await sqlget().SaveImageInfo(
                            user_no: user_no,
                            dic_no: dic_no,
                            mydic_no: mydic_no);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('저장되었습니다.'),
                        ));
                        Navigator.popUntil(context, (route) => route.isFirst);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('한국어 라벨을 받은 뒤 저장해주시기 바랍니다.'),
                        ));
                      }
                    },
                    child: Text(
                      '저장하기',
                      style: TextStyle(fontSize: 14, color: Colors.white),
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
      ),
      bottomNavigationBar: BottomScreen(),
      floatingActionButton: BottomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
