import 'package:flutter/material.dart';
import '../style/custom_color.dart';
import '../back_module/firebase.dart';
import 'dart:typed_data';

class SnapShotImage extends StatefulWidget {
  final String? user_no;
  final String? mydic_no;

  const SnapShotImage({
    required this.mydic_no,
    required this.user_no,
  });

  @override
  State<SnapShotImage> createState() => _SnapShotState();
}

class _SnapShotState extends State<SnapShotImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      // user_id / mydic_no
      // FirebaseClient에 접근하여 user_no와 mydic_no를 제공받아 이미지를 Load함
      future: FirebaseClient(user_no: widget.user_no, mydic_no: widget.mydic_no)
          .loadImage(), // null 체크 추가
      builder: (context, snapshot) {
        // 데이터가 존재한다면 Image.memory로 호출하게되어있음 그렇다면 File함수로 메모리를 이미지로 출력 가능
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!,
              fit: BoxFit.cover, width: 140, height: 100);
        } else if (widget.mydic_no == 'Profile') {
          return Image.asset(
            'assets/images/profile.png',
            fit: BoxFit.cover,
            color: CustomColor().blue(),
          );
        } else {
          // Storage에서 이미지를 받아오는동안 CircularProgressIndicator(로딩위젯) 나오게함
          return SizedBox(
            width: 140,
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}