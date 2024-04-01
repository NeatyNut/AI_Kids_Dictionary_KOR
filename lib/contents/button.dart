import 'package:flutter/material.dart';
import '../style/custom_color.dart';
import 'package:flutter/cupertino.dart';

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
                      TextButton(
                        onPressed: () {
                          setState(() {
                            // 상태를 변경하는 데 사용
                            widget.Controll.clear(); // _birthController 값을 초기화
                          });
                          Navigator.pop(context); // 다이얼로그 닫기
                        },
                        child: Text(
                          'Cancel',
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
                          'Done',
                          style: TextStyle(
                            color: CustomColor().blue(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
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
