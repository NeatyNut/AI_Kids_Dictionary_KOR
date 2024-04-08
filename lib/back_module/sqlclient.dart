import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import '../back_module/firebase.dart';
import '../back_module/setting.dart';

class Token {
  // 1. 로컬에 고객번호 기억하기(로그인)
  void Settoken(String? user_no) async {
    final storage = FlutterSecureStorage();
    storage.write(key:"no", value: user_no);
  }

  // 2. 로컬에 저장된 고객번호 가져오기(세션유지)
  Future<String?> Gettoken() async {
    final storage = FlutterSecureStorage();
    String? user_no = await storage.read(key: "no");
    return user_no;
  }

  // 3. 로컬에 저장된 고객번호 삭제하기
  void Deltoken() async {
    final storage = FlutterSecureStorage();
    storage.write(key:"no", value: null);
  }
}


class sqlget {
  // [sql] 정보
  static String username = setting.sql['username'];
  static String dbname = setting.sql['dbname'];
  static String password = setting.sql['password'];

  // https://www.erdcloud.com/d/cnjAmwmQZyQ8ddwen

  // [DB] 정보
  static String dic_db = "dictionary"; // 사전DB
  static String user_db = "user"; // 사용자정보DB
  static String mydic_db = "mydic"; // 사용자 사전DB
  static String book_db = "book"; // 동화책DB

  // [DB] column 정보
  // [DB] 1. dic_db_col
  static Map<String, String> dic_db_col =
  {"no" : "dic_no", // 사전 고유 번호
    "kor" : "word_kor", // 한국단어
    "mean" : "mean",  // 의미
    "eng" : "word_eng"};

  // [DB] 2. user_db_col
  static Map<String, String> user_db_col =
  {"no" : "user_no",
    "id" : "user_id",
    "pw" : "user_pw",
    "name" : "user_name",
    "birth" : "user_birth",
    "gender" : "user_gender",
    "state" : "user_state",
    "gentime" : "user_gentime",
    "edittime" : "user_edittime"
  };

  // [DB] 3. mydic_db_col
  static Map<String, String> mydic_db_col =
  {"no" : "mydic_no",
    "user_no" : "fk_user_no",
    "dic_no" : "fk_dic_no",
    "path" : "image_address",
    "gentime" : "mydic_gentime"
  };

  // [DB] 4. book_db_col
  static Map<String, String> book_db_col =
  {"no" : "book_no",
    "title" : "book_title",
    "video" : "book_video",
    "playtime" : "book_playtime",
    "age" : "book_age",
    "lang" : "book_lang",
    "source" : "book_source"
  };

  // [gender] 성별 맵데이터
  static Map<String, String> map_gender = {
    "0" : "남자",
    "1" : "여자"
  };

  // [not use] [return list] [Input String] select문을 통한 실행
  Future<List<Map<String, String?>>> _select(String queryState) async {
    List<Map<String, String?>> return_list = [];

    final conn = await MySQLConnection.createConnection(
      host: setting.sql['host'],
      port: setting.sql['port'],
      userName: username,
      password: password,
      databaseName: dbname,
    );

    await conn.connect();

    IResultSet? result;
    result = await conn.execute(queryState);

    if (result != null && result.isNotEmpty) {
      for (final row in result.rows) {
        return_list.add(row.assoc());
      }
    }
    await conn.close();
    return return_list;
  }

  // [not use] [return bool] [input String / Map] INSERT, UPDATE, DELETE
  Future<bool> _execute(String queryState, Map<String, dynamic>? params) async {

    final conn = await MySQLConnection.createConnection(
      host: setting.sql['host'],
      port: setting.sql['port'],
      userName: username,
      password: password,
      databaseName: dbname,
    );

    await conn.connect();

    IResultSet result;
    result = await conn.execute(queryState, params);

    if (result != null) {
      return true;
    } else {
      return false;
    }}

  // [user] 1. 로그인 기능
  // [user] 2. 아이디 중복확인 기능
  // int number = await sqlclient().GetUserByIdPw(id:'hjhan1201', pw: '1234');
  Future<String?> GetUserByIdPw({required String id, String pw=""}) async {
    List<Map<String, String?>> nopw = await _select(
        "Select ${user_db_col['no']}, ${user_db_col['pw']} From ${user_db} Where ${user_db_col['id']} = '${id}'");

    if (nopw.length == 0) {
      return "id"; // 아이디 오류
    } else if (nopw.first[user_db_col['pw']] != pw) {
      return "pw"; // 비밀번호 오류
    } else {
      return nopw.first["user_no"]; // 고객번호
    }
  }

  // [user] 3. 가입 기능
  // true : 성공 / false : 실패
  Future<bool> UserJoin({required String id, required String pw, required String name, String? birth=null, int? gender=null}) async {
    return await _execute("INSERT INTO ${user_db} (${user_db_col['id']}, ${user_db_col['pw']}, ${user_db_col['name']}, ${user_db_col['birth']}, ${user_db_col['gender']}, ${user_db_col['state']}) VALUES (:id, :pw, :name, :birth, :gender, :state)",
        {"id":id, "pw":pw, "name":name, "birth":birth, "gender":gender, "state":1}
    );
  }

