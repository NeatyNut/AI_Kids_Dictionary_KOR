import 'package:flutter/material.dart';
import 'package:mmd/contents/contents.dart';
import 'package:mmd/contents/image_down.dart';
import 'package:mmd/state_bar/appbar.dart';
import 'package:mmd/state_bar/bottombar.dart';
import '../style/custom_color.dart';
import '../back_module/sqlclient.dart';
import '../back_module/firebase.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String? user_no;
  String? username;
  String? userbirth;
  String? usergender;

  Future<void> Checktoken() async {
    String? no = await Token().Gettoken();

    if (no == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        user_no = no;
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final String path;
    final XFile? pickedFile =
        await _picker.pickImage(source: source, maxWidth: 300, maxHeight: 300);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      path = _image!.path;
      await FirebaseClient(user_no: user_no, mydic_no: 'Profile').upload(path);
      showSnackBar(context);
    }
  }

  Future<void> GetUserInfo() async {
    Map<String, String?> _userinfo = await sqlget().GetUserInfo(user_no: this.user_no);
    setState(() {
      username = _userinfo[sqlget.user_db_col['name']];
      userbirth = _userinfo[sqlget.user_db_col['birth']];
      usergender = sqlget.map_gender[_userinfo[sqlget.user_db_col['gender']]];
    });
  }

  Future<void> initprofile() async {
    await Checktoken();
    await GetUserInfo();
  }


  @override
  void initState() {
    super.initState();
    initprofile();
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('변경되었습니다.'),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false, isBackButtonVisible: false),
      body: SingleChildScrollView(
          child: Column(
            children: [
              TitleBanner(text: '나의 프로필'),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 320,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.1)),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 115,
                          height: 115,
                          padding: EdgeInsets.all(15),
                          child: _buildPhotoArea(),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: CustomColor().yellow(),
                              foregroundColor: CustomColor().text(),
                            ),
                            icon: Icon(Icons.add),
                            onPressed: () {
                              ChangeDialog();
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 150,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이름 : ${username ?? "-"}'),
                          Text('생일 : ${userbirth  ?? "-"}'),
                          Text('성별 : ${usergender ?? "-"}'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          SizedBox(
            height: 30,
          ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor().red(),
                  fixedSize: Size(130, 60),
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  LogoutDialog();
                },
                child: Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ))
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
      );
  }

  void LogoutDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Text('로그아웃'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('로그아웃 하시겠습니까?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Token().Deltoken();
                  await GoogleSignIn().signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('로그아웃 되었습니다..'),
                  ));
                },
                child: Text('로그아웃',style: TextStyle(color:CustomColor().red()),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소',style: TextStyle(color:CustomColor().blue())),
              ),
            ],
          );
        });
  }

  void ChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Text('프로필 사진'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('변경할거예요?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
                child: Text('카메라'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
                child: Text('갤러리'),
              )
            ],
          );
        });
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: FileImage(
                  File(_image!.path),
                ),
                fit: BoxFit.cover, // 이미지를 동그란 원에 맞게 조정합니다.
              ),
            ),
          )
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: SnapShotImage(mydic_no: 'Profile', user_no: user_no),
            ),
          );
  }
}
