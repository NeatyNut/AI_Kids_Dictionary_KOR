import 'package:http/http.dart' as http;
import 'dart:convert';
import '../back_module/label.dart';
import 'dart:typed_data';
import 'dart:math';
import '../back_module/setting.dart';

class GetLabel {
  // label.dart 참조
  static String text_label = Label.labellist.join(",");

  // api주소
  String api_url = "${setting.clip_url}?label=${text_label}" ;

  // json 송신 후 label return 받기
  Future<String?> get_label(String Image_path) async {
    var request = http.MultipartRequest('POST', Uri.parse(api_url));
    request.files.add(await http.MultipartFile.fromPath('file', Image_path));

    var response = await request.send();

    // 리턴 받은 값 출력
    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      String json = jsonDecode(responseString);
      return json;
    } else {
      String? data = null;
      return data;
    }
  }
}

class GetSound {
  static String url = setting.tts['url'];
  static Map<String, String> headers = setting.tts['headers'];
  final String text;
  String speaker;

  GetSound({required this.text, this.speaker = 'nara'});

  // Map<String, String> toMap() {
  //   Map<String, String> data = {
  //     'speaker': speaker,
  //     'text': text,
  //     'volume': '0',
  //     'speed': '0',
  //     'pitch': '0',
  //     'format': 'mp3',
  //   };
  //   return data;
  // }

  String toParameter() {
    String data = "speaker=${speaker}&volume=0&speed=1&pitch=0&format=mp3&text=${text}";
    return data;
  }

  Future<Uint8List?> get_voice() async {
    Uri real_url = Uri.parse(url);
    // String body = Uri(queryParameters: toMap()).query;

    http.Response response = await http.post(real_url,
        headers: headers,
        body: toParameter());

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('요청하는데에 실패해쪙');
    }
  }
}

class Getquiz {
  String api = setting.gemini_api;
  Random random = Random();
  List<String> years_list = ["4", "5", "6", "7"];

  Future<List<dynamic>?> _GetQuiz({required String topic}) async {
    var randomNumber = random.nextDouble();
    var randomNumber2 = random.nextInt(this.years_list.length);
    String temperature = randomNumber.toString();
    String years = this.years_list[randomNumber2];

    // 엔그록
    String api_url = "${setting.rag_url}?api=${this.api}&topic=${topic}&years=${years}&temperature=${temperature}";

    var response = await http.get(
        Uri.parse(api_url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      String _response = utf8.decode(response.bodyBytes); // 한글 인코딩
      String _json = jsonDecode(_response); // \지우기
      List<dynamic> QuizList = jsonDecode(_json);
      return QuizList;
    }
  }

  Future<List<Map<String, dynamic>>?> GetQuizList(
      {required String topic}) async {
    int maxAttempts = 3; // 최대 시도 횟수
    int attempts = 0; // 현재 시도 횟수
    List<dynamic>? raw_quiz_list;
    List<Map<String, dynamic>> QuizList = [];

    while (attempts < maxAttempts) {
      try {
        // 요청을 보내는 함수 호출
        raw_quiz_list = await _GetQuiz(topic: topic);
        List<String> keys = [];

        for (String key in raw_quiz_list![0].keys) {
          keys.add(key);
        }

        for (Map<String, dynamic> quiz in raw_quiz_list) {
          Map<String, dynamic> quizdict = {};
          quizdict['question'] = quiz[keys[0]];
          quizdict['answer'] = [
            {'text': quiz[keys[1]][0], 'score': 0 == quiz[keys[2]] ? 1 : 0},
            {'text': quiz[keys[1]][1], 'score': 1 == quiz[keys[2]] ? 1 : 0},
            {'text': quiz[keys[1]][2], 'score': 2 == quiz[keys[2]] ? 1 : 0}
          ];
          QuizList.add(quizdict);
        }
        break;
      } catch (e) {
        // 오류 발생 시 다음 시도를 위해 시도 횟수를 증가시킵니다.
        attempts++;
      }
    }
    return QuizList;
  }
}