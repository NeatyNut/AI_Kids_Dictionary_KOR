import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '../back_module/setting.dart';

class FirebaseInit {
  void SetFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.useAuthEmulator(setting.firebase_url, setting.firebase_port);
  }
}

class FirebaseClient {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  String? user_no;
  String? mydic_no;

  FirebaseClient({required this.user_no, required this.mydic_no});

  // 경로만들기
  String PathMaker({String? real_mydic_no=null}) {
    if (real_mydic_no==null) {
      return '$user_no/$mydic_no.jpg';}
    else {
      return '$user_no/$real_mydic_no.jpg';}
  }

  // 업로드
  Future<void> upload(String filepath) async {
    File file = File(filepath);
    final mountainsRef = storageRef.child(PathMaker());
    await mountainsRef.putFile(file);
  }

  // 이미지 데이터 가져오기
  Future<Uint8List?> _get() async {
    final mountainsRef = storageRef.child(PathMaker());
    const oneMegabyte = 1024 * 1024;
    return await mountainsRef.getData(oneMegabyte);
  }

  // 실패시 5번까지 반복 호출
  Future<Uint8List?> loadImage() async {
    Uint8List? byte = null;
    int retryCount = 0;
    while (byte == null && retryCount < 5) {
      byte = await _get();
      if (byte != null) {
        // 담겨있으면 리턴
        return byte;
      }
      retryCount++;
      await Future.delayed(Duration(seconds: 1));
    }
    // null시 리턴
    return byte;
  }

  // 삭제하기
  Future<void> remove() async {
    final desertRef = storageRef.child(PathMaker());
    await desertRef.delete();
  }

  // 이름 바꾸기
  Future<void> ChangeName(String? new_mydic_no) async {
    final storageRef = FirebaseStorage.instance.ref();
    final oldFileRef = storageRef.child(PathMaker());
    final newFileRef = storageRef.child(PathMaker(real_mydic_no:new_mydic_no));
    Uint8List? raw_file = await oldFileRef.getData();
    File file = File.fromRawPath(raw_file!);
    await newFileRef.putFile(file);
    await oldFileRef.delete();
  }

  Future<void> getImage() async{
    print(await storageRef.child(PathMaker()).getDownloadURL());
    // return await storageRef.child(PathMaker()).getDownloadURL();
  }

}