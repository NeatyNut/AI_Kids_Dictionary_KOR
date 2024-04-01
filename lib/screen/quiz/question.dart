import 'package:flutter/material.dart';
import '../../contents/contents.dart';
import 'question_list.dart';

class Question_Screen extends StatefulWidget {
  const Question_Screen({
    Key? key,
    required this.answerPressed,
    required this.questionIndex,
    required this.questionList,
  }) : super(key: key);

  final Function answerPressed;
  final int questionIndex;
  final List<Map<String, dynamic>> questionList;

  @override
  State<Question_Screen> createState() => _Question_ScreenState();
}

class _Question_ScreenState extends State<Question_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleBanner(text: '퀴즈! 퀴즈!'),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      Text(widget.questionList[widget.questionIndex]['question']),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][0]['score']),
                child: Text(widget.questionList[widget.questionIndex]['answer'][0]['text']),
              ),
              ElevatedButton(
                onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][1]['score']),
                child: Text(widget.questionList[widget.questionIndex]['answer'][1]['text']),
              ),
              ElevatedButton(
                onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][2]['score']),
                child: Text(widget.questionList[widget.questionIndex]['answer'][2]['text']),
              ),
              ElevatedButton(
                onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][3]['score']),
                child: Text(widget.questionList[widget.questionIndex]['answer'][3]['text']),
              ),
            ],
          ),
        ),
      ],
    );
  }
}