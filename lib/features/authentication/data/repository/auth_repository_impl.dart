// ignore_for_file: avoid_print

import 'package:flutter_node_practice/core/entities/user_entity.dart';
import 'package:flutter_node_practice/core/error/failures.dart';
import 'package:flutter_node_practice/features/authentication/data/datasource/auth_remote_data_sources.dart';
import 'package:flutter_node_practice/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_node_practice/core/services/dio_network_service.dart';
import 'package:flutter_node_practice/features/authentication/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, Map<String, dynamic>>> signUp(UserEntity user) async {
    try {
      Map<String, dynamic> response = await remoteDataSource.signUp(user);
      // final message = response["message"];
      print("response: $response");
      return right(response);
    } on ServerErrorException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      UserModel? user = await remoteDataSource.getCurrentUser();

      if (user != null) {
        return right(user as UserEntity);
      } else {
        return left(Failure("User not logged in !"));
      }
    } on ServerErrorException catch (e) {
      return left(Failure(e.message));
    }
  }
}
