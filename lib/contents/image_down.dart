import 'package:flutter/material.dart';
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
      future: FirebaseClient(user_no: widget.user_no, mydic_no : widget.mydic_no).loadImage(),// null 체크 추가
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!, fit: BoxFit.cover, width: 140, height: 100);
        } else {
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