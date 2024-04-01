import 'package:flutter/material.dart';
import 'question_list.dart';
import '../../state_bar/appbar.dart';
import '../../state_bar/bottombar.dart';
import 'question.dart';
import 'result.dart';

class Quiz_Screen extends StatefulWidget {
  const Quiz_Screen({Key? key}) : super(key: key);

  @override
  State<Quiz_Screen> createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  int questionIndex = 0;
  int totalScore = 0;

  void answerPressed(int score) {
    setState(() {
      questionIndex++;
      totalScore += score;
    });
    print(totalScore);
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: (questionIndex < questionList.length)
          ? Question_Screen(
        answerPressed: answerPressed,
        questionIndex: questionIndex,
        questionList: questionList,
      )
          : ResultScreen(
        totalScore: totalScore,
        resetQuiz: resetQuiz,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }
}