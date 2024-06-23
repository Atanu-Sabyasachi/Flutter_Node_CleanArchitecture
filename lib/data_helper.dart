class DataHelper {
  static final DataHelper _networkHelper = DataHelper._internal();
  String jwtToken = "";

  String get getJwtToken {
    return jwtToken;
  }

  set setJwtToken(String token) {
    jwtToken = token;
  }

  factory DataHelper() {
    return _networkHelper;
  }
  DataHelper._internal();
}
