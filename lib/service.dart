// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:3000/api";

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<UserModel> users =
          body.map((dynamic item) => UserModel.fromMap(item)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    var encodedata = jsonEncode(user.toMap());
    final response = await http.post(
      Uri.parse("$baseUrl/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: encodedata,
    );

    if (response.statusCode == 201) {
      print("user created successfully !");
      return UserModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  // Future<UserModel> updateUser(UserModel user) async {
  //   final response = await http.put(
  //     Uri.parse("$baseUrl/users/${user.id}"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: user.toJson(),
  //   );
  //   if (response.statusCode == 200) {
  //     return UserModel.fromMap(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to update user');
  //   }
  // }

  Future<UserModel> updateUser(UserModel user) async {
    var encodedata = jsonEncode(user.toMap());
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: encodedata,
    );

    if (response.statusCode == 200) {
      return UserModel.fromMap(
          jsonDecode(response.body)); // Parse the response to your user model
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/users/$id"));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
