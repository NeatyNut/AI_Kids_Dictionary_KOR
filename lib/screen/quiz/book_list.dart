import 'package:flutter/material.dart';
import 'package:mmd/back_module/sqlclient.dart';
import 'package:mmd/contents/image_down.dart';
import '../quiz/video_page.dart';
import '../../contents/contents.dart';
import '../../state_bar/appbar.dart';
import '../../state_bar/bottombar.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Map<String, String?>>? PostList;

  Future<void> Get_Book_List() async {
    List<Map<String, String?>> Future_PostList = await sqlget().GetTaleList();
    setState(() {
      PostList = Future_PostList;
    });
  }

  @override
  void initState() {
    super.initState();
    Get_Book_List();
  }

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
            PostList != null ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: PostList!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildListItem(PostList![index]),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ) : Container(child: Text(''),),
            SizedBox(
              height: 60,
            ),
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
            MaterialPageRoute(
                builder: (context) => VideoScreen(),
                settings: RouteSettings(arguments: {
                  'video': item[sqlget.book_db_col['video']],
                  'title': item[sqlget.book_db_col['title']]
                })));
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
            SnapShotImage(mydic_no: 'book_${item[sqlget.book_db_col['no']]}', user_no: 'book_images'),
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
                    item[sqlget.book_db_col['title']] ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${item[sqlget.book_db_col['age']]} / ${item[sqlget.book_db_col['lang']]}',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    item[sqlget.book_db_col['playtime']] ?? "",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    item[sqlget.book_db_col['source']] ?? "",
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
