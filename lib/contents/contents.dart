import 'package:flutter/material.dart';
import '../style/custom_color.dart';

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