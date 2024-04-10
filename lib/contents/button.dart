import 'package:flutter/material.dart';
import '../style/custom_color.dart';
import 'package:flutter/cupertino.dart';

// 현재 반응형 코드가 아니기에, 재사용성이 있을 것같은 Birth_button만 생성하였음
class Birth_button extends StatefulWidget {
  final TextEditingController Controll;

  Birth_button({
    required this.Controll,
  });

  @override
  State<Birth_button> createState() => _Birth_buttonState();
}

class _Birth_buttonState extends State<Birth_button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(100, 50),
        backgroundColor: CustomColor().yellow(),
      ),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            final initDate = DateTime.now();
            return Container(
              height: 300,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 취소버튼을 눌렀을 경우, 생년월일에 들어갔던 String 데이터를 지우는 효과
                      TextButton(
                        onPressed: () {
                          setState(() {
                            // 상태를 변경하는 데 사용
                            widget.Controll.clear(); // _birthController 값을 초기화
                          });
                          Navigator.pop(context); // 다이얼로그 닫기
                        },
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: CustomColor().red(),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '완료',
                          style: TextStyle(
                            color: CustomColor().blue(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    //CuperinoDatePicker라는 날짜를 선택하게 할수 있는 위젯
                    child: CupertinoDatePicker(
                      maximumYear: DateTime.now().year,
                      maximumDate: DateTime.now(),
                      initialDateTime: initDate,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime date) {
                        final selectedDate =
                            DateTime(date.year, date.month, date.day);
                        setState(() {
                          widget.Controll.text =
                              selectedDate.toIso8601String().split('T')[0];
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          },
          // 다른 곳을 클릭했을때 상호작용을 무시하기 위해 false값 적용
          barrierDismissible: false,
        );
      },
      child: Text(
        '생년월일',
        style: TextStyle(
          color: CustomColor().text(),
        ),
      ),
    );
  }
}
