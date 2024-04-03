import 'package:flutter/material.dart';
import '../back_module/sqlclient.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screen/dict_screen.dart';
import '../contents/image_down.dart';

class MainContent extends StatelessWidget {
  final VoidCallback onTap;
  final String imagepath;
  final String contentName;
  final Color backcolor;

  MainContent({
    required this.onTap,
    required this.imagepath,
    required this.contentName,
    required this.backcolor,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 320,
            height: 160,
            decoration: BoxDecoration(
                color: backcolor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0), // 좌측으로 옮길 값 설정
                child: Text(
                  contentName,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: Image.asset(imagepath),
          )
        ],
      ),
    );
  }
}

class Main_Screen_Dict {
  static Widget Main_FutureBuilder(BuildContext context, String? user_no) {
    return FutureBuilder(
      future: sqlget().GetMydicList(user_no: user_no),
      builder: (context,
          AsyncSnapshot<List<Map<String, String?>>?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        List<Map<String, String?>> postList = snapshot.data ?? [];
        postList = postList.reversed.toList(); // 리스트를 거꾸로 정렬합니다.
        postList =
            postList.take(6).toList(); // 마지막에 추가된 10개의 아이템만 선택합니다.
        if (postList.isNotEmpty) {
          return CarouselSlider(
            options: CarouselOptions(

              height: 260,
              viewportFraction: 0.5,
              aspectRatio: 16 / 9,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              enableInfiniteScroll: true,
              initialPage: 0,
              autoPlayInterval: Duration(seconds: 5),
            ),
            items: postList.map((item) {
              return _buildListItem(context, item, user_no);
            }).toList(),
          );
        } else {
          return Container(
            height: 100,
            child: Center(
              child: Text('현재 이미지가 존재하지 않습니다.'),
            ),
          );
        }
      },
    );
  }

  static Widget _buildListItem(BuildContext context, Map<String, String?> item, String? user_no) {
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
                    'mydic_no': item[sqlget.mydic_db_col['no']],
                    'kor': item[sqlget.dic_db_col['kor']],
                    'eng': item[sqlget.dic_db_col['eng']],
                    'mean': item[sqlget.dic_db_col['mean']]
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
                  child: SnapShotImage(
                      user_no: user_no, mydic_no: item[sqlget.mydic_db_col['no']]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                          item['word_kor'] ?? "",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Text(
                          item['word_eng'] ?? "",
                          style: TextStyle(fontSize: 12),
                        ),
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