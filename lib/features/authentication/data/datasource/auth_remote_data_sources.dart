// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_node_practice/core/entities/user_entity.dart';
import 'package:flutter_node_practice/core/error/exceptions.dart';
import 'package:flutter_node_practice/core/services/dio_network_service.dart';
import 'package:flutter_node_practice/core/services/network_service.dart';
import 'package:flutter_node_practice/features/authentication/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> signUp(UserEntity user);
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dioClient, this.httpClient);

  final HTTPNetworkService httpClient;
  final DioNetworkService dioClient;

  @override
  Future<Map<String, dynamic>> signUp(UserEntity user) async {
    final userMap = user.toMap();
    final apiResponse = await dioClient.postAPI('signup', userMap);
    return apiResponse;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        final apiResponse =
            await httpClient.getAPI("get-user?uid=${auth.currentUser?.uid}");
        return UserModel.fromMap(apiResponse["user"]);
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
