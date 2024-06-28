import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class HTTPNetworkService {
  Future<Map<String, dynamic>> getAPI(String url);
  Future<Map<String, dynamic>> roleBasedSignInGetAPI(String url);
}

class HTTPNetworkServiceImpl implements HTTPNetworkService {
  HTTPNetworkServiceImpl({
    required this.baseUrl,
    required this.client,
  });

  final String baseUrl;
  final http.Client client;

  @override
  Future<Map<String, dynamic>> getAPI(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');

    Map<String, String> headers =
        jwtToken != null ? {'Authorization': 'Bearer $jwtToken'} : {};

    try {
      final response = await client.get(
        Uri.parse(baseUrl + url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return _handleResponse(response);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error in getAPI: $error');
      return {"statusCode": 500, "error": error.toString()};
    }
  }

  @override
  Future<Map<String, dynamic>> roleBasedSignInGetAPI(String url) async {
    try {
      final response = await client.get(Uri.parse(baseUrl + url));
      final responseJson = _decodeResponse(response);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', responseJson["accesstoken"]);

      return responseJson;
    } catch (error) {
      print('Error in roleBasedSignInGetAPI: $error');
      return {"statusCode": 500, "error": error.toString()};
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return _decodeResponse(response);
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException(response.body);
      case 403:
        throw ForbiddenException(response.body);
      case 404:
        throw NotFoundException(response.body);
      case 500:
        return _decodeResponse(response);
      default:
        throw ServerErrorException(response.body);
    }
  }

  dynamic _decodeResponse(http.Response response) {
    return json.decode(response.body);
  }
}

class BadRequestException implements Exception {
  BadRequestException(this.message);

  final String message;
}

class UnauthorizedException implements Exception {
  UnauthorizedException(this.message);

  final String message;
}

class ForbiddenException implements Exception {
  ForbiddenException(this.message);

  final String message;
}

class NotFoundException implements Exception {
  NotFoundException(this.message);

  final String message;
}

class ServerErrorException implements Exception {
  ServerErrorException(this.message);

  final String message;
}
