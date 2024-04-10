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
  // 문제가 생성되지 않았을때를 위해 항상 초기화값을 설정
  int questionIndex = 0;
  int totalScore = 0;
  List<Map<String, dynamic>> questionList = [];

  bool isLoading = false; // 데이터 로딩 상태를 나타내는 변수 추가

  // 문제를 풀때마다 다음 Index 번호를 호출하고, Score값을 0과 1로 구분지어놨는데 풀때마다 그 숫자를 더하는 방식
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
    // qustionList의 값을 RAG model API를 이용하여 채워 넣음
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
      // Index가 문제 갯수보다 적을경우에는 계속 문제 Question_Screen 호출, length와 같거나 높아질경우 ResultScreen 호출
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
