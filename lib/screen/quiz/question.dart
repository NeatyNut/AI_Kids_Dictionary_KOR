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

  @override
  void initState() {
    super.initState();
    _audioPlayer = audioplay();
  }

  @override
  Widget build(BuildContext context) {
    // 질문 음성을 재생합니다.
    _playQuestionAudio(widget.questionIndex);

    return Column(
      children: [
        TitleBanner(text: '퀴즈! 퀴즈!'),
        SizedBox(height: 30),
        if (widget.questionList.isNotEmpty && widget.questionIndex < widget.questionList.length)
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
                        Text(widget.questionList[widget.questionIndex]['question']),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor().green(),
                    foregroundColor: Colors.white,
                    fixedSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][0]['score']),
                  child: Text(widget.questionList[widget.questionIndex]['answer'][0]['text']),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor().blue(),
                    foregroundColor: Colors.white,
                    fixedSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][1]['score']),
                  child: Text(widget.questionList[widget.questionIndex]['answer'][1]['text']),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor().red(),
                    foregroundColor: Colors.white,
                    fixedSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => widget.answerPressed(widget.questionList[widget.questionIndex]['answer'][2]['score']),
                  child: Text(widget.questionList[widget.questionIndex]['answer'][2]['text']),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // 질문 음성을 재생하는 메서드
  Future<void> _playQuestionAudio(int index) async {
    Uint8List? voice = await GetSound(text: widget.questionList[index]['question']).get_voice();
    _audioPlayer.byteplay(voice!);
  }
}
