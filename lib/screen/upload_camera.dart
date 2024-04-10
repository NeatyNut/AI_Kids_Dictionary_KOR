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
  XFile? _image; // 이미지 파일을 저장할 변수
  final ImagePicker _picker = ImagePicker(); // ImagePicker라는 함수를 _picker라고 변수로 지정
  String? user_no; // user_no, 즉 스토리지에 붙일 이름(폴더)

  Future<void> _getImage(ImageSource source) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: source, maxWidth: 300, maxHeight: 300); // 이미지 피커를 이용하여 이미지를 가져옴 source 는 camera 와 gallery
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile; // 이미지가 선택된다면, 그 이미지가 setstate로 인하여 되어 상태를 업데이트함
      });
    }
  }
  // 로그인 세션확인하는 함수 만약에 로그인하지 않았는데 이페이지가 열린다면 LoginScreen으로 이동
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
        user_no = no; // 그래서 만약에 유저넘버가 존재하고있다면 사용자 번호가 업데이트 됨
      });}
  }

  @override
  void initState() {
    super.initState();
    Checktoken(); // 유저넘버가 존재하는지 확인후 있다면 있는걸로, 없다면 없는걸로 하여 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false, isBackButtonVisible: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(text: '카메라 촬영'),
            SizedBox(height: 30),
            _buildPhotoArea(), // 이미지가 나올 구역
            SizedBox(height: 20),
            _buildButton(), // 카메라 기능을 할지, 갤러리 기능을 할지 선택하는 버튼 구역
            SizedBox(height: 20),
            _buildSendButton(), // DownLoadCamera 위치로 이동함
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
        ? Container( // 이미지를 제대로 불러왔을 경우
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), // 이미지 파일을 출력함
          )
        : Container( // 이미지를 불러오지 않았을 경우 초기화면
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
            _getImage(ImageSource.camera); // Image_picker의 카메라 기능 활성화
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
            _getImage(ImageSource.gallery); // Image_picker의 갤러리 기능 활성화
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
          /*
          * 만약에 이미지를 불러오는데 성공할경우 저장된 경로를 DownLoadCamera로 보내는 방식
          * RouterSettings(arguments) 는 다른 페이지에 그 저장된 정보값을 전달 가능
          * */
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
