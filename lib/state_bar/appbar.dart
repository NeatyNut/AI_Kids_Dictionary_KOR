import 'package:flutter/material.dart';
import 'package:mmd/contents/image_down.dart';
import 'package:mmd/screen/profile_screen.dart';
import '../back_module/sqlclient.dart';
import '../style/custom_color.dart';

class Appbar_screen extends StatefulWidget implements PreferredSizeWidget {
  final bool isMainScreen;

  Appbar_screen({
    required this.isMainScreen,
  });

  @override
  State<Appbar_screen> createState() => _Appbar_screenState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Appbar_screenState extends State<Appbar_screen> {
  String? user_no;

  void Checktoken() async {
    String? no = await Token().Gettoken();

    setState(() {
      user_no = no;
    });
  }

  @override
  void initState() {
    super.initState();
    Checktoken();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.white,
      title: Text(
        'My Memory Dictionary',
        style: TextStyle(
          color: CustomColor().text(),
        ),
      ),
      centerTitle: true,
      leading: widget.isMainScreen
          ? _buildMenuButton(context)
          : _buildBackButton(context),
      // 삼항 연산자 boolean 조건 ? 무엇True : 무엇False
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            child: ClipOval(
              child: SnapShotImage(mydic_no: 'Profile', user_no: user_no),
            ),
          ),
        )
      ],
    );
  }

  // 메뉴 버튼 생성
  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        size: 40,
        color: CustomColor().blue(),
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }

  // 뒤로가기 버튼 생성
  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 40,
        color: CustomColor().blue(),
      ),
      onPressed: () {
        Navigator.pop(context); // 이전 화면으로 이동
      },
    );
  }
}
