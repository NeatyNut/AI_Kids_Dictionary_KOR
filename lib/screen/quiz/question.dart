import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../../contents/contents.dart';
import '../../back_module/audioplay.dart';
import '../../back_module/modelapi.dart';
import '../../style/custom_color.dart';

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
  late final audioplay _audioPlayer;
  final List<Color> color_list = [
    CustomColor().green(),
    CustomColor().blue(),
    CustomColor().red()
  ];
  late Future<void> _ttsFuture;

  @override
  void initState() {
    super.initState();
    _audioPlayer = audioplay();
    _ttsFuture =
        _playQuestionAudio(widget.questionIndex); // TTS 함수 호출 및 Future 객체 생성
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _ttsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset('assets/images/Quiz_loading.gif'),
          );
        } else {
          return Column(
            children: [
              TitleBanner(text: '퀴즈! 퀴즈!'),
              SizedBox(height: 30),
              if (widget.questionList.isNotEmpty &&
                  widget.questionIndex < widget.questionList.length)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Text(widget.questionList[widget.questionIndex]
                              ['question']),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget
                            .questionList[widget.questionIndex]['answer']
                            .length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color_list[index],
                                  foregroundColor: Colors.white,
                                  fixedSize: Size(300, 60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onPressed: () {
                                  bool isCorrect = widget
                                      .questionList[widget.questionIndex]
                                  ['answer'][index]['score'] > 0;
                                  String correctAnswer = widget.questionList[widget.questionIndex]['answer'].firstWhere((element) => element['score'] == 1)['text']; // 'score'가 1인 답을 찾아서 가져옴
                                  _showResultDialog(isCorrect, correctAnswer);
                                },
                                child: Text(
                                    widget.questionList[widget.questionIndex]
                                    ['answer'][index]['text']),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }

  Future<void> _playQuestionAudio(int index) async {
    Uint8List? voice =
    await GetSound(text: widget.questionList[index]['question'])
        .get_voice();
    _audioPlayer.byteplay(voice!);
  }

  void _showResultDialog(bool isCorrect, String correctAnswer) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? '정답입니다!' : '오답입니다!'),
        content: Text(isCorrect ? '다음 문제로 넘어갈까요?' : '정답은 $correctAnswer입니다. 계속 노력해주세요!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                if (isCorrect) {
                  // 정답을 맞추면 totalScore를 1 증가시킴
                  widget.answerPressed(1);
                } else {
                  // 오답일 경우에는 점수를 증가시키지 않음
                  widget.answerPressed(0);
                }
              });
            },
            child: Text('다음 문제 풀기'),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(Question_Screen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionIndex != widget.questionIndex) {
      setState(() {
        _ttsFuture = _playQuestionAudio(widget.questionIndex);
      });
    }
  }
}
