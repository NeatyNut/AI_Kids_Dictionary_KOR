import 'package:flutter/material.dart';
import '../style/custom_color.dart';
import '../screen/main_screen.dart';

class MainContent extends StatelessWidget {
  final VoidCallback onTap;
  final String imagepath;
  final String contentName;
  final Color backcolor;

  MainContent({
    required this.onTap,
    required this.imagepath,
    required this.contentName,
    required this.backcolor,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 320,
            height: 160,
            decoration: BoxDecoration(
                color: backcolor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0), // 좌측으로 옮길 값 설정
                child: Text(
                  contentName,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: Image.asset(imagepath),
          )
        ],
      ),
    );
  }
}
