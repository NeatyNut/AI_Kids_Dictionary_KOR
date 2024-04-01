import 'package:flutter/material.dart';
import '../contents/contents.dart';
import '../screen/dict_screen.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';

class DictListScreen extends StatefulWidget {
  @override
  State<DictListScreen> createState() => _DictListScreenState();
}

class _DictListScreenState extends State<DictListScreen> {

  final List<Map<String, String>> PostList = [
    {'image': 'assets/images/dog.jpg', 'kor': '강아지', 'eng': 'dog'},
    {'image': 'assets/images/dog.jpg', 'kor': '고양이', 'eng': 'cat'},
    {'image': 'assets/images/dog.jpg', 'kor': '호랑이', 'eng': 'tiger'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: PostList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  TitleBanner(text: '나만의 사전'),
                  SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (PostList.length / 2).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildListItem(PostList[index * 2]),
                          SizedBox(width: 40),
                          if (index * 2 + 1 < PostList.length)
                            _buildListItem(PostList[index * 2 + 1]),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '사진이 텅텅 비어있어요!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: CustomColor().text()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/mmd_dict.png')
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }

  Widget _buildListItem(Map<String, String?> item) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dict_Screen(),
                settings: RouteSettings(
                  arguments: {
                    'image': item['image'],
                    'kor': item['kor'],
                    'eng': item['eng']
                  },
                ),
              ),
            );
          },
          child: Container(
            width: 140,
            height: 200,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset(item['image'] ?? ""),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                          item['kor'] ?? "",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                          item['eng'] ?? "",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              backgroundColor: CustomColor().red(),
                              fixedSize: Size(40, 20),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'X',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
