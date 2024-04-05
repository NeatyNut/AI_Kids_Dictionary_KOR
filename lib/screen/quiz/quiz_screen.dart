import 'package:flutter/material.dart';
import '../../state_bar/appbar.dart';
import '../../state_bar/bottombar.dart';
import 'question.dart';
import 'result.dart';
import '../../back_module/modelapi.dart';

class Quiz_Screen extends StatefulWidget {
  const Quiz_Screen({Key? key}) : super(key: key);

  @override
  State<Quiz_Screen> createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  int questionIndex = 0;
  int totalScore = 0;
  List<Map<String, dynamic>> questionList = [];

  bool isLoading = false; // 데이터 로딩 상태를 나타내는 변수 추가

  void answerPressed(int score) {
    setState(() {
      questionIndex++;
      totalScore += score;
    });
    print(totalScore);
  }

  void loadQuestionList(String title) async {
    setState(() {
      isLoading = true; // 데이터 로딩 중임을 표시
    });
    final loadedQuestions = await Getquiz().GetQuizList(topic: title);
    setState(() {
      isLoading = false; // 데이터 로딩 완료 후 상태 업데이트
      questionList = loadedQuestions ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    if (questionList.isEmpty && !isLoading) { // 데이터가 비어 있고 로딩 중이 아닌 경우에만 데이터 로드
      loadQuestionList(args['title'] ?? "");
    }

    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: isLoading
          ? Center(child: Image.asset('assets/images/Quiz_loading.gif')) // 데이터 로딩 중일 때 로딩 인디케이터 표시
          : questionList.isNotEmpty
          ? (questionIndex < questionList.length)
          ? Question_Screen(
        answerPressed: answerPressed,
        questionIndex: questionIndex,
        questionList: questionList,
      )
          : ResultScreen(
        totalScore: totalScore,
        questionList: questionList,
      )
          : Container(child: Text('')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }
}
