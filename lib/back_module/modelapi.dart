import 'package:http/http.dart' as http;
import 'dart:convert';
import '../back_module/label.dart';
import 'dart:typed_data';


class GetLabel {
  // label.dart 참조
  static String text_label = Label.labellist.join(",");

  // api주소
  String api_url = "http://34.64.177.205/?label=${text_label}" ;

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
  static const String client_id = "c7a4y9659b";
  static const String client_secret = "4Uw8YUFaXYeWByG1nIjaaX8JeALFc4iIbWKzPROJ";
  static const String url = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
  static const Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'X-NCP-APIGW-API-KEY-ID': client_id,
    'X-NCP-APIGW-API-KEY': client_secret,
  };
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
    }
  }
}