  // [user] 4. 회원 정보 수정
  Future<bool> UserChange({required String? user_no, String? pw=null, String? name=null, String? birth=null, int? gender=null}) async {
    Map<String, dynamic>? update_map = {};
    String pw_update = "";
    String name_update = "";
    String birth_update = "";
    String gender_update = "";
    var now = DateTime.now();
    String time = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    // 패스워드
    if (pw!=null) {
      pw_update = "${user_db_col['pw']} = :pw, ";
      update_map['pw'] = pw;
    }

    // 이름
    if (name!=null) {
      name_update = "${user_db_col['name']} = :name, ";
      update_map['name'] = name;
    }

    // 생년월일
    if (birth!=null) {
      birth_update = "${user_db_col['birth']} = :birth, ";
      update_map['birth'] = birth;
    }

    // 성별
    if (gender!=null) {
      gender_update = "${user_db_col['gender']} = :gender, ";
      update_map['gender'] = gender;
    }

    update_map['time'] = time;

    return await _execute("UPDATE ${user_db} SET ${pw_update} ${name_update} ${birth_update} ${gender_update} ${user_db_col['edittime']} = :time where ${user_db_col['no']} like ${user_no}", update_map);
  }

  // [user] 5. 탈퇴 기능
  // true : 성공 / false : 실패
  Future<bool> UserDelete({required String? user_no}) async {
    return await _execute("DELETE FROM ${user_db} WHERE ${user_db_col['no']} like :no", {"no": int.parse(user_no!)});
  }

  // [user] 6. 회원정보 조회
  // gender / man : 0, woman : 1
  Future<Map<String, String?>> GetUserInfo({required String? user_no}) async {
    List<Map<String, String?>> UserInfoList = await _select("SELECT ${user_db_col['name']}, ${user_db_col['birth']}, ${user_db_col['gender']} FROM ${user_db} WHERE ${user_db_col['no']} like ${user_no}");
    return UserInfoList[0];
  }

  // [user] 7. 사용자 이름 조회
  Future<String?> GetUserName({required String? user_no}) async {
    List<Map<String, String?>> _UserName = await _select("SELECT ${user_db_col['name']} FROM ${user_db} WHERE ${user_db_col['no']} like ${user_no}");
    return _UserName[0][user_db_col['name']];
  }

  // [dic_db_col] 1. 넘버, 한국단어, 뜻
  Future<List<Map<String, String?>>> GetAllByEng({required String? eng}) async {
    return _select("Select ${dic_db_col['dic_no']}, ${dic_db_col['kor']}, ${dic_db_col['mean']} From ${dic_db} Where ${dic_db_col['eng']} like '$eng'");
  }

  // [dic_db_col] 2. 한국단어
  Future<String?> GetWordKorByEng({required String? eng}) async {
    List<Map<String, String?>> result = await _select("Select ${dic_db_col['kor']} From ${dic_db} Where ${dic_db_col['eng']} like '$eng'");
    // 영단어는 무결하다는 가정!
    return result[0]['${dic_db_col['kor']}'];
  }

  // [dic_db_col] 3. dic넘버
  Future<String?> GetNoByEng({required String? eng}) async {
    List<Map<String, String?>> result = await _select("Select ${dic_db_col['no']} From ${dic_db} Where ${dic_db_col['eng']} like '$eng'");
    // 영단어는 무결하다는 가정!
    return result[0]['${dic_db_col['no']}'];
  }

  // [mydic_db] 1. 새로운 번호 받기
  Future<String?> GetNewMyDicNo() async {
    List<Map<String, String?>> no = await _select('SELECT Max(${mydic_db_col['no']}) FROM ${mydic_db}');
    if (no[0]['Max(mydic_no)'] != null) {
      int max_no = int.parse(no[0]['Max(mydic_no)']!) + 1;
      String? new_no = max_no.toString();
      return new_no;
    } else {
      return "1";
    }
  }

  // [mydic_db] 2. 이미지 정보 rds 추가(유저번호, 사전번호)
  Future<bool> SaveImageInfo({required String? user_no, required String? dic_no, required String? mydic_no}) async {
    // s3client pathmaker : user.no/dic_no.jpg
    String? path = FirebaseClient(user_no:user_no, mydic_no: mydic_no).PathMaker();
    return await _execute("INSERT INTO ${mydic_db} (${mydic_db_col['no']}, ${mydic_db_col['user_no']}, ${mydic_db_col['dic_no']}, ${mydic_db_col['path']}) VALUE(:no, :user_no, :dic_no, :path);",
        {'no':int.parse(mydic_no!), 'user_no':int.parse(user_no!), 'dic_no':int.parse(dic_no!), 'path':path});
  }

  // [mydic_db] 3. 이미지 정보 rds 삭제(고유번호)
  Future<bool> DeleteImageInfo({required user_no, required mydic_no}) async {
    FirebaseClient(user_no:user_no, mydic_no: mydic_no).remove();
    return await _execute("DELETE FROM ${mydic_db} WHERE ${mydic_db_col['no']} = :no;",
        {'no':int.parse(mydic_no)});
  }

  // [mydic_db] 4. 이미지 불러오기
  Future<List<Map<String, String?>>> GetTaleList() async {
    return await _select("SELECT ${book_db_col['no']}, ${book_db_col['title']}, ${book_db_col['video']}, ${book_db_col['playtime']}, ${book_db_col['age']}, ${book_db_col['lang']}, ${book_db_col['source']} FROM ${book_db}");
  }

  // [mydic_db] left join [dic_db] 1. 유저별 이미지 + dictionary 정보 불러오기
  Future<List<Map<String, String?>>> GetMydicList({required user_no}) async {
    return await _select("SELECT ${mydic_db_col['no']}, ${mydic_db_col['dic_no']}, ${mydic_db_col['path']}, ${dic_db_col['eng']}, ${dic_db_col['kor']}, ${dic_db_col['mean']} FROM ${mydic_db} left join ${dic_db} on ${mydic_db_col['dic_no']} = ${dic_db_col['no']} WHERE ${mydic_db_col['user_no']} = ${user_no}");
  }

}