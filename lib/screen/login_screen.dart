import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../contents/login_content.dart';
import 'join_screen.dart';
import '../style/custom_color.dart';
import 'main_screen.dart';
import '../back_module/sqlclient.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoginPlatform {
  google,none
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  LoginPlatform loginPlatform = LoginPlatform.none;

  @override
  void initState() {
    super.initState();
    GetNumber();
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      setState(() {
        loginPlatform = LoginPlatform.google;
      });

      // 사용자 유무
      // sql에서 email, pw(googleUser.id) 체크
      String? userNo = await sqlget().GetUserByIdPw(id: googleUser.email, pw: googleUser.id);
      // 없으면 회원가입 (DB에 사용자 저장)
      if(userNo == 'id' || userNo == 'pw') {
        // 회원가입
        String name = googleUser.displayName as String;
        bool joinResult = await sqlget().UserJoin(
            id: googleUser.email,
            pw: googleUser.id,
            name: name);
        if(joinResult) {
          String? newUserNo = await sqlget().GetUserByIdPw(id: googleUser.email, pw: googleUser.id);
          Token().Settoken(userNo);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(),
                settings: RouteSettings(
                    arguments: {'user_no': newUserNo})),
          );
        }
      } else {
        // 로그인
        Token().Settoken(userNo);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(),
              settings: RouteSettings(
                  arguments: {'user_no': userNo})),
        );
      }
    }
  }

  Future<void> GetNumber() async {
    String? user_no = await Token().Gettoken();
    print(user_no);
    if (user_no != null) {
      // 다음 화면 넘기기
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(),
            settings: RouteSettings(
                arguments: {'user_no': user_no})),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar 추가될 부분
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              //로그인 배경
              alignment: Alignment.center,
              children: [
                LoginBackTop(
                    backcolor: CustomColor().yellow(),
                    backright: 0,
                    backbottom: -10,
                    imagepath: 'assets/images/mmd_rabbit.png'),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 60,
                  child: Column(
                    // 로그인 부분
                    children: [
                      Column(
                        children: [
                          loginTile(
                              first_Text: '아이디',
                              hint_Text: '아이디를 입력하세요',
                              Controll: _idController,
                              Obsure: false),
                          SizedBox(
                            height: 20,
                          ),
                          loginTile(
                              first_Text: '비밀번호',
                              hint_Text: '비밀번호를 입력하세요',
                              Controll: _pwController,
                              Obsure: true)
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor().green(),
                            fixedSize: Size(160, 50)),
                        onPressed: () async {
                          if (_idController.text=="" || _pwController.text=="") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('아이디, 비밀번호를 입력해주시기 바랍니다.'),
                            ));
                            return;
                          }

                          String? result = await sqlget().GetUserByIdPw(
                              id: _idController.text, pw: _pwController.text);
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('서버 오류'),
                            ));
                            return;
                          } else if (result == "id") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('아이디가 틀렸습니다.'),
                            ));
                            return;
                          } else if (result == "pw") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('비밀번호가 틀렸습니다.'),
                            ));
                            return;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('로그인 성공!'),
                              duration: Duration(seconds: 3),
                            ));
                            // 로그인 세션 유지
                            Token().Settoken(result);
                            // 다음 화면 넘기기
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                  settings: RouteSettings(
                                      arguments: {'user_no': result})),
                            );
                          }
                        },
                        child: Text(
                          '로그인 하기',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              //회원가입 배경
              alignment: Alignment.center,
              children: [
                LoginBackBottom(
                  backcolor: CustomColor().green(),
                  imagepath: 'assets/images/mmd_bear.png',
                  textcolor: CustomColor().text(),
                  text: '나랑 같이 놀자!',
                  backbottom: -10,
                  backleft: 0,
                ),
                Positioned(
                  top: 50,
                  child: Column(
                    // 회원가입 페이지로 들어가는 부분
                    children: [
                      Column(
                        children: [
                          Register(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JoinScreen()));
                              },
                              imagepath: 'assets/images/M.png',
                              backcolor: CustomColor().yellow(),
                              text: 'MMD 회원가입 하기'),
                          SizedBox(
                            height: 30,
                          ),
                          Register(
                              onPressed: () {
                                signInWithGoogle();
                              },
                              imagepath: 'assets/images/google.png',
                              backcolor: Colors.white,
                              text: '구글로 로그인 하기'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottom Bar 추가될 부분
    );
  }
}
