// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../back_module/label.dart';
// import 'dart:io';
// import 'firebase.dart';
//
//
// class GetLabel {
//   // 생성자로 받을 url
//   String? user_no;
//   String? mydic_no;
//   String? path;
//
//   // 생성자
//   GetLabel({required this.user_no, required this.mydic_no});
//
//   // label.dart 참조
//   List<String> text_label = Label.labellist;
//
//   // api주소
//   String api_url = 'https://8a13-114-202-17-6.ngrok-free.app/';
//
//   // map화
//   Future<Map<String, dynamic>> toMap() async {
//     String url = await FirebaseClient(user_no:this.user_no, mydic_no: this.mydic_no).getImage();
//     print('--------------------------------');
//     print('$url');
//     print('--------------------------------');
//     return {'url': url, 'labels': text_label.join(',')};
//   }
//
//   // json 송신 후 label return 받기
//   Future<String?> get_label() async {
//     Uri real_url = Uri.parse(api_url);
//     http.Response response = await http.post(real_url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(await toMap()));
//
//     // 리턴 받은 값 출력
//     if (response.statusCode == 200) {
//       String json = jsonDecode(response.body);
//       List<String> list = json.split(',');
//       List<String> list1 = list[0].split(':');
//       // List<String> list2 = list[1].split(':');
//
//       String? data = list1[1];
//       return data;
//     } else {
//       String? data = null;
//       return data;
//     }
//   }
// }
//
//
// // // "622964d6255364be41659078"
// // class GetSound {
// //   final String actor_id;
// //   final String text;
// //   static const String url = "https://typecast.ai/api/speak";
// //   static const String token = "Bearer __pltEV8b68YDW6Pt3LK372qTp3FPjE2r9WvNtMENEPxP";
// //
// //   GetSound({required this.actor_id, required this.text});
// //
// //   Map<String, dynamic> toMap() =>
// //       {"actor_id": this.actor_id,
// //         "text": this.text,
// //         "lang": "auto",
// //         "tempo": 1,
// //         "volume": 100,
// //         "pitch": 0,
// //         "xapi_hd": true,
// //         "max_seconds": 60,
// //         "model_version": "latest",
// //         "xapi_audio_format": "mp3",
// //       };
// //
// //   Future<void> get_voice() async {
// //     Uri real_url = Uri.parse(url);
// //     http.Response response = await http.post(real_url,
// //         headers: {'Content-Type': 'application/json', 'Authorization': token
// //         },
// //         body: jsonEncode(toMap()));
// //
// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> json = jsonDecode(response.body);
// //       String mp3_url = json['result']['speak_v2_url'];
// //       print(mp3_url);
// //       http.Response response2 = await http.get(Uri.parse(mp3_url), headers:{'Content-Type': 'application/json', 'Authorization': token});
// //
// //       if (response2.statusCode == 200) {
// //         Map<String, dynamic> json2 = jsonDecode(response2.body);
// //         print(json2);
// //       }
// //
// //     }
// //   }
// // }
//
// class GetSound {
//   static const String client_id = "c7a4y9659b";
//   static const String client_secret = "4Uw8YUFaXYeWByG1nIjaaX8JeALFc4iIbWKzPROJ";
//   static const String url = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
//   static const Map<String, String> headers = {
//     'Content-Type': 'application/x-www-form-urlencoded',
//     'X-NCP-APIGW-API-KEY-ID': client_id,
//     'X-NCP-APIGW-API-KEY': client_secret,
//   };
//   final String text;
//   String speaker;
//
//   GetSound({required this.text, this.speaker = 'nara'});
//
//   // Map<String, String> toMap() {
//   //   Map<String, String> data = {
//   //     'speaker': speaker,
//   //     'text': text,
//   //     'volume': '0',
//   //     'speed': '0',
//   //     'pitch': '0',
//   //     'format': 'mp3',
//   //   };
//   //   return data;
//   // }
//
//   String toParameter() {
//     String data = "speaker=${speaker}&volume=0&speed=1&pitch=0&format=mp3&text=${text}";
//     return data;
//   }
//
//   Future<void> get_voice(String filename) async {
//     Uri real_url = Uri.parse(url);
//     // String body = Uri(queryParameters: toMap()).query;
//
//     http.Response response = await http.post(real_url,
//         headers: headers,
//         body: toParameter());
//
//     if (response.statusCode == 200) {
//       final bytes = response.bodyBytes;
//
//
//       // final tempDir = Directory.systemTemp;
//       // final filePath = '${tempDir.path}/$filename.mp3';
//       // await saveFile(filePath, bytes);
//       await saveFile('assets/sound/${filename}.mp3', bytes);
//     } else {
//       print(response.statusCode);
//     }
//   }
//
//   Future<void> saveFile(String filePath, List<int> bytes) async {
//     File file = File(filePath);
//
//     try {
//       await file.writeAsBytes(bytes);
//       print('File saved successfully at: $filePath');
//     } catch (e) {
//       print('Failed to save file: $e');
//     }
//   }
// }