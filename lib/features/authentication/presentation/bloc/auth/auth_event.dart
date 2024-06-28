import 'package:equatable/equatable.dart';
import 'package:flutter_node_practice/core/entities/user_entity.dart';

abstract class AuthEvent extends Equatable {}

class AuthSignUpEvent extends AuthEvent {
  AuthSignUpEvent({
    required this.user,
  });

  final UserEntity user;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthLoggedIn extends AuthEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
