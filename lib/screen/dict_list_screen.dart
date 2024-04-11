import 'package:flutter/material.dart';
import '../back_module/firebase.dart';
import '../back_module/sqlclient.dart';
import '../contents/contents.dart';
import '../screen/dict_screen.dart';
import '../state_bar/appbar.dart';
import '../state_bar/bottombar.dart';
import '../style/custom_color.dart';
import '../screen/login_screen.dart';
import '../contents/image_down.dart';

class DictListScreen extends StatefulWidget {
  @override
  State<DictListScreen> createState() => _DictListScreenState();
}

class _DictListScreenState extends State<DictListScreen> {
  String? user_no;
  List<Map<String, String?>> PostList = [];

  // 세션 토큰 검사
  Future<void> _Checktoken() async {
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

  // sql문으로 GetToken에서 받아온 user_no로 PostList를 만드는 코드
  Future<void> GetList() async {
    if (user_no == null) {
      await _Checktoken();
    }
    List<Map<String, String?>> Future_PostList =
        await sqlget().GetMydicList(user_no: user_no);
    setState(() {
      PostList = Future_PostList;
    });
  }

  @override
  void initState() {
    super.initState();
    GetList(); // 페이지에 들어왔을경우 초기값으로 PostList를 불러옴
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false, isBackButtonVisible: false),
      body: PostList.isNotEmpty // PostList에 요소가 존재할경우
          ? SingleChildScrollView(
              child: Column(
                children: [
                  TitleBanner(text: '나만의 사전'),
                  SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // Overflowing을 방지하나, 이 안에 요소는 별도로 Scroll 되지 않음
                    itemCount: (PostList.length / 2).ceil(),
                    // 한줄에 2개의 Object가 나오기위해 줄 길이를 반으로 만듦
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildListItem(PostList[index * 2]),
                          // 리스트 아이템을 2개씩 나타나게 하기위한 코드
                          SizedBox(width: 40),
                          if (index * 2 + 1 < PostList.length)
                            _buildListItem(PostList[index * 2 + 1]),
                          // 만약에 홀수 일경우 한개만 나타나게 만들기 위한 코드
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          : Center(
              // PostList가 비어있을 경우 나타나는 화면
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '사전이 텅텅 비어있어요!',
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
                    // SQL문으로 불러온 데이터를 Dict_Screen에 필요한데이터만 보내기 위한 Route Setting
                    'mydic_no': item[sqlget.mydic_db_col['no']],
                    'kor': item[sqlget.dic_db_col['kor']],
                    'eng': item[sqlget.dic_db_col['eng']],
                    'mean': item[sqlget.dic_db_col['mean']],
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
                  // Storage에 있는 이미지를 불러오기위한 함수
                  child: SnapShotImage(
                      user_no: user_no,
                      mydic_no: item[sqlget.mydic_db_col['no']]),
                ),
                Padding( // null값이 존재한다는 조건으로 ""이 아니라면 데이터 정보값을 호출
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
                            onPressed: () {
                              DleteDialog(item);
                            },
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

  // 데이터 삭제버튼을 눌렀을때 화면에 AlertDialog를 띄우기 위한 코드
  @override
  void DleteDialog(Map<String, String?> item) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Color(0xFFFFFFFF),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("사전 지우기"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "진짜 지울 거예요?",
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text(
                  "지우기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor().red(),
                  ),
                ),
                onPressed: () async {
                  // 삭제한다는 버튼을 눌렀을경우 Storage 및 SQL DB에서 데이터 삭제
                  await FirebaseClient(
                          user_no: user_no,
                          mydic_no: item[sqlget.mydic_db_col['no']])
                      .remove();
                  await sqlget().DeleteImageInfo(
                      user_no: user_no,
                      mydic_no: item[sqlget.mydic_db_col['no']]);
                  await GetList();
                  Navigator.pop(context);
                },
              ),
              new TextButton(
                child: new Text(
                  "취소",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor().blue(),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
