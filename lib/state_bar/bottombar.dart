import 'package:flutter/material.dart';
import '../screen/dict_list_screen.dart';
import '../screen/quiz/quiz_screen.dart';
import '../screen/upload_camera.dart';
import '../screen/main_screen.dart';
import '../style/custom_color.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.1))
      ]),
      child: BottomAppBar(
        surfaceTintColor: Colors.white,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
          width: double.infinity,
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  'assets/images/home.png',
                  color: CustomColor().blue(),
                  width: 40,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
              Spacer(),
              // 원하는 위치에 IconButton 추가
              IconButton(
                icon: Image.asset(
                  'assets/images/profile.png',
                  color: CustomColor().blue(),
                  width: 40,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
              Spacer(flex: 6),
              IconButton(
                icon: Image.asset(
                  'assets/images/dict.png',
                  color: CustomColor().blue(),
                  width: 40,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DictListScreen()));
                },
              ),
              Spacer(),
              IconButton(
                icon: Image.asset(
                  'assets/images/note.png',
                  color: CustomColor().blue(),
                  width: 40,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Quiz_Screen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomFAB extends StatelessWidget {
  const BottomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(40),
      //   boxShadow: [
      //     BoxShadow(
      //       offset: Offset(0, 0),
      //       blurRadius: 4,
      //       spreadRadius: 2,
      //       color: Colors.black.withOpacity(0.1),
      //     ),
      //   ],
      // ),
      child: FloatingActionButton(
        shape: CircleBorder(eccentricity: 1),
        backgroundColor: CustomColor().red(),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UpLoadCamera()));
          // Add your onPressed code here!
        },
        child: Image.asset(
          'assets/images/camera.png',
          color: Colors.white,
        ),
        elevation: 0,
      ),
    );
  }
}
