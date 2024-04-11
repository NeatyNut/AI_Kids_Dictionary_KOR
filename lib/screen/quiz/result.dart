import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmd/contents/contents.dart';
import 'package:mmd/screen/quiz/book_list.dart';
import 'package:mmd/screen/quiz/quiz_screen.dart';
import '../../style/custom_color.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.totalScore,
    required this.questionList,
  }) : super(key: key);

  final int totalScore;
  final List<Map<String, dynamic>> questionList;

  @override
  Widget build(BuildContext context) {
    String resultMessage;
    String resultImage;

    if (totalScore == questionList.length) {
      resultMessage = '우와 다 맞췄네요! 대단해요!';
      resultImage = 'assets/images/result_3.png';
    } else if (totalScore > 0 && totalScore < questionList.length) {
      resultMessage = '아쉽지만 그래도 $totalScore개나 맞췄어요! 다음에는 다 맞출 수 있을 거예요~!';
      resultImage = 'assets/images/result_2.png';
    } else {
      resultMessage = '퀴즈가 쉽지 않았죠? 우리 다시 공부하고 풀어 봐요!';
      resultImage = 'assets/images/result_1.png';
    }


    return Center(
      child: Column(
        children: [
          TitleBanner(text: '퀴즈! 퀴즈!'),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 320,
            height: 300,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.1))
            ]),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(resultImage),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 10,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 160,
                      height: 200,
                      child: Text(resultMessage, style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor().blue(),
              fixedSize: Size(200, 60),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            onPressed: (){
              // Stack을 다 날리면서 원하는 페이지로 이동하기 위해
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/book', // 이동할 목표 route의 이름
                ModalRoute.withName('/book'), // 팝할 조건을 지정하는 predicate
              );
            },
            child: Text("동화 목록으로 돌아가기"),
          ),
        ],
      ),
    );
  }
}
