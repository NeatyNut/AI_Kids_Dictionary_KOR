import 'package:image_picker/image_picker.dart';
import 'package:minio_new/minio.dart';
import 'package:minio_new/io.dart';
import 'dart:typed_data';
import '../back_module/setting.dart';


// 업로드 클래스
class Awss3 {
  static const String region = setting.s3_region;
  static const String bucketId = setting.s3_bucketId;
  static const String accesskey = setting.s3_accessKey;
  static const String secretkey = setting.s3_secretkey;
  String? user_no;
  String? mydic_no;

  Awss3({required this.user_no, required this.mydic_no});

  static Minio minio = Minio(
      endPoint: "${bucketId}.s3.dualstack.${region}.amazonaws.com",
      accessKey: accesskey,
      secretKey: secretkey,
      region: region
  );

  // 1/1.jpg
  String PathMaker({String? real_mydic_no=null}) {
    if (real_mydic_no==null) {
      return '$user_no/$mydic_no.jpg';}
    else {
      return '$user_no/$real_mydic_no.jpg';}
    }

  Future<void> upload(String imagepath) async {
    await minio.fPutObject(bucketId, PathMaker(), imagepath);
}

  Future<void> remove() async {
    await minio.removeObject(bucketId, PathMaker());
  }

  Future<Uint8List> _get() async {
    MinioByteStream stream = await minio.getObject(bucketId, PathMaker());
    List<List<int>> stream2 = await stream.toList();
    final flattenedList = stream2.fold<List<int>>([], (a, b) => a..addAll(b));
    return Uint8List.fromList(flattenedList);
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

  Future<void> ChangeName(String? new_mydic_no) async {
    Uint8List? stream = await loadImage();
    Stream<Uint8List> stream2 = Stream.value(stream!);
    await minio.putObject(bucketId, PathMaker(real_mydic_no: new_mydic_no), stream2);
    await minio.removeObject(bucketId, PathMaker());
  }
}