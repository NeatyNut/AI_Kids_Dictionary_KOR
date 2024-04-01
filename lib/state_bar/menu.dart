import 'package:flutter/material.dart';
import '../screen/main_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // 상태 표시줄의 높이 가져오기
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Drawer(
      child: Column(
        children: [
          Container(
            height: statusBarHeight, // 상태 표시줄의 높이만큼 빈 공간 만들기
          ),
          Container(
            height: 120,
            color: Color(0xFFFFFBEB),
            child: Center(
              child: Text(
                'My Memory Dictionary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('홈'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              '사물 촬영',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('나만의 사전'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('나만의 일기'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
