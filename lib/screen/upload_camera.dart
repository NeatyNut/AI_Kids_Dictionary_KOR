import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screen/download_camera.dart';
import '../contents/contents.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';
import '../back_module/sqlclient.dart';
import 'login_screen.dart';

class UpLoadCamera extends StatefulWidget {
  const UpLoadCamera({super.key});

  @override
  State<UpLoadCamera> createState() => _UpLoadCameraState();
}

class _UpLoadCameraState extends State<UpLoadCamera> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String? user_no;

  Future<void> _getImage(ImageSource source) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: source, maxWidth: 300, maxHeight: 300);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void Checktoken() async {
    String? no = await Token().Gettoken();

    if (no == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        user_no = no;
      });}
  }

  @override
  void initState() {
    super.initState();
    Checktoken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(text: '카메라 촬영'),
            SizedBox(height: 30),
            _buildPhotoArea(),
            SizedBox(height: 20),
            _buildButton(),
            SizedBox(height: 20),
            _buildSendButton(),
            SizedBox(height: 60)
          ],
        ),
      ),
      floatingActionButton: BottomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomScreen(),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.2)),
              ],
            ),
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '사진을 찍어 주세요!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColor().text(),
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/mmd_camera.png',
                ),
              ],
            ),
          );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor().yellow(),
            fixedSize: Size(130, 60),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            _getImage(ImageSource.camera);
          },
          child: Text(
            "카메라",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor().green(),
            fixedSize: Size(130, 60),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            _getImage(ImageSource.gallery);
          },
          child: Text(
            "갤러리",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor().red(),
        fixedSize: Size(300, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyCamera2(),
              settings: RouteSettings(arguments: {'path':_image!.path})),
        );
      },
      child: Text(
        '사용하기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
