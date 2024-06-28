class DataHelper {
  factory DataHelper() {
    return _networkHelper;
  }

  DataHelper._internal();

  String jwtToken = "";

  static final DataHelper _networkHelper = DataHelper._internal();

  String get getJwtToken {
    return jwtToken;
  }

  set setJwtToken(String token) {
    jwtToken = token;
  }
}
