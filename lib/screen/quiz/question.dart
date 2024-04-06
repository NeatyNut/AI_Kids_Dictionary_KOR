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
          // TTS 함수가 아직 완료되지 않은 경우, 로딩 인디케이터 표시
          return Center(
            child: Image.asset('assets/images/Quiz_loading.gif'),
          );
        } else {
          // TTS 함수가 완료된 후에 위젯을 빌드
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
                                onPressed: () => widget.answerPressed(
                                    widget.questionList[widget.questionIndex]
                                        ['answer'][index]['score']),
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

  // 질문 음성을 재생하는 메서드
  Future<void> _playQuestionAudio(int index) async {
    Uint8List? voice =
        await GetSound(text: widget.questionList[index]['question'])
            .get_voice();
    _audioPlayer.byteplay(voice!);
  }

  @override
  void didUpdateWidget(Question_Screen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionIndex != widget.questionIndex) {
      // 질문이 변경되었을 때만 TTS 함수 호출 및 Future 객체 업데이트
      setState(() {
        _ttsFuture = _playQuestionAudio(widget.questionIndex);
      });
    }
  }
}