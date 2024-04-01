import 'package:flutter/material.dart';
import '../contents/button.dart';
import '../style/custom_color.dart';
import '../contents/join_content.dart';
import '../back_module/sqlclient.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _conpwController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool IdCheck = false; // 아이디 중복확인
  String? _confirmPasswordError;
  int? _selectedGender;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    // 여기에 추가적인 비밀번호 유효성 검사 로직을 추가할 수 있습니다.
    // 예를 들어, 최소 길이, 특수문자 포함 등의 규칙을 검사할 수 있습니다.
    return null;
  }

  bool CheckJoin() {
    // 1. 비밀번호 공백인지 + 동일한지
    bool PwCheck = (_pwController.text == _conpwController.text) &&
        (_pwController.text != "");
    return IdCheck && PwCheck;
  }

  void initState() {
    super.initState();
    _conpwController.addListener(_checkConfirmPassword);
  } // listener 기능 - 위의 코드가 실행될 때, 동시에 이 함수를 같이 실행시켜라

  void dispose() {
    _conpwController.removeListener(_checkConfirmPassword);
    super.dispose(); // join_screen이 끝날 때, 이 함수도 꺼라
  }

  // 비밀번호 확인 필드 값 변경 시 호출되는 함수
  void _checkConfirmPassword() {
    setState(() {
      if (_conpwController.text != _pwController.text) {
        _confirmPasswordError = '비밀번호가 일치하지 않습니다.';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar 들어갈 부분
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Register_form(
                  first_Text: '아이디',
                  hint_Text: '아이디를 입력하세요',
                  Controll: _idController,
                  Obsure: false,
                  width: 210,
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(100, 50),
                    backgroundColor: CustomColor().yellow(),
                  ),
                  onPressed: () async {
                    // 빈칸 입력 시
                    if (_idController.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('아이디를 입력해주시기 바랍니다.'),
                      ));
                      IdCheck = false; // IDCheck 중복 확인이 안 됐거나, 중복이거나
                      return; // 밑에까지 안 가고 여기서 코드를 끝낸다.
                    }

                    // 버튼 클릭 시 동작 추가
                    String? check = await sqlget()
                        .GetUserByIdPw(id: _idController.text);
                    if (check == 'pw') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('중복된 아이디가 있습니다.'),
                      ));
                      IdCheck = false;
                    } else if (check == 'id') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('사용 가능 합니다.'),
                      ));
                      IdCheck = true;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('서버 오류, 다시 시도해주시기 바랍니다.'),
                      ));
                      IdCheck = false;
                    }
                  },
                  child: Text(
                    '중복확인',
                    style: TextStyle(
                      color: CustomColor().text(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Register_Pwform(
                first_Text: '비밀번호',
                hint_Text: '비밀번호를 입력하세요',
                Controll: _pwController,
                Obsure: true,
                validator: validatePassword),
            SizedBox(
              height: 30,
            ),
            Register_ConfirmPwform(
              first_Text: '비밀번호 확인',
              hint_Text: '비밀번호를 입력하세요',
              Controll: _conpwController,
              Obsure: true,
              validator: (value) {
                // value = _conpwController
                if (value != _pwController.text) {
                  return '비밀번호가 일치하지 않습니다.';
                }
                return null; // 위의 조건 통과
              },
              errorText: _confirmPasswordError,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Register_form(
                  first_Text: '생년월일',
                  hint_Text: '예시 YYYY-MM-DD',
                  Controll: _birthController,
                  Obsure: false,
                  width: 210,
                ),
                SizedBox(
                  width: 20,
                ),
                Birth_button(Controll: _birthController)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Register_form(
                first_Text: '이름',
                hint_Text: '이름을 입력하세요',
                Controll: _nameController,
                Obsure: false),
            SizedBox(
              height: 30,
            ),
            GenderRadio(
              onGenderSelected: (int gender) {
                setState(() {
                  _selectedGender = gender;
                });
              },
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(160, 50),
                  backgroundColor: CustomColor().blue(),
                  foregroundColor: Colors.white),
              onPressed: () async {
                // if (_idController.text = "") {
                //
                // }
                if (IdCheck != true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('아이디 중복확인을 해주세요.')));
                  return;
                }

                bool Join_Ok = CheckJoin();

                if (Join_Ok) {
                  int genderValue = _selectedGender ?? -1;
                  bool result = await sqlget().UserJoin(
                      id: _idController.text,
                      pw: _pwController.text,
                      gender: genderValue,
                      birth: _birthController.text,
                      name: _nameController.text);
                  if (result) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text('회원가입 성공!'),
                    ));
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text('서버 연결 오류!'),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('모든 항목들을 작성해주세요.'),
                  ));
                }
              },
              child: Text(
                '회원가입',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(160, 50),
                  backgroundColor: CustomColor().red(),
                  foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '뒤로가기',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            JoinBack()
          ],
        ),
      ),
    );
  }
}
