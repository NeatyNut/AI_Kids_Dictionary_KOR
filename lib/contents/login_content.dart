import 'package:flutter/material.dart';
import '../style/custom_color.dart';

/*
* Form을 자동생성하기 위한 모듈화, 어떤 필드인지, 힌트는 어떻게 줄것인지,
* Controller는 어떤것을 쓸것인지, 숨길것인지 나타낼것인지를 필요 매개변수로 받아
* 나머지 사이즈 및, 색상은 고정값으로 사용
* */
class loginTile extends StatefulWidget {
  final String first_Text;
  final String hint_Text;
  final dynamic Controll;
  final bool Obsure;

  loginTile({
    required this.first_Text,
    required this.hint_Text,
    required this.Controll,
    required this.Obsure,
  });

  @override
  State<loginTile> createState() => _loginTileState();
}

// 아이디 및 비밀번호 TextField
class _loginTileState extends State<loginTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 80,
      child: Column(
        children: [
          Container(
            width: 330,
            height: 30,
            child: Text(
              widget.first_Text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: CustomColor().text(),
              ),
            ),
          ),
          TextField(
            controller: widget.Controll,
            obscureText: widget.Obsure,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 16, color: CustomColor().text()),
              filled: true,
              fillColor: Color(0xFFF6F6F6),
              hintText: widget.hint_Text,
              // 힌트 텍스트 색상 및 투명도 조절
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // BorderRadius 적용
                borderSide: BorderSide(color: Color(0xFFF6F6F6)), // 경계선 스타일 지정
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // BorderRadius 적용
                borderSide:
                    BorderSide(color: Colors.blue), // 포커스를 받았을 때 경계선 스타일 지정
              ),
              // 포커스를 받았을 때 경계선 제거
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}

// 로그인 화면 회원가입 및 구글 로그인 버튼
class Register extends StatefulWidget {
  final String imagepath;
  final dynamic backcolor;
  final String text;
  final VoidCallback onPressed;

  Register({
    required this.imagepath,
    required this.backcolor,
    required this.text,
    required this.onPressed,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backcolor,
        ),
        onPressed: widget.onPressed,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(widget.imagepath),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomColor().text(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
* 로그인 화면 의 배경은 코드를 간단하게 보여주기위해 모듈을 따로 제작 하였음
* */
// 로그인 화면 상단 배경
class LoginBackTop extends StatelessWidget {
  final Color backcolor;
  final double? rotateAngle; // double 타입 또는 null을 허용하도록 변경
  final double? backright; // int 타입 또는 null을 허용하도록 변경
  final double? backbottom; // int 타입 또는 null을 허용하도록 변경
  final String imagepath;

  LoginBackTop({
    required this.backcolor,
    this.rotateAngle,
    this.backright,
    this.backbottom,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: backcolor,
          ),
        ),
        if (backright != null &&
            backbottom != null) // backright와 bottom이 null이 아닐 때만 위치 지정
          Positioned(
            right: backright!,
            bottom: backbottom!,
            child: Transform.rotate(
              angle: rotateAngle ?? -0.15, // rotateAngle이 null이면 기본값 사용
              child: Image.asset(imagepath),
            ),
          ),
      ],
    );
  }
}

// 로그인 화면 하단 배경
class LoginBackBottom extends StatelessWidget {
  final Color backcolor;
  final double? rotateAngle; // double 타입 또는 null을 허용하도록 변경
  final double? backleft; // int 타입 또는 null을 허용하도록 변경
  final double? backbottom; // int 타입 또는 null을 허용하도록 변경
  final String imagepath;
  final Color textcolor;
  final String text;

  LoginBackBottom({
    required this.backcolor,
    this.rotateAngle,
    this.backleft,
    this.backbottom,
    required this.imagepath,
    required this.textcolor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: backcolor,
          ),
        ),
        if (backleft != null &&
            backbottom != null) // backright와 bottom이 null이 아닐 때만 위치 지정
          Positioned(
            left: backleft!,
            bottom: backbottom!,
            child: Transform.rotate(
              angle: rotateAngle ?? 0.15, // rotateAngle이 null이면 기본값 사용
              child: Image.asset(imagepath),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 60,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sb_1.png'),
                  fit: BoxFit.contain),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
