import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/custom_color.dart';
import 'dart:math';

class Register_form extends StatefulWidget {
  final String first_Text;
  final String hint_Text;
  final TextEditingController Controll;
  final bool Obsure;
  final double width; // 너비를 조절할 속성 추가
  final double height; // 높이를 조절할 속성 추가

  Register_form({
    required this.first_Text,
    required this.hint_Text,
    required this.Controll,
    required this.Obsure,
    this.width = 330,
    this.height = 80,
  });

  @override
  State<Register_form> createState() => _Register_formState();
}

// 아이디 및 비밀번호 TextField
class _Register_formState extends State<Register_form> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
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

class Register_Pwform extends StatefulWidget {
  final String first_Text;
  final String hint_Text;
  final TextEditingController Controll;
  final bool Obsure;
  final String? Function(String?) validator;
  final String? errorText;

  const Register_Pwform({
    Key? key,
    required this.first_Text,
    required this.hint_Text,
    required this.Controll,
    required this.Obsure,
    required this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  State<Register_Pwform> createState() => _Register_PwformState();
}

class _Register_PwformState extends State<Register_Pwform> {
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
          TextFormField(
            validator: widget.validator,
            controller: widget.Controll,
            obscureText: widget.Obsure,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 16, color: CustomColor().text()),
              filled: true,
              fillColor: Color(0xFFF6F6F6),
              hintText: widget.hint_Text,
              errorText: widget.errorText,
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

class Register_ConfirmPwform extends StatefulWidget {
  final String first_Text;
  final String hint_Text;
  final TextEditingController Controll;
  final bool Obsure;
  final String? Function(String?) validator;
  final String? errorText;

  const Register_ConfirmPwform({
    Key? key,
    required this.first_Text,
    required this.hint_Text,
    required this.Controll,
    required this.Obsure,
    required this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  State<Register_ConfirmPwform> createState() => _Register_ConfirmPwformState();
}

class _Register_ConfirmPwformState extends State<Register_ConfirmPwform> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 110,
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
          TextFormField(
            validator: widget.validator,
            controller: widget.Controll,
            obscureText: widget.Obsure,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 16, color: CustomColor().text()),
              filled: true,
              fillColor: Color(0xFFF6F6F6),
              hintText: widget.hint_Text,
              errorText: widget.errorText,
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide:
                    BorderSide(color: Colors.red), // 에러가 발생했을 때의 경계선 스타일 지정
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    color: Colors.red), // 포커스를 받았을 때 에러가 발생했을 때의 경계선 스타일 지정
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

enum Gender { male, female }

class GenderRadio extends StatefulWidget {
  final Function(int) onGenderSelected; // 선택된 성별을 알려주는 콜백 함수

  const GenderRadio({required this.onGenderSelected, Key? key}) : super(key: key);

  @override
  _GenderRadioState createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 330,
          child: Text(
            '성별',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: CustomColor().text(),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 220,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGender = Gender.male;
                    widget.onGenderSelected(0); // 선택된 성별을 콜백 함수로 전달
                  });
                },
                child: Container(
                  width: 100,
                  height: 60,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _selectedGender == Gender.male
                        ? CustomColor().green()
                        : CustomColor().yellow(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '남자',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGender = Gender.female;
                    widget.onGenderSelected(1); // 선택된 성별을 콜백 함수로 전달
                  });
                },
                child: Container(
                  width: 100,
                  height: 60,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _selectedGender == Gender.female
                        ? CustomColor().green()
                        : CustomColor().yellow(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '여자',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class JoinBack extends StatelessWidget {
  const JoinBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.transparent,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            'assets/images/mmd_quiz.png',
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 86,
          child: Transform(
            transform: Matrix4.rotationY(pi),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/sb_1.png',
              height: 120, // 이미지의 세로 크기를 지정합니다.
              width: double.infinity,
              fit: BoxFit.contain,
              color: Color(0xFFE8E8E8),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 130, // 화면 크기에 따라 동적으로 조정됩니다.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '자 마지막이야! 우리 힘차게 \n 회원가입 버튼을 눌러볼까?!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: CustomColor().text(),
                  // CustomColor().text() 대신에 적절한 색상을 지정하세요.
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
