import 'package:flutter/material.dart';
import 'package:mmd/screen/quiz/video_page.dart';
import '../../contents/contents.dart';
import '../../state_bar/appbar.dart';
import '../../state_bar/bottombar.dart';
import 'quiz_screen.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final PostList = [
    {
      'image': 'assets/images/b1.png',
      'video' : 'G5b_az5yeLI',
      'title': '토끼와 거북이',
      'age': '4~7세',
      'lang': '한국어',
      'time': '2분 17초',
      'source': '세이브 더 칠드런',
    },
    {
      'image': 'assets/images/b2.png',
      'video' : 'kHP8KCPO2mU',
      'title': '해와 달이 된 오누이',
      'age': '4~7세',
      'lang': '한국어',
      'time': '2분 15초',
      'source': '세이브 더 칠드런'
    },
    {
      'image': 'assets/images/b3.png',
      'video' : 'fbptwUqi-YA',
      'title': '금도끼와 은도끼',
      'age': '4~7세',
      'lang': '한국어',
      'time': '2분 30초',
      'source': '세이브 더 칠드런'
    },
    {
      'image': 'assets/images/b1.png',
      'video' : 'G5b_az5yeLI',
      'title': '토끼와 거북이',
      'age': '4~7세',
      'lang': '한국어',
      'time': '2분 17초',
      'source': '세이브 더 칠드런'
    },
    {
      'image': 'assets/images/b2.png',
      'video' : 'kHP8KCPO2mU',
      'title': '해와 달이 된 오누이',
      'age': '4~7세',
      'lang': '한국어',
      'time': '2분 15초',
      'source': '세이브 더 칠드런'
    },
    {
      'image': 'assets/images/b3.png',
      'video' : 'fbptwUqi-YA',
      'title': '금도끼와 은도끼',
      'age': '4~7세',
      'lang': '한국어',
      'time': '2분 30초',
      'source': '세이브 더 칠드런'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBanner(text: '퀴즈! 퀴즈!'),
            SizedBox(
              height: 30,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: PostList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildListItem(PostList[index]),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }

  Widget _buildListItem(Map<String, String?> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoScreen(),
              settings: RouteSettings(arguments: {'video':item['video']}))
        );
      },
      child: Container(
        width: 360,
        height: 100,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.1))
        ]),
        child: Row(
          children: [
            Image.asset(item['image']!),
            SizedBox(
              width: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${item['age']} / ${item['lang']}',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    item['time']!,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    item['source']!,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
