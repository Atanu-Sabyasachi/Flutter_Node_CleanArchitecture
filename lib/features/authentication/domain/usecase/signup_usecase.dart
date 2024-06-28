import 'package:flutter_node_practice/core/error/failures.dart';
import 'package:flutter_node_practice/core/usecase/usecase.dart';
import 'package:flutter_node_practice/core/usecase/user_params.dart';
import 'package:flutter_node_practice/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUseCase implements UseCase<Map<String, dynamic>, UserParams> {
  SignUpUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(UserParams params) async {
    return await repository.signUp(params.user);
  }
}
