import 'package:flutter/material.dart';
import 'package:mmd/style/custom_color.dart';
import 'quiz_screen.dart';
import '../../contents/contents.dart';
import '../../state_bar/appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../state_bar/bottombar.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoScreenState(); // 비디오 화면의 상태를 관리하는 State 클래스 생성
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>; // 전달된 인자 가져오기

    final YoutubePlayerController _con = YoutubePlayerController(
        initialVideoId: args['video']!, // 초기 비디오 ID 설정
        flags: const YoutubePlayerFlags(
          autoPlay: true, // 자동 재생 설정
          mute: false, // 음소거 여부 설정
          disableDragSeek: false, // 드래그 시크 여부 설정
          loop: true, // 반복 재생 설정
          isLive: false, // 라이브 여부 설정
          forceHD: false, // HD 강제 설정
          enableCaption: true, // 자막 사용 여부 설정
        ));

    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false), // 앱바 설정
      body: Column(
        children: [
          TitleBanner(
            text: '퀴즈! 퀴즈!', // 타이틀 배너 설정
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: YoutubePlayer(
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: ProgressBarColors(
                    playedColor: Colors.red, // 재생된 부분의 색상 설정
                    handleColor: Colors.redAccent, // 핸들의 색상 설정
                  ),
                ),
              ],
              controller: _con, // 유튜브 플레이어 컨트롤러 설정
              showVideoProgressIndicator: true, // 비디오 프로그레스 인디케이터 표시 설정
              progressColors: ProgressBarColors(playedColor: Colors.red), // 프로그레스 바 색상 설정
            ),
          ),
          SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor().yellow(), // 버튼 배경색 설정
                foregroundColor: CustomColor().text(), // 버튼 텍스트 색상 설정
                fixedSize: Size(130, 60), // 버튼 크기 설정
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)), // 버튼 모양 설정
              ),
              onPressed: () {
                Navigator.pop(context); // 현재 화면 팝
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Quiz_Screen(),
                        settings: RouteSettings(
                            arguments: {'title': args['title']}))); // 퀴즈 화면으로 이동
              },
              child: Text('퀴즈 풀러 가기',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),)) // 버튼 텍스트 설정
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // 플로팅 액션 버튼 위치 설정
      floatingActionButton: BottomFAB(), // 플로팅 액션 버튼 설정
      bottomNavigationBar: BottomScreen(), // 바텀 네비게이션 바 설정
    );
  }
}
