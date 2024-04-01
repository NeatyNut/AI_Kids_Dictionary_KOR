import 'package:flutter/material.dart';
import 'question_list.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.totalScore,
    required this.resetQuiz,
  }) : super(key: key);

  final int totalScore;
  final Function resetQuiz;

  @override
  Widget build(BuildContext context) {
    String resultMessage;

    if (totalScore == questionList.length) {
      resultMessage = '헉 다 맞추셨어요!';
    } else if (totalScore >= questionList.length / 2) {
      resultMessage = '아쉽게도 조금 틀렸네요 다음엔 할 수 있어요!';
    } else{
      resultMessage = '어려웠나봐요 우리 다시 공부해서 풀어봐요';
    }
    return Center(
      child: Column(
        children: [
          SizedBox(height: 150,),
          Text(resultMessage),
          SizedBox(height: 100,),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            child: Text("reset quiz"),
          ),
        ],
      ),
    );
  }
}