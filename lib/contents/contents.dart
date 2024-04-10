import 'package:flutter/material.dart';
import '../style/custom_color.dart';
// 공통적으로 사용하는 모듈이기때문에 별도로 contents 라는 dart파일로 만듦,
// 화면의 최상단에 나오는 제목을 위한 코드 text값을 필요매개변수로 받음
class TitleBanner extends StatelessWidget {
  final String text;

  TitleBanner({
   required this.text,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Banner.png'),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: CustomColor().text(),
          ),
        ),
      ),
    );
  }
}