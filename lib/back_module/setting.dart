class setting {
  static Map<String, dynamic> sql = {
    'username' : 'USERNAME',
    'dbname' : 'DBNAME',
    'password' : 'PASSWORD',
    'host' : 'HOST IP',
    'port' : 0000
  };

  //*** url에 끝에는 반드시 / 를 붙일 것

  ///// Clip 세팅값
  // GCP
  static String clip_url = "CLIP_URL";
  // ngrok
  // static String clip_url = "https://84f6-114-202-17-6.ngrok-free.app/";

  ///// TTS 세팅값
  // naver clova voice
  static Map<String, dynamic> tts = {
    'url' : 'https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts',
    'headers' : {'Content-Type': 'application/x-www-form-urlencoded',
                  'X-NCP-APIGW-API-KEY-ID': 'NAVER CLOVA API KEY ID', // client id
                  'X-NCP-APIGW-API-KEY': 'NAVER CLOVA API KEY'} // client_secret
  };

  ///// RAG 세팅값
  // LLM(Gemini만)
  static String gemini_api = "GEMINI_API";

  // GCP
  static String rag_url = "RAG_URL";
  // ngrok
  // static String rag_url = "https://6146-114-202-17-6.ngrok-free.app/";

  ///// Firebase 세팅값
  static String firebase_url = 'FIREBASE URL';
  static int firebase_port = 0000;

  ///// Firebase_options 세팅값
  static const String firebase_options_apikey = '';
  static const String firebase_options_appId = '';
  static const String firebase_options_messagingSenderId = '';
  static const String firebase_options_projectId = '';
  static const String firebase_options_storageBucket = '';

  ///// s3 세팅값
  static String s3_region = "";
  static String s3_bucketId = "";
  static String s3_accessKey = "";
  static String s3_secretkey = "";
}