import 'package:flutter_node_practice/core/entities/user_entity.dart';
import 'package:flutter_node_practice/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> signUp(UserEntity user);
  Future<Either<Failure, UserEntity>> currentUser();
}
