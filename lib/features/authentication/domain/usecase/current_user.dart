import 'package:flutter_node_practice/core/entities/user_entity.dart';
import 'package:flutter_node_practice/core/error/failures.dart';
import 'package:flutter_node_practice/core/usecase/no_params.dart';
import 'package:flutter_node_practice/core/usecase/usecase.dart';
import 'package:flutter_node_practice/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
