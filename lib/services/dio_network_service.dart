import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DioNetworkService {
  Future<Map<String, dynamic>> postAPI(String url, Map<String, dynamic> data);
  Future<Map<String, dynamic>> putAPI(String url, Map<String, dynamic> data);
}

class DioNetworkServiceImpl implements DioNetworkService {
  DioNetworkServiceImpl({
    required this.baseUrl,
    required this.dio,
  });

  final String baseUrl;
  final Dio dio;

  @override
  Future<Map<String, dynamic>> postAPI(
      String url, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');

    Options options = jwtToken != null
        ? Options(headers: {'Authorization': 'Bearer $jwtToken'})
        : Options();

    try {
      final response = await dio.post(
        baseUrl + url,
        data: jsonEncode(data),
        options: options,
      );

      return _handleResponse(response);
    } catch (error) {
      print('Error in postAPI: $error');
      return {"statusCode": 500, "error": error.toString()};
    }
  }

  @override
  Future<Map<String, dynamic>> putAPI(
      String url, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');

    Options options = jwtToken != null
        ? Options(headers: {'Authorization': 'Bearer $jwtToken'})
        : Options();

    try {
      final response = await dio.put(
        baseUrl + url,
        data: jsonEncode(data),
        options: options,
      );

      return _handleResponse(response);
    } catch (error) {
      print('Error in putAPI: $error');
      return {"statusCode": 500, "error": error.toString()};
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        throw UnauthorizedException(response.data.toString());
      case 403:
        throw ForbiddenException(response.data.toString());
      case 404:
        throw NotFoundException(response.data.toString());
      case 500:
        return response.data;
      default:
        throw ServerErrorException(response.data.toString());
    }
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
