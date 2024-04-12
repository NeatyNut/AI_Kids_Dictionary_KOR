import 'package:flutter/material.dart';
import 'package:mmd/screen/main_screen.dart';
import '../contents/image_down.dart';
import '../screen/profile_screen.dart';
import '../back_module/sqlclient.dart';
import '../style/custom_color.dart';

class Appbar_screen extends StatefulWidget implements PreferredSizeWidget {
  final bool isMainScreen;
  final bool isBackButtonVisible;

  Appbar_screen({
    required this.isMainScreen,
    this.isBackButtonVisible = true,
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
        '찰칵 찰칵 한글 탐험',
        style: TextStyle(
          color: CustomColor().text(),
        ),
      ),
      centerTitle: true,
      leading: widget.isMainScreen
      // isMainScreen 값을 True로 주면 Menu, False로 주면 Backarrow
          ? _buildMenuButton(context)
          : _buildBackButton(context),
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

  Widget _buildBackButton(BuildContext context) {
    // 변수값으로 isBackButtonVisible 값을 True 로 주면 pop, false를 주면 pushAndRemovUntil을 주게 된다.
    // pushAndRemoveUntil은 페이지 이동을 한뒤 Stack개념을 다 없어지게 해준다.
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 40,
        color: CustomColor().blue(),
      ),
      onPressed: () {
        if (widget.isBackButtonVisible) {
          Navigator.pop(context);
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false,
          );
        }
      },
    );
  }
}
